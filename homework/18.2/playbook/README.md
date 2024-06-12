# Clickhouse и Vector Playbook

Репозиторий, содержащий playbook для установки и запуска Clickhouse и Vector.

## Требования

* Ansible core 2.16.7 и выше.
* На стороне хоста: 
    * SSH service;
    * Python версии, [соответствующей Ansible core](https://docs.ansible.com/ansible/latest/reference_appendices/release_and_maintenance.html#ansible-core-support-matrix).
    * RPM-based дистрибутив (требуется yum в качестве пакетного менеджера).

## Настройка:

### Адрес хоста

В директории inventory требуется добавить inventory-файл, в котором будет описан хост clickhouse-01 группы clickhouse. Пример:
```yaml
---
clickhouse:
  hosts:
    clickhouse-01:
      ansible_host: <ip хоста>
```

### Параметры установки

В файле [vars.yml](group_vars/clickhouse/vars.yml) можно настроить некоторые параметры Clickhouse и Vector:

| Параметр | Что это |
|----------|---------|
| clickhouse_version | Версия Clickhouse |
| Пакеты Clickhouse | Пакеты, которые будут скачаны при установке Clickhouse. Не рекомендуется менять, так как далее именно этот список запрашивается при установке пакетов. |
| vector_version | Версия Vector |
| vector_user | Пользователь для запуска Vector |
| vector_group | Группа пользователей для запуска Vector |

### Конфигурация Vector

Для настройки поведения Vector небходимо внести изменения в шаблон [vector.yaml.j2](templates/vector.yaml.j2). 