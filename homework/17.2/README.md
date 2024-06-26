### Задание 1
В качестве ответа всегда полностью прикладывайте ваш terraform-код в git.  Убедитесь что ваша версия **Terraform** =1.5.Х (версия 1.6.Х может вызывать проблемы с Яндекс провайдером) 

1. Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.
2. Создайте сервисный аккаунт и ключ. [service_account_key_file](https://terraform-provider.yandexcloud.net).
4. Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную **vms_ssh_public_root_key**.
5. Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
6. Подключитесь к консоли ВМ через ssh и выполните команду ``` curl ifconfig.me```.
Примечание: К OS ubuntu "out of a box, те из коробки" необходимо подключаться под пользователем ubuntu: ```"ssh ubuntu@vm_ip_address"```. Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: ```eval $(ssh-agent) && ssh-add``` Вы познакомитесь с тем как при создании ВМ создать своего пользователя в блоке metadata в следующей лекции.;
8. Ответьте, как в процессе обучения могут пригодиться параметры ```preemptible = true``` и ```core_fraction=5``` в параметрах ВМ.

В качестве решения приложите:

- скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес;
- скриншот консоли, curl должен отобразить тот же внешний ip-адрес;
- ответы на вопросы.

#### Решение 1

Ключ для сервисного аккаунта создан и cложен в домашнюю директорию, где его будет искать `terrarorm` при создании провайдера.

Итак, ошибки:
1. В `yandex_compute_instance.platform` используется неизвестный `platform_id` "standart-v4". "Standart" заменён на "standard" и версия изменена на одну из существующих, "standard-v3".Из-за этого также пришлось сменить: 
    1. `resources.core_fraction`, так как гарантированное значение в 5% для выбранной платформы недоступно.
    2. `resources.cores`, так как 1 CPU для платформы слишком мало.

Остальное на удивление создалось и работает. Хм.

Успешно подключаемся под ubuntu. Находим свой ip:

![alt text](images/17.2.1.1.png)

Совпадает с тем, что видно в консоли Yandex Cloud:

![alt text](images/17.2.1.2.png)

##### Зачем нужны preemtible = true и низкий core_fraction

`preemtible` определяет, является ли машина прерываемой. Постоянно работающая ВМ стоит больше.
`core_fraction` – гарантированная доля vCPU, которая будет выделена ВМ. Соответственно, определяет производительность. Естественно, больше производительность – выше цена. 

Итого: `preemtible = true` и низкий `core_fraction` позволяют сохранить некоторую часть денег, так как для обучения непрерывность и производительность чаще всего не важны.

---

### Задание 2

1. Замените все хардкод-**значения** для ресурсов **yandex_compute_image** и **yandex_compute_instance** на **отдельные** переменные. К названиям переменных ВМ добавьте в начало префикс **vm_web_** .  Пример: **vm_web_name**.
2. Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их **default** прежними значениями из main.tf. 
3. Проверьте terraform plan. Изменений быть не должно. 


#### Решение 2

Изменены файлы [variables.tf](terraform/variables.tf) и [main.tf](terraform/main.tf). Проверяем terraform:

![alt text](images/17.2.2.1.png)

Изменений нет.

---

### Задание 3

1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: **"netology-develop-platform-db"** ,  ```cores  = 2, memory = 2, core_fraction = 20```. Объявите её переменные с префиксом **vm_db_** в том же файле ('vms_platform.tf').  ВМ должна работать в зоне "ru-central1-b"
3. Примените изменения.

#### Решение 3

Создан файл [vms_platform.tf](terraform/vms_platform.tf).

Для создания виртуальной машины `netology-develop-platform-db` в зоне `ru-central1-b` было применено небольшое жульничество. В файле [main.tf](terraform/main.tf) добавлена подсеть `develop-db` с той же зоной; переменные для описания подсети добавлены в [variables.tf](terraform/variables.tf).

Виртуальная машина создана:

![alt text](images/17.2.3.1.png)

---

### Задание 4

1. Объявите в файле outputs.tf **один** output , содержащий: instance_name, external_ip, fqdn для каждой из ВМ в удобном лично для вас формате.
2. Примените изменения.

В качестве решения приложите вывод значений ip-адресов команды ```terraform output```.

#### Решение 4

В файл [outputs.tf](terraform/outputs.tf) добавлен `vm_info`:

![alt text](images/17.2.4.1.png)

---

### Задание 5

1. В файле locals.tf опишите в **одном** local-блоке имя каждой ВМ, используйте интерполяцию ${..} с НЕСКОЛЬКИМИ переменными по примеру из лекции.
2. Замените переменные внутри ресурса ВМ на созданные вами local-переменные.
3. Примените изменения.

#### Решение 5

В [locals.tf](terraform/locals.tf) добавлены переменные.

Для виртуальных машин изменены имена в [main.tf](terraform/main.tf) и [vms_platform.tf](terraform/vms_platform.tf).

Раз уж у нас так удачно есть `output`, покажем изменения в нём:

![alt text](images/17.2.5.1.png)

---

### Задание 6

1. Вместо использования трёх переменных  ".._cores",".._memory",".._core_fraction" в блоке  resources {...}, объедините их в единую map-переменную **vms_resources** и  внутри неё конфиги обеих ВМ в виде вложенного map.  
   ```
   пример из terraform.tfvars:
   vms_resources = {
     web={
       cores=
       memory=
       core_fraction=
       ...
     },
     db= {
       cores=
       memory=
       core_fraction=
       ...
     }
   }
   ```
3. Создайте и используйте отдельную map переменную для блока metadata, она должна быть общая для всех ваших ВМ.
   ```
   пример из terraform.tfvars:
   metadata = {
     serial-port-enable = 1
     ssh-keys           = "ubuntu:ssh-ed25519 AAAAC..."
   }
   ```  
  
5. Найдите и закоментируйте все, более не используемые переменные проекта.
6. Проверьте terraform plan. Изменений быть не должно.

#### Решение 6

Выносим переменные в [vms_platform.tf](terraform/vms_platform.tf), там же и в [variables.tf](terraform/variables.tf) комментируем ненужные, меняем объявление виртуальных машин в vms_platform.tf и [main.tf](terraform/main.tf).

Применяем изменения – изменений нет.

![alt text](images/17.2.6.1.png)

------

## Дополнительное задание (со звёздочкой*)

**Настоятельно рекомендуем выполнять все задания со звёздочкой.**   
Они помогут глубже разобраться в материале. Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию. 


------
### Задание 7*

Изучите содержимое файла console.tf. Откройте terraform console, выполните следующие задания: 

1. Напишите, какой командой можно отобразить **второй** элемент списка test_list.
2. Найдите длину списка test_list с помощью функции length(<имя переменной>).
3. Напишите, какой командой можно отобразить значение ключа admin из map test_map.
4. Напишите interpolation-выражение, результатом которого будет: "John is admin for production server based on OS ubuntu-20-04 with X vcpu, Y ram and Z virtual disks", используйте данные из переменных test_list, test_map, servers и функцию length() для подстановки значений.

**Примечание**: если не догадаетесь как вычленить слово "admin", погуглите: "terraform get keys of map"

В качестве решения предоставьте необходимые команды и их вывод.

#### Решение 7

1. `local.test_list[1]` = "staging"
2. `length(local.test_list)` = 3
3. `local.test_map.admin` = "John"
4. `"${local.test_map.admin} is ${keys(local.test_map)[0]} for ${local.test_list[2]} server based on OS ${local.servers[local.test_list[2]].image} with ${local.servers[local.test_list[2]].cpu} vcpu, ${local.servers[local.test_list[2]].ram} ram and ${length(local.servers[local.test_list[2]].disks)} disks."` = "John is admin for production server based on OS ubuntu-20-04 with 10 vcpu, 40 ram and 4 disks."

![alt text](images/17.2.7.1.png)

------

### Задание 8*
1. Напишите и проверьте переменную test и полное описание ее type в соответствии со значением из terraform.tfvars:
```
test = [
  {
    "dev1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117",
      "10.0.1.7",
    ]
  },
  {
    "dev2" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88",
      "10.0.2.29",
    ]
  },
  {
    "prod1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101",
      "10.0.1.30",
    ]
  },
]
```
2. Напишите выражение в terraform console, которое позволит вычленить строку "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117"

#### Решение 8

Переменная создана в файле [variables.tf](terraform/variables.tf).

Для получения нужного значения выполняем запрос `var.test[0].dev1[0]`:

![alt text](images/17.2.8.1.png)

------

### Задание 9*

Используя инструкцию https://cloud.yandex.ru/ru/docs/vpc/operations/create-nat-gateway#tf_1, настройте для ваших ВМ nat_gateway. Для проверки уберите внешний IP адрес (nat=false) у ваших ВМ и проверьте доступ в интернет с ВМ, подключившись к ней через serial console. Для подключения предварительно через ssh измените пароль пользователя: ```sudo passwd ubuntu```

#### Решение 9

В файл [main.tf](terraform/main.tf) добавлены ресурсы `yandex_vpc_gateway` и `yandex_vpc_route_table`; для подсетей подключена созданная таблица маршрутизации; в [variables.tf](terraform/variables.tf) вынесены новые значения.

В [vms_platform.tf](terraform/vms_platform.tf) отключен NAT для виртуальных машин.

Для пользователя `ubuntu` задан пароль.

Изменения внесены:

![alt text](images/17.2.9.0.png)

Подключаемся к первой виртуальной машине (`yc compute connect-to-serial-port --instance-name netology-develop-platform-db-ru-central1-b --ssh-key ~/.ssh/id_ed25519 --folder-id <folder_id>`). Доступ в интернет есть:

![alt text](images/17.2.9.1.png)