# Generated by Django 3.2.25 on 2024-07-03 21:47

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('db', '0011_user_last_active'),
    ]

    operations = [
        migrations.AddField(
            model_name='match',
            name='game_type',
            field=models.CharField(default='', max_length=255),
        ),
    ]