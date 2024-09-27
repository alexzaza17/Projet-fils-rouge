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








###### Partie 3: déploiement des différentes applications dans un cluster Kubernetes

###### A-Donnons le role et le type des ressources en nous basant sur l architecture logicielle 

A : Service
Type Nodeport 
Rôle : Ce service achemine le trafic externe vers le pod ic-webapp (B) : Ce service achemine le trafic externe vers le pod ic-webapp (B). Il sert de point d'entrée pour les demandes des utilisateurs.

B : ic-webapp
Type : Pod
Rôle : Ce module exécute l'application web. Il gère la logique commerciale principale et les interactions avec les utilisateurs pour l'application Web initiale.

C : Service
Type: Il peut etre considere  Service Cluster IP ou de type Nodeport
Rôle : Ce service achemine le trafic du pod ic-webapp (B) vers le pod Odoo_Web (D). Il facilite la communication entre l'application web et le backend Odoo.

D : Odoo_Web
Type : Pod
Rôle : Ce pod exécute l'application web Odoo. Il gère la logique de base de l'application et sert l'interface Odoo à l'utilisateur.

E : Service
Type : Service cluster IP
Role : Ce service achemine le trafic du pod Odoo_Web (D) vers le pod BDD_Odoo (F). Il gère la connexion entre l'application Odoo et sa base de données.

F : BDD_Odoo
Type : Pod
Role : Ce pod exécute la base de données Odoo (probablement PostgreSQL). Il stocke toutes les données nécessaires à l'application Odoo.

G: service 
Type de service: Il peut etre considere  Service Cluster IP ou de type Nodeport
Rôle : Ce service achemine le trafic vers le pod Pgadmin (H) : Ce service achemine le trafic vers le pod Pgadmin (H). Il permet d'effectuer des tâches administratives sur la base de données.

###### B-Deploiement de nos applications

###### B.1- Déploiement de l’application ic-webapp

Il est question ici pour nous de deployer notre application ic-webapp a l aide des fichiers manifest qui contiendra notre application odoo et pgadmin. Nous avons tout d abord creer le fichier:

. ic-webapp-namespace.yml: permet l isolation de l organisation de nos ressources et le management du control d access de notre charge de travail dans l environnement kubernetes que nous utilisons

. ic-webapp-deployment.yml: permet de deployer l'application

. ic-webapp-Nodeport.yml: permet d'exposer (les pods) notre application via le port 30006 a l exterieur de la machine. En attaquant la machine avec l adresse ip de notre vm mikube et le port on obtient l application

![Namespace-kubernetes](https://github.com/user-attachments/assets/5500fb02-f2d4-42d9-a884-05b35b21cc20)


###### B.2- Déploiement de l’application postgres

Un volume persistence claim(pvc) postgres-pvc.yml: il permettra de consommer le volume persistent (pv), ici nous n avons pas defini le pv car il sera mis en place de facon automatique

deployer postgres-deployment: permet de deployer l'application c est a dire notre base de donnees. Notre pod va consommer le pvc.

Un service Cluster ip postgres-service.yml: permet a nos pods application uniquement a l interieur du cluster.

###### B.3- Déploiement de l’application odoo

odoo-pvc.yml:  il permettra de consommer le volume persistent (pv), ici nous n avons pas defini le pv car il sera mis en place de facon automatique

odoo-deployment.yml: permet de deployer l'application odoo c est a dire notre frontend. Notre pod va consommer le pvc.

odoo-Nodeport.yml: permet d'exposer (les pods) notre application via le port 30007 a l exterieur de la machine


###### B.4- Déploiement de l’application pgadmin

pgadmin-pvc.yml: il permettra de consommer le volume persistent (pv), ici nous n avons pas defini le pv car il sera mis en place de facon automatique

pgadmin-deployment.yml: permet de deployer l'application odoo c est a dire notre frontend. Notre pod va consommer le pvc.

pgadmin-nodeport.yml: permet d'exposer (les pods) notre application via le port 30007 a l exterieur de la machine

pgadmin-config.yml: 

