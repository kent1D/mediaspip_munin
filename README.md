MediaSPIP Munin
===============

Scripts de monitoring de fermes [SPIP](http://www.spip.net "Système de Publication pour Internet") [MediaSPIP [http://www.mediaspip.net]

Ce dépot est constitué de 2 scripts de monitoring :
- spip_mutu_sites
- mediaspip_media

## Les scripts

### spip_mutu_sites

Comptage des sites d'une instance de mutualisation

#### Description

Ce script permet de voir le nombre de sites actifs pour une ou plusieurs fermes de SPIP sur un même serveur.

#### Configuration et installation


### mediaspip_media

Comptage du nombre de médias hébergés dans une ferme.

#### Description

Ce script est utile dans le cas d'hébergement d'une ferme de [MediaSPIP](http://www.mediaspip.net) même s'il peut également être 
utilisé dans le cadre d'une ferme classique de SPIP.

Il donne 5 informations pour chaque ferme analysées :
- le nombre total de documents (dans tous les sites) ;
- le nombre total de médias de type vidéo ;
- le nombre total de médias de type audio ;
- le nombre total de médias de type image ;
- le nombre total de médias de type textuel ;

#### Configuration et installation

## Historique

### Version 0.2 :
- Refactoring pour que les scripts soient configurables

### Version 0.1 :
- Version originale développée par [Infini - Eric Talarmain](http://www.infini.fr "Infini - Hébergeur associatif brestois")
- Non configurable (Les sites doivent être dans /var/www/mediaspip/)
