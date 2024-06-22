## Основная часть

Ваша цель — разбить ваш playbook на отдельные roles. 

Задача — сделать roles для ClickHouse, Vector и LightHouse и написать playbook для использования этих ролей. 

Ожидаемый результат — существуют три ваших репозитория: два с roles и один с playbook.

**Что нужно сделать**

1. Создайте в старой версии playbook файл `requirements.yml` и заполните его содержимым:

   ```yaml
   ---
     - src: git@github.com:AlexeySetevoi/ansible-clickhouse.git
       scm: git
       version: "1.13"
       name: clickhouse 
   ```

2. При помощи `ansible-galaxy` скачайте себе эту роль.
3. Создайте новый каталог с ролью при помощи `ansible-galaxy role init vector-role`.
4. На основе tasks из старого playbook заполните новую role. Разнесите переменные между `vars` и `default`. 
5. Перенести нужные шаблоны конфигов в `templates`.
6. Опишите в `README.md` обе роли и их параметры. Пример качественной документации ansible role [по ссылке](https://github.com/cloudalchemy/ansible-prometheus).
7. Повторите шаги 3–6 для LightHouse. Помните, что одна роль должна настраивать один продукт.
8. Выложите все roles в репозитории. Проставьте теги, используя семантическую нумерацию. Добавьте roles в `requirements.yml` в playbook.
9. Переработайте playbook на использование roles. Не забудьте про зависимости LightHouse и возможности совмещения `roles` с `tasks`.
10. Выложите playbook в репозиторий.
11. В ответе дайте ссылки на оба репозитория с roles и одну ссылку на репозиторий с playbook.

---

### Решение

Добавлен файл [requirements.yml](../18.2/playbook/requirements.yml).<br/>
По нему скачана роль ClickHouse – проект автоматически добавлен в директорию `roles`.<br/>
После некоторых танцев с бубном выяснилось, что проще сменить систему, чем подобрать нужный микс значений переменных, так что [была сменена оперционная система машины с ClickHouse](../18.2/terraform/main.tf).

Vector перенесён в директорию https://github.com/RedRatInTheHat/vector-role.

Lighthouse был вынесен в https://github.com/RedRatInTheHat/lighthouse-role.

Сам Nginx оставлен в виде task'и, как намекает фраза `возможности совмещения roles с tasks`. <br/>
Таким образом, зависимость Lighthouse от Nginx была оформлена не в виде `dependencies` от роли `nginx`, а простой проверкой наличия сервиса.


