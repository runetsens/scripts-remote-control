# Journalisation
journalisation() {
    # Demander à l'utilisateur s'il veut consulter le log d'aujourd'hui ou d'une autre date
    read -p "Voulez-vous consulter le log d'aujourd'hui (O/N) ? " today_choice
    today_choice=$(echo "$today_choice" | tr '[:lower:]' '[:upper:]')  # Convertir la réponse en majuscule

    if [[ "$today_choice" == "O" ]]; then
        LOG_DATE=$(date +"%Y-%m-%d")  # Date actuelle
    else
        # Demander à l'utilisateur de saisir une autre date
        read -p "Entrez la date du log à consulter (format YYYY-MM-DD) : " log_date
        LOG_DATE=$log_date
    fi

    LOG_FILE="/home/wilder/Documents/log_evt_$LOG_DATE.log"  # Chemin du fichier log

    # Vérifier si le fichier log existe
    if [ -f "$LOG_FILE" ]; then
        # Afficher le contenu du fichier log
        cat "$LOG_FILE"
        echo "Affichage du log pour la date : $LOG_DATE"
    else
        echo "Le fichier log pour la date $LOG_DATE n'existe pas."
    fi
}