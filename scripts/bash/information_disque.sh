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

# Nombre de disques
function nbrDeDisque {
    ssh $nomssh@$addressip fdisk -l
    log_action "Information nombre de disque"
}

# Partition par disque
function partitionParDisque {
    ssh $nomssh@$addressip parted --list
    log_action "Information partition de disque"
}

# Espace disque restant par partition
function espaceDiskRestant {
    ssh $nomssh@$addressip df -h
    log_action "Information espace disque restant"
}

# Nom et espace disque d'un dossier
function espaceDiskDossier {
    ssh $nomssh@$addressip du -sh
    log_action "Information espace disque dossier"
}

# Liste des disques montés
function listeLecteurMonte {
    ssh $nomssh@$addressip lsblk
    log_action "Information liste lecteur monté"
}

# Menu principal
while true; do
    clear
    echo "=============================="
    echo "Menu de gestion des disques et partitions"
    echo "=============================="
    echo "1) Nombre de disques"
    echo "2) Partition par disque"
    echo "3) Espace disque restant par partition"
    echo "4) Nom et espace disque d'un dossier"
    echo "5) Liste des disques montés"
    echo "6) Quitter"
    read -p "Votre choix : " choix

    case $choix in
        1)
            nbrDeDisque
            ;;
        2)
            partitionParDisque
            ;;
        3)
            espaceDiskRestant
            ;;
        4)
            espaceDiskDossier
            ;;
        5)
            listeLecteurMonte
            ;;
        6)
            echo "Au revoir!"
            exit 0
            ;;
        *)
            echo "Choix invalide."
            ;;
    esac
done
