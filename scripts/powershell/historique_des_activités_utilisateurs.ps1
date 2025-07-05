$filePath =  "./historique_activité_utilisateurlog.txt"
$date = Get-Date

# Fonction pour créer un fichier log
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

# Fonction pour afficher la date de la dernière connexion de l'utilisateur
function Connexion-Utilisateur {
    # Utilisation de Get-EventLog pour obtenir les événements de connexion
    $lastLogon = Get-WinEvent -LogName Security | Where-Object {$_.Id -eq 4624} | Select-Object -First 1 -Property TimeCreated, Message
    Write-Host "Dernière connexion : $($lastLogon.TimeCreated)"
    Write-Host "Détails : $($lastLogon.Message)"
    Add-Content -Path $filePath -Value "$date - information de derniere connexion obtenu."
}

# Fonction pour afficher la date de la dernière modification du mot de passe d'un utilisateur
function MotDePasse-Utilisateur {
    $nom = Read-Host "Nom de l'utilisateur"
    try {
        # Récupérer la date de dernière modification du mot de passe via Get-LocalUser
        $user = Get-LocalUser -Name $nom
        $lastPasswordSet = $user.PasswordLastSet
        Write-Host "Dernière modification du mot de passe pour $nom : $lastPasswordSet"
        Add-Content -Path $filePath -Value "$date - date de derniere modification du mots de passe de $nom obtenu."
    } catch {
        Write-Host "Utilisateur introuvable."
    }
}

# Fonction pour afficher la liste des sessions ouvertes par les utilisateurs
function Session-Ouverte-Utilisateur {
    # Utilisation de Get-WmiObject pour obtenir les sessions utilisateurs
    $sessions = Get-WmiObject -Class Win32_ComputerSystem | Select-Object UserName
    if ($sessions.UserName) {
        Write-Host "Sessions ouvertes :"
        Write-Host $sessions.UserName
        Add-Content -Path $filePath -Value "$date - liste des dernière session ouverte obtenu."
    } else {
        Write-Host "Aucune session ouverte."
    }
}

# Menu principal
while ($true) {
    Clear-Host
    Write-Host "=== Historique des activités utilisateur ==="
    Write-Host "1. Date de dernière connexion d'un utilisateur"
    Write-Host "2. Date de dernière modification du mot de passe"
    Write-Host "3. Liste des sessions ouvertes par l'utilisateur"
    Write-Host "4. Retour"
    $choice = Read-Host "Choisissez une option"

    switch ($choice) {
        1 {
            Connexion-Utilisateur
            Read-Host "Appuyez sur [Entrée] pour revenir au menu"
        }
        2 {
            MotDePasse-Utilisateur
            Read-Host "Appuyez sur [Entrée] pour revenir au menu"
        }
        3 {
            Session-Ouverte-Utilisateur
            Read-Host "Appuyez sur [Entrée] pour revenir au menu"
        }
        4 {
            Write-Host "Retour au menu principal..."
            break
        }
        default {
            Write-Host "Choix invalide. Veuillez sélectionner une option valide."
            Read-Host "Appuyez sur [Entrée] pour revenir au menu"
        }
    }
}
