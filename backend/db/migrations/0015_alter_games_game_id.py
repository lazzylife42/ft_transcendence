# Generated by Django 3.2.25 on 2024-07-04 18:19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('db', '0014_auto_20240704_1313'),
    ]

    operations = [
        migrations.AlterField(
            model_name='games',
            name='game_id',
            field=models.AutoField(primary_key=True, serialize=False),
        ),
    ]