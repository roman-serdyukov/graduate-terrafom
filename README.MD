# Репозиторий для развертывания инфраструктуры с помощью Terraform в рамках дипломного проекта Нетологии по специальности "DevOps-инженер"
В даном репозитории описана конфигурация terraform для создания облачной ифраструктуры в Yandex Cloud и backend в Terraform Cloud.
Северы создаются на базе образов Ubuntu 20.04 и Ubuntu 18.04 nat instance.

## Состав:
-	[versions.tf](https://github.com/roman-serdyukov/graduate-terrafom/blob/main/versions.tf)
Определение провайдера облачной инфраструктуры и Backend.
-	[network.tf](https://github.com/roman-serdyukov/graduate-terrafom/blob/main/network.tf)
Настройки сетевой инфраструктуры для проекта
-	[dns.tf](https://github.com/roman-serdyukov/graduate-terrafom/blob/main/dns.tf)
Настройки зон DNS для проекта
-	[reverse.tf](https://github.com/roman-serdyukov/graduate-terrafom/blob/main/reverse.tf)
Конфигурация для VM reverse proxy. Используется версия образа ubuntu 18.04 nat instance
-	[mysql.tf](https://github.com/roman-serdyukov/graduate-terrafom/blob/main/mysql.tf)
Конфигурация для создания двух VM под базы данных.
- [www.tf](https://github.com/roman-serdyukov/graduate-terrafom/blob/main/www.tf)
Конфигурация для VM application server на wordpress
-	[gitlab-ci.tf](https://github.com/roman-serdyukov/graduate-terrafom/blob/main/gitlab-ci.tf)
Конфигурация для создания 2 VM под gitlab и runner
-	[monitoring.tf](https://github.com/roman-serdyukov/graduate-terrafom/blob/main/monitoring.tf)
Конфигурация для VM monitoring с использованием prometheus/grafana/alertmanager
-	[outputs.tf](https://github.com/roman-serdyukov/graduate-terrafom/blob/main/outputs.tf) 
Конфигурация для вывода важных значений.
- [vars.tf](https://github.com/roman-serdyukov/graduate-terrafom/blob/main/vars.tf)
Конфигурация для переменных.
- [data.tf](https://github.com/roman-serdyukov/graduate-terrafom/blob/main/data.tf)
Конфигурация для данных family-image.

## Особенности настроек
-	В концигурациях VM предусметрено копирование публичных ключей ssh.
-	Настроен на работу с Terraform cloud Backend.
- Настроен на создание публичной зоны DNS с добавлением ресурсных записей (пердварительно необходимо делегировать домен на ns YC).
- Настроен на создание внутренней зоны DNS в создаваемой сети.
- Настроен для работы в 2 workspaces:
1.	stage - VM  и сети создаются в зоне ru-central1-a. Используется одна общая подсеть. Для использования необходимо создать в этой зоне статический IP и указать его в зонах DNS.
2.	prod - VM и сети создаются в зоне ru-central1-b. Используются разные подсети для каждой группы серверов. Для использования необходимо создать в этой зоне статический IP.

## Перед запуском
- Создать ключи ssh.
- Создать организацию и workspaces в Terraform cloud. В файле versions.tf настроено на развертывание среды в workspace "prod".
- В Terraform cloud добавить в нужный workspace (по умолчанию "prod") переменную sshkey cо значением публичного ключа. Важно добавить значение следующим образом: [ имя пользователя VM (в нашем случае "ubuntu") ]:[ сам ключ ].
Пример:
```
ubuntu:ssh-rsa YouRPublicKeY+BLablABla\+=BLablABla\+=BLablABla\+= youremail@example.com
```
- В Terraform cloud добавить в нужный workspace (по умолчанию "prod") переменную среды окружения YC_TOKEN - token для Вашего YC.
- В Terraform cloud добавить в нужный workspace (по умолчанию "prod") переменную среды окружения YC_CLOUD_ID - cloud_id для Вашего YC.
- В Terraform cloud добавить в нужный workspace (по умолчанию "prod") переменную среды окружения YC_FOLDER_ID - folder_id для Вашего YC
- В Terraform cloud добавить в нужный workspace (по умолчанию "prod") переменную dns-zone со значением имени Вашей зоны DNS.
- В Terraform cloud добавить в нужный workspace (по умолчанию "prod") переменную dns-name со значением названия публичного DNS.
- В Terraform cloud добавить в нужный workspace (по умолчанию "prod") переменную dns-name-privat со значением названия приватного DNS.
- В терминале, перед запуском terraform init, добавить TF_TOKEN_app_terraform_io (token для Terraform cloud) в переменные среды окружения.

## Переменные
В файле vars.tf указаны значения следующих переменных:
- static (не используется в текущей конфигурации)
Статический ip адрес. По умолчанию настроено на добавление данной переменной в Terraform cloud. Можно задать значение в этом блоке, например:
```
variable "static" {
  type        = string
  default     = "Ваш IP"
  description = "Static IP addres in your network YC"
}
```
- sshkey
Публичный ключ SSH. По умолчанию настроено на добавление данной переменной в Terraform cloud. Как правильно добавиьть эту переменную указано в пункте выше. Можно задать значение в этом блоке, например:
```
variable "sshkey" {
  type        = string
  default     = "ubuntu:ssh-rsa YouRPublicKeY+BLablABla\+=BLablABla\+=BLablABla\+= youremail@example.com"
  description = "SSH key for VMs"
}
```
- dns-zone
Имя домена для создания зоны DNS.

- dns-name
Название ресурса для публичной yandex_dns_zone.

- dns-name-private для приватной yandex_dns_zone.

В файле versions.tf необходимо указать имя организации в Terraform cloud вместо "your_company".
