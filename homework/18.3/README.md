## Подготовка к выполнению

1. Подготовьте в Yandex Cloud три хоста: для `clickhouse`, для `vector` и для `lighthouse`.
2. Репозиторий LightHouse находится [по ссылке](https://github.com/VKCOM/lighthouse).

## Основная часть

1. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает LightHouse.
2. При создании tasks рекомендую использовать модули: `get_url`, `template`, `yum`, `apt`.
3. Tasks должны: скачать статику LightHouse, установить Nginx или любой другой веб-сервер, настроить его конфиг для открытия LightHouse, запустить веб-сервер.
4. Подготовьте свой inventory-файл `prod.yml`.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-03-yandex` на фиксирующий коммит, в ответ предоставьте ссылку на него.

### Решение

Предварительно изменим [main.tf](../18.2/terraform/main.tf) и [hosts.tftpl](../18.2/terraform/hosts.tftpl) для создания отдельных машин для clickhouse, vector и lighthouse.<br/>
Соответственно меняются и ansible файлы для обработки новой структуры inventory.

В [site.yml](../18.2/playbook/site.yml) добавлены play для установки nginx и lighthouse.

Исправлено всё, что найдёно ansible-lint, кроме того, что он ругается на `command`:

![alt text](images/1.png)

Что уж поделать, если даже документация по модулю предлагает такой вариант.<br/>
В данном случае, идемпотентность обеспечивается вызовом команды только в случае изменений таски с доступами к директории.

Как и в 18.2, `--check` отработал до момента, когда пора устанавливать нескачанные пакеты.

Запускаем с `-diff` первый раз, и получаем простыню. Запускаем второй, изменений нет:

![alt text](images/2.png)

Обновлено описание в [README.md](../18.2/playbook/README.md).
