# --- Script avec Menu interactif pour gérer les utilisateurs et les groupes en PowerShell ---

$filePath =  ".\groupelog.txt"
$date = Get-Date

# Fonction pour créer un fichier log
function Create-File {
    param (
        [string]$filePath
    )

    if (-not (Test-Path -Path $filePath)) {
        New-Item -ItemType File -Path $filePath -Force | Out-Null
        Write-Output "Fichier '$filePath' créé avec succès."
        # Ajout d'un message de création dans le fichier
        Add-Content -Path $filePath -Value "$date - Fichier créé"
    } else {
        Write-Output "Le fichier '$filePath' existe déjà." > $null
    }
}




while ($true) {
    # Affichage du menu
    Write-Host "=============================="
    Write-Host "Menu de gestion des utilisateurs"
    Write-Host "=============================="
    Write-Host "1. Ajouter un utilisateur à un groupe d'administration"
    Write-Host "2. Ajouter un utilisateur à un groupe local"
    Write-Host "3. Retirer un utilisateur d'un groupe"
    Write-Host "4. Quitter"
    $choice = Read-Host "Choisissez une option [1-4]"

    switch ($choice) {
        1 {
            # --- Ajouter un utilisateur à un groupe d'administration ---
            Write-Host "=== Ajouter un utilisateur à un groupe d'administration ==="
            $username = Read-Host "Entrez le nom de l'utilisateur"
            $password = Read-Host "Entrez le mot de passe de l'utilisateur"
            $admin_group = Read-Host "Entrez le groupe d'administration (par défaut 'Administrators')"
            if (-not $admin_group) { $admin_group = "Administrators" }

            # Vérifier si l'utilisateur existe
            $user = Get-LocalUser -Name $username -ErrorAction SilentlyContinue
            if ($user) {
                Write-Host "L'utilisateur $username existe déjà."
            } else {
                # Création de l'utilisateur
                New-LocalUser -Name $username -Password (ConvertTo-SecureString $password -AsPlainText -Force)
                Write-Host "L'utilisateur $username a été créé."
                Add-Content -Path $filePath -Value "$date - utilisateur $username à été créé."
            }

            # Ajouter l'utilisateur au groupe d'administration
            $group = Get-LocalGroup -Name $admin_group -ErrorAction SilentlyContinue
            if ($group) {
                Add-LocalGroupMember -Group $admin_group -Member $username
                Write-Host "L'utilisateur $username a été ajouté au groupe d'administration $admin_group."
                Add-Content -Path $filePath -Value "$date - utilisateur $username a été ajouté au groupe d'administration $admin_group."
            } else {
                Write-Host "Le groupe $admin_group n'existe pas. Veuillez vérifier."
            }
        }
        2 {
            # --- Ajouter un utilisateur à un groupe local ---
            Write-Host "=== Ajouter un utilisateur à un groupe local ==="
            $username = Read-Host "Entrez le nom de l'utilisateur"
            $password = Read-Host "Entrez le mot de passe de l'utilisateur"
            $group = Read-Host "Entrez le groupe local auquel ajouter l'utilisateur"

            # Vérifier si l'utilisateur existe
            $user = Get-LocalUser -Name $username -ErrorAction SilentlyContinue
            if ($user) {
                Write-Host "L'utilisateur $username existe déjà."
            } else {
                # Création de l'utilisateur
                New-LocalUser -Name $username -Password (ConvertTo-SecureString $password -AsPlainText -Force)
                Write-Host "L'utilisateur $username a été créé."
                Add-Content -Path $filePath -Value "$date - utilisateur $username a été créé."

            }

            # Ajouter l'utilisateur au groupe local
            $groupObj = Get-LocalGroup -Name $group -ErrorAction SilentlyContinue
            if ($groupObj) {
                Add-LocalGroupMember -Group $group -Member $username
                Write-Host "L'utilisateur $username a été ajouté au groupe local $group."
                Add-Content -Path $filePath -Value "$date - utilisateur $username a été ajouté au groupe d'administration $admin_group."
            } else {
                Write-Host "Le groupe $group n'existe pas. Veuillez vérifier."
            }
        }
        3 {
            # --- Retirer un utilisateur d'un groupe ---
            Write-Host "=== Retirer un utilisateur d'un groupe ==="
            $username = Read-Host "Entrez le nom de l'utilisateur"
            $group = Read-Host "Entrez le nom du groupe duquel retirer l'utilisateur"

            # Vérification si l'utilisateur et le groupe existent
            $user = Get-LocalUser -Name $username -ErrorAction SilentlyContinue
            if (-not $user) {
                Write-Host "L'utilisateur $username n'existe pas."
                continue
            }

            $groupObj = Get-LocalGroup -Name $group -ErrorAction SilentlyContinue
            if (-not $groupObj) {
                Write-Host "Le groupe $group n'existe pas."
                continue
            }

            # Vérification si l'utilisateur est membre du groupe
            $groupMembers = Get-LocalGroupMember -Group $group
            if ($groupMembers.Name -contains $username) {
                Remove-LocalGroupMember -Group $group -Member $username
                Write-Host "L'utilisateur $username a été retiré du groupe $group."
                Add-Content -Path $filePath -Value "$date - utilisateur $username a été retiré du groupe $group."
            } else {
                Write-Host "L'utilisateur $username n'est pas membre du groupe $group."
            }
        }
        4 {
            # Quitter le script
            Write-Host "Au revoir!"
            exit
        }
        default {
            # Option invalide
            Write-Host "Option invalide. Veuillez choisir une option entre 1 et 4."
        }
    }

    # Demander de revenir au menu principal après chaque action
    Write-Host
    Read-Host "Appuyez sur [Entrée] pour revenir au menu principal..."
}
