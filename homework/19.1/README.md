## Основная часть

Необходимо создать собственные workflow для двух типов задач: bug и остальные типы задач. Задачи типа bug должны проходить жизненный цикл:

1. Open -> On reproduce.
2. On reproduce -> Open, Done reproduce.
3. Done reproduce -> On fix.
4. On fix -> On reproduce, Done fix.
5. Done fix -> On test.
6. On test -> On fix, Done.
7. Done -> Closed, Open.

Остальные задачи должны проходить по упрощённому workflow:

1. Open -> On develop.
2. On develop -> Open, Done develop.
3. Done develop -> On test.
4. On test -> On develop, Done.
5. Done -> Closed, Open.

**Что нужно сделать**

1. Создайте задачу с типом bug, попытайтесь провести его по всему workflow до Done. 
1. Создайте задачу с типом epic, к ней привяжите несколько задач с типом task, проведите их по всему workflow до Done. 
1. При проведении обеих задач по статусам используйте kanban. 
1. Верните задачи в статус Open.
1. Перейдите в Scrum, запланируйте новый спринт, состоящий из задач эпика и одного бага, стартуйте спринт, проведите задачи до состояния Closed. Закройте спринт.
2. Если всё отработалось в рамках ожидания — выгрузите схемы workflow для импорта в XML. Файлы с workflow и скриншоты workflow приложите к решению задания.

---

### Решение

Для выполнения задания использовался docker-образ Jira Data Center.

Созданы два бизнес-процесса: Bug и Netology default.

![alt text](images/1.png)

![alt text](images/2.png)

Бизнес-процессы привязаны к типам заявок:

![alt text](images/3.png)

Создана задача типа Bug; проведена до статуса Done:

![alt text](images/4.png)

Создана Kanban-доска. Разделение по типу статусов выглядит достаточно наглядным, так что ничего менять не пришлось:

![alt text](images/5.png)

Создан Epic, в него добавлены задачи, проведённые по Kanban-доске до статуса Done (и ещё добавлена связь с Bug, чтобы ему не скучно было):

![alt text](images/6.png)

Запланирован новый спринт:

![alt text](images/7.png)

Задачи спринта завершены:

![alt text](images/8.png)

Спринт завершён:

![alt text](images/9.png)

Бизнес-процессы выгружены: [Bug](workflows/Bug.xml), [Netology default](<workflows/Netology default.xml>).