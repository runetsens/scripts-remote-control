$filePath =  "./information_disquelog.txt"
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


# Fonction pour afficher le nombre de disques
function Nombre-De-Disques {
    # Utilisation de Get-Disk pour obtenir la liste des disques physiques
    $disks = Get-Disk
    Write-Host "Nombre de disques : $($disks.Count)"
    $disks | Select-Object -Property Number, FriendlyName, Size
    Add-Content -Path $filePath -Value "$date - nombre de disque obtenu"
}

# Fonction pour afficher les partitions par disque
function Partition-Par-Disque {
    # Utilisation de Get-Partition pour obtenir les partitions sur chaque disque
    $partitions = Get-Partition
    Write-Host "Partitions par disque :"
    $partitions | Select-Object -Property DiskNumber, PartitionNumber, Size, Type
    Add-Content -Path $filePath -Value "$date - partition par disque obtenu"
}

# Fonction pour afficher l'espace disque restant par partition
function Espace-Disque-Restant {
    # Utilisation de Get-PSDrive pour obtenir les informations d'espace disque pour les lecteurs locaux
    $drives = Get-PSDrive -PSProvider FileSystem
    Write-Host "Espace disque restant par partition :"
    $drives | Select-Object -Property Name, 
        @{Name="Used(GB)"; Expression={($_.Used/1GB)}}, 
        @{Name="Free(GB)"; Expression={($_.Free/1GB)}}, 
        @{Name="Total(GB)"; Expression={($_.Used + $_.Free)/1GB}}
        Add-Content -Path $filePath -Value "$date - espace disque restant par partition obtenu"
}

# Fonction pour afficher le nom et l'espace disque d'un dossier
function Espace-Disque-Dossier {
    # Demander le chemin du dossier
    $folderPath = Read-Host "Entrez le chemin du dossier"
    if (Test-Path $folderPath) {
        $size = (Get-ChildItem -Path $folderPath -Recurse | Measure-Object -Property Length -Sum).Sum
        Write-Host "Espace disque utilisé par le dossier '$folderPath' : $(($size / 1GB).ToString("0.##")) GB"
        Add-Content -Path $filePath -Value "$date - espace disque du dossier $folderPath obtenu"
    } else {
        Write-Host "Le dossier spécifié n'existe pas."
    }
}

# Fonction pour afficher la liste des disques montés
function Liste-Lecteurs-Montes {
    # Utilisation de Get-Volume pour afficher les volumes montés
    $volumes = Get-Volume
    Write-Host "Disques montés :"
    $volumes | Select-Object -Property DriveLetter, FileSystemLabel, 
        @{Name="Size(GB)"; Expression={($_.Size / 1GB)}}, 
        @{Name="Used(GB)"; Expression={($_.UsedSpace / 1GB)}}, 
        @{Name="Free(GB)"; Expression={($_.SizeRemaining / 1GB)}}
        Add-Content -Path $filePath -Value "$date - liste des disque monté obtenu"
}

# Menu principal
while ($true) {
    Clear-Host
    Write-Host "=== Gestion des Disques et Partitions ==="
    Write-Host "1) Nombre de disques"
    Write-Host "2) Partition par disque"
    Write-Host "3) Espace disque restant par partition"
    Write-Host "4) Nom et espace disque d'un dossier"
    Write-Host "5) Liste des disques montés"
    Write-Host "6) Quitter"
    $choix = Read-Host "Votre choix"

    switch ($choix) {
        1 {
            Nombre-De-Disques
            Read-Host "Appuyez sur [Entrée] pour revenir au menu"
        }
        2 {
            Partition-Par-Disque
            Read-Host "Appuyez sur [Entrée] pour revenir au menu"
        }
        3 {
            Espace-Disque-Restant
            Read-Host "Appuyez sur [Entrée] pour revenir au menu"
        }
        4 {
            Espace-Disque-Dossier
            Read-Host "Appuyez sur [Entrée] pour revenir au menu"
        }
        5 {
            Liste-Lecteurs-Montes
            Read-Host "Appuyez sur [Entrée] pour revenir au menu"
        }
        6 {
            Write-Host "Au revoir!"
            exit 0
        }
        default {
            Write-Host "Choix invalide. Veuillez choisir une option valide."
            Read-Host "Appuyez sur [Entrée] pour revenir au menu"
        }
    }
}
