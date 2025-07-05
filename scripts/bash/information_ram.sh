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

# Fonction pour afficher la mémoire RAM totale
Ram_total() {
    clear
    ssh $nomssh@$addressip free -h -t
    log_action "Mémoire RAM totale affichée"
}

# Fonction pour afficher l'utilisation de la RAM
Utilisation_ram() {
    clear
    ssh $nomssh@$addressip free -h
    log_action "Utilisation de la mémoire RAM affichée"
}

# Menu des options pour la mémoire RAM
while true; do
    
    echo "=== Historique des activités de la RAM ==="
    echo "1. Mémoire RAM totale"
    echo "2. Utilisation de la RAM"
    echo "3. Retour"
    read -p "Choisissez une option: " choice

    case $choice in
        1) Ram_total ;;
        2) Utilisation_ram ;;
        3) echo "Retour au menu principal..." ; break ;;
        *) echo "Choix invalide !" ;;
    esac
done
