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

# Fonction pour afficher le groupe d'appartenance d'un utilisateur
groupe_appartenance_utilisateur() {
    ssh $nomssh@$addressip groups
    log_action "Succès demande appartenance au groupe"
}

# Fonction pour afficher l'historique des commandes exécutées par l'utilisateur
historique_commande_utilisateur() {
    ssh $nomssh@$addressip "cat /home/wilder/.bash_history"
    log_action "Succès demande historique de commandes"
}

# Menu des options d'historique d'activités utilisateur
while true; do
    clear
    echo "=== Historique des activités utilisateur ==="
    echo "1. Groupe d'appartenance d'un utilisateur"
    echo "2. Historique des commandes exécutées par l'utilisateur"
    echo "3. Retour"
    read -p "Choisissez une option: " choice

    case $choice in
        1) groupe_appartenance_utilisateur ;;
        2) historique_commande_utilisateur ;;
        3) echo "Retour au menu principal..." ;;
        *) echo "Choix invalide !" ;;
    esac
done
