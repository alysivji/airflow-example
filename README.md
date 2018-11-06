# Airflow Example

Airflow with LocalExecutor and Postgres using Docker-Compose.

DAGs go in `dags`.

## Create user

```console
docker-compose webserver bash
ipython
```

```python
from airflow import models, settings
from airflow.contrib.auth.backends.password_auth import PasswordUser

user = PasswordUser(models.User())
user.username = input("Enter username: ")
user.email = input("Enter email address: ")
user.password = input("Enter password: ")

session = settings.Session()
session.add(user)
session.commit()
session.close()
```
