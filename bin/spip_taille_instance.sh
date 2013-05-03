#!/bin/bash
# 
# spip_taille_instance.sh
# 
# Script à executer en cron (tâche planifiée)
# cf : https://technique.arscenic.org/commandes-linux-de-base/article/cron-gestion-des-taches-planifiees
#
# Il écrit un tableau dans un fichier texte, qui indique l'espace occupé par chaque instance de mutualisaton
# pour être utilisé par la suite par le plugin pour Munin "spip_mutu_taille"
#
# VERSION
# v0.1 (2013-05-02)
#
# AUTHORS
# © Association INFINI - Eric Talarmain (2011-xxxx)
# Distribué sous licence GNU/GPLv2 (http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt)


# On inclue le fichier /etc/default/munin_spip_mutu s'il existe qui permet de redéfinir les variables :
# - dossier : le ou les dossiers sites à scanner si une ou plusieurs mutualisations sur le serveur
# par défaut /var/www/mediaspip/sites
# - journal : le fichier où seront stockées les données, par défaut /usr/local/log/mediaspip_taille_instance.log
if [ -r "/etc/default/munin_spip_mutu" ]; then
. /etc/default/munin_spip_mutu
fi

DOSSIERS=${dossier:-/var/www/mediaspip/sites}
journal=${journal:-/usr/local/log/mediaspip_taille_instance.log}
dir_journal=$(dirname $journal)

# On vérifique que le répertoire du fichier de log existe bien
# sinon on le crée
if [ ! -d "$dir_journal" ]; then
	mkdir -p $dir_journal
fi

IFS=":"
set $DOSSIERS
i=0
for item
do
	# Le répertoire à scanner existe bien?
	if [ -d "$item" ];then
		cd $item
		# Si on est dans la première itération, on écrase le journal
		if [ "$i" = 0 ]; then
			# On calcule la taille des répertoires sauf ceux terminant par _deleted ou _disabled
			# On déréférence également les liens symboliques
			du -bsL * --exclude '*_deleted' --exclude '*_disabled' > $journal
		else
			du -bsL * --exclude '*_deleted' --exclude '*_disabled' >> $journal
		fi
		i=$((i+1))
	fi
	# Si le journal existe, on applique un sort sur les résultats
	# car on peut avoir plusieurs instances de mutualisation
	# On crée un fichier temporaire que l'on renomme ensuite
	if [ -r "$journal" ];then
		cat $journal |sort -gr > $journal.tmp
		mv $journal.tmp $journal
	fi
	
done
exit 0