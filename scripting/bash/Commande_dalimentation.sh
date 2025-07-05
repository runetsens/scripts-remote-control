#!/bin/bash

# --- Script de gestion des commandes d'alimentation ---

# Connexion via SSH
#read -p "Donner le nom du client : " sshname
#read -p "Donner l'adresse IP du client : " sship

nomssh=$sshname
addressip=$sship

# Récupérer la date actuelle
LOG_DATE=$(date +"%Y-%m-%d")
LOG_FILE="/home/wilder/Documents/log_evt_$LOG_DATE.log"  # Chemin du fichier log avec la date dans le nom
date=$(date "+%Y-%m-%d %H:%M:%S")  # Date et heure actuelles pour les entrées de log

# Fonction pour créer un fichier log
create_file() {
    # Vérifie si le fichier log existe
    if [ ! -f "$LOG_FILE" ]; then
        # Crée le fichier log
        touch "$LOG_FILE"
        echo "Fichier '$LOG_FILE' créé avec succès."
        # Ajoute un message de création avec la date dans le fichier
        echo "$date - Fichier créé" >> "$LOG_FILE"
    else
        echo "Le fichier '$LOG_FILE' existe déjà." > /dev/null
    fi
}

# Fonction pour enregistrer l'action dans le fichier log
log_action() {
    echo "$date - $1" >> "$LOG_FILE"
}

# Appel de la fonction pour créer le fichier log
create_file

stop(){

  # Arrêter l'ordinateur
            echo "Arrêt en cours..."
            if
            # ssh $nomssh@$addressip 
            "shutdown now"; then
                log_action "Arrêt de l'ordinateur"
            else
                echo "Erreur de connexion ou d'exécution de la commande 'shutdown'."
                log_action "Erreur d'exécution de 'shutdown'"
            fi
            break   
}

reboot(){
 # Redémarrer l'ordinateur
            echo "Redémarrage en cours..."
            if 
            #ssh $nomssh@$addressip 
            "reboot"; then
                log_action "Redémarrage de l'ordinateur"
            else
                echo "Erreur de connexion ou d'exécution de la commande 'reboot'."
                log_action "Erreur d'exécution de 'reboot'"
            fi
            break
}

veille(){

     # Verrouiller la session
            echo "Verrouillage de la session..."
            #ssh $nomssh@$addressip <<EOF
            if command -v gnome-screensaver-command &>/dev/null; then
                gnome-screensaver-command -l
                echo "Session verrouillée avec gnome-screensaver-command"
                exit 0
            elif command -v loginctl &>/dev/null; then
                loginctl lock-session
                echo "Session verrouillée avec loginctl"
                exit 0
            elif command -v xtrlock &>/dev/null; then
                 xtrlock
                echo "Session verrouillée avec xtrlock"
                exit 0
            else
                echo "Impossible de verrouiller la session : aucune méthode disponible."
                exit 1
            fi
#EOF
            # Vérification de la réussite de l'opération
            if [ $? -eq 0 ]; then
                log_action "Verrouillage de l'ordinateur"
            else
                log_action "Erreur verrouillage de l'ordinateur"
            fi
}

while true; do
    # Affichage du menu
    clear
    echo "=============================="
    echo "Menu de gestion d'alimentation"
    echo "=============================="
    echo "1. Arrêter l'ordinateur"
    echo "2. Redémarrer l'ordinateur"
    echo "3. Verrouiller la session"
    echo "4. Quitter"
    echo -n "Choisissez une option [1-4] : "
    read choice

    case $choice in
        1)
          stop 
            ;;
        
        2)
         reboot  
            ;;
        
        3)
          veille 
            ;;
        
        4)
            # Quitter le script
            echo "Au revoir !"
            exit 0
            ;;
        
        *)
            # Option invalide
            echo "Option invalide. Veuillez choisir une option entre 1 et 4."
            ;;
    esac

    # Demander de revenir au menu principal après chaque action
    echo
    read -p "Appuyez sur [Entrée] pour revenir au menu principal..."
done
