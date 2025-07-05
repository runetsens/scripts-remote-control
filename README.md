#  TSSR_PARIS_0924_P2_G5 – Contrôle à distance par scripts

##  Objectifs du projet

**Objectif principal**  
- Exécuter un script PowerShell depuis un serveur Windows vers des machines clientes Windows.
- Exécuter un script Bash depuis un serveur Debian vers des machines clientes Ubuntu.

**Objectif secondaire**  
- Permettre l'exécution de scripts inter-systèmes (ex. : depuis Linux vers Windows, et inversement).

---

##  Répartition des rôles dans l'équipe

| Semaine     | Yagui YOLOU – Scrum Master / Product Owner | Jessy FREMOR – 💼 Product Owner / Scrum Master |
|-------------|-----------------------------------------------|------------------------------------------------|
| Semaine 1   | Installation réseau VM (Windows 10 & Server 2022), création de la branche principale | Installation VM (Debian 12 & Ubuntu 22.04/24.04), création du dépôt GitHub |
| Semaine 2   | Menus Bash : utilisateurs, groupes, alimentation, mises à jour | Menus Bash : répertoires, pare-feu, prise à distance, logiciels |
| Semaine 3   | Menus PowerShell + logs | Menus PowerShell : répertoires, prise à distance, pare-feu, logiciels + logs Bash |
| Semaine 4   | Tests finaux et documentation | Tests finaux et documentation |

---

## Configuration de l’environnement

###  Serveurs

| Système         | Nom        | Utilisateur     | IP               |
|-----------------|------------|------------------|------------------|
| Windows Server 2022 | SRVWIN10   | Administrateur   | 172.16.10.5/24    |
| Debian 12       | SRVLX01     | root             | 172.16.10.10/24   |

###  Clients

| Système         | Nom        | Utilisateur     | IP               |
|-----------------|------------|------------------|------------------|
| Windows 10      | CLIWIN01    | wilder           | 172.16.10.20/24   |
| Ubuntu 22.04/24.04 | CLILIN01    | wilder           | 172.16.10.30/24   |

---

## Outils utilisés

- Scripts : `Bash`, `PowerShell`
- Éditeur : Visual Studio Code
- Connexions : SSH & WinRM

---

##  Étapes du projet

1. Installation et configuration des VMs
2. Connexion réseau via SSH (Linux) & WinRM (Windows)
3. Développement des scripts Bash et PowerShell
4. Tests de fonctionnalité en local et à distance
5. Rédaction de la documentation

---

## Choix techniques

Nous avons choisi de créer deux scripts indépendants :

- Un script **Bash** pour les environnements Linux
- Un script **PowerShell** pour les environnements Windows

L’objectif est d’automatiser les tâches d’administration à distance, tout en garantissant une compatibilité avec les deux principaux types de systèmes d’exploitation.

---

##  Difficultés rencontrées et solutions

| Problème                          | Solution apportée |
|----------------------------------|-------------------|
| Connexion SSH à distance         | Ajout de variables dynamiques dans le script + gestion des logs |
| Configuration de WinRM           | Passage du réseau en mode privé + activation manuelle du WinRM côté client/serveur |

---

##  Résultat final

Grâce à ces scripts, un administrateur peut :

- **Créer, modifier ou supprimer** des comptes utilisateurs à distance
- **Gérer les logiciels, services, répertoires** et paramètres réseau
- **Effectuer des actions d’alimentation, journaliser les requêtes**, et bien plus

---

## Documentation complémentaire

-  [Guide Administrateur (Configuration des machines)](docs/ADMIN_GUIDE.md)
-  [Guide Utilisateur (Utilisation des scripts)](docs/USER_GUIDE.md)

---

##  Conclusion

Ce projet démontre notre capacité à automatiser la gestion d’un parc informatique distant grâce à des scripts robustes et bien structurés, dans un contexte multi-OS.

Il met en valeur :
- notre rigueur dans la documentation,
- notre capacité à collaborer en mode Agile,
- notre maîtrise des environnements Windows & Linux.

---
