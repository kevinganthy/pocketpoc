# Pocket POC

Preview disponible sur Render <https://pocketpoc-latest.onrender.com>.

Image Docker Hub <https://hub.docker.com/repository/docker/kevinganthy/pocketpoc/general>.

## Utilisation

> :warning: Penser à créer le fichier `.env` à partir du fichier `.env.example`

Au choix :

* Avec **devcontainer**, démarrage automatique
* Avec **docker**, commande `docker compose up -d`

### Accès

* `localhost` : Front end
* `pb.localhost` : Pockebase

### Pockebase

**Auto seeding** : Le fichier `init.sql` est exécuté automatiquement au démarrage de Pocketbase si la base de données est vide.

* **EMAIL :** <kevin@gnth.io>
* **PASSWORD :** azerty1234

Custom endpoints :

* `pb.localhost/api/helloworld` (public)
* `pb.localhost/api/hello/:id` (private)

## Going to production

Le fichier `.env` peut contenir les variables d'environnement suivantes :

* POCKET_URL
* POCKET_PORT
* HELLO_WORLD_RESPONSE

### From DockerHub

```sh
# With env file
docker run --env-file=.env -p 8090:8090 -v ~/pocketpoc:/app/pb_data kevinganthy/pocketpoc
# With env var
docker run -e HELLO_WORLD_RESPONSE="Salut" -p 8090:8090 -v ~/pocketpoc:/app/pb_data kevinganthy/pocketpoc
```

### Build from source

Une image docker peut être générée à l'aide du `Dockerfile` à la racine du projet avec la commande :

```sh
docker build -t pocketpoc --build-arg VITE_APP_NAME="Pocketpoc" .
```

Pour lancer l'image, il suffit de lancer la commande :

```sh
# With env file
docker run --env-file=.env -p 8090:8090 -v ~/pocketpoc:/app/pb_data pocketpoc
# With env var
docker run -e HELLO_WORLD_RESPONSE="Salut" -p 8090:8090 -v ~/pocketpoc:/app/pb_data pocketpoc
```

### Oauth

L'autentification est possible via Google ou Github en reseignants les champs `client_id` et `client_secret`. Liens pour les créer :

* [Github](https://github.com/settings/applications/2786757)
* [Google](https://console.cloud.google.com/apis/credentials)
