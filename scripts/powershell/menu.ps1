# Début du script
function Debut-Script  {
    Clear-Host
    Write-Host "=== Menu Principal ==="
    Write-Host "1. Action sur Utilisateurs ou Ordinateur"
    Write-Host "2. Information sur Utilisateurs ou Ordinateurs"
    Write-Host "3. Quitter"
    $choice = Read-Host "Choisissez une option"

    switch ($choice) {
        1 { Main-Menu }
        2 { Main-Menu2 }
        3 { exit }
        default { Write-Host "Choix invalide !" ; Debut-Script }
    }
}

# Menu principal pour les actions
function Main-Menu {
    Clear-Host
    Write-Host "=== Menu Principal ==="
    Write-Host "1. Gestion des Utilisateurs"
    Write-Host "2. Gestion des Ordinateurs"
    Write-Host "3. Quitter"
    $choice = Read-Host "Choisissez une option"

    switch ($choice) {
        1 { Menu-Gestion-Utilisateur }
        2 { Menu-Gestion-Ordinateur }
        3 { exit }
        default { Write-Host "Choix invalide !" ; Main-Menu }
    }
}

# Sous-menu pour la gestion des utilisateurs
function Menu-Gestion-Utilisateur {
    Clear-Host
    Write-Host "=== Gestion des Utilisateurs ==="
    Write-Host "1. Compte Utilisateur"
    Write-Host "2. Groupes"
    Write-Host "3. Retour au Menu Principal"
    $choice = Read-Host "Choisissez une option"

    switch ($choice) {
        1 { & "./Compte_Utilisateur.ps1" }
        2 { & "./Groupes.ps1" }
        3 { Main-Menu }
        default { Write-Host "Choix invalide !" ; Menu-Gestion-Utilisateur }
    }
}

# Sous-menu pour la gestion des ordinateurs
function Menu-Gestion-Ordinateur {
    Clear-Host
    Write-Host "=== Gestion des Ordinateurs ==="
    Write-Host "1. Commande d'alimentation"
    Write-Host "2. Mise à jour du système"
    Write-Host "3. Gestion de répertoire"
    Write-Host "4. Gestion du pare-feu"
    Write-Host "5. Gestion des logiciels"
    Write-Host "6. Retour au Menu Principal"
    $choice = Read-Host "Choisissez une option"

    switch ($choice) {
        1 { & "./Commandes_d'alimentation.ps1" }
        2 { & "./Mise_a_jour_du_systeme.ps1" }
        3 { & "./Gestion_repertoire.ps1"}
        4 { & "./gestion_du_pare_feu.ps1" }
        5 { & "./install_desinstall_logiciel.ps1" }
        6 { Main-Menu }
        default { Write-Host "Choix invalide !" ; Menu-Gestion-Ordinateur }
    }
}

# Menu principal pour les informations
function Main-Menu2 {
    Clear-Host
    Write-Host "=== Menu Principal Information ==="
    Write-Host "1. Information des Utilisateurs"
    Write-Host "2. Information des Ordinateurs"
    Write-Host "3. Script"
    Write-Host "4. Quitter"
    $choice = Read-Host "Choisissez une option"

    switch ($choice) {
        1 { Menu-Information-Utilisateur }
        2 { Menu-Information-Ordinateur }
        3 { exit }
        default { Write-Host "Choix invalide !" ; Main-Menu2 }
    }
}

# Sous-menu pour les informations des utilisateurs
function Menu-Information-Utilisateur {
    Clear-Host
    Write-Host "=== Information des Utilisateurs ==="
    Write-Host "1. Historique des activités utilisateur"
    Write-Host "2. Profils et activités utilisateurs"
    Write-Host "3. Droits/permissions utilisateurs"
    Write-Host "4. Retour au Menu Principal"
    $choice = Read-Host "Choisissez une option"

    switch ($choice) {
        1 { & "./historique_des_activités_utilisateurs.ps1" }
        2 { & "./profil_et_activités_utilisateurs.ps1"}
        3 { & "./Droits_permissions_utilisateur.ps1"}
        4 { Main-Menu2 }
        default { Write-Host "Choix invalide !" ; Menu-Information-Utilisateur }
    }
}

# Sous-menu pour les informations des ordinateurs
function Menu-Information-Ordinateur {
    Clear-Host
    Write-Host "=== Information des Ordinateurs ==="
    Write-Host "1. Version de l'OS"
    Write-Host "2. Information disque"
    Write-Host "3. Etat du système et des ressources"
    Write-Host "4. Informations RAM"
    Write-Host "5. Retour au Menu Principal"
    $choice = Read-Host "Choisissez une option"

    switch ($choice) {
        1 { & "./version_os.ps1" }
        2 { & "./information_disque.ps1" }
        3 { & "./etat_systeme_ressource.ps1" }
        4 { & "./information_ram.ps1" }
        5 { Main-Menu2 }
        default { Write-Host "Choix invalide !" ; Menu-Information-Ordinateur }
    }
}


# Exécution du script
Debut-Script
