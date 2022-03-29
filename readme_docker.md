```
docker-compose build  
docker-compose run --rm web sh -c "django-admin startproject testproject ."
docker-compose run --rm web sh -c "python manage.py startapp testapp"
docker-compose up
```
