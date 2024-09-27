# Fankem
## Alex Junior
### Eazytraining 18th DevOps Bootcamp
#### Period: march-april-may


##### Application
Il est question ici pour nous de mettre sur pied un site web vitrine de la societe *IC GROUP* ", qui doit acceder a deux applications phares nomme:
- odoo
- pgadmin.
Notre devoir est divise en 3 grandes parties:
- La premiere partie est la conteneurisation de l’application web
- La deuxieme partie mise en place d'un pipeline CI/CD à l'aide de JENKINS et de ANSIBLE
- La troisieme partie déploiement des différentes applications dans un cluster Kubernetes.
##

- La premiere partie consiste a utiliser les commandes docker pour afficher la liste des etudiants
- La deuxieme partie consiste a afficher la liste des etudiants en utilisant docker-compose
- La troisieme partie consiste a pusher notre image cree sur le registry

######Plan de travail 
Nous allons mettre en place les commandes des differents conteneurs 
- Nous allons faire le tag de notre image apres run le conteneur api qui nous permettra de voir la liste des etudiants
- Nous allons mettre en place un conteneur en utilisant le docker-compose.yml pour l affiche des infos des etudiants
- Nous allons creer le registry avec le docker-compose-registry pour pouvoir heberger notre application en local
 
#####Elaboration du plan de travail

Partie 1
 
1-Ici nous avons faire le build de l image en precisant le version et le contexte
