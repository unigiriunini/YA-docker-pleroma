# YA docker-pleroma

Yet Another docker-pleroma

## Usage

``` sh
docker-compose build
docker-compose run --rm web mix ecto.migrate
docker-compose run --rm web mix pleroma.user new admin admin@example.com --password password --admin
docker-compose up -d
# Open localhost:8080 on your browser and login as a user you created by a command above
```

Please wait a minute after executing `docker-compose up -d` because Pleroma takes a while to start.
