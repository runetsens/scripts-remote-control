
# Guide Utilisateur pour le Script d'Automatisation des Tâches

- [Guide Utilisateur pour le Script d'Automatisation des Tâches](#guide-utilisateur-pour-le-script-dautomatisation-des-tâches)
  - [Introduction](#introduction)
  - [Prérequis](#prérequis)
  - [Démarrer le Script](#démarrer-le-script)
- [MENU PRINCIPAL](#menu-principal)
  - [Connexion SSH/winRM](#connexion-sshwinrm)
  - [Actions sur les Utilisateurs/Ordinateurs](#actions-sur-les-utilisateursordinateurs)
    - [Utilisateur](#utilisateur)
    - [Ordinateur Client](#ordinateur-client)
  - [Informations sur les Utilisateurs/Ordinateurs](#informations-sur-les-utilisateursordinateurs)
    - [Utilisateur](#utilisateur-1)
    - [Ordinateur Client](#ordinateur-client-1)
  - [Journalisation des Requêtes](#journalisation-des-requêtes)
  - [Retour à l'Étape Précédente](#retour-à-létape-précédente)
  - [Quitter le Script](#quitter-le-script)
  - [Continuer ou Quitter](#continuer-ou-quitter)
  - [FAQ](#faq)

## Introduction
Ces script Bash et powershell permettent d'automatiser diverses tâches d'administration sur un serveur Debian en se connectant à un client Ubuntu ou sur un serveur windows server 2022 en se connectant à un client windows 10. Vous pouvez effectuer des actions sur les utilisateurs et les ordinateurs, récupérer des informations sur ces éléments, ainsi que consulter la journalisation des requêtes effectuées.

## Prérequis
Avant de commencer, assurez-vous que les éléments suivants sont en place :
- Un serveur Debian ou windows configuré.
- Un client Ubuntu configuré pour accepter des connexions SSH ou windows pour accepter le connexions winRM
- Le script Bash/powershell installé sur votre serveur debian/windows.
- Une connexion réseau entre le serveur Debian/windows et le client Ubuntu/windows.

## Démarrer le Script
Pour démarrer le script, ouvrez un terminal sur votre serveur debian et exécutez la commande suivante :

./Script_automatisation.sh

Pour démarrer le script, ouvrez un terminal sur votre serveur windows et exécutez la commande suivante :

invoke-command -computerName <nom ou ip> -FIlePath c:\users\wilder\documents\Script_automatisation.ps1

# MENU PRINCIPAL

Le menu principal vous permet de naviguer entre différentes sections du script. Voici les options disponibles :

   1. **Actions sur les Utilisateurs/Ordinateurs**
    Effectuer des actions administratives sur les utilisateurs ou ordinateurs.

    2. **Informations sur les Utilisateurs/Ordinateurs**
    Obtenir des informations détaillées sur les utilisateurs ou ordinateurs.

    3. **Journalisation des Requêtes**
    Consulter la journalisation des actions effectuées avec les timestamps correspondants.

    4. **Retour à l'Étape Précédente**
    Revenir à la section précédente du script.

    5. **Quitter le Script**
    Quitter le script une fois que vous avez terminé.

Pour sélectionner une option, entrez le numéro correspondant. Par exemple, pour afficher les actions possibles sur les utilisateurs et ordinateurs, tapez 1.
## Connexion SSH/winRM

Avant chaque action ou récupération d'information, le script vous demandera :

   - Le nom de l'utilisateur visé.
    - L'adresse IP de l'ordinateur cible.
    - Le mot de passe de l'utilisateur spécifié.

Ces informations sont nécessaires pour établir une connexion SSH et effectuer l'action sur l'ordinateur cible.
## Actions sur les Utilisateurs/Ordinateurs

Voici les actions possibles sur les utilisateurs et ordinateurs :
### Utilisateur
- **Création de compte utilisateur local** : Crée un nouveau compte utilisateur local.
- **Changement de mot de passe** : Permet de changer le mot de passe d'un utilisateur.                                    - **Suppression de compte utilisateur local** : Supprime un compte utilisateur local du système.
 -  **Désactivation de compte utilisateur local** : Désactive un compte utilisateur local sans le supprimer.
- **Ajout à un groupe d'administration** : Ajoute un utilisateur à un groupe d'administration.
- **Ajout à un groupe local** : Ajoute un utilisateur à un groupe local spécifique.
- **Sortie d’un groupe local** : Retire un utilisateur d'un groupe local spécifique.

### Ordinateur Client

  - **Commande d'alimentation** :
    - **Arrêt** : Arrête l'ordinateur.
    - **Redémarrage** : Redémarre l'ordinateur.
    - **Verrouillage** : Verrouille l'ordinateur.

- **Mise à jour du système** : Effectue une mise à jour complète du système.

- **Gestion de répertoire** :
        - **Création de répertoire** : Crée un répertoire sur l'ordinateur cible.
        - **Modification de répertoire** : Modifie les propriétés d'un répertoire existant.
        - **Suppression de répertoire** : Supprime un répertoire du système.

- **Prise en main à distance** : Permet de prendre le contrôle à distance de l'ordinateur cible pour effectuer des actions supplémentaires.

- **Gestion du pare-feu** :
       - **Activation du pare-feu** : Active le pare-feu sur l'ordinateur cible.
       - **Désactivation du pare-feu** : Désactive le pare-feu sur l'ordinateur cible.

- **Gestion de logiciel** :
        - **Installation de logiciel** : Installe un logiciel spécifié.
        - **Désinstallation de logiciel** : Désinstalle un logiciel spécifié.
        - **Exécution de script sur la machine distante** : Exécute un script sur l'ordinateur cible.

## Informations sur les Utilisateurs/Ordinateurs

Voici les informations disponibles pour les utilisateurs et ordinateurs :
### Utilisateur

- **Historique des activités des utilisateurs** : Affiche l'historique des actions réalisées par un utilisateur spécifique.
- **Profils et activités des utilisateurs** : Montre les profils d'utilisateurs et leurs actions sur le système.
- **Droits/permissions des utilisateurs** : Vérifie les permissions des utilisateurs sur les fichiers et dossiers.
- **Version de l'OS** : Affiche la version du système d'exploitation utilisé par l'utilisateur.
- **Date de dernière connexion** : Affiche la date et l'heure de la dernière connexion d'un utilisateur.
- **Date de dernière modification du mot de passe** : Affiche la date de la dernière modification du mot de passe de l'utilisateur.
- **Liste des sessions ouvertes** : Affiche la liste des sessions actuellement ouvertes par un utilisateur.
- **Groupe d'appartenance** : Montre les groupes auxquels appartient un utilisateur.
- **Historique des commandes exécutées** : Affiche l'historique des commandes exécutées par l'utilisateur.

### Ordinateur Client

- **Version de l'OS** : Affiche la version du système d'exploitation de l'ordinateur client.
- **Nombre de disques et partitions** :
       - Nombre, nom, système de fichiers (FS), et taille de chaque disque.
        - Espace disque restant pour chaque partition/volume.
- **Nom et espace disque d'un dossier** : Affiche l'espace occupé par un dossier spécifique.
- **Liste des lecteurs montés** : Affiche la liste des lecteurs montés, y compris les disques et les périphériques externes (CD, etc.).
- **Liste des applications/paquets installés** : Affiche la liste des applications et paquets installés sur l'ordinateur client.
- **Liste des services en cours d'exécution** : Montre les services actuellement actifs sur l'ordinateur.
    Liste des utilisateurs locaux : Affiche les utilisateurs locaux sur l'ordinateur.
- **Mémoire RAM** :
        - Affiche la mémoire RAM totale.
        - Montre l'utilisation de la RAM.
- **Recherche de fichier log_evt.log** : Recherche des événements dans le fichier log_evt.log pour un utilisateur ou un ordinateur spécifique.

## Journalisation des Requêtes

Le script enregistre chaque requête effectuée dans un fichier de journalisation avec une timestamp. Vous pouvez consulter ce fichier pour voir un historique complet des actions effectuées.

Pour accéder à la journalisation, sélectionnez l'option correspondante dans le menu et le script vous affichera les entrées précédentes avec la date et l'heure des actions effectuées.
## Retour à l'Étape Précédente

Si vous souhaitez revenir à une étape précédente, vous pouvez sélectionner l'option "Retour à l'Étape Précédente". Cela vous ramènera à la section du menu où vous pourrez choisir une nouvelle option.
## Quitter le Script

Une fois que vous avez terminé toutes vos actions ou informations, vous pouvez quitter le script en sélectionnant l'option "Quitter le Script". Le script se terminera et vous serez ramené à votre terminal.
## Continuer ou Quitter

Après avoir effectué une action ou obtenu des informations, vous serez invité à choisir si vous souhaitez :

- **Continuer** : pour effectuer une autre action ou obtenir plus d'informations.
- **Quitter** : pour sortir du script et revenir à votre terminal.

Le script vous offrira ces options après chaque action ou information, afin de vous permettre de poursuivre vos tâches ou de terminer votre session.

## FAQ
**Problèmes courants et solutions**

- **Problème de Connexion SSH (Debian/Ubuntu)**
    **Erreur de connexion** : Vérifiez que le service SSH est actif sur la machine distante. Assurez vous que l'adresse IP et les informations d'identification sont correctes.
- **Problème de Connexion PowerShell (Windows)**
    **Erreur de connexion** : Vérifiez que PowerShell Remoting est activé sur la machine distante (Enable-PSRemoting).
    **Droits d'accès** : L'utilisateur distant doit être membre du groupe "Remote Management Users" ou avoir des droits d'administrateur.
- **Problèmes de Journalisation**
    **Accès au fichier log.event** : Vérifiez que l'utilisateur dispose des droits en écriture sur son dossier personnel pour enregistrer le fichier de log.
- **Problèmes de droit d'exécution des commandes**
    **Droits d'accès** : L'utilisateur distant doit avoir des permissions suffisantes pour exécuter les commandes demandées. Si nécessaire exécutez la partie du script avec l'utilisateur root.
