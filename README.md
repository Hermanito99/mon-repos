# README

## Description

Ce script Bash permet de créer un utilisateur sur un système Linux avec des caractéristiques spécifiques, notamment :
- Nom d'utilisateur
- Commentaire associé
- Shell par défaut
- Durée de validité du compte
- Quota disque

Il configure également :
- Un mot de passe par défaut, à changer lors de la première connexion.
- Les quotas disques pour le répertoire personnel de l'utilisateur.
- Les restrictions horaires pour les connexions.

## Usage

```bash
./rattrapage.sh <NomUtilisateur> <Commentaire> <ShellParDefaut> <DureeValidite> <QuotaDisque>
```

### Arguments
1. **NomUtilisateur** : Le nom de l'utilisateur à créer.
2. **Commentaire** : Un commentaire décrivant l'utilisateur (optionnel dans `useradd`, mais requis ici).
3. **ShellParDefaut** : Le shell par défaut pour cet utilisateur (exemple : `/bin/bash`).
4. **DureeValidite** : Nombre de jours avant que le compte expire.
5. **QuotaDisque** : Quota disque (en blocs, selon la configuration de votre système).

### Exemple

Pour créer un utilisateur avec :
- Nom : `johndoe`
- Commentaire : `Développeur`
- Shell : `/bin/bash`
- Durée de validité : `30` jours
- Quota disque : `10000` blocs

Exécutez :

```bash
./rattrapage.sh johndoe "Développeur" /bin/bash 30 10000
```

## Prérequis

1. **Droits administratifs** : Ce script nécessite des privilèges sudo.
2. **Paquet `quota`** : Assurez-vous que le paquet pour la gestion des quotas est installé.
3. **Fichiers de configuration PAM** : Le script modifie `/etc/pam.d/sshd` et `/etc/security/time.conf` pour appliquer les restrictions horaires.

## Fonctionnalités principales

- **Création d'utilisateur** : Utilise `useradd` pour créer l'utilisateur avec un répertoire personnel.
- **Configuration du mot de passe** : Définit un mot de passe par défaut (`inf3611`) et force le changement au premier login.
- **Quota disque** : Vérifie et applique un quota disque pour l'utilisateur.
- **Restrictions horaires** : Limite les connexions aux heures spécifiées (8:00 à 18:00).

## Sécurité

- Le mot de passe par défaut doit être changé dès que possible pour des raisons de sécurité.
- Les modifications de fichiers sensibles comme `/etc/security/time.conf` doivent être surveillées.

## Dépendances

- `useradd`
- `chpasswd`
- `chage`
- `quotacheck`
- `setquota`
- PAM modules (`pam_time.so`)

## Avertissements

1. La commande `quotacheck` nécessite que le répertoire `/home` soit configuré pour les quotas.
2. Les modifications des fichiers PAM peuvent affecter les connexions SSH ; vérifiez la configuration pour éviter les blocages.

## Auteur

Créé par Herman. Ce script est destiné à automatiser la création d'utilisateurs avec des paramètres spécifiques pour des environnements Linux.

