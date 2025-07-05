$filePath =  "./information_ramlog.txt"
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

# Fonction pour afficher la mémoire RAM totale
function Get-RamTotal {
    Clear-Host
    $memory = Get-WmiObject -Class Win32_OperatingSystem
    $totalRam = [math]::round($memory.TotalVisibleMemorySize / 1MB, 2)
    Write-Host "Mémoire RAM Totale : $totalRam MB"
     Add-Content -Path $filePath -Value "$date - memoire ram total obtenu"

}

# Fonction pour afficher l'utilisation de la RAM
function Get-RamUsage {
    Clear-Host
    $memory = Get-WmiObject -Class Win32_OperatingSystem
    $totalRam = [math]::round($memory.TotalVisibleMemorySize / 1MB, 2)
    $freeRam = [math]::round($memory.FreePhysicalMemory / 1MB, 2)
    $usedRam = $totalRam - $freeRam
    Write-Host "Utilisation de la RAM :"
    Write-Host "  Total : $totalRam MB"
    Write-Host "  Utilisé : $usedRam MB"
    Write-Host "  Libre : $freeRam MB"
     Add-Content -Path $filePath -Value "$date - information sur l'utilisation ram obtenu"
}

# Menu des options pour la mémoire RAM
while ($true) {
    Write-Host "=== Historique des activités mémoire RAM ==="
    Write-Host "1. Mémoire RAM Totale"
    Write-Host "2. Utilisation de la RAM"
    Write-Host "3. Retour"
    $choice = Read-Host "Choisissez une option"

    switch ($choice) {
        1 { 
            Get-RamTotal
            Read-Host "Appuyez sur [Entrée] pour revenir au menu"
        }
        2 {
            Get-RamUsage
            Read-Host "Appuyez sur [Entrée] pour revenir au menu"
        }
        3 {
            Write-Host "Retour au menu principal..."
            break
        }
        default {
            Write-Host "Choix invalide. Veuillez choisir une option valide."
            Read-Host "Appuyez sur [Entrée] pour revenir au menu"
        }
    }
}
