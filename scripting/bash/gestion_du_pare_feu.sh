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

# Fonction pour désactiver le pare-feu
function desactiver {
    ssh $nomssh@$addressip <<EOF
    sudo ufw disable
    ufw status
EOF
    log_action "Le pare-feu est désactivé"
}

# Fonction pour activer le pare-feu
function activer {
    ssh $nomssh@$addressip <<EOF
    sudo ufw enable
    ufw status
EOF
    log_action "Le pare-feu est activé"
}

# Menu principal
while true; do
    clear
    echo "=== Gestion du pare-feu ==="
    echo "1) Désactiver le pare-feu"
    echo "2) Activer le pare-feu"
    echo "3) Quitter"
    read -p "Choisissez une option : " choix

    case $choix in
        1)
            desactiver
            ;;
        2)
            activer
            ;;
        3)
            echo "Au revoir!"
            exit 0
            ;;
        *)
            echo "Choix invalide."
            ;;
    esac
done
