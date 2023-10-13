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

    docker-compose up -d

You can access the Web UI at: `http://your-domain:18113`

## Docker-compose

Here are some example snippets to help you get started creating a container.

    version: "3.3"
    services:
        lowcoder-api-service:
            image: elestio4test/lowcoder:${SOFTWARE_VERSION_TAG}
            restart: always
            ports:
                - "172.17.0.1:18113:3000"
                - "172.17.0.1:43160:3443"
            environment:
                REDIS_ENABLED: "true"
                MONGODB_ENABLED: "true"
                API_SERVICE_ENABLED: "true"
                NODE_SERVICE_ENABLED: "true"
                FRONTEND_ENABLED: "true"
                PUID: "1000"
                PGID: "1000"
                DEFAULT_ORGS_PER_USER: 100
                DEFAULT_ORG_MEMBER_COUNT: 1000
                DEFAULT_ORG_GROUP_COUNT: 100
                DEFAULT_ORG_APP_COUNT: 1000
                DEFAULT_DEVELOPER_COUNT: 50
                MONGODB_URL: "mongodb://172.17.0.1:27017/lowcoder?authSource=admin"
                REDIS_URL: "redis://172.17.0.1:6379"
                ENABLE_USER_SIGN_UP: "true"
                ENCRYPTION_PASSWORD: "lowcoder.org"
                ENCRYPTION_SALT: "lowcoder.org"
                CORS_ALLOWED_DOMAINS: "*"
                LOWCODER_API_SERVICE_URL: "http://172.17.0.1:8080"
                LOWCODER_NODE_SERVICE_URL: "http://172.17.0.1:6060"
                LOWCODER_MAX_REQUEST_SIZE: 20m
                LOWCODER_MAX_QUERY_TIMEOUT: 120
            volumes:
                - ./lowcoder-stacks:/lowcoder-stacks



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

- <a target="_blank" href="https://github.com/lowcoder-org/lowcoder">lowcoder Github repository</a>

- <a target="_blank" href="https://docs.lowcoder.cloud/lowcoder-documentation/">lowcoder documentation</a>

- <a target="_blank" href="https://github.com/elestio-examples/lowcoder">Elestio/parlowcoderse Github repository</a>
