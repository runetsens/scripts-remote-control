# Demander l'IP ou le nom de la machine distante
$remoteComputer = Read-Host "Veuillez entrer l'IP ou le nom de la machine distante"

# Demander les informations d'identification une seule fois
$credential = Get-Credential

# Récupérer la date actuelle pour les logs
$logDate = (Get-Date).ToString("yyyy-MM-dd")  # Formater la date pour le nom du fichier log
$logFile = "C:\Users\wilder\Documents\log_evt_$logDate.log"  # Chemin du fichier log avec la date dans le nom
$date = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")  # Date et heure actuelles pour les entrées de log


# Fonction pour créer un fichier log
function Create-LogFile {
    # Vérifie si le répertoire existe
    $logDir = [System.IO.Path]::GetDirectoryName($logFile)
    if (-Not (Test-Path $logDir)) {
        # Si le répertoire n'existe pas, le créer
        New-Item -Path $logDir -ItemType Directory -Force
        Write-Host "Répertoire '$logDir' créé avec succès."
    }

    # Vérifie si le fichier log existe
    if (-Not (Test-Path $logFile)) {
        # Si le fichier n'existe pas, le créer
        New-Item -Path $logFile -ItemType File -Force
        Write-Host "Fichier '$logFile' créé avec succès."
    } else {
        Write-Host "Le fichier '$logFile' existe déjà."
    }
}


# Fonction pour enregistrer l'action dans le fichier log
function Log-Action($message) {
    $date = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")  # Met à jour la date pour chaque action
    Add-Content -Path $logFile -Value "$date - $message"
}


# Créer le fichier log au début du script
Create-LogFile

# Fonction pour exécuter des commandes à distance
function Execute-RemoteCommand {
    param (
        [string]$Command
    )
    # Utilisation de Invoke-Command avec un ScriptBlock
    Invoke-Command -ComputerName $remoteComputer -Credential $credential -ScriptBlock {
        param ($Command)
        
        # Vérification de la commande à exécuter
        Invoke-Expression $Command
    } -ArgumentList $Command
}


# Fonction de confirmation pour continuer
function Ask-Continue {
    $response = Read-Host "Appuyez sur Entrée pour revenir au menu principal..."
    Main-Menu
}

# Fonction pour afficher le menu principal
function Main-Menu {
    clear
    Write-Host "=== Menu Principal ==="
    Write-Host "1. Créer un compte utilisateur"
    Write-Host "2. Modifier le mot de passe d'un compte utilisateur"
    Write-Host "3. Supprimer un compte utilisateur"
    Write-Host "4. Désactiver un compte utilisateur"
    Write-Host "5. Quitter"
    $choice = Read-Host "Choisissez une option"

    switch ($choice) {
        "1" { Menu-Creation-Compte-Utilisateur }
        "2" { Menu-Modification-Mot-De-Passe }
        "3" { Menu-Suppression-Compte-Utilisateur }
        "4" { Menu-Désactiver-Compte-Utilisateur }
        "5" { exit }
        default { Write-Host "Choix invalide ! Veuillez réessayer." ; Main-Menu }
    }
}

# Sous-menu pour la création d'un compte utilisateur
function Menu-Creation-Compte-Utilisateur {
    Clear-Host
    $newUser = Read-Host "Entrez le nom du compte à créer"
    Log-Action "Début de la création de l'utilisateur $newUser sur $remoteComputer"

    $command = @"
        if (!(Get-LocalUser -Name "$newUser" -ErrorAction SilentlyContinue)) {
            New-LocalUser -Name "$newUser" -NoPassword -FullName "$newUser"
            "Utilisateur $newUser créé !"
        } else {
            "L'utilisateur $newUser existe déjà."
        }
"@
    $output = Execute-RemoteCommand -Command $command
    Write-Host $output
    Log-Action "Fin de la création de l'utilisateur $newUser sur $remoteComputer"

    Ask-Continue
}

# Sous-menu pour la modification du mot de passe d'un utilisateur
function Menu-Modification-Mot-De-Passe {
    Clear-Host
    $userName = Read-Host "Entrez le nom de l'utilisateur"
    $newPassword = Read-Host "Entrez le nouveau mot de passe" -AsSecureString
    $command = @"
        Set-LocalUser -Name '$userName' -Password (ConvertTo-SecureString '$newPassword' -AsPlainText -Force)
        'Mot de passe de $userName modifié avec succès'
"@
    $output = Execute-RemoteCommand -Command $command
    Write-Host $output
    Log-Action "Mot de passe de $userName modifié"

    Ask-Continue
}

# Sous-menu pour la suppression d'un compte utilisateur
function Menu-Suppression-Compte-Utilisateur {
    Clear-Host
    $delUser = Read-Host "Entrez le nom de l'utilisateur à supprimer"
    Log-Action "Début de la suppression de l'utilisateur $delUser sur $remoteComputer"

    $command = @"
        if (Get-LocalUser -Name "$delUser" -ErrorAction SilentlyContinue) {
            Remove-LocalUser -Name "$delUser"
            "Utilisateur $delUser supprimé avec succès."
        } else {
            "L'utilisateur $delUser n'existe pas."
        }
"@
    $output = Execute-RemoteCommand -Command $command
    Write-Host $output
    Log-Action "Fin de la suppression de l'utilisateur $delUser sur $remoteComputer"

    Ask-Continue
}


# Sous-menu pour désactiver un compte utilisateur local
function Menu-Désactiver-Compte-Utilisateur {
    Clear-Host
    $userToDisable = Read-Host "Entrez le nom de l'utilisateur à désactiver"
    Log-Action "Début de la désactivation de l'utilisateur $userToDisable sur $remoteComputer"

    $command = @"
        if (Get-LocalUser -Name "$userToDisable" -ErrorAction SilentlyContinue) {
            Disable-LocalUser -Name "$userToDisable"
            "Utilisateur $userToDisable désactivé avec succès."
        } else {
            "L'utilisateur $userToDisable n'existe pas."
        }
"@
    $output = Execute-RemoteCommand -Command $command
    Write-Host $output
    Log-Action "Fin de la désactivation de l'utilisateur $userToDisable sur $remoteComputer"

    Ask-Continue
}

# Lancer le menu principal
Main-Menu
