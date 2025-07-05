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

# Fonction pour créer un répertoire
function create {
    read -p "Donnez un nom à votre répertoire : " nom

    # Vérifier si le répertoire n'existe pas
    while true; do
        ssh $nomssh@$addressip <<EOF
            if [ ! -e "$nom" ]; then
                mkdir "$nom"
                echo "Le dossier est créé."
                log_action "Le dossier $nom est créé"
                exit 0
            else 
                echo "Ce dossier existe déjà."
                read -p "Voulez-vous essayer un autre nom ? (o/n) : " reessayer
                if [[ "$reessayer" != "o" ]]; then
                    break
                fi
            fi 
EOF        
    done
}

# Fonction pour modifier un répertoire
function modified {
    while true; do
        read -p "Quel répertoire voulez-vous modifier : " nomrep
        ssh $nomssh@$addressip <<EOF
            if [ ! -e "$nomrep" ]; then
                echo "Ce dossier n'existe pas."
            else
                while true; do
                    read -p "Quel nouveau nom voulez-vous donner à \"$nomrep\" : " newname
                    if [ ! -e "$newname" ]; then
                        mv "$nomrep" "$newname"
                        echo "Le nom a été modifié."
                        log_action "Le dossier $nomrep a été renommé en $newname"
                        break
                    else
                        echo "Ce dossier existe déjà."
                    fi
                done
            fi 
EOF        
    done  
}

# Fonction pour supprimer un répertoire
function delete {
    while true; do
        read -p "Quel répertoire voulez-vous supprimer : " repsup
        ssh $nomssh@$addressip <<EOF
            if [ -e "$repsup" ]; then
                rm -r "$repsup"
                echo "Le répertoire a été supprimé."
                log_action "Le dossier $repsup a été supprimé"
                break
            else
                echo "Ce dossier n'existe pas."
            fi
EOF        
    done
}

# Menu principal
while true; do
    clear
    read -p "Choisissez une option : 
    1) Créer un dossier
    2) Modifier un dossier
    3) Supprimer un dossier
    4) Quitter
    Votre choix : " choix

    case $choix in
        1)
            create
            ;;
        2)
            modified
            ;;
        3)
            delete
            ;;
        4)
            echo "Au revoir!"
            exit 0
            ;;
        *)
            echo "Choix invalide."
            ;;
    esac
done
