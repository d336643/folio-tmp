from django.db import models


# Create your models here.
class Testtable(models.Model):
	attachment = models.FileField()
