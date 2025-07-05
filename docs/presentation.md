
# Présentation du projet : Scripts distants Linux & Windows

## Objectif principal

Ce projet a pour but de piloter des machines clientes à distance via des scripts exécutés depuis un serveur.

- Depuis **un serveur Windows**, un script PowerShell cible et interagit avec des postes Windows.
- Depuis **un serveur Debian**, un script Bash cible et interagit avec des postes Ubuntu.

---

## Objectif secondaire

Tester la prise en main de machines avec un système d’exploitation différent depuis un autre OS serveur.

---

## Architecture du projet

```
remote-scripting-tssr/
├── docs/              # Documentation technique et présentation
│   └── presentation.md
├── lib/               # Fonctions et bibliothèques communes
├── scripts/           # Scripts principaux
│   ├── bash/
│   └── powershell/
└── README.md
```

---

## Rôles et organisation de l’équipe

| Semaine | Jessy FREMOR               | Yagui YOLOU              |
|--------|----------------------------|--------------------------|
| S1     | Création VM Linux / GitHub | Création VM Windows      |
| S2     | Bash (répertoires, pare-feu)| Bash (groupes, maj...)   |
| S3     | PowerShell (répertoires...) | PowerShell (groupes...)  |
| S4     | Documentation + test        | Documentation + test     |

---

## Technologies utilisées

- **Systèmes** : Debian 12, Ubuntu 22.04/24.04, Windows Server 2022, Windows 10
- **Langages** : Bash, PowerShell
- **Outils** : SSH, WinRM, Visual Studio Code

---

## Conclusion

Ce projet montre qu’il est possible de contrôler à distance des postes clients via des scripts bien structurés,
de consigner les actions et d’interagir avec différentes familles de systèmes (Linux ↔ Windows).
