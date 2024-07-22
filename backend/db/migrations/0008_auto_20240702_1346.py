# Generated by Django 3.2.25 on 2024-07-02 13:46

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('db', '0007_auto_20240702_1338'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='last_active',
            field=models.DateTimeField(default=django.utils.timezone.now),
        ),
        migrations.AddField(
            model_name='user',
            name='status',
            field=models.CharField(default='offline', max_length=10),
        ),
        migrations.DeleteModel(
            name='UserStatus',
        ),
    ]
