# Guide Administrateur : Configuation du server et du client 

## Sommaire 

1. [Introduction](#introduction)
2. [Préparation de l'environnement](#preparation-de-lenvironnement)
   - [VM Server Windows 2022](#vm-server-windows-2022)
      - [Installation Windows Server 2022](#installation-windows-server-2022)
      - [Création de l'administrateur Windows Server 2022](#creation-dun-utilisateur-windows-server-2022)
      - [Configuration de l'adresse IP statique](#configuration-de-l'adresse-ip-statique)
   - [VM Client Windows 10](#vm-client-Windows-10)
      - [Création de l'utilisateur Windows 10](#creation-dun-utilisateur-windows-10)
      - [Installation Windows 10](#installation-Windows-10)
      - [Configuration de l'adresse IP statique](#configuration-de-l'adresse-ip-statique)
   - [VM Server Debian 12](#vm-server-Debian-12)
  - [Installation Debian 12](#installation-debian-12)
   - [Création de l'administrateur Debian 12](#creation-dun-utilisateur-debian-12)
   - [Configuration de l'adresse IP static](#configuration-de-l'adresse-ip-static)
   - [VM Client Ubuntu 22.04/24.04](#vm-client-ubuntu-22.04/24.04)
   - [Création de l'utilisateur Ubuntu](#creation-dun-utilisateur-Ubuntu) 
   - [Installation Ubuntu 22.04/24.04](#Installation-Ubuntu-22.04/24.04)
3. [Configuration de l'adresse IP static](#configuration-de-l'adresse-ip-static)
4. [Désactivation du pare-feu](#désactivation-du-pare-feu)
5. [Configuration WinRM](#configuration-winrm)
6. [Configuartion SSH](#configuration-ssh)


## Introduction 

Chaque configuration permettera des servers et des clients permettera de pouvoir les connectés et que les scripts puissent etre fonctionnels a distance.

## Préparation de l'environnement

### VM Server Windows 2022

#### Installation Windows Server 2022 
1.	Télécharger l'ISO de Windows Server 2022 : Visitez le site officiel de Microsoft pour obtenir l'image ISO.

2.	Créer une machine virtuelle :

-	Ouvrez votre logiciel de virtualisation.
-	Créez une nouvelle machine virtuelle et sélectionnez l'ISO de Windows Serveur.
-	Configurez la mémoire, le processeur et le stockage selon vos besoins.

3.	Installer Windows Serveur : Suivez les instructions à l'écran pour installer le système d'exploitation.

#### Creation d'un utilisateur Windows Server 2022 

- Depuis Powershell lancer la commande suivante :
   ```powershell
   New-LocalUser -Name "Administrateur" -Password (ConvertTo-SecureString "Azerty1*" -AsPlainText -Force) -FullName "Administrateur" -Description "Compte Administrateur" -PasswordNeverExpires $true -UserCannotChangePassword $true
   ```
   
- Ajouter l'utilisateur au groupe Administrateurs :
  
   ```powershell
   Add-LocalGroupMember -Group "Administrators" -Member "Administrateur"
   ```
   
- Vérifier la création :

   ```powershell
   Get-LocalUser
   ```
#### Configuration de l'adresse IP statique

- Lancer la commande suivante pour voir l'addresse ip de la machine et connaitre l’alias de la machine : 
   ```powershell
   Get-NetIPConfiguration
   ``
- Lancer la commande suivante pour configurer l'adresse IP statique en indiquant dans *-IPAddress* la bonne adresse :
   ```powershell
   New-NetIPAddress -InterfaceAlias "Ethernet 2" -IPAddress 172.16.10.5 - PrefixLenth 24
   Set-DnsClientServerAddress -InterfaceAlias "Ethernet 2" -ResetServerAddresses

### VM Client Windows 10

#### Installation Windows 10 
1.	Télécharger l'ISO de Windows 10 : Visitez le site officiel de Microsoft pour obtenir l'image ISO.

2.	Créer une machine virtuelle :

-	Ouvrez votre logiciel de virtualisation.
-	Créez une nouvelle machine virtuelle et sélectionnez l'ISO de Windows Serveur.
-	Configurez la mémoire, le processeur et le stockage selon vos besoins.

3.	Installer Windows Serveur : Suivez les instructions à l'écran pour installer le système d'exploitation.

#### Creation d'un utilisateur Windows 10

- Depuis Powershell lancer la commande suivante :
   ```powershell
   New-LocalUser -Name "Wilder" -Password (ConvertTo-SecureString "Azerty1*" -AsPlainText -Force) -FullName "Wilder" -Description "Compte Wilder" -PasswordNeverExpires $true -UserCannotChangePassword $true
   ```
   
- Ajouter l'utilisateur au groupe Administrateurs :
  
   ```powershell
   Add-LocalGroupMember -Group "Administrators" -Member "Administrateur"
   ```
   
- Vérifier la création :

   ```powershell
   Get-LocalUser
   ```
#### Configuration de l'adresse IP statique

- Lancer la commande suivante pour voir l'addresse ip de la machine et connaitre l’alias de la machine : 
   ```powershell
   Get-NetIPConfiguration
   ``
- Lancer la commande suivante pour configurer l'adresse IP statique en indiquant dans *-IPAddress* la bonne adresse :
   ```powershell
   New-NetIPAddress -InterfaceAlias "Ethernet 2" -IPAddress 172.16.10.20 - PrefixLenth 24
   Set-DnsClientServerAddress -InterfaceAlias "Ethernet 2" -ResetServerAddresses

### VM Server Debian 12

#### Intallation Debian 12

- Intaller la version la plus récente de Debian sur VirtualBox [Debian 12](https://www.debian.org/download)
- Suivez les instructions demandés par le système. 
- Crée un compte utilisateur sous le nom "root".

#### Configuration de IP statique

Sur Ubuntu, la configuration réseau utilise Netplan. Le fichier de configuration se trouve généralement dans le dossier /etc/netplan/, il faut donc modifier le fichier de configuration qui se trouve dans ce dossier. 

- Listez toutes les interfaces réseau (par exemple, ens18 ou eth0)

   ```bash
   ip a 
   ```

-  Pour vérifier les fichiers de configuration disponibles.
   ```bash
    ls/etc/netplan
    ```

- Ouvrir le fichier dans un éditeur *(ici le fichier se nomme :50-cloud-init.yaml)* :

   ```bash
   sudo nano /etc/netplan/50-cloud-init.yaml
   ```
**Point d'attention : respectez bien l'intendation attendue dans le script yaml.**

   ```bash
   #This file is generated from information provided by the datasource.  Changes
   #to it will not persist across an instance reboot.  To disable cloud-init's
   #network configuration capabilities, write a file
   #/etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
   #network: {config: disabled}
   network:
     ethernets:
        enp0s3:
            dhcp4: true
        enp0s8:
            dhcp4: false
            addresses :
              - 172.16.10.30/24  # adresse ip stati
            nameservers :
              addresses :
                - 8.8.8.8  #serveur dns
                - 8.8.4.4
    version: 2
   ```

- Après avoir configuré le fichier, vous devez appliquer les modifications :

   ```bash
   sudo netplan apply
   ```
En relancant la commande *ip a* vous devriez voir l’adresse IP statique que vous avez configurée dans la sortie de cette commande. 22.04/24.04


### VM client Ubuntu 22.04/24.04

#### Intallation Ubuntu 22.04/24.04

- Intaller la version la plus récente de Ubuntu sur VirtualBox [Ubuntu](https://www.ubuntu-fr.org/download/)
- Suivez les instructions demandés par le système. 
- Crée un compte utilisateur sous le nom "Wilder".

#### Configuration de l'adresse IP statique

Sur Ubuntu, la configuration réseau utilise Netplan. Le fichier de configuration se trouve généralement dans le dossier /etc/netplan/, il faut donc modifier le fichier de configuration qui se trouve dans ce dossier. 

- Listez toutes les interfaces réseau (par exemple, ens18 ou eth0)

   ```bash
   ip a 
   ```

-  Pour vérifier les fichiers de configuration disponibles.
   ```bash
    ls/etc/netplan
    ```

- Ouvrir le fichier dans un éditeur *(ici le fichier se nomme :50-cloud-init.yaml)* :

   ```bash
   sudo nano /etc/netplan/50-cloud-init.yaml
   ```
**Point d'attention : respectez bien l'intendation attendue dans le script yaml.**

   ```bash
   #This file is generated from information provided by the datasource.  Changes
   #to it will not persist across an instance reboot.  To disable cloud-init's
   #network configuration capabilities, write a file
   #/etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
   #network: {config: disabled}
   network:
     ethernets:
        enp0s3:
            dhcp4: true
        enp0s8:
            dhcp4: false
            addresses :
              - 172.16.10.20/24  # adresse ip stati
            nameservers :
              addresses :
                - 8.8.8.8  #serveur dns
                - 8.8.4.4
    version: 2
   ```

- Après avoir configuré le fichier, vous devez appliquer les modifications :

   ```bash
   sudo netplan apply
   ```
En relancant la commande *ip a* vous devriez voir l’adresse IP statique que vous avez configurée dans la sortie de cette commande.

## Désactivation du pare-feu 

Pour que la connexion a distance puisse fonctionner vous devez désactiver les pares-feux de chaque servers et de chez les cilents également sinon les pares-feu bloquera l'accès à distance. 
