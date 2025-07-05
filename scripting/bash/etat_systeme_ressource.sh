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

# Liste des applications/paquets installés
function Application_installees() {
    ssh $nomssh@$addressip dpkg --get-selections
    log_action "Liste des applications/paquets installés affichée"
}

# Liste des services en cours d'exécution
function Service_en_execution() {
    ssh $nomssh@$addressip systemctl list-units --type=service --state=running
    log_action "Liste des services en cours d'exécution affichée"
}

# Liste des utilisateurs locaux
function Utilisateur_locaux() {
    ssh $nomssh@$addressip cut -d: -f1 /etc/passwd
    log_action "Liste des utilisateurs locaux affichée"
}

# Boucle du menu principal
while true; do
    echo "=== État du système et des ressources ==="
    echo "1. Liste des applications/paquets installés"
    echo "2. Liste des services en cours d'exécution"
    echo "3. Liste des utilisateurs locaux"
    echo "4. Retour"
    read -p "Choisissez une option: " choice

    case $choice in
        1) Application_installees ;;
        2) Service_en_execution ;;
        3) Utilisateur_locaux ;;
        4) echo "Retour au menu principal..." ; break ;;
        *) echo "Choix invalide !" ;;
    esac
done
