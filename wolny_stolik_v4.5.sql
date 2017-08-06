# version_4.5 2017-08-07 01:01

###
###  !!! BAZA DANYCH
###

create database wolny_stolik;

use wolny_stolik;

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

# tabela rezerwacji
create table booking (
	id_booking int unsigned not null auto_increment,
    id_user int unsigned not null,
    id_table int unsigned not null,
	date_book_start datetime not null,
    date_book_stop datetime not null,
    primary key (id_booking),
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
select e_mail, pass from users where pass = 'user1_1pass';

select login, pass from waiters where login = 'waiter_zap1';

##
## Zapytania wykomywane od użytkowników
##

# zapytanie o wypisanie miast

select * from cities;

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

# wyświetla restauracje ze średnią oceną powyżej x (np. 5.0)
select city_name as 'Miasto', rest_name as 'Nazwa restauracji', round(avg(value_rating),1) as 'Ocena' from restaurants natural left join rating natural left join cities group by rest_name having round(avg(value_rating),1) > 5.0 order by city_name desc ;

# zapytania o rodzaj kuchni
select city_name as 'Miasto', rest_name as 'Nazwa restauracji', type_cuisine as 'Rodzaj kuchni' from restaurants natural right join cuisines natural left join cities;

# zapytania o rezerwację stolika



# zapytania o zajętość stolika

# sprawdzenie statusu zajętości stolików 
select city_name as 'Miasto', rest_name as 'Nazwa restauracji', nr_table as 'Numer stolika', qty_chairs 'Ilość krzeseł przy stoliku', case when time_occ_start < now() then 'stolik zajęty' end as 'Status zajętości stolika' from occupancy natural join type_tables natural join restaurants natural join cities;
select city_name as 'Miasto', rest_name as 'Nazwa restauracji', nr_table as 'Numer stolika', qty_chairs 'Ilość krzeseł przy stoliku', 'stolik zajęty' from occupancy natural join type_tables natural join restaurants natural join cities;

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

# sprawdza ilość zajętych stolików danego typu w danej restauracji
select city_name as 'Miasto', rest_name as 'Nazwa restauracji', qty_chairs as 'Ilość krzeseł przy stoliku', count(qty_chairs) as 'Ilosc zajętych stolików z określoną ilością krzeseł' from occupancy natural join restaurants natural join type_tables natural join cities group by rest_name, qty_chairs order by city_name desc, rest_name desc;

select count(qty_chairs) from occupancy natural left join restaurants natural left join type_tables where rest_name = 'Zapiecek' and qty_chairs = 2 group by rest_name, qty_chairs order by rest_name desc;
select count(qty_chairs) from occupancy natural left join restaurants natural left join type_tables where rest_name = 'Zapiecek' and qty_chairs = 4 group by rest_name, qty_chairs order by rest_name desc;
select count(qty_chairs) from occupancy natural left join restaurants natural left join type_tables where rest_name = 'Zapiecek' and qty_chairs = 6 group by rest_name, qty_chairs order by rest_name desc;
select count(qty_chairs) from occupancy natural left join restaurants natural left join type_tables where rest_name = 'Zapiecek' and qty_chairs = 8 group by rest_name, qty_chairs order by rest_name desc;

#
# Zapytania wykonywane od kelnerów
#

# wyświetlenie rezerwacji stolików dokonanych przez użytkowników (wszystkich rezerwacji, bez względu na datę)
select e_mail, nr_table, date_book_start, date_book_stop from booking natural left join users natural left join type_tables order by e_mail;
# wyświetlenie rezerwacji stolików dokonanych przez użytkowników w konkretnym dniu
select e_mail, nr_table, date_book_start, date_book_stop from booking natural left join users natural left join type_tables where date_format(date_book_start, '%Y-%m-%d') = '2017-08-10' order by e_mail;
# wyświetla rezerwację stolików w dniu dzisiejszym, aby sprawdzić ile jest dokonanych rezerwacji z wyprzedzeniem:
select e_mail, nr_table, date_book_start, date_book_stop from booking natural left join users natural left join type_tables where date_format(date_book_start, '%Y-%m-%d') = current_date() order by e_mail;


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
select * from booking order by id_booking;
select * from rating order by id_rating;
select * from occupancy order by id_occ;
select * from waiters order by id_wait;