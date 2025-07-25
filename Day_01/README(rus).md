# День 01 - Интенсив SQL

## _Первые шаги с множествами и JOIN в SQL_

Резюме: Сегодня вы научитесь получать нужные данные, используя операции с множествами и простые JOIN-ы.

## Содержание

1. [Глава I](#глава-i) \
    1.1. [Введение](#введение)
2. [Глава II](#глава-ii) \
    2.1. [Общие правила](#общие-правила)
3. [Глава III](#глава-iii) \
    3.1. [Правила дня](#правила-дня)  
4. [Глава IV](#глава-iv) \
    4.1. [Упражнение 00 - Танец UNION](#упражнение-00-танец-union)  
5. [Глава V](#глава-v) \
    5.1. [Упражнение 01 - UNION с подзапросом](#упражнение-01-union-с-подзапросом)  
6. [Глава VI](#глава-vi) \
    6.1. [Упражнение 02 - Дубликаты или нет](#упражнение-02-дубликаты-или-нет)  
7. [Глава VII](#глава-vii) \
    7.1. [Упражнение 03 - "Скрытые" инсайты](#упражнение-03-скрытые-инсайты)  
8. [Глава VIII](#глава-viii) \
    8.1. [Упражнение 04 - Разница между мультимножествами](#упражнение-04-разница-между-мультимножествами)
9. [Глава IX](#глава-ix) \
    9.1. [Упражнение 05 - Картезианское произведение](#упражнение-05-картезианское-произведение)
10. [Глава X](#глава-x) \
    10.1. [Упражнение 06 - Ещё раз о "Скрытых" инсайтах](#упражнение-06-ещё-раз-о-скрытых-инсайтах)
11. [Глава XI](#глава-xi) \
    11.1. [Упражнение 07 - Просто JOIN](#упражнение-07-просто-join)
12. [Глава XII](#глава-xii) \
    12.1. [Упражнение 08 - NATURAL JOIN](#упражнение-08-natural-join)
13. [Глава XIII](#глава-xiii) \
    13.1. [Упражнение 09 - IN против EXISTS](#упражнение-09-in-против-exists)
14. [Глава XIV](#глава-xiv) \
    14.1. [Упражнение 10 - Глобальный JOIN](#упражнение-10-глобальный-join)


## Глава I
## Введение

![D01_01](misc/images/D01_01.png)

Во многих аспектах реляционных баз данных используются множества. Не только для операций UNION или MINUS между наборами данных. Множества также полезны для рекурсивных запросов.

В PostgreSQL доступны следующие операторы множеств:
- UNION [ALL]
- EXCEPT [ALL]
- INTERSECT [ALL]

Ключевое слово "ALL" означает сохранение дубликатов строк в результате.
Основные правила работы с множествами:
- Главный SQL-запрос определяет итоговые имена столбцов для всего результата
- Столбцы подчинённого SQL-запроса должны совпадать по количеству и типу с главным запросом

![D01_02](misc/images/D01_02.png)

Кроме того, SQL-множества полезны для вычисления некоторых метрик Data Science, например, расстояния Жаккара между двумя объектами на основе имеющихся признаков.


## Глава II
## Общие правила

- Используйте только эту страницу как источник информации. Не доверяйте слухам и домыслам о том, как выполнять задания.
- Убедитесь, что используете последнюю версию PostgreSQL.
- Можно использовать IDE для написания SQL-скриптов.
- Для проверки ваши решения должны быть в вашем GIT-репозитории.
- Ваши решения будут проверяться вашими одногруппниками.
- В вашей папке не должно быть файлов, кроме явно указанных в заданиях. Рекомендуется настроить `.gitignore` для предотвращения случайных ошибок.
- Есть вопрос? Спросите соседа справа. Если не помог — попробуйте слева.
- Ваши справочники: одногруппники / Интернет / Google.
- Внимательно читайте примеры — иногда в них есть требования, не указанные явно в тексте задания.
- Пусть SQL-Сила будет с вами!
- Абсолютно всё можно выразить на SQL! Начнём и получим удовольствие!

## Глава III
## Правила дня

- Убедитесь, что у вас есть собственная база данных и доступ к ней в вашем кластере PostgreSQL.
- Скачайте [скрипт](materials/model.sql) с моделью базы данных и примените его к своей базе (можно через psql или любую IDE, например DataGrip или pgAdmin).
- В каждом задании есть разделы Allowed и Denied с разрешёнными и запрещёнными конструкциями. Ознакомьтесь с ними перед началом.
- Ознакомьтесь с логической схемой нашей базы данных:

![schema](misc/images/schema.png)

1. **pizzeria** — справочник доступных пиццерий
    - id — первичный ключ
    - name — название пиццерии
    - rating — средний рейтинг (от 0 до 5)
2. **person** — справочник любителей пиццы
    - id — первичный ключ
    - name — имя
    - age — возраст
    - gender — пол
    - address — адрес
3. **menu** — справочник меню и цен на конкретную пиццу
    - id — первичный ключ
    - pizzeria_id — внешний ключ на пиццерию
    - pizza_name — название пиццы
    - price — цена
4. **person_visits** — информация о посещениях пиццерий
    - id — первичный ключ
    - person_id — внешний ключ на person
    - pizzeria_id — внешний ключ на pizzeria
    - visit_date — дата посещения (например, 2022-01-01)
5. **person_order** — информация о заказах
    - id — первичный ключ
    - person_id — внешний ключ на person
    - menu_id — внешний ключ на menu
    - order_date — дата заказа (например, 2022-01-01)

Посещение и заказ — разные сущности и не связаны напрямую. Например, клиент может быть в одной пиццерии (просто смотреть меню), а заказать — в другой по телефону или через приложение. Или вообще заказать из дома.

## Глава IV
## Упражнение 00 - Танец UNION

| Упражнение 00: Танец UNION |                                                                                                                          |
|---------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Папка для сдачи           | ex00                                                                                                                     |
| Файл для сдачи            | `day01_ex00.sql`                                                                                 |
| **Разрешено**             |                                                                                                                          |
| Язык                      | ANSI SQL                                                                                              |

Напишите SQL-запрос, который возвращает идентификатор и название пиццы из таблицы `menu` и идентификатор и имя человека из таблицы `person` в одном общем списке (с именами столбцов, как в примере ниже), отсортированном по object_id, затем по object_name.

| object_id | object_name |
| --------- | ----------- |
| 1         | Анна        |
| 1         | cheese pizza|
| ...       | ...         |


## Глава V
## Упражнение 01 - UNION с подзапросом

| Упражнение 01: UNION с подзапросом |                                                                                                                          |
|------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Папка для сдачи                    | ex01                                                                                                                     |
| Файл для сдачи                     | `day01_ex01.sql`                                                                                 |
| **Разрешено**                      |                                                                                                                          |
| Язык                               | ANSI SQL                                                                                              |

Измените SQL-запрос из "Упражнения 00", убрав столбец object_id. Затем отсортируйте часть данных из таблицы `person` по object_name, а затем — из таблицы `menu` (как в примере ниже). Сохраняйте дубликаты!

| object_name |
| ----------- |
| Андрей      |
| Анна        |
| ...         |
| cheese pizza|
| cheese pizza|
| ...         |


## Глава VI
## Упражнение 02 - Дубликаты или нет

| Упражнение 02: Дубликаты или нет |                                                                                                                          |
|----------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Папка для сдачи                  | ex02                                                                                                                     |
| Файл для сдачи                   | `day01_ex02.sql`                                                                                 |
| **Разрешено**                    |                                                                                                                          |
| Язык                             | ANSI SQL                                                                                              |
| **Запрещено**                    |                                                                                                                          |
| SQL-конструкции                  | `DISTINCT`, `GROUP BY`, `HAVING`, любые виды `JOIN`                                                                                              |

Напишите SQL-запрос, который возвращает уникальные названия пицц из таблицы `menu` и сортирует их по убыванию (desc) по столбцу pizza_name. Обратите внимание на запрещённые конструкции.


## Глава VII
## Упражнение 03 - "Скрытые" инсайты

| Упражнение 03: "Скрытые" инсайты |                                                                                                                          |
|-----------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Папка для сдачи                   | ex03                                                                                                                     |
| Файл для сдачи                    | `day01_ex03.sql`                                                                                 |
| **Разрешено**                     |                                                                                                                          |
| Язык                              | ANSI SQL                                                                                              |
| **Запрещено**                     |                                                                                                                          |
| SQL-конструкции                   | любые виды `JOIN`                                                                                              |

Напишите SQL-запрос, который возвращает общие строки по атрибутам order_date, person_id из таблицы `person_order` и visit_date, person_id из таблицы `person_visits` (см. пример ниже). То есть найдите идентификаторы людей, которые посещали и заказывали пиццу в один и тот же день. Отсортируйте по action_date по возрастанию и по person_id по убыванию.

| action_date | person_id |
| ----------- | --------- |
| 2022-01-01  | 6         |
| 2022-01-01  | 2         |
| 2022-01-01  | 1         |
| 2022-01-03  | 7         |
| 2022-01-04  | 3         |
| ...         | ...       |


## Глава VIII
## Упражнение 04 - Разница между мультимножествами

| Упражнение 04: Разница между мультимножествами |                                                                                                                          |
|-----------------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Папка для сдачи                              | ex04                                                                                                                     |
| Файл для сдачи                               | `day01_ex04.sql`                                                                                 |
| **Разрешено**                                |                                                                                                                          |
| Язык                                         | ANSI SQL                                                                                              |
| **Запрещено**                                |                                                                                                                          |
| SQL-конструкции                              | любые виды `JOIN`                                                                                              |

Напишите SQL-запрос, который возвращает разницу (минус) значений person_id с сохранением дубликатов между таблицами `person_order` и `person_visits` для заказов и посещений, совершённых 7 января 2022 года.


## Глава IX
## Упражнение 05 - Картезианское произведение

| Упражнение 05: Картезианское произведение |                                                                                                                          |
|-------------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Папка для сдачи                          | ex05                                                                                                                     |
| Файл для сдачи                           | `day01_ex05.sql`                                                                                 |
| **Разрешено**                            |                                                                                                                          |
| Язык                                     | ANSI SQL                                                                                              |

Напишите SQL-запрос, который возвращает все возможные комбинации строк из таблиц `person` и `pizzeria`. Отсортируйте по идентификатору человека, затем по идентификатору пиццерии. Пример результата ниже (названия столбцов могут отличаться):

| person.id | person.name | age | gender | address | pizzeria.id | pizzeria.name | rating |
| --------- | ----------- | --- | ------ | ------- | ----------- | ------------- | ------ |
| 1         | Анна        | 16  | жен    | Москва  | 1           | Pizza Hut     | 4.6    |
| 1         | Анна        | 16  | жен    | Москва  | 2           | Dominos       | 4.3    |
| ...       | ...         | ... | ...    | ...     | ...         | ...           | ...    |


## Глава X
## Упражнение 06 - Ещё раз о "Скрытых" инсайтах

| Упражнение 06: Ещё раз о "Скрытых" инсайтах |                                                                                                                          |
|---------------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Папка для сдачи                            | ex06                                                                                                                     |
| Файл для сдачи                             | `day01_ex06.sql`                                                                                 |
| **Разрешено**                              |                                                                                                                          |
| Язык                                       | ANSI SQL                                                                                              |

Вернитесь к упражнению №03 и измените SQL-запрос так, чтобы возвращались имена людей вместо их идентификаторов. Отсортируйте по action_date по возрастанию, затем по person_name по убыванию. Пример результата:

| action_date | person_name |
| ----------- | ----------- |
| 2022-01-01  | Ирина       |
| 2022-01-01  | Анна        |
| 2022-01-01  | Андрей      |
| ...         | ...         |


## Глава XI
## Упражнение 07 - Просто JOIN

| Упражнение 07: Просто JOIN |                                                                                                                          |
|---------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Папка для сдачи           | ex07                                                                                                                     |
| Файл для сдачи            | `day01_ex07.sql`                                                                                 |
| **Разрешено**             |                                                                                                                          |
| Язык                      | ANSI SQL                                                                                              |

Напишите SQL-запрос, который возвращает дату заказа из таблицы `person_order` и соответствующую информацию о человеке (имя и возраст в формате, как в примере ниже) из таблицы `person`. Отсортируйте по обоим столбцам по возрастанию.

| order_date | person_information |
| ---------- | ----------------- |
| 2022-01-01 | Андрей (возраст:21)|
| 2022-01-01 | Андрей (возраст:21)|
| 2022-01-01 | Анна (возраст:16) |
| ...        | ...               |


## Глава XII
## Упражнение 08 - NATURAL JOIN

| Упражнение 08: NATURAL JOIN |                                                                                                                          |
|-----------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Папка для сдачи             | ex08                                                                                                                     |
| Файл для сдачи              | `day01_ex08.sql`                                                                                 |
| **Разрешено**               |                                                                                                                          |
| Язык                        | ANSI SQL                                                                                              |
| SQL-конструкция             | `NATURAL JOIN`                                                                                              |
| **Запрещено**               |                                                                                                                          |
| SQL-конструкция             | другие виды `JOIN`                                                                                              |

Перепишите SQL-запрос из упражнения №07, используя конструкцию NATURAL JOIN. Результат должен быть таким же, как и в упражнении №07.


## Глава XIII
## Упражнение 09 - IN против EXISTS

| Упражнение 09: IN против EXISTS |                                                                                                                          |
|---------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Папка для сдачи                 | ex09                                                                                                                     |
| Файл для сдачи                  | `day01_ex09.sql`                                                                                 |
| **Разрешено**                   |                                                                                                                          |
| Язык                            | ANSI SQL                                                                                              |

Напишите два SQL-запроса, которые возвращают список названий пиццерий, которые не были посещены ни одним человеком: первый — с использованием IN, второй — с использованием EXISTS.


## Глава XIV
## Упражнение 10 - Глобальный JOIN

| Упражнение 10: Глобальный JOIN |                                                                                                                          |
|-------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Папка для сдачи               | ex10                                                                                                                     |
| Файл для сдачи                | `day01_ex10.sql`                                                                                 |
| **Разрешено**                 |                                                                                                                          |
| Язык                          | ANSI SQL                                                                                              |

Напишите SQL-запрос, который возвращает список имён людей, заказавших пиццу в соответствующей пиццерии. Пример результата (с названиями столбцов): отсортируйте по трём столбцам (`person_name`, `pizza_name`, `pizzeria_name`) по возрастанию.

| person_name | pizza_name    | pizzeria_name |
| ----------- | ------------ | ------------- |
| Андрей      | cheese pizza | Dominos       |
| Андрей      | mushroom pizza | Dominos     |
| Анна        | cheese pizza | Pizza Hut     |
| ...         | ...          | ...           | 