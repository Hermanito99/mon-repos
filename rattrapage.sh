#!/bin/bash

# Script pour créer un utilisateur avec des caractéristiques spécifiées

echo "BIENVENU DANS LE PROCESSUS DE CREATION D'UTILISATEURS AVEC DES CARACTERISTIQUES"

# Vérification du nombre correct d'arguments
if [ "$#" -ne 5 ]; then
    echo "Usage: $0 <NomUtilisateur> <Commentaire> <ShellParDefaut> <DureeValidite> <QuotaDisque>"
    exit 1
fi

# Assignation des paramètres d'entrée à des variables
NOM_UTILISATEUR=$1
COMMENTAIRE=$2
SHELL_PAR_DEFAUT=$3
DUREE_VALIDITE=$4
QUOTA_DISQUE=$5

# Création de l'utilisateur avec les caractéristiques spécifiées, y compris le répertoire personnel
sudo useradd -m -c "$COMMENTAIRE" -s "$SHELL_PAR_DEFAUT" -e "$(date -d "+$DUREE_VALIDITE days" +%Y-%m-%d)" "$NOM_UTILISATEUR"

# Définition du mot de passe par défaut et forcer le changement lors de la première connexion
echo "$NOM_UTILISATEUR:inf3611" | sudo chpasswd
sudo chage -d 0 "$NOM_UTILISATEUR"

# Initialisation du fichier de quota (assurez-vous que le paquet quota est installé)
sudo quotacheck -cug /home
sudo quotaon /home

# Définition du quota disque
sudo setquota -u "$NOM_UTILISATEUR" "$QUOTA_DISQUE" 0 0 0 /home

# Restriction des heures de connexion (en utilisant PAM)
echo "auth required pam_time.so" | sudo tee -a /etc/pam.d/sshd
echo "$NOM_UTILISATEUR;8:00-18:00" | sudo tee -a /etc/security/time.conf

echo "Utilisateur $NOM_UTILISATEUR créé avec succès avec les paramètres spécifiés."

