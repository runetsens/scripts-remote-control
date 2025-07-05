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

# Fonction pour afficher la date de la dernière connexion de l'utilisateur
connexion_utilisateur(){
    ssh $nomssh@$addressip last -n 1
    log_action "Information sur la dernière connexion de l'utilisateur affichée"
}

# Fonction pour afficher la date de dernière modification du mot de passe d'un utilisateur
motDePasse_utilisateur(){
    read -p "Nom de l'utilisateur: " nom
    ssh $nomssh@$addressip <<EOF
    if id "$nom" &>/dev/null; then
        chage -l "$nom" | grep "Dernière modification du mot de passe"
        log_action "Information sur la dernière modification du mot de passe de l'utilisateur $nom affichée"
    else
        echo "Utilisateur introuvable."
    fi
EOF    
}

# Fonction pour afficher la liste des sessions ouvertes par les utilisateurs
session_ouverte_utilisateur(){
    ssh $nomssh@$addressip who
    log_action "Information sur les sessions ouvertes par les utilisateurs affichée"
}

# Menu des options d'historique d'activités utilisateur
while true; do
    echo "=== Historique des activités utilisateur ==="
    echo "1. Date de dernière connexion d'un utilisateur"
    echo "2. Date de dernière modification du mot de passe"
    echo "3. Liste des sessions ouvertes par l'utilisateur"
    echo "4. Retour"
    read -p "Choisissez une option: " choice

    case $choice in
        1) connexion_utilisateur ;;
        2) motDePasse_utilisateur ;;
        3) session_ouverte_utilisateur ;;
        4) echo "Retour au menu principal..." ;;
        *) echo "Choix invalide !" && continue ;;
    esac
done
