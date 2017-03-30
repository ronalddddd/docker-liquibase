# Liquibase 3.5.0

Liquibase image to build and run your change sets as docker images.
It can also be used to generate change logs or do database diff using the `generate` or `diff` commands.

## Changelog Volume

Change log files will be placed under `/changelogs` in the container.
When using this image directly, you can mount `/your/path:/changelogs` to work on your change logs.

## Environment Variables

- `CHANGE_LOG_FILE`: defaults to "db.changelog.yml"
- `DB_HOST`: the target database host
- `DB_PORT`: the target database port
- `DB_NAME`: the target database name
- `DB_USERNAME`: the target database username
- `DB_PASSWORD`: the target database password

## Examples

### Creating a migration image

```Dockerfile
# The base image will automatically add your ./changelogs folder
FROM ronalddddd/liquibase:postgres
```

### Running the `generate` script

```
docker run -it --rm \
    -v /tmp:/changelogs \
    --link postgres:db \
    -e DB_HOST=db \
    -e DB_PORT=5432 \
    -e DB_NAME=app_db \
    -e DB_USERNAME=postgres \
    -e DB_PASSWORD=postgres \
    ronalddddd/liquibase generate
```

### Running the `migrate` script

```
docker run -it --rm \
    --link postgres:db \
    -e DB_HOST=db \
    -e DB_PORT=5432 \
    -e DB_NAME=app_db \
    -e DB_USERNAME=postgres \
    -e DB_PASSWORD=postgres \
    ronalddddd/liquibase:postgres migrate
```

## Notes

- Adapted from https://raw.githubusercontent.com/sequenceiq/docker-liquibase
- This image uses the `postgresql-42.0.0` jdbc driver
- Using 3.5.0 because later versions introduces a bug that causes addAutoIncrement changes to fail. See: https://liquibase.jira.com/browse/CORE-2978?page=com.atlassian.streams.streams-jira-plugin%3Aactivity-stream-issue-tab
