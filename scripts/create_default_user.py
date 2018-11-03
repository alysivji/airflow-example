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
