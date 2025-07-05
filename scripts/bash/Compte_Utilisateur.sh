#!/bin/bash

# --- Script de gestion des comptes utilisateurs ---

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

# Fonction pour afficher le menu principal
main_menu() {
    clear
    echo "=== Menu Principal ==="
    echo "1. Créer un compte utilisateur"
    echo "2. Modifier le mot de passe d'un compte utilisateur"
    echo "3. Supprimer un compte utilisateur"
    echo "4. Désactiver un compte utilisateur"
    echo "5. Quitter"
    read -p "Choisissez une option: " choice

    case $choice in
        1) menu_creation_compte_utilisateur ;;
        2) menu_modification_mot_de_passe ;;
        3) menu_suppression_dun_compte_utilisateur ;;
        4) menu_désactiver_un_compte_utilisateur_local ;;
        5) exit 0 ;;
        *) echo "Choix invalide ! Veuillez réessayer." && main_menu ;;
    esac
}

# Sous-menu pour la création d'un compte utilisateur
menu_creation_compte_utilisateur() {
    clear
    echo "=== Création compte utilisateur ==="
    read -p "Donner un nom de compte à créer : " newUser
    ssh $nomssh@$addressip <<EOF
    if grep -q "^$newUser:" /etc/passwd; then
        echo -e "Utilisateur $newUser existe\nSortie du script"
        exit 1
    else
        echo "Création utilisateur $newUser"
        sudo useradd "$newUser" > /dev/null
        if grep -q "^$newUser:" /etc/passwd; then
            echo "Utilisateur $newUser créé !"
            log_action "Utilisateur $newUser créé"
        else
            echo "Utilisateur $newUser non créé ==> problème"
            log_action "Erreur utilisateur $newUser non créé"
        fi
    fi
EOF
    read -p "Appuyez sur Entrée pour revenir au menu principal..."
    main_menu  # Retour au menu principal
}

# Fonction pour la modification du mot de passe
menu_modification_mot_de_passe() {
    clear
    echo "Modification du mot de passe compte utilisateur"
    read -s -p "Nouveau mot de passe : " mdp
    echo ""
    ssh $nomssh@$addressip <<EOF
    if test -z "$mdp"; then
        echo "Le mot de passe ne peut pas être vide."
        exit 1
    fi

    read -s -p "Retapez le mot de passe (vérification) : " mdp2
    echo ""

    if [ "$mdp" != "$mdp2" ]; then
        echo "Les mots de passe saisis ne correspondent pas."
        exit 1
    fi

    # Change le mot de passe
    echo "$mdp" | sudo passwd --stdin $newUser
    if [ $? -eq 0 ]; then
        echo "Modification du mot de passe avec succès."
        log_action "Succès modification mot de passe"
    else
        echo "Erreur lors de la modification du mot de passe."
        log_action "Erreur modification mot de passe"
    fi
EOF
    read -p "Appuyez sur Entrée pour revenir au menu principal..."
    main_menu  # Retour au menu principal
}

# Sous-menu pour la suppression d'un compte utilisateur
menu_suppression_dun_compte_utilisateur() {
    clear
    echo "=== Suppression d'un compte utilisateur ==="
    read -p "Donner un nom de compte utilisateur à supprimer : " delUser
    ssh $nomssh@$addressip <<EOF
    if grep -qw "$delUser" /etc/passwd > /dev/null 2>&1; then
        echo -e "Utilisateur $delUser existe\nGo SUPPRESSION !"
        sudo userdel -r -f "$delUser" 2> /dev/null
        if ! grep -qw "$delUser" /etc/passwd; then
            echo "Utilisateur $delUser supprimé."
            log_action "Utilisateur $delUser supprimé"
        else
            echo "! Erreur : Utilisateur $delUser non supprimé."
            log_action "Erreur utilisateur $delUser non supprimé"
        fi
    else
        echo -e "Utilisateur $delUser non existant.\nSortie du script."
        log_action "Erreur : Utilisateur $delUser non existant"
        exit 1
    fi
EOF
    read -p "Appuyez sur Entrée pour revenir au menu principal..."
    main_menu  # Retour au menu principal
}

# Sous-menu pour désactiver un compte utilisateur local

menu_désactiver_un_compte_utilisateur_local() {
    clear
    echo "=== Désactivation d'un compte utilisateur local ==="
    read -p "Donner un nom de compte utilisateur à désactiver : " userToDisable
    ssh $nomssh@$addressip <<EOF
    if grep -qw "$userToDisable" /etc/passwd > /dev/null 2>&1; then
        echo -e "Utilisateur $userToDisable existe\nDésactivation en cours..."
        sudo usermod -L "$userToDisable"  # Lock the account
        if passwd -S "$userToDisable" | grep -q "L"; then  # Check if account is locked
            echo "Utilisateur $userToDisable désactivé."
            log_action "Utilisateur $userToDisable désactivé"
        else
            echo "! Erreur : Utilisateur $userToDisable non désactivé."
            log_action "Erreur utilisateur $userToDisable non désactivé"
        fi
    else
        echo -e "Utilisateur $userToDisable non existant.\nSortie du script."
        log_action "Erreur : Utilisateur $userToDisable non existant"
        exit 1
    fi
EOF
    read -p "Appuyez sur Entrée pour revenir au menu principal..."
    main_menu  # Retour au menu principal
}

# Lancer le menu principal
main_menu
