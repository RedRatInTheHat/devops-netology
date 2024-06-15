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

В директории inventory требуется добавить inventory-файл, в котором будут описаны хосты для clickhouse, vector и lighthouse соответственно. Пример:
```yaml
---
---
all:
  hosts:
    clickhouse:
      ansible_host: <ip хоста с clickhouse>
    lighthouse:
      ansible_host: <ip хоста с lighthouse>
    vector:
      ansible_host: <ip хоста с vector>
```

### Параметры установки

В файле [clickhouse/vars.yml](group_vars/all/clickhouse/vars.yml) можно настроить некоторые параметры Clickhouse:

| Параметр | Что это |
|----------|---------|
| clickhouse_version | Версия Clickhouse |
| clickhouse_packages | Пакеты, которые будут скачаны при установке Clickhouse. Не рекомендуется менять, так как далее именно этот список запрашивается при установке пакетов. |

В файле [vector/vars.yml](group_vars/vector/vars.yml) можно настроить некоторые параметры Vector:

| Параметр | Что это |
|----------|---------|
| vector_version | Версия Vector |
| vector_user | Пользователь для запуска Vector |
| vector_group | Группа пользователей для запуска Vector |

В файле [lighthouse/vars.yml](group_vars/lighthouse/vars.yml) можно настроить некоторые параметры Lighthouse:

| Параметр | Что это |
|----------|---------|
| lighthouse_repository | Git-репозиторий для клонирования Lighthouse |
| lighthouse_version | Версия Lighthouse; может быть указана ветка, тэг или хэш коммита |
| lighthouse_directory | Директория, в которую будет склонирован Lighthouse; используется nginx для отображения страниц |

### Конфигурации 

#### Vector

Для настройки поведения Vector небходимо внести изменения в шаблон [vector.yaml.j2](templates/vector.yaml.j2). 

#### Nginx

Nginx используется для отображения LightHouse. Для изменения его конфигурации необходимо внести изменения в шаблон [nginx.conf.j2](templates/nginx.conf.j2).