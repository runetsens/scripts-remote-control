#!/bin/bash

# --- Script de gestion des droits et permissions utilisateurs ---

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

# Fonction pour afficher le groupe d'appartenance d'un utilisateur sur un dossier
dossier_utilisateur() {
    read -p "Donnez le nom du dossier : " dossier
    ssh $nomssh@$addressip ls -l "$dossier"
    log_action "Droits sur le dossier '$dossier' affichés"
}

# Fonction pour afficher les droits sur un fichier utilisateur
fichier_utilisateur() {
    read -p "Donnez le nom du fichier : " fichier
    ssh $nomssh@$addressip ls -ld "$fichier"
    log_action "Droits sur le fichier '$fichier' affichés"
}

# Menu des options d'historique d'activités utilisateur
while true; do
    clear
    echo "=== Historique des activités utilisateur ==="
    echo "1. Droits/permissions de l'utilisateur sur un dossier"
    echo "2. Droits/permission de l'utilisateur sur un fichier"
    echo "3. Retour"
    read -p "Choisissez une option : " choice

    case $choice in
        1) dossier_utilisateur ;;
        2) fichier_utilisateur ;;
        3) echo "Retour au menu principal..." && break ;;
        *) echo "Choix invalide !" ;;
    esac
done
