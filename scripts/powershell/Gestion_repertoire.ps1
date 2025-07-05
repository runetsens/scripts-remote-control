$filePath =  ".\gestion_repertoirelog.txt"
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

# Exemple d'utilisation
# Create-File -filePath "C:\Users\Utilisateur\mon_fichier.txt"


# Fonction pour créer un répertoire
function Create-Directory {
    param (
        [string]$directoryName
    )
    while ($true) {
        if (-not (Test-Path -Path $directoryName)) {
            New-Item -ItemType Directory -Path $directoryName | Out-Null
            # Ajouter une entrée dans le fichier log sans écraser son contenu
            Add-Content -Path $filePath -Value "$date - Le dossier '$directoryName' a été créé."
            Write-Output "Le dossier '$directoryName' est créé."
        
        } else {
            Write-Output "Ce dossier existe déjà."
            $retry = Read-Host "Voulez-vous essayer un autre nom ? (o/n)"
            if ($retry -ne 'o') { break }
            $directoryName = Read-Host "Donnez un autre nom pour votre répertoire"
        }
    }
}

# Fonction pour modifier un répertoire
function Rename-Directory {
    param (
        [string]$directoryName
    )
    while ($true) {
        if (-not (Test-Path -Path $directoryName)) {
            Write-Output "Ce dossier n'existe pas."
        
        } else {
            $newName = Read-Host "Quel nouveau nom voulez-vous donner à '$directoryName'"
            if (-not (Test-Path -Path $newName)) {
                Rename-Item -Path $directoryName -NewName $newName
                # Ajouter une entrée dans le fichier log sans écraser son contenu
                Add-Content -Path $filePath -Value "$date - Le dossier '$directoryName' a été renommé en '$newName'."
                Write-Output "Le nom du dossier a été modifié en '$newName'."
            
            } else {
                Write-Output "Ce dossier existe déjà."
                break
            }
        }
    }
}

# Fonction pour supprimer un répertoire
function Delete-Directory {
    param (
        [string]$directoryName
    )
    while ($true) {
        if (Test-Path -Path $directoryName) {
            Remove-Item -Path $directoryName -Recurse -Force
            # Ajouter une entrée dans le fichier log sans écraser son contenu
            Add-Content -Path $filePath -Value "$date - Le dossier '$directoryName' a été supprimé."
            Write-Output "Le répertoire '$directoryName' a été supprimé."
            
        } else {
            Write-Output "Ce dossier n'existe pas."
            break
        
        }
    }
}

# Menu principal
while ($true) {
    Clear-Host
    Write-Output "Choisissez une option :"
    Write-Output "1) Créer un dossier"
    Write-Output "2) Modifier un dossier"
    Write-Output "3) Supprimer un dossier"
    Write-Output "4) Quitter"
    $choix = Read-Host "Votre choix"

    switch ($choix) {
        '1' {
            $directoryName = Read-Host "Donnez un nom à votre répertoire"
            Create-File -filePath $filePath  # S'assurer que le fichier log existe
            Create-Directory -directoryName $directoryName
        }
        '2' {
            $directoryName = Read-Host "Quel répertoire voulez-vous modifier"
            Create-File -filePath $filePath  # S'assurer que le fichier log existe
            Rename-Directory -directoryName $directoryName
        }
        '3' {
            $directoryName = Read-Host "Quel répertoire voulez-vous supprimer"
            Create-File -filePath $filePath  # S'assurer que le fichier log existe
            Delete-Directory -directoryName $directoryName
        }
        '4' {
            Write-Output "Au revoir!"
            break
        }
        default {
            Write-Output "Choix invalide."
        }
    }
}