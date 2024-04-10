<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Lowcoder, verified and packaged by Elestio

[Lowcoder](https://github.com/lowcoder-org/lowcoder) is open source. Developers can create and use their own components instead of depending on official updates.

<img src="https://github.com/elestio-examples/lowcoder/raw/main/lowcoder.gif" alt="lowcoder" width="800">

Deploy a <a target="_blank" href="https://elest.io/open-source/lowcoder">fully managed lowcoder</a> on <a target="_blank" href="https://elest.io/">elest.io</a> if you want automated backups, reverse proxy with SSL termination, firewall, automated OS & Software updates, and a team of Linux experts and open source enthusiasts to ensure your services are always safe, and functional.

[![deploy](https://github.com/elestio-examples/lowcoder/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/lowcoder)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/lowcoder.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Run the project with the following command

    ./scripts/preInstall.sh
    docker-compose up -d
    ./scripts/postInstall.sh

You can access the Web UI at: `http://your-domain:18113`

## Docker-compose

Here are some example snippets to help you get started creating a container.

    version: "3"
    services:
        mongodb:
            image: "mongo:4.4"
            environment:
                MONGO_INITDB_DATABASE: lowcoder
                MONGO_INITDB_ROOT_USERNAME: lowcoder
                MONGO_INITDB_ROOT_PASSWORD: ${MONGO_INITDB_ROOT_PASSWORD}
            volumes:
                - ./mongodata:/data/db
            restart: always

        redis:
            image: elestio/redis:7.0
            container_name: redis

        lowcoder-api-service:
            image: elestio4test/lowcoder-api-service:${SOFTWARE_VERSION_TAG}
            ports:
                - "172.17.0.1:8080:8080"
            environment:
                LOWCODER_PUID: "9001"
                LOWCODER_PGID: "9001"
                LOWCODER_MONGODB_URL: "mongodb://lowcoder:${MONGO_INITDB_ROOT_PASSWORD}@mongodb/lowcoder?authSource=admin"
                LOWCODER_REDIS_URL: "redis://redis:6379"
                LOWCODER_NODE_SERVICE_URL: "http://lowcoder-node-service:6060"
                LOWCODER_MAX_QUERY_TIMEOUT: 120
                LOWCODER_EMAIL_AUTH_ENABLED: "true"
                LOWCODER_EMAIL_SIGNUP_ENABLED: "true"
                LOWCODER_CREATE_WORKSPACE_ON_SIGNUP: "true"
                LOWCODER_DB_ENCRYPTION_PASSWORD: ${LOWCODER_DB_ENCRYPTION_PASSWORD}
                LOWCODER_DB_ENCRYPTION_SALT: ${LOWCODER_DB_ENCRYPTION_SALT}
                LOWCODER_CORS_DOMAINS: "*"
                LOWCODER_MAX_ORGS_PER_USER: 100
                LOWCODER_MAX_MEMBERS_PER_ORG: 1000
                LOWCODER_MAX_GROUPS_PER_ORG: 100
                LOWCODER_MAX_APPS_PER_ORG: 1000
                LOWCODER_MAX_DEVELOPERS: 50
                LOWCODER_API_KEY_SECRET: ${LOWCODER_API_KEY_SECRET}
                LOWCODER_WORKSPACE_MODE: SAAS
            restart: always
            depends_on:
                - mongodb
                - redis

        lowcoder-node-service:
            image: elestio4test/lowcoder-ce-node-service:${SOFTWARE_VERSION_TAG}
            ports:
                - "172.17.0.1:6060:6060"
            environment:
                LOWCODER_PUID: "9001"
                LOWCODER_PGID: "9001"
                LOWCODER_API_SERVICE_URL: "http://lowcoder-api-service:8080"
            restart: always
            depends_on:
                - lowcoder-api-service

        lowcoder-frontend:
            image: elestio4test/lowcoder-ce-frontend:${SOFTWARE_VERSION_TAG}
            ports:
                - "172.17.0.1:18113:3000"
            environment:
                LOWCODER_PUID: "9001"
                LOWCODER_PGID: "9001"
                LOWCODER_MAX_REQUEST_SIZE: 20m
                LOWCODER_MAX_QUERY_TIMEOUT: 120
                LOWCODER_API_SERVICE_URL: "http://lowcoder-api-service:8080"
                LOWCODER_NODE_SERVICE_URL: "http://lowcoder-node-service:6060"
            restart: always
            depends_on:
                - lowcoder-node-service
                - lowcoder-api-service
            volumes:
                - ./static-assets:/lowcoder/assets

### Environment variables

|            Variable             |                   Value (example)                   |
| :-----------------------------: | :-------------------------------------------------: |
|      SOFTWARE_VERSION_TAG       |                       latest                        |
|         ADMIN_PASSWORD          |                    your-password                    |
|         ADMIN_USERNAME          |                   test@gmail.com                    |
|           ADMIN_EMAIL           |                   admin@email.com                   |
| LOWCODER_DB_ENCRYPTION_PASSWORD |                    your-password                    |
|   LOWCODER_DB_ENCRYPTION_SALT   |                    your-password                    |
|   MONGO_INITDB_ROOT_PASSWORD    |                    your-password                    |
|     LOWCODER_API_KEY_SECRET     | should be a string of at least 32 random characters |

# Maintenance

## Logging

The Elestio lowcoder Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://github.com/lowcoder-org/lowcoder">Lowcoder Github repository</a>

- <a target="_blank" href="https://docs.lowcoder.cloud/lowcoder-documentation/">Lowcoder documentation</a>

- <a target="_blank" href="https://github.com/elestio-examples/lowcoder">Elestio/Lowcoder Github repository</a>
