$filePath =  "./etat_systeme_ressourcelog.txt"
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

# Fonction pour lister les applications/paquets installés
function Get-InstalledApplications {
    Get-WmiObject -Class Win32_Product | Select-Object Name, Version
    Add-Content -Path $filePath -Value "$date - Liste des applications installé"
}

# Fonction pour lister les services en cours d'exécution
function Get-RunningServices {
    Get-Service | Where-Object { $_.Status -eq 'Running' } | Select-Object Name, Status
     Add-Content -Path $filePath -Value "$date - Liste des services en cours d'execution"
}

# Fonction pour lister les utilisateurs locaux
function Get-LocalUsers {
    Get-LocalUser | Select-Object Name, Enabled
     Add-Content -Path $filePath -Value "$date - Liste des utilisateurs locaux"
}

# Boucle du menu principal
while ($true) {
    Write-Host "=== État du système et des ressources ==="
    Write-Host "1. Liste des applications/paquets installés"
    Write-Host "2. Liste des services en cours d'exécution"
    Write-Host "3. Liste des utilisateurs locaux"
    Write-Host "4. Retour"
    $choice = Read-Host "Choisissez une option"

    switch ($choice) {
        1 { 
            Get-InstalledApplications
        }
        2 {
            Get-RunningServices
        }
        3 {
            Get-LocalUsers
        }
        4 {
            Write-Host "Retour au menu principal..."
            break
        }
        default {
            Write-Host "Choix invalide !"
        }
    }
}
