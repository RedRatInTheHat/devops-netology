## Задача 1

Ознакомьтесь с [инструкцией ](https://github.com/netology-code/devops-materials/blob/master/cloudwork.MD) по экономии облачных ресурсов.


1. Создайте через web-интерфейс Yandex Cloud - VPC и виртуальную машину из инструкции конфигурации "эконом-ВМ" с публичным ip-адресом. В пункте "Выбор образа/загрузочного диска" выберите вкладку "Cloud Marketplace" , щелкните "Посмотреть больше", найдите образ "Yandex Cloud Toolbox".
2. Убедитесь, что вы можете подключиться к консоли ВМ через ssh, используя публичный ip-адрес. Убедитесь, что на ВМ установлен Docker с помощью команды ```docker --version```(команду выполните от имени root пользователя) !
3. Узнайте в инструкции Яндекс, какие еще инструменты предустановлены в данном образе.
4. Оставьте ВМ работать, пока она не выключится самостоятельно! Опция "прерываемая" выключит ее не позже чем через 24 часа. 
5. Для наглядности подождите еще 1 сутки.
6. Перейдите по [ссылке ](https://console.cloud.yandex.ru/billing?section=accounts). Выберите свой платежный аккаунт. Перейдите на вкладку детализация (фильтр "По продуктам") и оцените график потребления финансов.
7. Удалите ВМ или пользуйтесь ею при выполнении последующих домашних заданий курса обучения.

---

## Решение 1

1. В Yandex cloud создана виртуальная машина из образа Yandex Cloud Toolbox.
2. Произведено подключение к ВМ через ssh.
3. Проведена первичная настройка скриптом `setup.sh`.
4. Получена версия docker:
```
tool@test $ sudo docker --version
Docker version 20.10.21, build 20.10.21-0ubuntu1~22.04.3
```
5. Созданная виртуальная машина отключается через некоторое время, ибо прерываемая.
6. График потребления не производит впечатления, так как пока используются финансы промокода и потребления будто и нет.


---

## Задача 2

Выберите один из вариантов платформы в зависимости от задачи. Здесь нет однозначно верного ответа так как все зависит от конкретных условий: финансирование, компетенции специалистов, удобство использования, надежность, требования ИБ и законодательства, фазы луны.

Тип платформы:

- физические сервера;
- паравиртуализация;
- виртуализация уровня ОС;

Задачи:

- высоконагруженная база данных MySql, критичная к отказу;
- различные web-приложения;
- Windows-системы для использования бухгалтерским отделом;
- системы, выполняющие высокопроизводительные расчёты на GPU.

Объясните критерии выбора платформы в каждом случае.

## Решение 2

1. Высоконагруженная база данных MySql, критичная к отказу.<br/>
Критичность к отказу можно реализовать независимо от типа выбранной платформы – главное обеспечить репликацию созданных виртуальных машин и распределение нагрузки.<br/>
Если выбирать какой-то один вариант, можно предложить виртуализацию уровня ОС. Контейнеры быстро поднимаются и восстанавливаются, можно быстро организовать ещё пару контейнеров (при наличии ресурсов, конечно), и более-менее гибко их настраивать. И обеспечить безопасный доступ к ресурсам.
2. Различные web-приложения.<br/>
Также можно использовать виртуализацию на уровне ОС для распределения элементов системы по контейнерам и обеспечения безопасных доступов.
3. Windows-системы для использования бухгалтерским отделом. <br/>
Подойдёт что угодно, что может запускаться нажатием на ярлык, помещённый в центр рабочего стола.<br/>
Если мы не можем установить Windows на рабочие машины, можно поднимать их локально, используя паравиртуализацию.
4. Cистемы, выполняющие высокопроизводительные расчёты на GPU.<br/>
Физические сервера. Чем меньше прослоек до вычислительных ресурсов, тем лучше.

---

## Задача 3

Выберите подходящую систему управления виртуализацией для предложенного сценария. Опишите ваш выбор.

Сценарии:

1. 100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based-инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий.
2. Требуется наиболее производительное бесплатное open source-решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.
3. Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows-инфраструктуры.
4. Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.

## Решение 3

1. После "преимущественно Windows based-инфраструктура" нет никаких смнений в выборе "Microsoft Hyper-V". Кто лучше Miscrosoft справится со своими же системами?<br/>
К тому же он проще в обслуживании, содержит инструмент кластеризации Failover Clustering, позволяет создавать резервные копии (System Center Data Protection Manager).
2. Можно использовать KVM. Хотя он и не настолько надёжен, как Xen, он более производителен.
3. Можно использовать VMWare, но с ограничениями бесплатной версии. Или VirtualBox.
4. Для сценария подойдут и KVM, и Xen. С учётом того, что это рабочее окружение, Xen подойдёт больше, так как стабильнее.

---

## Задача 4

Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, создавали бы вы гетерогенную среду или нет?

## Решение 4

Минусы гетерогенной среды виртуализации:
* От инженера требуется больше знаний и компетенций, так как задействовано больше решений. Либо же требуется команда инженеров для обслуживания.
* Больше точек отказа.
* Больше слоёв абстракции.
* Невозможность создания универсальных решений.

По большей части эти проблемы решаются повышением квалифицаии и оптимизации использования таких сред.

Гетерогенная среда, подозреваю, появляется не от хорошей жизни. Так что по возможности я бы её избегала, пока её использование не стало бы необходимостью или преимущества перевесили недостатки.

---