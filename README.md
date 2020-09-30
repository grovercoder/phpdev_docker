# PHPDev_Docker

A quick PHP development environment with composer and Node support.

## Pre-requisites

-   A recent docker installation
-   A recent docker-compose installation

The `docker-compose.yml` file makes use of `version: "3"`, so the newer Docker versions are required.

## Usage:

1.   Clone this repository.
2.   (optional) Edit the `docker-compose.yml` file to set your MYSQL database name, user, and password.
3.   (optional) Modify the Nginx or PHP-FPM settings in the `conf` directory to meet your requirements
3.   Place your web application in the `source` directory.
4.   Start the containers with `docker-compose up -d`

## Services

Three service containers are created - `web`, `phpfpm`, and `db`:

-   The `web` service is based on Nginx and handles the HTTP requests.
-   The `phpfpm` service provides the PHP services.  PHP requests from the web services are proxied to the PHP services (`fastcgi_pass   phpfpm:9000;` in the nginx configuration file).
-   The `db` service provides a basic MySQL server.

## Configurations

Configuration files are stored in the `conf` directory.

`conf/nginx/default.conf` provides a basic server configuration.  Modify this to match the needs of your development framework.  i.e. if a Laravel application is being developed, you may need to change the "root" setting to `/var/www/source/public`.

phpfpm is configured to use a custom user named `webuser`.  This user's UID will match the UID of the host user that started the containers.  This allows read/write access from both the host and inside the container.  This setting is found in the `conf/phpfpm/www.conf` file.

## The "app" script.

The app script provides a convenience wrapper to commonly used commands.

```
  # start the docker containers (equivalent to `docker-compose up -d`)
  ./app start

  # stops the docker containers (`docker-compose stop`)
  ./app stop

  # show the status of the docker containers (`docker ps`)
  ./app status

  # rebuild the docker containers (`docker-compose build`)
  ./app rebuild

  # open a shell inside the `phpfpm` container
  # other container names can be specified - `./app enter db` - see docker-compose.yml file for container names
  ./app enter
```
