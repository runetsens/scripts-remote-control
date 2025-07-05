# Déclaration du chemin du fichier de journalisation
$filePath =  ".\version_oslog.txt"
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


# Afficher les informations système
Clear-Host

# Obtenir des informations sur la version de Windows
$osInfo = Get-ComputerInfo

# Affichage des informations sur le système d'exploitation
Write-Host "Nom du système d'exploitation : $($osInfo.OsName)"
Write-Host "Version : $($osInfo.WindowsVersion)"
Write-Host "Build : $($osInfo.WindowsBuildLabEx)"
Write-Host "Architecture : $($osInfo.OsArchitecture)"
Add-Content -Path $filePath -Value "$date - information sur le système d'exploitation obtenu "
