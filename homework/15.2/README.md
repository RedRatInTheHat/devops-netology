## Задача 1

Используя Docker, поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose-манифест.

## Решение 1

```yml
version: '3.8'

services:
  postgres:
    image: postgres:12
    container_name: postgres
    restart: always
    environment:
      POSTGRES_PASSWORD: "postgres"
      PGDATA: "/var/lib/postgresql/data/pgdata"
    volumes:
      - ./data:/var/lib/postgresql/data
      - ./backup:/home/Documents/backup
    ports:
      - "5432:5432"
```

---
## Задача 2

В БД из задачи 1: 

- создайте пользователя test-admin-user и БД test_db;
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже);
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db;
- создайте пользователя test-simple-user;
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE этих таблиц БД test_db.

Таблица orders:

- id (serial primary key);
- наименование (string);
- цена (integer).

Таблица clients:

- id (serial primary key);
- фамилия (string);
- страна проживания (string, index);
- заказ (foreign key orders).

Приведите:

- итоговый список БД после выполнения пунктов выше;
- описание таблиц (describe);
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db;
- список пользователей с правами над таблицами test_db.

## Решение 2

```sql
create user "test-admin-user";

create database test_db;

create table orders (
	id serial primary key,
	name varchar(255),
	price int
);

create table clients (
	id serial primary key,
	фамилия varchar(255),
	"страна проживания" varchar(255),
	заказ int,
	constraint fk_заказы
		foreign key (заказ)
		references orders(id)
);

create index i_страна on clients("страна проживания");

grant all privileges on
all tables in schema public to "test-admin-user";

create user "test-simple-user"; 

grant select, insert, update, delete on orders, clients to "test-admin-user";
```

Проверяем созданные таблицы:
```sql
\dt+
\d+ orders
\d+ clients
```
Получаем:
```
          List of relations
 Schema |  Name   | Type  |  Owner   
--------+---------+-------+----------
 public | clients | table | postgres
 public | orders  | table | postgres

                                                            Table "public.orders"
    Column    |          Type          | Collation | Nullable |              Default               | Storage  | Stats target | Description 
--------------+------------------------+-----------+----------+------------------------------------+----------+--------------+-------------
 id           | integer                |           | not null | nextval('orders_id_seq'::regclass) | plain    |              | 
 наименование | character varying(255) |           |          |                                    | extended |              | 
 цена         | integer                |           |          |                                    | plain    |              | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "fk_заказы" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap

                                                             Table "public.clients"
      Column       |          Type          | Collation | Nullable |               Default               | Storage  | Stats target | Description 
-------------------+------------------------+-----------+----------+-------------------------------------+----------+--------------+-------------
 id                | integer                |           | not null | nextval('clients_id_seq'::regclass) | plain    |              | 
 фамилия           | character varying(255) |           |          |                                     | extended |              | 
 страна проживания | character varying(255) |           |          |                                     | extended |              | 
 заказ             | integer                |           |          |                                     | plain    |              | 
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "i_страна" btree ("страна проживания")
Foreign-key constraints:
    "fk_заказы" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap
```

Проверяем доступы пользователей:

```sql
select
	*
from
	information_schema.role_table_grants
where
	grantee in ('test-admin-user', 'test-simple-user');
```

Получаем:
```
 grantor  |     grantee      | table_catalog | table_schema | table_name | privilege_type | is_grantable | with_hierarchy 
----------+------------------+---------------+--------------+------------+----------------+--------------+----------------
 postgres | test-simple-user | test_db       | public       | orders     | INSERT         | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | SELECT         | NO           | YES
 postgres | test-simple-user | test_db       | public       | orders     | UPDATE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | DELETE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | INSERT         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | SELECT         | NO           | YES
 postgres | test-admin-user  | test_db       | public       | orders     | UPDATE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | DELETE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | TRUNCATE       | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | REFERENCES     | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | TRIGGER        | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | INSERT         | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | SELECT         | NO           | YES
 postgres | test-simple-user | test_db       | public       | clients    | UPDATE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | DELETE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | INSERT         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | SELECT         | NO           | YES
 postgres | test-admin-user  | test_db       | public       | clients    | UPDATE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | DELETE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | TRUNCATE       | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | REFERENCES     | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | TRIGGER        | NO           | NO
```

---

## Задача 3

Используя SQL-синтаксис, наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL-синтаксис:
- вычислите количество записей для каждой таблицы.

Приведите в ответе:

    - запросы,
    - результаты их выполнения.

## Решение 3

```sql
insert
	into
	orders (наименование, цена)
values ('Шоколад', 10),
	('Принтер',3000),
	('Книга', 500),
	('Монитор', 7000),
	('Гитара', 4000);

insert
	into
	clients (фамилия, "страна проживания")
values ('Иванов Иван Иванович', 'USA'),
	('Петров Петр Петрович', 'Canada'),
	('Иоганн Себастьян Бах', 'Japan'),
	('Ронни Джеймс Дио', 'Russia'),
	('Ritchie Blackmore', 'Russia');
```

Вычисляем количестов записей:

```
select count(*) from orders;
select count(*) from clients;
```

---

## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys, свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения этих операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод этого запроса.
 
Подсказка: используйте директиву `UPDATE`.

## Решение 4

```sql
update clients set заказ = (select id from orders where наименование = 'Книга') where фамилия = 'Иванов Иван Иванович';
update clients set заказ = (select id from orders where наименование = 'Монитор') where фамилия = 'Петров Петр Петрович';
update clients set заказ = (select id from orders where наименование = 'Гитара') where фамилия = 'Иоганн Себастьян Бах';
```

Выводим пользователей и заказы:
```sql
select
	c.фамилия,
	o.наименование
from
	clients c
join orders o on
	c.заказ = o.id;
```
Получаем:
```
       фамилия        | наименование 
----------------------+--------------
 Иванов Иван Иванович | Книга
 Петров Петр Петрович | Монитор
 Иоганн Себастьян Бах | Гитара
```

---

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните, что значат полученные значения.

## Решение 5

```sql
explain analyze
select
	c.фамилия,
	o.наименование
from
	clients c
join orders o on
	c.заказ = o.id;
```
Получаем:
```
                                                    QUERY PLAN                                                     
-------------------------------------------------------------------------------------------------------------------
 Hash Join  (cost=11.57..24.20 rows=70 width=1032) (actual time=0.049..0.055 rows=3 loops=1)
   Hash Cond: (o.id = c."заказ")
   ->  Seq Scan on orders o  (cost=0.00..11.40 rows=140 width=520) (actual time=0.013..0.015 rows=5 loops=1)
   ->  Hash  (cost=10.70..10.70 rows=70 width=520) (actual time=0.020..0.021 rows=3 loops=1)
         Buckets: 1024  Batches: 1  Memory Usage: 9kB
         ->  Seq Scan on clients c  (cost=0.00..10.70 rows=70 width=520) (actual time=0.010..0.014 rows=5 loops=1)
 Planning Time: 0.207 ms
 Execution Time: 0.093 ms
```

Здесь:
* cost – приблизительная стоимость запуска.
* rows – ожидаемое число выводимых строк. Не совсем понятно, почему 70.
* width – ожидаемый средний размер выводимых строк в байтах.
* actual time – время обработки запроса (или его этапа). Как видно, обработка идёт за 0.055мс максимум (на каждый этап затрачивается где-то 0.01-0.02мс).
* rows – количество строк. Как видно, в каждой таблице изначально обрабатываются по 5 строк, на этапе join'а – уже 3, которые мы и получаем в выводе.

В первой строке выводится суммарное значение для всех её потомков.

Отдельно видны операции условия (оператор ON), чтения таблиц и объединения таблиц и оценка для них.

---

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. задачу 1).

Остановите контейнер с PostgreSQL, но не удаляйте volumes.

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 
