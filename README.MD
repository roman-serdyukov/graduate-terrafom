# Репозиторий для развертывания инфраструктуры с помощью Terraform в рамках дипломного проекта Нетологии по специальности "DevOps-инженер"
В даном репозитории описана конфигурация terraform для создания облачной ифраструктуры в Yandex Cloud и backend в Terraform Cloud.
Северы создаются на базе образов Ubuntu 20.04 и Ubuntu 18.04 nat instance.

## Состав:
-	versions.tf
Определение провайдера облачной инфраструктуры и Backend.
-	network.tf
Настройки сетевой инфраструктуры для проекта
-	dns.tf
Настройки зон DNS для проекта
-	reverse.tf
Конфигурация для VM reverse proxy. Используется версия образа ubuntu 18.04 nat instance
-	mysql.tf
Конфигурация для создания двух VM под базы данных.
- www.tf
Конфигурация для VM application server на wordpress
-	gitlab-ci.tf
Конфигурация для создания 2 VM под gitlab и runner
-	monitoring.tf
Конфигурация для VM monitoring с использованием prometheus/grafana/alertmanager
-	outputs.tf 
Конфигурация для вывода важных значений.
- vars.tf
Конфигурация для переменных.

## Особенности настроек
-	В концигурациях VM предусметрено копирование публичных ключей ssh.
-	Настроен на работу с Terraform cloud Backend.
- 	Созданы 2 workspaces:
a)	stage - VM  и сети создаются в зоне ru-central1-a. Используется одна общая подсеть. Для использования необходимо создать в этой зоне статический IP и указать его в зонах DNS.
б)	prod - VM и сети создаются в зоне ru-central1-b. Используются разные подсети для каждой группы серверов. Для использования необходимо создать в этой зоне статический IP.

## Перед запуском
- Создать ключи ssh.
- В Terraform cloud добавить в нужный workspace переменную sshkey cо значением публичного ключа. Важно добавить значение следующим образом: [ имя пользователя VM (в нашем случае "ubuntu") ]:[ сам ключ ].
Пример:
```
ubuntu:ssh-rsa YouRPublicKeY+BLablABla\+=BLablABla\+=BLablABla\+= youremail@example.com
```
- В Terraform cloud добавить в нужный workspace переменную среды окружения YC_TOKEN  в Terraform cloud.
- В Terraform cloud добавить в нужный workspace переменную "static" со значением статического IP адреса, зарезеврированного в YC. Важно не ошибиться с зоной регистрации IP адреса (см. п. "Особенности настроек").
- В терминале, перед запуском terraform apply, добавить TF_TOKEN_app_terraform_io (token для Terraform cloud) в переменные среды окружения.

## Переменные
В файле vars.tf указаны значения следующих переменных:
- static
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
Имя доменя для создания зоны DNS.

- dns-name
Название ресурса для yandex_dns_zone.