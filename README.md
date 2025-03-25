# Nginx Reverse Proxy - Transcendence

## Description
Ce service utilise **Nginx** en tant que **reverse proxy** pour servir une application front-end et rediriger les requêtes vers des services back-end sécurisés. Il inclut également la gestion du **SSL** pour sécuriser les communications.

## 📌 Fonctionnalités
- 🔄 Reverse proxy vers les services back-end.
- 🔒 Sécurisation avec SSL/TLS.
- 🚀 Optimisation avec Gzip et cache des fichiers statiques.
- 📡 Vérification du bon fonctionnement via une route de santé (`/nginx_health`).

## 📂 Structure du projet
```
/
├── Dockerfile
├── entrypoint.sh
├── web_server/
│   ├── transcendence_nginx.conf    # Configuration principale de Nginx
│   ├── ft_transcendence.crt        # Certificat SSL
│   ├── ft_transcendence.key        # Clé privée SSL
│   ├── certificate_key.txt         # Mot de passe pour clé SSL
├── app/                            # Contenu du front-end
```

## 🚀 Installation & Utilisation

### 1️⃣ **Construire et Lancer le Conteneur**
```sh
docker build -t jbadaire/front_end:latest ./
docker docker container run -p 25565:443 --name=front-end jbadaire/front_end:latest
```

### 2️⃣ **Vérifier le bon fonctionnement**
Accédez à : `https://172.17.0.1:25565/nginx_heath`
Vous devriez voir :
```
healthy
```

## ⚙️ Configuration Nginx

### 📌 Fichier `transcendence_nginx.conf`
#### 🔹 Reverse Proxy (décommenter pour activer l'API Backend)
```nginx
# location /api/ {
#    proxy_pass http://backend:5000/;
#    proxy_ssl_verify off;
#    proxy_set_header Host $host;
#    proxy_set_header X-Real-IP $remote_addr;
#    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#    proxy_set_header X-Forwarded-Proto $scheme;
# }
```

#### 🔹 Gestion du Cache pour les fichiers statiques
```nginx
location ~* \.(css|png|jpg|jpeg|gif|ico|svg)$ {
    expires max;
    log_not_found off;
}
```

#### 🔹 Activation de la Compression Gzip
```nginx
gzip on;
gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
```

## 🔧 Dépannage

### ❌ **Erreur au lancement du container (`docker: Error response from daemon: Conflict. The container name "/${NAME}" is already in use by container "X". You have to remove (or rename) that container to be able to reuse that name. See 'docker run --help'.`)**
✅ Solution : Supprimez le container deja existant `${NAME}` via la commande `docker container rm ${NAME}`.

## 📜 Licence
GNU General Public License v3.0

