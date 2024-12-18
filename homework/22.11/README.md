
## Задание. Необходимо определить требуемые ресурсы

Известно, что проекту нужны база данных, система кеширования, а само приложение состоит из бекенда и фронтенда. Опишите, какие ресурсы нужны, если известно:

1. Необходимо упаковать приложение в чарт для деплоя в разные окружения. 
2. База данных должна быть отказоустойчивой. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии. 
3. Кеш должен быть отказоустойчивый. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии. 
4. Фронтенд обрабатывает внешние запросы быстро, отдавая статику. Потребляет не более 50 МБ ОЗУ на каждый экземпляр, 0.2 ядра. 5 копий. 
5. Бекенд потребляет 600 МБ ОЗУ и по 1 ядру на копию. 10 копий.

---

### Решение

1. Для управления всем этим добром нужны master-ноды, не меньше трёх.<br/>
Требования к ним везде указываются разные; возьмём рекомендации из лекции. Тогда на каждой ноде должно быть как минимум 2ГБ RAM, 2 ядра CPU, 50ГБ дискового пространства. <br/>
Помножим это значение на два для какого-никакого запаса.

2. База данных. Итак, минимально нужны 3 ноды с 4ГБ RAM и одним ядром. <br/>
Вероятно, это не слишком большие базы данных, но одному богу (и опытным сеньорам) известно, сколько же она будет занимать данные. Данные одного сайта с сомнительной статистикой показывают, что, исходя из количества RAM, нужно будет 28 ГБ памяти. Для красоты округлим до 32.

3. Кеш. Тут всё так же, 3 ноды с 4ГБ RAM и одним ядром.<br/>
При использовании механизма постоянного хранения, данные также будут записываться на диск, то есть нужно как минимум 4ГБ свобдного пространства. Увеличим в два раза на всякий случай, получаем 8.

4. Фронтенд. 5 экземпляров по 50МБ RAM и 0.2 ядра.<br/>
Никаких представлений, что это может быть такое маленькое и шустрое. Зажмуримся и кинем 2ГБ памяти на каждый экземпляр.

5. Бекенд. 10 копий по 600МБ RAM и 1 ядру каждая.<br/>
Также пальцем в небо укажем 4ГБ на каждое приложение.

Итого.
1. Master-ноды.
    * 3 копии. На каждой:
    * 4ГБ RAM
    * 4 ядра

2. Worker-ноды.
    * Возьмём 5 нод, чтобы не так больно было терять одну.<br/>
        * Самая большая проблема возникнет с распихиванием подов с базой данных -- у неё должна быть возможность расположиться на каждой ноде и возможность переехать на любую из нод в случае неполадок. Это минимум 4ГБ RAM, одно ядро и 32ГБ каждая.
        * На каждой ноде также может расположиться по одному поду кеша, так что это ещё плюс 4ГБ RAM, ядро и 8 ГБ каждая.
        * Равномерно размажем поды фронтенда. Не будем мельчить, и добавим 1ГБ RAM, 1 ядро и 2ГБ каждой ноде.
        * Также размажем бэкенд по два пода на ноду, и тогда каждой ноде прибавляем (также, округляя) 2ГБ RAM, 2 ядра и 16ГБ каждой.
        * Итого, при таком распределении получается избыток примерно в 24ГБ RAM, 8я и 120ГБ -- достаточно для переезда одной упавшей ноды. Хотя, конечно, надёжнее было бы просто увеличить ресурсы каждой ноды в два раза, чтобы места точно хватило под переезжающий под любого размера.
        Но пока оставим так. Получаем:
    * 11ГБ RAM
    * 5 ядер
    * 58ГБ

