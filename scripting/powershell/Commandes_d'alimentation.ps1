# --- Script de gestion des commandes d'alimentation en PowerShell ---

# Demander les informations de connexion
$sshname = Read-Host "Donner le nom du client"
$sship = Read-Host "Donner l'adresse IP du client"
$LOG_DATE = Get-Date -Format "yyyy-MM-dd"
$LOG_FILE = "C:\Users\Wilder\Documents\log_evt_$LOG_DATE.log"  # Chemin du fichier log avec la date dans le nom

# Récupérer la date actuelle
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"  # Date et heure actuelles pour les entrées de log

# Fonction pour créer un fichier log
function Create-LogFile {
    # Vérifie si le fichier log existe
    if (-not (Test-Path $LOG_FILE)) {
        # Crée le fichier log
        New-Item -Path $LOG_FILE -ItemType File
        Write-Host "Fichier '$LOG_FILE' créé avec succès."
        # Ajouter une entrée pour signaler la création du fichier
        Add-Content -Path $LOG_FILE -Value "$date - Fichier créé"
    } else {
        Write-Host "Le fichier '$LOG_FILE' existe déjà."
    }
}

# Fonction pour enregistrer l'action dans le fichier log
function Log-Action {
    param (
        [string]$action
    )
    Add-Content -Path $LOG_FILE -Value "$date - $action"
}

# Appel de la fonction pour créer le fichier log
Create-LogFile

while ($true) {
    # Affichage du menu
    Write-Host "=============================="
    Write-Host "Menu de gestion d'alimentation"
    Write-Host "=============================="
    Write-Host "1. Arrêter l'ordinateur"
    Write-Host "2. Redémarrer l'ordinateur"
    Write-Host "3. Verrouiller la session"
    Write-Host "4. Quitter"
    $choice = Read-Host "Choisissez une option [1-4]"

    switch ($choice) {
        1 {
            # Arrêter l'ordinateur
            Write-Host "Arrêt en cours..."
            Stop-Computer -Force
            # Ajouter une entrée dans le fichier log sans écraser son contenu
            Log-Action "L'ordinateur a été arrêté."
            break
        }
        
        2 {
            # Redémarrer l'ordinateur
            Write-Host "Redémarrage en cours..."
            Restart-Computer -Force
            # Ajouter une entrée dans le fichier log sans écraser son contenu
            Log-Action "L'ordinateur a été redémarré."
            break
        }
        
        3 {
            # Verrouiller la session
            Write-Host "Verrouillage de la session..."
            # Utilisation de la commande de verrouillage pour Windows
            rundll32.exe user32.dll,LockWorkStation
            # Ajouter une entrée dans le fichier log sans écraser son contenu
            Log-Action "L'ordinateur a été verrouillé."
        }
        
        4 {
            # Quitter le script
            Write-Host "Au revoir !"
            exit
        }
        
        default {
            # Option invalide
            Write-Host "Option invalide. Veuillez choisir une option entre 1 et 4."
        }
    }

    # Demander de revenir au menu principal après chaque action
    Write-Host
    Read-Host "Appuyez sur [Entrée] pour revenir au menu principal..."
}
