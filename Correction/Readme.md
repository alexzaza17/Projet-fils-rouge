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

![Build_image](https://github.com/user-attachments/assets/8a513314-40f9-410c-a82a-2b0dde02ae86) 

2- Run l image de l application qui a ete builde et creer le conteneur avec pour nom test-ic-webapp

![Run-container](https://github.com/user-attachments/assets/f1fadd4e-7db5-42d6-aa63-6c1e97ceae40) 

3-  Cette commande permet de voir et confirmer que notre conteneur a bien ete cree et l image a ete builde

![docker-images](https://github.com/user-attachments/assets/0f99cf78-eee8-47ac-8327-74723a35cb28)

![docker-ps](https://github.com/user-attachments/assets/e21f41d3-5c98-4cb5-94a9-96de90c3d8df)

4- verification du fonctionnement de l application

![docker-ic-webapp](https://github.com/user-attachments/assets/4e5009d2-504f-4a7e-a488-103e3b87ae43)

Apres un clique sur le logo de odoo nous obtenons ceci 

![docker for  odoo](https://github.com/user-attachments/assets/3366d67c-324c-49d9-95ba-10a040fa3c67)

Apres un clique sur le logo de pgadmin nous obtenons ceci 

![docker for pgadmin ](https://github.com/user-attachments/assets/9807b1c2-02cc-4557-b2ca-1b536633e68c)

5- push de  appli sur notre dockerhub 

![docker-push-dockerhub ](https://github.com/user-attachments/assets/3f7fa06b-fd78-4296-8b05-010a81440ec1)

6- Arret et suppression du container

![docker stop and remove](https://github.com/user-attachments/assets/7c3ae499-8826-428a-ae7b-d51865eed55b)
