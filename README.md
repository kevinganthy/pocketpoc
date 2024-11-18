# Pocket POC

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

* `pb.localhost/api/helloworld`
* `pb.localhost/api/hello/:id`

## Going to production

Une image docker est générée à l'aide du `Dockerfile` à la racine du projet avec la commande :

```sh
docker build -t pocketpoc --build-arg VITE_APP_NAME="Pocketpoc" .
```

Pour lancer l'image, il suffit de lancer la commande :

```sh
docker run --env-file=.env -p 8090:8090 pocketpoc
```

Le fichier `.env` doit contenir les variables d'environnement suivantes :

* DISCORD_BOT_TOKEN
* OPENAI_API_KEY
* POCKET_URL
* POCKET_PORT
