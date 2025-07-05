#!/bin/bash

# Connexion via SSH
read -p "Donner le nom du client : " sshname
read -p "Donner l'adresse IP du client : " sship

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

# --- Script de gestion de la mise à jour pour Ubuntu/Debian ---

miseajour(){
# Vérification que nous sommes sur un système Debian/Ubuntu
            ssh $nomssh@$addressip <<EOF
            if [ -f /etc/debian_version ]; then
                echo "Mise à jour du système en cours sur Debian/Ubuntu..."
                sudo apt update -y && sudo apt upgrade -y
                echo "Mise à jour terminée avec succès !"
                log_action "Mise à jour terminée avec succès"
            else
                echo "Ce script est uniquement conçu pour les systèmes Debian/Ubuntu."
            fi
EOF            
}
while true; do
    # Affichage du menu
    clear
    echo "=============================="
    echo "Menu de gestion de mise à jour"
    echo "=============================="
    echo "1. Mettre à jour le système"
    echo "2. Quitter"
    echo -n "Choisissez une option [1-2] : "
    read choice

    case $choice in
        1)
            miseajour
            ;;

        2)
            # Quitter le script
            echo "Au revoir !"
            log_action "Quitter le script"
            exit 0
            ;;

        *)
            # Option invalide
            echo "Option invalide. Veuillez choisir une option entre 1 et 2."
            log_action "Choix invalide"
            ;;
    esac

    # Demander de revenir au menu principal après chaque action
    echo
    read -p "Appuyez sur [Entrée] pour revenir au menu principal..."
done
