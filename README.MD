# Репозиторий для развертывания инфраструктуры с помощью Terraform в рамках дипломного проекта Нетологии по специальности "DevOps-инженер"
В даном репозитории описана конфигурация terraform для создания облачной ифраструктуры в Yandex Cloud.
Серверы создаются на базе образов Ubuntu 20.04 и Ubuntu 18.04 nat instance.

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
- Настроен на создание публичной зоны DNS с добавлением ресурсных записей (пердварительно необходимо делегировать домен на ns YC).
- Настроен на создание внутренней зоны DNS в создаваемой сети.
- Настроен для работы в 2 workspaces:
1.	stage - VM  и сети создаются в зоне ru-central1-a. Используется одна общая подсеть. Для использования необходимо создать в этой зоне статический IP и указать его в зонах DNS.
2.	prod - VM и сети создаются в зоне ru-central1-b. Используются разные подсети для каждой группы серверов. Для использования необходимо создать в этой зоне статический IP.

## Перед запуском
- Создать ключи ssh.
- Создать workspaces prod и stage.
- В vars.tf указать путь к публичному ключу для подключения по SSH.
- В vars.tf указать cloud_id для Вашего YC.
- В vars.tf указать folder_id для Вашего YC
- В vars.tf указать переменную dns-zone со значением имени Вашей зоны DNS.
- В терминале, перед запуском terraform init, добавить YC_TOKEN в переменные среды окружения.

## Переменные
В файле vars.tf указаны значения следующих переменных:

- sshkey - Публичный ключ SSH, например:

```
variable "sshkey" {
  type        = string
  default     = "~/.ssh/your_key.pub"
  description = "SSH key for VMs"
}
```
- static - Статический ip адрес (не используется в текущей конфигурации), например:
```
variable "static" {
  type        = string
  default     = "Ваш IP"
  description = "Static IP addres in your network YC"
}
```

- cloud_id - Cloud id для Вашего YC.

- folder_id - Folder id для Вашего YC.

- family-image - Версия образа для instance.

- family-image-nat - Версия образа для NAT instance.

- user - Имя пользователя для подключения к instance по SSH.

- dns-zone - Имя домена для создания зоны DNS.

- dns-name - Название ресурса для публичной yandex_dns_zone.

- dns-name-private - Название ресурса для приватной yandex_dns_zone.

- prod-zone - Зона в workspace prod.

- stage-zone - Зона в workspace stage.