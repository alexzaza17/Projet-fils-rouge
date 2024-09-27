# Fankem
## Alex Junior
### Eazytraining 18th DevOps Bootcamp
#### Period: march-april-may


##### Application
Il est question ici pour nous de mettre sur pied un site web vitrine de la societe *IC GROUP* ", qui doit acceder a deux applications phares nomme:
- odoo
- pgadmin

Notre devoir est divise en 3 grandes parties:
- La premiere partie est la conteneurisation de l’application web
- La deuxieme partie mise en place d'un pipeline CI/CD à l'aide de JENKINS et de ANSIBLE
- La troisieme partie déploiement des différentes applications dans un cluster Kubernetes.
  
##### Partie 1: conteneurisation de l’application web

###### Plan de travail 
Nous allons mettre en place les commandes des differents conteneurs 
- Nous allons ecrire le Dockerfile du site web de ic-group  faire le tag de notre image apres run le conteneur api qui n
- Nous allons mettre en place un conteneur c-a-d build l image , la tagger et apres run le conteneur 
- Nous allons push notre image sur le Dockerhub le regisstry pour heberber l'application et enfin stop et supprimer le conteneur
 
##### Elaboration du plan de travail

Partie 1
 
1-Ici nous avons faire le build de l image en precisant le nom de l'image: ic-webapp, le tag:1.0 et le contexte
![Build image](https://github.com/user-attachments/assets/ad3bc4bd-060d-4077-9790-66d8294521fa)

2- Run l image de l application qui a ete builde et creer le conteneur avec pour nom test-ic-webapp
![Run-container](https://github.com/user-attachments/assets/b5f48384-938a-4417-b801-b199d747deb1)

3-  Cette commande permet de voir et confirmer que notre conteneur a bien ete cree
![docker images](https://github.com/user-attachments/assets/69f5fec5-734e-4e6e-8239-8ecb7182c78a)
