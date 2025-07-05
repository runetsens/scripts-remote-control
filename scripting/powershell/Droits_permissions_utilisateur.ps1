$filePath =  "./Droit_permissions_utilisateurlog.txt"
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



# Fonction pour afficher les droits/permissions sur un dossier
function Get-DossierPermissions {
    param (
        [string]$dossier
    )

    if (Test-Path $dossier) {
        Get-Acl -Path $dossier | ForEach-Object {
            $_.Access | Select-Object IdentityReference, FileSystemRights, AccessControlType
        }
         Add-Content -Path $filePath -Value "$date - Droit dossier"
    } else {
        Write-Host "Le dossier n'existe pas."
    }
}

# Fonction pour afficher les droits/permissions sur un fichier
function Get-FichierPermissions {
    param (
        [string]$fichier
    )

    if (Test-Path $fichier) {
        Get-Acl -Path $fichier | ForEach-Object {
            $_.Access | Select-Object IdentityReference, FileSystemRights, AccessControlType
        }
         Add-Content -Path $filePath -Value "$date - Droit fichier"
    } else {
        Write-Host "Le fichier n'existe pas."
    }
}

# Menu des options d'historique d'activités utilisateur
function Menu-HistoriqueActivitesUtilisateur {
    
    Write-Host "=== Historique des activités utilisateur ==="
    Write-Host "1. Droits/permissions de l'utilisateur sur un dossier"
    Write-Host "2. Droits/permissions de l'utilisateur sur un fichier"
    Write-Host "3. Retour"
    
    $choice = Read-Host "Choisissez une option"

    switch ($choice) {
        1 {
            $dossier = Read-Host "Entrez le chemin du dossier"
            Get-DossierPermissions -dossier $dossier
        }
        2 {
            $fichier = Read-Host "Entrez le chemin du fichier"
            Get-FichierPermissions -fichier $fichier
        }
        3 {
            Write-Host "Retour au menu principal..."
        }
        default {
            Write-Host "Choix invalide !"
        }
    }
}

# Appel du menu pour lancer le script

    Menu-HistoriqueActivitesUtilisateur

