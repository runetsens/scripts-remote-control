$filePath =  "./install_desinstall_logiciellog.txt"
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


# Fonction pour installer un logiciel
function Install-Software {
    # Demander le nom du logiciel à installer
    $nom_install = Read-Host "Nom du logiciel à installer"
    
    # Mise à jour des dépôts et installation du logiciel
    Write-Host "Mise à jour des dépôts..."
    sudo apt update
    Write-Host "Installation de $nom_install..."
    sudo apt install -y $nom_install
    Add-Content -Path $filePath -Value "$date - installation du logiciel $nom_install"
}

# Fonction pour désinstaller un logiciel
function Uninstall-Software {
    # Demander le nom du logiciel à désinstaller
    $nom_desinstall = Read-Host "Nom du logiciel à désinstaller"
    
    # Désinstallation du logiciel
    Write-Host "Désinstallation de $nom_desinstall..."
    sudo apt remove -y $nom_desinstall
     Add-Content -Path $filePath -Value "$date - desinstallation du logiciel $nom_desinstall"
}

# Menu principal
while ($true) {
    Clear-Host
    Write-Host "=== Menu de gestion des logiciels ==="
    Write-Host "1) Installer un logiciel"
    Write-Host "2) Désinstaller un logiciel"
    Write-Host "3) Quitter"
    $choix = Read-Host "Choisissez une option"

    switch ($choix) {
        1 {
            Install-Software
        }
        2 {
            Uninstall-Software
        }
        3 {
            Write-Host "Au revoir!"
            exit 0
        }
        default {
            Write-Host "Choix invalide. Veuillez choisir une option entre 1 et 3."
        }
    }
}
