$filePath =  "./gestion_pare_feulog.txt"
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

# Fonction pour désactiver le pare-feu
function Desactiver {
    # Vérifie si le pare-feu est activé
    $firewallStatus = Get-NetFirewallProfile | Where-Object { $_.Enabled -eq $true }

    if ($firewallStatus) {
        Write-Host "Désactivation du pare-feu..."
        Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled False
        # Vérification de l'état du pare-feu après désactivation
        $newStatus = Get-NetFirewallProfile | Where-Object { $_.Enabled -eq $true }
        if ($newStatus) {
            Write-Host "Le pare-feu est toujours activé."
            Add-Content -Path $filePath -Value "$date - Erreur: le pare feu est toujours activé"
        } else {
            Write-Host "Le pare-feu a été désactivé avec succès."
            Add-Content -Path $filePath -Value "$date - pare feu desactivé"
        }
    } else {
        Write-Host "Le pare-feu est déjà désactivé."
        Add-Content -Path $filePath -Value "$date - pare feu deja désactivé"
    }
}

# Fonction pour activer le pare-feu
function Activer {
    # Vérifie si le pare-feu est désactivé
    $firewallStatus = Get-NetFirewallProfile | Where-Object { $_.Enabled -eq $false }

    if ($firewallStatus) {
        Write-Host "Activation du pare-feu..."
        Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled True
        # Vérification de l'état du pare-feu après activation
        $newStatus = Get-NetFirewallProfile | Where-Object { $_.Enabled -eq $false }
        if ($newStatus) {
            Write-Host "Le pare-feu est toujours désactivé."
             Add-Content -Path $filePath -Value "$date - Erreur: le pare feu est toujours désactivé"
        } else {
            Write-Host "Le pare-feu a été activé avec succès."
             Add-Content -Path $filePath -Value "$date - pare feu activé"
        }
    } else {
        Write-Host "Le pare-feu est déjà activé."
        Add-Content -Path $filePath -Value "$date - pare feu deja activé"
    }
}

# Menu principal
while ($true) {
    Clear-Host
    $choix = Read-Host "Choisissez une option : 
    1) Désactiver le pare-feu
    2) Activer le pare-feu
    3) Quitter"

    switch ($choix) {
        1 {
            Desactiver
            Read-Host "Appuyez sur [Entrée] pour revenir au menu principal..."
        }
        2 {
            Activer
            Read-Host "Appuyez sur [Entrée] pour revenir au menu principal..."
        }
        3 {
            Write-Host "Au revoir!"
            exit 0
        }
        default {
            Write-Host "Choix invalide."
            Read-Host "Appuyez sur [Entrée] pour revenir au menu principal..."
        }
    }
}
