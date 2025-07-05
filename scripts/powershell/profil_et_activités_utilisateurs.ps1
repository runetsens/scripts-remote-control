# Déclaration du chemin du fichier de journalisation
$filePath =  ".\profil_et_activité_utilisateurlog.txt"
$date = Get-Date

# Fonction de création du fichier de journalisation
function Create-File {
    param (
        [string]$filePath
    )

    if (-not (Test-Path -Path $filePath)) {
        New-Item -ItemType File -Path $filePath -Force | Out-Null
        Write-Output "Fichier '$filePath' créé avec succès."
        # Ajout d'un message de création dans le fichier
        Add-Content -Path $filePath -Value "$date - Fichier créé"
    } else {
        Write-Output "Le fichier '$filePath' existe déjà." > $null
    }
}

# Fonction pour afficher le groupe d'appartenance d'un utilisateur
function Get-UserGroups {
    # Demander le nom de l'utilisateur
    $username = Read-Host "Entrez le nom de l'utilisateur"
    
    # Récupérer les groupes de l'utilisateur
    $groups = (Get-LocalUser $username).GroupMembership
    if ($groups) {
        Write-Host "$username appartient aux groupes suivants :"
        $groups | ForEach-Object { Write-Host $_.Name }
         Add-Content -Path $filePath -Value "$date - obtention du groupe de $username"
    } else {
        Write-Host "L'utilisateur n'a pas de groupe d'appartenance."
        Add-Content -Path $filePath -Value "$date - $username n'appatient a aucun groupe"
    }
}

# Fonction pour afficher l'historique des commandes exécutées par l'utilisateur
function Get-UserCommandHistory {
    # Vérifier que l'historique des commandes est disponible
    $historyFile = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt"
    if (Test-Path $historyFile) {
        Write-Host "Historique des commandes exécutées :"
        Get-Content $historyFile
        Add-Content -Path $filePath -Value "$date - historique des commande executées obtenu"
    } else {
        Write-Host "Aucun historique de commandes disponible."
    }
}

# Menu des options d'historique d'activités utilisateur
while ($true) {
    Clear-Host
    Write-Host "=== Historique des activités utilisateur ==="
    Write-Host "1. Groupe d'appartenance d'un utilisateur"
    Write-Host "2. Historique des commandes exécutées par l'utilisateur"
    Write-Host "3. Retour"
    $choice = Read-Host "Choisissez une option"

    switch ($choice) {
        1 {
            Get-UserGroups
        }
        2 {
            Get-UserCommandHistory
        }
        3 {
            Write-Host "Retour au menu principal..."
            break
        }
        default {
            Write-Host "Choix invalide. Veuillez choisir une option entre 1 et 3."
        }
    }
}
