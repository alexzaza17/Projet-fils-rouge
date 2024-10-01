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


###### Partie 2:  Mise en place d'un pipeline CI/CD à l'aide de JENKINS et de ANSIBLE.

##### b- Infrastructure
Dans cette partie il sera question pour nous de mettre en place 3 servers On Premises avec VirtualBox en utilisant vagrant 

- Dans le premier server nous allons installer jenkins
- Dans le deuxieme server nous allons installer pgadmin et ic-webapp
- Dans le troisieme server nous allons installer odoo

![server_3](https://github.com/user-attachments/assets/9303ff5b-5317-4712-a3c4-95268ec44c85)

##### c- Automatisation du déploiement

##### c.1- Partie Ansible

Il est question ici pour nous de mettre en place un code Ansible qui nous permettra de configurer une machine cliente a distance c est a dire installer docker a l aide d un role. Nous avons tout d abord creer le fichier:

-  Un docker-compose permettant de déployer entièrement l’application Odoo tout en créant un réseau docker et un volume pour faire persister les données de la BDD
  
-  un docker-compose permettant de déployer l’application pgadmin avec les paramètres décrits dans la partie1 (fichier servers.json et persistance des données)

#####  Ansible ressources 

- ansible.cfg Le fichier de configuartion. Nous avons defini le chemin du fichier d inventaire, le repertoire ou il stocke ses roles, become: true pour l escalade des privileges pour faire du sudo si besoin et le host_key_checking
  
- Le dossier goup_vars qui contient le fichier prod.yml qui permettra ansible de definir l adresse de la machine sur laquelle on voudra faire la configuration et la varaiable du servers.json de pgadmin servers, en fin on demande a Ansible d accepter la connexion a distance 

- Le dossier files/secrets contient le fichier credentials.vault qui permettra de securiser la connexion

- Le dossier role qui contient le dossiers suivant: qui va etre appeler dans lorsqu on va lance la commande ansible playbook avec le fichier deploy.yml. le dossier apache_docker contient le tasks qui lui a son tour contient deux fichiers a savoir main.yml et le pre-tasks.yml

* docker-install qui contient le dossier tasks avec e fichier main.yml qui permettra de conteneuriser motre application
  
* ic-webapp qui contient le dossier tasks et defautls avec leurs ficheirs main.yml
  Dans le dossier defaults/main.yml nous avons defini les variables par defaults qui seront utilises a savoir les ip, mon docker_id
  Dans le dossier tasks/main.yml nous avons creer le reseau et ensuite creer le conteneur avec le module conteneur
  
* odoo_role qui contient le dossier tasks, defautls et templates ts et templates qui contiennent les fichiers main.yml pour les deux premiers, docker-compose-Odoo.yml.j2 pour le template
  Dans le dossier defaults/main.yml nous avons defini les variables par defaults
  Dans le dossier tasks/main.yml nous avons cree le fichier template avec ses droits apres on lance la commande docker-compose up
  Dans le dossier template/docker-compose-Odoo.yml.j2 nous avons templatise le docker-compose de odoo et nous avons variabilises et ses variables ont ete definis sur la partie defaults que nous avons defini plus hauts
  
* pgadmin_role qui contient le dossier tasks, defaults et templates qui contiennent les fichiers main.yml pour les deux premiers, docker-compose-Pgadmin.yml.j2 etb server.json pour le template
  Dans le dossier defaults/main.yml nous avons defini les variables par defaults
  Dans le dossier tasks/main.yml nous avons cree le fichier template avec ses droits apres on genere le ervers.json.j2 qui nous a ete donnees dans l enonce , enfin on lance la commande docker-compose up
  Dans le dossier template/docker-compose-Odoo.yml.j2 nous avons templatise le docker-compose de pgadmin et servers.json que nous avons variabilises et ses variables ont ete definis sur la partie defaults que nous avons defini plus hauts
  
- Le dossier playbooks qui contient nos differents playbooks docker-install.yml, ic-webapp-deploy.yml, odoo-depoy.yml et pdgadmin-deploy.yml qui seront lance dans la commande notre Ansible playbook pour executer la configuration

- Le hosts.yml inventaire principal qui contient les adresses ip de nos differents server a savoir
* odoo_server est defini par 192.168.56.11
* ic_webapp_server est defini par 192.168.56.12
* pgamin_server est defini par 192.168.56.12
 Dans notre inventaire nous avons aussi defini le ansible_user et ansible_ssh_pass pour permettre d avoir access a nos differents server 

![Ansible-docker-install1](https://github.com/user-attachments/assets/4ba6152e-99df-4385-a3a2-11d5518725ae)

![Ansible-docker-instal2](https://github.com/user-attachments/assets/b0a12aa5-2553-4aba-a89a-01401bb353aa)

![Ansible-docker-install3](https://github.com/user-attachments/assets/a3ea4b77-bfcb-4b31-b0c9-95f5d7d366c0)

![Ansible-ic-webapp-install](https://github.com/user-attachments/assets/6b113e72-4367-43ba-86cd-730b3838ed41)

![Ansible-odoo-install](https://github.com/user-attachments/assets/880c1932-4504-45c1-ac8e-ac558c6c4fae)

![Ansible-pgadmin-install](https://github.com/user-attachments/assets/1f916079-c27d-4bb5-b76a-262ddbe23271)

![Ansible-ic-webapp-browser](https://github.com/user-attachments/assets/0690065c-61b7-48f6-b4e2-b78f876624a9)

![Ansible-odoo-browser](https://github.com/user-attachments/assets/197d212e-5781-4b2b-ab33-7cff9aebdadd)

![Ansible-pgadmin-browser](https://github.com/user-attachments/assets/6318250b-a01c-40f6-bfd0-c4b669bf1b2c)

##### c.2- Partie Jenkins

Il est question ici pour nous de mettre en place un pipeline qui nous permettra de deployer et d heberger application dans les differents servers. Nous avons d'abord ecrit le *Dockerfile_v1.0* du code. Creer les jobs qui nous permettrons de realiser celle ci dans notre *Jenkinsfile1* . Ansible va etre dedans notre pipeline jenkins car c est lui qui va aller installer ou deployment l appli dans nos 2 servers a savoir app_servers1 pour odoo et app_servers2 pour pgadmin et ic-webapp

Plan de travail

Nous allons realiser ses differents jobs sur jenkins CI/CD qui permettrons de mettre en place notre pipeline: 

- Build  l image
- Run le container
- Test d'acceptation de l'image(
- Clean container
- push de l image sur le Dockerhub)
- check l environnement Ansible 
- Deploy l appli
- Install nos differents role ansible
- Ping targeted c-a-d veriefier que l appli fonctionne
- check la syntaxe de nos differents playbooks
- Deployment de notre aplli sur les differents servers a grace a leur adresse ip que nous avons configures sur Ansible

Avant de realiser ces differentes atsks nousavons tout a d abord redige le Dockerfile, ensuite le jenkinsfile(nous avons bien precise que n importe quel agent pour executer notre job)

![jenkins-complet1](https://github.com/user-attachments/assets/6042d168-506a-4595-8580-d7151e459820)

![jenkins-complet2](https://github.com/user-attachments/assets/f470979d-dd0d-4f23-b423-691f4ea12d03)

![deploy-jenkins-ic-webapp](https://github.com/user-attachments/assets/1260c127-36ff-4df6-a659-30deace788ba)

![deploy-jenkins-odoo](https://github.com/user-attachments/assets/47dfec98-701e-4d84-988f-6e2b4cbf14b7)

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

![kuber-odoo](https://github.com/user-attachments/assets/eeac1348-08fd-4ad8-9def-ee7587dd561e)


###### B.4- Déploiement de l’application pgadmin

pgadmin-pvc.yml: il permettra de consommer le volume persistent (pv), ici nous n avons pas defini le pv car il sera mis en place de facon automatique

pgadmin-deployment.yml: permet de deployer l'application odoo c est a dire notre frontend. Notre pod va consommer le pvc.

pgadmin-nodeport.yml: permet d'exposer (les pods) notre application via le port 30008 a l exterieur de la machine

pgadmin-config.yml: 


![kuber-pgadmin](https://github.com/user-attachments/assets/9bb15175-431b-49ca-826a-5abed7b1943a)
