# Generated by Django 3.2.25 on 2024-07-02 14:00

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('db', '0008_auto_20240702_1346'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='user',
            name='last_active',
        ),
        migrations.AlterField(
            model_name='user',
            name='status',
            field=models.CharField(max_length=50),
        ),
    ]