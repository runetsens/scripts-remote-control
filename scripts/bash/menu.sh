#!/bin/bash

# Début de script
debut_script() {
    clear
    echo "=== Menu Principal ==="
    echo "1. Action sur Utilisateurs ou Ordinateur"
    echo "2. Information sur Utilisateurs ou Ordinateurs"
    echo "3. journalisation"
    echo "4. Quitter"
    read -p "Choisissez une option: " choice

    case $choice in
        1) main_menu ;;
        2) main_menu2 ;;
        3) source journalisation.sh ;;
        4) exit 0 ;;
        *) echo "Choix invalide !" && debut_script ;;
    esac
}


# Menu principal
main_menu() {
    clear
    echo "=== Menu Principal ==="
    echo "1. Gestion des Utilisateurs"
    echo "2. Gestion des Ordinateurs"
    echo "3. Quitter"
    read -p "Choisissez une option: " choice

    case $choice in
        1) menu_gestion_utilisateur ;;
        2) menu_gestion_ordinateur ;;
        3) exit 0 ;;
        *) echo "Choix invalide !" && main_menu ;;
    esac
}

# Sous-menu pour la gestion des utilisateurs
menu_gestion_utilisateur() {
    clear
    echo "=== Gestion des Utilisateurs ==="
    echo "1. Compte Utilisateur"
    echo "2. Groupes"
    echo "3. Retour au Menu Principal"
    read -p "Choisissez une option: " choice

    case $choice in
        1) source Compte_Utilisateur.sh ;;
        2) source Groupes.sh ;;
        3) main_menu ;;
        *) echo "Choix invalide !" && menu_gestion_utilisateur ;;
    esac
}

# Sous-menu pour la gestion des ordinateurs
menu_gestion_ordinateur() {
    clear
    echo "=== Gestion des Ordinateurs ==="
    echo "1. Commande d'alimentation"
    echo "2. Mise à jour du système"
    echo "3. Gestion de répertoire"
    echo "4. Prise en main à distance"
    echo "5. Gestion du pare-feu"
    echo "6. Gestion des logiciels"
    echo "7. Retour au Menu Principal"
    read -p "Choisissez une option: " choice

    case $choice in
        1) source Commande_dalimentation.sh ;;
        2) source Mise_à_jour_du_système.sh ;;
        3) source gestion_repertoire.sh ;;
        4) remote_access_menu ;;
        5) source gestion_du_pare_feu.sh ;;
        6) source install_desinstall_logiciel.sh ;;
        7) main_menu ;;
        *) echo "Choix invalide !" && menu_gestion_ordinateur ;;
    esac
}

# Menu principal pour les informations
main_menu2() {
    clear
    echo "=== Menu Principal Information ==="
    echo "1. Information des Utilisateurs"
    echo "2. Information des Ordinateurs"
    echo "3. Script"
    echo "4. Quitter"
    read -p "Choisissez une option: " choice

    case $choice in
        1) menu_information_utilisateur ;;
        2) menu_information_ordinateur ;;
        3) exit 0 ;;
        *) echo "Choix invalide !" && main_menu2 ;;
    esac
}

# Sous-menu pour les informations des utilisateurs
menu_information_utilisateur() {
    clear
    echo "=== Information des Utilisateurs ==="
    echo "1. Historique des activités utilisateur"
    echo "2. Profils et activités utilisateurs"
    echo "3. Droits/permissions utilisateurs"
    echo "4. Retour au Menu Principal"
    read -p "Choisissez une option: " choice

    case $choice in
        1) source historique_des_activités_utilisateurs.sh ;;
        2) source profil_et_activités_utilisateurs.sh ;;
        3) source Droits_permissions_utilisateur.sh ;;
        4) main_menu2 ;;
        *) echo "Choix invalide !" && menu_information_utilisateur ;;
    esac
}

# Sous-menu pour les informations des ordinateurs
menu_information_ordinateur() {
    clear
    echo "=== Information des Ordinateurs ==="
    echo "1. Version de l'OS"
    echo "2. Information disque"
    echo "3. Etat du système et des ressources"
    echo "4. Informations RAM"
    echo "5. Retour au Menu Principal"
    read -p "Choisissez une option: " choice

    case $choice in
        1) source version_os.sh ;;
        2) source information_disque.sh ;;
        3) source etat_systeme_ressource.sh ;;
        4) source information_ram.sh ;;
        5) main_menu2 ;;
        *) echo "Choix invalide !" && menu_information_ordinateur ;;
    esac
}

# Démarrer le script en affichant le menu principal
debut_script
