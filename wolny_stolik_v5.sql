# version_5.0 2017-08-23 00:38

###
###  !!! BAZA DANYCH
###

create database wolny_stolik_5;

use wolny_stolik_5;

###
###  !!! TABELE
###

# tabela miast
create table cities (
	id_city int unsigned not null auto_increment,
	city_name varchar(30) not null,
    primary key (id_city)
);

# tabela rodzajów kuchni
create table cuisines (
	id_cuisine int unsigned not null auto_increment,
    type_cuisine varchar(30) unique not null,
	primary key (id_cuisine)
);

# tabela restauracji
create table restaurants (
	id_rest int unsigned not null auto_increment,
    rest_name varchar(30) not null,
    id_city int unsigned not null,
    id_cuisine int unsigned not null,
    primary key (id_rest),
    foreign key (id_city) references cities(id_city),
    foreign key (id_cuisine) references cuisines(id_cuisine)
);

#tabela kelnerzy
create table waiters (
	id_wait int unsigned not null auto_increment,
    login varchar(60) unique not null,
    pass varchar(30) not null,
    id_rest int unsigned not null,
    date_login datetime not null,
    primary key (id_wait),
    foreign key (id_rest) references restaurants(id_rest)
);

# tabela użytkowników
create table users (
	id_user int unsigned not null auto_increment,
    e_mail varchar(60) unique not null,
    pass varchar(30) not null,
    id_city int unsigned,
    date_login datetime not null,
    primary key (id_user),
    foreign key (id_city) references cities(id_city)
);

# tabela oceny
create table rating (
	id_rating int unsigned not null auto_increment,
	id_user int unsigned not null,
    id_rest int unsigned not null,
    value_rating float(3,1) unsigned not null,
    primary key (id_rating),
	foreign key (id_user) references users(id_user),
    foreign key (id_rest) references restaurants(id_rest)
);

# tabela rodzajów stolików TABELA GŁÓWNA
create table type_tables(
	id_table int unsigned not null auto_increment,
    id_rest int unsigned not null,
    nr_table int unsigned not null,
    qty_chairs int not null,
    smooking boolean not null,
    outside boolean not null,
    primary key (id_table),
    foreign key (id_rest) references restaurants(id_rest)
);

# tabela rezerwacji w tym momencie
create table booking_now (
	id_booking_now int unsigned not null auto_increment,
    id_user int unsigned not null,
    id_table int unsigned not null,
	date_book_now datetime not null,
    primary key (id_booking_now),
    foreign key (id_user) references users(id_user),
    foreign key (id_table) references type_tables(id_table)
);

# tabela rezerwacji na przyszłość
create table booking_future (
	id_booking_future int unsigned not null auto_increment,
    id_user int unsigned not null,
    id_table int unsigned not null,
	date_book_start datetime not null,
    date_book_stop datetime not null,
    primary key (id_booking_future),
    foreign key (id_user) references users(id_user),
    foreign key (id_table) references type_tables(id_table)
);

# tabela zajętości stolika w danej restauracj w chwili obecnej
create table occupancy (
	id_occ int unsigned not null auto_increment,
    id_table int unsigned not null,
    id_wait int unsigned not null,
    time_occ_start datetime not null,
    primary key (id_occ),
    foreign key (id_table) references type_tables(id_table),
    foreign key (id_wait) references waiters(id_wait)
);

###
###  !!! Zapytania
### 

##
## Zapytania do autoryzacji 
##

# zapytanie do bazy danych w celu wyszukania konkretnego użytkownika jego loginu i hasła, wykorzystane w celu autoryzacji
select id_user, e_mail, pass from users where e_mail = 'tomek@tomek.pl';
select e_mail, pass from users where pass = 'user1_1pass';

select id_wait, login, pass, rest_name from waiters natural left join restaurants where login = 'waiter_zap1';
select login, pass, rest_name from waiters natural left join restaurants where pass = 'waiter_zap1pass';

select id_wait, login, pass from waiters where login = 'waiter_zap1';

##
## Zapytania wykomywane od użytkowników
##

# zapytanie o wypisanie miast

select * from cities;

select city_name from cities natural left join users where e_mail = 'user1_1@gmail.com';

# zapytanie o restaurację w danym mieście

# wszystkie restauracjie
select city_name as 'Miasto', rest_name as 'Nazwa restauracji;' from restaurants natural left join cities;
# restauracjie z Warszawy
select city_name as 'Miasto', rest_name as 'Nazwa restauracji;' from restaurants natural left join cities where city_name = 'Warszawa';
# restauracje z Krakowa
select city_name as 'Miasto', rest_name as 'Nazwa restauracji;' from restaurants natural left join cities where city_name = 'Kraków';
# restauracje z Katowic
select city_name as 'Miasto', rest_name as 'Nazwa restauracji;' from restaurants natural left join cities where city_name = 'Katowice';

# zapytania o ilość stolików w restauracji (pomijając rezerwacje "booking" i zajętość stolika "occupancy")

# zapytanie o wszystkie stoliki w danej restauracji (bez sumowania ich)

select id_table, nr_table, qty_chairs from type_tables natural left join restaurants where rest_name = 'Zapiecek';

# ilości stolików i ilości krzeseł przy tym stoliku w restauracji
select city_name as 'Miasto', rest_name  as 'Nazwa restauracji', qty_chairs as 'Ilość krzeseł przy stoliku', count(qty_chairs) as 'Ilość stolików z określoną ilością krzeseł' from restaurants natural right join type_tables natural left join cities group by id_rest, qty_chairs;
# suma wszystkich stolików w restauracji
select city_name as 'Miasto', rest_name as 'Nazwa restauracji', count(id_rest) as 'Ilość wszystkich stolików' from restaurants natural left join type_tables natural left join cities group by city_name desc, rest_name;
# ilość stolików dla 2 osób (przyjęto, że 2 osoby mogą siedzieć przy stoliku 2  albo 4 osobowym)
select city_name as 'Miasto', rest_name as 'Nazwa restauracji', count(id_rest) as 'Ilość stolików dla 2 osób' from restaurants natural left join type_tables natural left join cities where qty_chairs = 4 or qty_chairs = 2 group by city_name desc, rest_name; 
# ilość stolików dla 3 osób (przyjęto, że 3 osoby mogą siedzieć przy stoliku 4 osobowym)
select city_name as 'Miasto', rest_name as 'Nazwa restauracji', count(id_rest) as 'Ilość stolików dla 3 osbó' from restaurants natural left join type_tables natural left join cities where qty_chairs = 4 group by city_name desc, rest_name; 
# ilość stolików dla 4 osób (przyjęto, że 4 osoby mogą siedzieć przy stoliku 4 albo 6 osobowym)
select city_name as 'Miasto', rest_name as 'Nazwa restauracji', count(id_rest) as 'Ilość stolików dla 4 osób' from restaurants natural left join type_tables natural left join cities where qty_chairs = 4 or qty_chairs = 6 group by city_name desc, rest_name; 
# ilość stolików dla 5 osób i więcej osób (max. 8) (przyjęto, że 5 i więcej osób może siedzieć przy stoliku 6 albo 8)
select city_name as 'Miasto', rest_name as 'Nazwa restauracji', count(id_rest) as 'Ilość stolików dla 5 osób i więcej' from restaurants natural left join type_tables natural left join cities where qty_chairs >= 6 group by city_name desc, rest_name; 

# zapytania o ocenę restauracji

# wypisuje każdą ocenę otrzymaną przez restaurację
select city_name as 'Miasto', rest_name as 'Nazwa restauracji', e_mail as 'Użytkownik', value_rating 'Ocena' from restaurants natural left join rating natural left join cities natural left join users;
# wyświetla średnią ocenę restauracji spośród otrzymanych
select id_rest as 'Id restauracji', city_name as 'Miasto', rest_name as 'Nazwa restauracji', round(avg(value_rating),1) as 'Ocena' from restaurants natural left join rating natural left join cities where city_name = 'Warszawa' group by rest_name order by city_name desc, Ocena desc;

select id_rest as 'Id restauracji', rest_name as 'Nazwa restauracji', type_cuisine as 'Rodzaj kuchni', round(avg(value_rating),1) as 'Ocena' from restaurants natural left join rating natural left join cities natural right join cuisines  where city_name = 'Warszawa' group by rest_name order by city_name desc, Ocena desc;

select id_rest as 'Id restauracji', rest_name as 'Nazwa restauracji', type_cuisine as 'Rodzaj kuchni', round(avg(value_rating),1) as 'Ocena' from restaurants natural left join rating natural left join cities natural right join cuisines  where city_name = (select city_name from cities natural left join users where e_mail = 'user1_1@gmail.com') group by rest_name order by city_name desc, Ocena desc;

# wyświetla restauracje ze średnią oceną powyżej x (np. 5.0)
select city_name as 'Miasto', rest_name as 'Nazwa restauracji', round(avg(value_rating),1) as 'Ocena' from restaurants natural left join rating natural left join cities group by rest_name having round(avg(value_rating),1) > 5.0 order by city_name desc ;

# zapytania o rodzaj kuchni
select city_name as 'Miasto', rest_name as 'Nazwa restauracji', type_cuisine as 'Rodzaj kuchni' from restaurants natural right join cuisines natural left join cities;

#
# Zapytania wykonywane od kelnerów
#

# wyświetlenie rezerwacji stolików dokonanych przez użytkowników (wszystkich rezerwacji, bez względu na datę)
select e_mail, nr_table, date_book_start, date_book_stop from booking natural left join users natural left join type_tables order by e_mail;
# wyświetlenie rezerwacji stolików dokonanych przez użytkowników w konkretnym dniu
select e_mail, nr_table, date_book_start, date_book_stop from booking natural left join users natural left join type_tables where date_format(date_book_start, '%Y-%m-%d') = '2017-08-10' order by e_mail;
# wyświetla rezerwację stolików w dniu dzisiejszym, aby sprawdzić ile jest dokonanych rezerwacji z wyprzedzeniem:
select e_mail, nr_table, date_book_start, date_book_stop from booking natural left join users natural left join type_tables where date_format(date_book_start, '%Y-%m-%d') = current_date() order by e_mail;

# zapytania o rezerwację stolika

# zapytania o zajętość stolika

# sprawdzenie statusu zajętości stolików 
select city_name as 'Miasto', rest_name as 'Nazwa restauracji', nr_table as 'Numer stolika', qty_chairs as 'Ilość krzeseł przy stoliku', case when time_occ_start < now() then 'stolik zajęty' end as 'Status zajętości stolika' from occupancy natural join type_tables natural join restaurants natural join cities;
select city_name as 'Miasto', rest_name as 'Nazwa restauracji', nr_table as 'Numer stolika', qty_chairs as 'Ilość krzeseł przy stoliku', 'stolik zajęty' from occupancy natural join type_tables natural join restaurants natural join cities;
select rest_name, nr_table, login, qty_chairs, time_occ_start from occupancy natural join type_tables natural join restaurants natural left join waiters where rest_name = 'Zapiecek' and nr_table = '4';


# sprawdzenie czy dany nr stolika danej restauracji jest już zajęty
select rest_name, nr_table, login, qty_chairs, time_occ_start from occupancy natural join type_tables natural join restaurants natural left join waiters where nr_table = '2' and rest_name = 'Zapiecek';

# sprawdzenie czy dany nr stolika jest w restauracji
select rest_name, nr_table, qty_chairs from type_tables natural left join restaurants where nr_table = '1' and rest_name = 'Zapiecek'; 

# sprawdzenie dostepności stolików odliczając te które są zajęte
# poniższe zapytanie dotyczące konkretnej restauracji i konrketnego typou stolika
select rest_name as 'Nazwa restauracji', qty_chairs as 'Ilość krzeseł przy stoliku', (select count(qty_chairs) from type_tables natural left join restaurants where rest_name = 'Zapiecek' and qty_chairs = 2 group by id_rest, qty_chairs) - (select count(qty_chairs) from occupancy natural left join restaurants natural left join type_tables where rest_name = 'Zapiecek' and qty_chairs = 2 group by rest_name, qty_chairs order by rest_name desc) as 'Dostępna ilość stolików' from restaurants natural left join type_tables where rest_name = 'Zapiecek' and qty_chairs = 2 group by rest_name, qty_chairs;
select rest_name as 'Nazwa restauracji', qty_chairs as 'Ilość krzeseł przy stoliku', (select count(qty_chairs) from type_tables natural left join restaurants where rest_name = 'Zapiecek' and qty_chairs = 4 group by id_rest, qty_chairs) - (select count(qty_chairs) from occupancy natural left join restaurants natural left join type_tables where rest_name = 'Zapiecek' and qty_chairs = 4 group by rest_name, qty_chairs order by rest_name desc) as 'Dostępna ilość stolików' from restaurants natural left join type_tables where rest_name = 'Zapiecek' and qty_chairs = 4 group by rest_name, qty_chairs;
select rest_name as 'Nazwa restauracji', qty_chairs as 'Ilość krzeseł przy stoliku', (select count(qty_chairs) from type_tables natural left join restaurants where rest_name = 'Zapiecek' and qty_chairs = 6 group by id_rest, qty_chairs) - (select count(qty_chairs) from occupancy natural left join restaurants natural left join type_tables where rest_name = 'Zapiecek' and qty_chairs = 6 group by rest_name, qty_chairs order by rest_name desc) as 'Dostępna ilość stolików' from restaurants natural left join type_tables where rest_name = 'Zapiecek' and qty_chairs = 6 group by rest_name, qty_chairs;
select rest_name as 'Nazwa restauracji', qty_chairs as 'Ilość krzeseł przy stoliku', (select count(qty_chairs) from type_tables natural left join restaurants where rest_name = 'Zapiecek' and qty_chairs = 8 group by id_rest, qty_chairs) - (select count(qty_chairs) from occupancy natural left join restaurants natural left join type_tables where rest_name = 'Zapiecek' and qty_chairs = 8 group by rest_name, qty_chairs order by rest_name desc) as 'Dostępna ilość stolików' from restaurants natural left join type_tables where rest_name = 'Zapiecek' and qty_chairs = 8 group by rest_name, qty_chairs;

# całkowita ilość stolików o określonej liczbie krzeseł w konkretnej restauracji
select count(qty_chairs) from type_tables natural left join restaurants where rest_name = 'Zapiecek' and qty_chairs = 2 group by id_rest, qty_chairs;
select count(qty_chairs) from type_tables natural left join restaurants where rest_name = 'Zapiecek' and qty_chairs = 4 group by id_rest, qty_chairs;
select count(qty_chairs) from type_tables natural left join restaurants where rest_name = 'Zapiecek' and qty_chairs = 6 group by id_rest, qty_chairs;
select count(qty_chairs) from type_tables natural left join restaurants where rest_name = 'Zapiecek' and qty_chairs = 8 group by id_rest, qty_chairs;

# zapytania o ilość stolików w restauracji oraz o ilość stolików w restauaracji które są zajęte

select count(nr_table) from type_tables natural left join restaurants where rest_name = 'Zapiecek' group by id_rest;

select id_table, id_rest, nr_table, qty_chairs from type_tables natural left join restaurants where rest_name = 'Zapiecek';

select count(nr_table) from occupancy natural left join restaurants natural left join type_tables where rest_name = 'Zapiecek' group by id_rest;

select id_table, nr_table, id_rest from occupancy natural left join restaurants natural left join type_tables where rest_name = 'Zapiecek';

select id_table, nr_table, id_rest, rest_name from booking natural left join type_tables natural left join restaurants;

select timestampdiff(minute, now(), date_book_now) from booking_now natural left join type_tables natural left join restaurants where rest_name = 'Zapiecek' and id_table = '8';

# sprawdzenie jeżeli zbliża się rezerwacja stolika
select case when timestampdiff(minute, now(), date_book_now) < 240 and  timestampdiff(minute, now(), date_book_now) >= 30 then concat_ws(' ', id_table, ' Uwaga: stolik zarezerwowany w dniu dziejszym zajęty od', date_format(date_book_now, '%H:%i')) end from booking_now where id_table = '1';

select case when timestampdiff(minute, now(), date_book_now) >= 30 then concat_ws(' ', id_table, ' Uwaga: stolik zarezerwowany w dniu dziejszym zajęty od', date_format(date_book_now, '%H:%i')) end from booking_now where id_table = '1';

# jeżeli rezerwacja z przyszłości się zbliża i czas jej jest jeszcze większy niż 30 minut to stolik jest dostępny ---- na razie nie rozważać
select case when timestampdiff(minute, now(), date_book_now) >= 30 then 1 end from booking_now where id_table = '1';

# jeżeli rezerwacja z przyszłości się zbliża i jej czas jest w granicy 30 minu - 0 minut to tolik jest już niedostępny ---- na razie nie rozważać
select case when timestampdiff(minute, now(), date_book_now) < 30 and timestampdiff(minute, now(), date_book_now) >= 0 then 0 end from booking_now where id_table = '1';

select case when timestampdiff(minute, now(), '2017-08-17 20:00') < 240 and timestampdiff(minute, now(), '2017-08-17 20:00') >= 30 then 1 end from booking_now where id_table = '1';

# sprawdzenie czy zaklepanie stolika miesci się w 15 minutach
select case when timestampdiff(minute, now(), date_book_now) <= 0 and timestampdiff(minute, now(), date_book_now) >= -15 then concat_ws(' ',timestampdiff(minute, now(), date_book_now),'stolik zaklepany') end from booking_now where id_table = '8';

# jeżeli zaklepanie się mieści w granicy 15 minut to stolik jest niedostepny
select case when timestampdiff(minute, now(), date_book_now) > 90 then 3 when timestampdiff(minute, now(), date_book_now) > 0 and timestampdiff(minute, now(), date_book_now) <= 90 then 2 when timestampdiff(minute, now(), date_book_now) <= 0 and timestampdiff(minute, now(), date_book_now) >= -15 then 1 else 0 end from booking_now where id_table = '7';

select case when timestampdiff(minute, now(), date_book_now) > 0 then 2 end from booking_now where id_table = '9';

select date_format(date_book_now, "%H:%i") from booking_now where timestampdiff(minute, now(), date_book_now) <= 0 and timestampdiff(minute, now(), date_book_now) >= -15 and id_table = '6';

select date_format(date_book_now, "%H:%i") from booking_now where timestampdiff(minute, now(), date_book_now) > 0 and timestampdiff(minute, now(), date_book_now) <= 90 and id_table = '8';

delete from booking_now where id_table = '4' and timestampdiff(minute, now(), date_book_now) < 0;

#jeżel od zaklepania mineło więcej niż 15 minut to stolik jest znowu dostępny
select case when timestampdiff(minute, now(), date_book_now) <= -15 then '1' end from booking_now where id_table = '8';

# sprawdzenie czy w tabeli zajętości wystepuje dany stolik w restauracji
select * from occupancy where id_table = '5';

select rest_name, id_table, nr_table, qty_chairs, e_mail, date_book_now from restaurants natural join type_tables natural join users natural join booking_now where id_table = '6';


# sprawdza ilość zajętych stolików danego typu w danej restauracji
select city_name as 'Miasto', rest_name as 'Nazwa restauracji', qty_chairs as 'Ilość krzeseł przy stoliku', count(qty_chairs) as 'Ilosc zajętych stolików z określoną ilością krzeseł' from occupancy natural join restaurants natural join type_tables natural join cities group by rest_name, qty_chairs order by city_name desc, rest_name desc;

select id_table, nr_table, rest_name from type_tables natural left join restaurants where nr_table = '1' and rest_name = 'Zapiecek';

select count(qty_chairs) from occupancy natural left join restaurants natural left join type_tables where rest_name = 'Zapiecek' and qty_chairs = 2 group by rest_name, qty_chairs order by rest_name desc;
select count(qty_chairs) from occupancy natural left join restaurants natural left join type_tables where rest_name = 'Zapiecek' and qty_chairs = 4 group by rest_name, qty_chairs order by rest_name desc;
select count(qty_chairs) from occupancy natural left join restaurants natural left join type_tables where rest_name = 'Zapiecek' and qty_chairs = 6 group by rest_name, qty_chairs order by rest_name desc;
select count(qty_chairs) from occupancy natural left join restaurants natural left join type_tables where rest_name = 'Zapiecek' and qty_chairs = 8 group by rest_name, qty_chairs order by rest_name desc;

select city_name as 'Miasto', rest_name as 'Nazwa restauracji', nr_table as 'Numer stolika', qty_chairs as 'Ilość krzeseł przy stoliku', case when time_occ_start < now() then 'stolik zajęty' end as 'Status zajętości stolika' from occupancy natural join type_tables natural join restaurants natural join cities;

select city_name as 'Miasto', rest_name as 'Nazwa restauracji', nr_table as 'Numer stolika', qty_chairs as 'Ilość krzeseł przy stoliku', case when time_occ_start < now() then 'stolik zajęty' end as 'Status zajętości stolika' from occupancy natural join type_tables natural join restaurants natural join cities;

# pokazuje stoliki obsłMugiwane przez konkretnego kelnera

select nr_table, qty_chairs from occupancy natural left join type_tables natural left join waiters where login = 'waiter_zap1' order by nr_table;



###
###  !!! Zapytania proste do pomocy
###    

select count(*) from type_tables;        
        
# wyświetlenie zawartości tabel
select * from cities order by id_city;
select * from cuisines order by id_cuisine;
select * from type_tables order by id_table;
select * from users order by id_user;
select * from restaurants order by id_rest;
select * from booking_now order by id_booking_now;
select * from booking_future order by id_booking_future;
select * from rating order by id_rating;
select * from occupancy order by id_occ;
select * from waiters order by id_wait;