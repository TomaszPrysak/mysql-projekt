#
#	Projekt mySQL w ramach warsztatów Back-end Developer ReaktorPWN
#	
#
#	Baza danych aplikacji "Wolny stolik"
#
# 	Założenia aplikacji (wstępne):	
#
#	1. Wyświetlenie  w okolicy użytkownika restauracji wraz ze statusem zajętości stolika (możliwość filtrowania po rodzaju świadczonej kuchni, średniej ocenie, cenie posiłków itp), 
#	2. Możliwość zarezerwowania stolika w dwóch trybach:
#		a) rezerwacja z wyprzedzeniem 15-minutowym (użytkownik przebywając na mieście znajduje poprzez aplikację ciekawą restaurację i chce mieć pewność, że wolny stoik na niego będzie czekać),
#		b) rezerwacja na konkretny dzień i godzinę,
#	3. Zmianę rezerwacji,
#	4. Wraz z rezerwacją złżenie zamówienia na danie, tak aby nie musieć czekać na jedzenie po przybyciu do restauracji (aplikacja będzie mieć zaimplementowane menu restauracji),
#	5. Zdalne opłacenie wystawionego rachunku (poprzez podpięcie pod konto użytkownika karty kredytowej)
#	6. Wystawienia oceny restauracji (obsługi, jedzenia).
# 
#	Konstrukcja bazy danych:
#
#	Nazwa: Wolny_stolik
#
#	Tabele: 	
#
#	
#	UWAGA !!! Reorganizacja tabel !!!! aktualna wersja zaczyna się zazaczniekami "############" w kilku wierszach

create database wolny_stolik;

use wolny_stolik;






#	Brudnopis:

#
#
#	
#
#

create database wolny_stolik;

use wolny_stolik;

#
#
#
#
#

# tabela miast 
create table cities (
	id_city int unsigned not null auto_increment,
	city_name varchar(30) not null,
    primary key (id_city)
);

# tabela rodzajów kuchni
create table cuisines (
	id_cuisine int unsigned not null auto_increment,
    type_cuisine varchar(30) not null,
	primary key (id_cuisine)
);

# tabela rodzajów stolika
create table type_tables(
	id_table int unsigned not null auto_increment,
    qty_chairs int unsigned unsigned not null,
    smooking boolean not null,
    outside boolean not null,
    primary key (id_table)
);

# tabela użytkowników
create table users (
	id_user int unsigned not null auto_increment,
    e_mail varchar(60) unique not null,
    pass varchar(30) not null,
    id_city int unsigned not null,
    date_login datetime not null,
    primary key (id_user),
    foreign key (id_city) references cities(id_city)
);

# tabela restauracji
create table restaurants (
	id_rest int unsigned not null auto_increment,
    name_rest varchar(30) not null,
    id_city int unsigned not null,
    id_cuisine int unsigned not null,
    id_table int unsigned not null,
    qty_type_table int unsigned not null,
    primary key (id_rest),
    foreign key (id_table) references type_tables(id_table),
    foreign key (id_city) references cities(id_city),
    foreign key (id_cuisine) references cuisines(id_cuisine)
);

# tabela rezerwacji
create table booking (
	id_booking int unsigned not null auto_increment,
    id_user int unsigned not null,
    id_rest int unsigned not null,
	date_book_start datetime not null,
    date_book_stop datetime not null,
    primary key (id_booking),
    foreign key (id_user) references users(id_user),
    foreign key (id_rest) references restaurants(id_rest)
);

# tabela oceny restauracji
create table rating (
	id_rating int unsigned not null auto_increment,
	id_user int unsigned not null,
    id_rest int unsigned not null,
    value_rating int unsigned not null,
    primary key (id_rating),
	foreign key (id_user) references users(id_user),
    foreign key (id_rest) references restaurants(id_rest)
);

# tabela zajętości stolika w danej restauracj w chwili obecnej
create table occupancy (
	id_occ int unsigned not null auto_increment,
    id_rest int unsigned not null,
    id_wait int unsigned not null,
    time_occ_start datetime not null,
    time_occ_stop datetime not null,
    primary key (id_occ),
    foreign key (id_rest) references restaurants(id_rest),
    foreign key (id_wait) references waiters (id_wait)
);

create table waiters (
	id_wait int unsigned not null auto_increment,
    login varchar(60) not null,
    pass varchar(30) not null,
    id_rest int unsigned not null,
    primary key (id_wait),
    foreign key (id_rest) references restaurants(id_rest)
);

#
#
#	
#
#

# rekordy w tabeli miast
insert into cities (city_name) values ("Warszawa");
insert into cities (city_name) values ("Kraków");
insert into cities (city_name) values ("Katowice");

select * from cities;

# rekordy w tabeli rodzaj kuchni
insert into cuisines (type_cuisine) values ("polska");
insert into cuisines (type_cuisine) values ("tajska");
insert into cuisines (type_cuisine) values ("włoska");

select * from cuisines;

# rekordy w tabeli rodzaj stolika
insert into type_tables (qty_chairs, smooking, outside) values (2, false, false);
insert into type_tables (qty_chairs, smooking, outside) values (4, false, false);
insert into type_tables (qty_chairs, smooking, outside) values (6, false, false);
insert into type_tables (qty_chairs, smooking, outside) values (8, false, false);

insert into type_tables (qty_chairs, smooking, outside) values (2, true, false);
insert into type_tables (qty_chairs, smooking, outside) values (4, true, false);
insert into type_tables (qty_chairs, smooking, outside) values (6, true, false);
insert into type_tables (qty_chairs, smooking, outside) values (8, true, false);
insert into type_tables (qty_chairs, smooking, outside) values (2, true, true);
insert into type_tables (qty_chairs, smooking, outside) values (4, true, true);
insert into type_tables (qty_chairs, smooking, outside) values (6, true, true);
insert into type_tables (qty_chairs, smooking, outside) values (8, true, true);

select * from type_tables;

delete from type_tables where qty_chairs = 1;

alter table type_tables change smoking smooking boolean;

select now();

# rekordy w tabeli użytkownicy
insert into users (e_mail, pass, id_city, date_login) values ("maja672@wp.pl", "ULDx2eNRMd", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("jaworski2012@wp.pl@wp.pl", "NRCFaGa7EE", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("paulina.krawczyk@o2.pl", "bn2mBQaLL2", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("jankowskiblaej@onet.pl", "n7cq4C4hUf", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("wrobel9573@gmail.com", "V9xXf76PDa", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("krzysztof7224@onet.pl", "UfWnZYBzaM", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("kozlowska.blanka@interia.pl", "ZVjCLMFfv2", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("malinowski5819@gmail.com", "VQzTefrJuu", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("sebastian2012@interia.pl", "kNaFzz5BzE", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("rutkowska1995@gmail.com", "NZZx4cJ9SD", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("kacper2012@gmail.com", "AdUAwyfnG9", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("filip242@onet.pl", "groQxnQ3oQ", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("majewski2954@gmail.com", "7BfxyH9Hhr", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("szymanski2013@gmail.com", "Mj57j25YNc", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("martyna-dudek@onet.pl", "xu3mKY72sU", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("wojcik1999@o2.pl", "gXWVUV5t4L", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("wiktoria.nowakowska@interia.pl", "kgvPMdfhBt", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("malgorzata-mazur@gmail.com", "TznnkxLRXC", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("piotrowska617@gmail.com", "cDZyZkTudo", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("zielinska891@yahoo.com", "FX4AcgdRXf", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("mikolajpawlowski@o2.pl", "Jhfw4YuegR", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("maria2013@interia.pl", "hSVGQmsae6", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("michalski1761@yahoo.com", "Xkurm67Yov", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("adrian2012@gmail.com", "DxcjtFHnmp", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("jaworska2011@onet.pl", "D3FYaWJ3xp", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("tomaszewska.patrycja@gmail.com", "yU8sKTXhhK", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("krol291@interia.pl", "cmGP5AUcnF", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("grabowski2014@onet.pl", "2r87PHuXbr", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("nadia622@interia.pl", "M9KmZVDoCm", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("patrycja1996@onet.pl", "yf7EuAEPds", 1, now());

select * from users order by id_user;

delete from users where e_mail = "maja672@wp.pl";

delete from users;

alter table users modify e_mail varchar(30);

# rekordy w tabeli kelnerzy
insert into waiters (login, pass, id_rest, date_login) values ("kelner_zap1", "ULDx2eNRMd", 1, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_zap2", "NRCFaGa7EE", 1, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_zap3", "bn2mBQaLL2", 1, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_zap4", "n7cq4C4hUf", 1, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_zap5", "V9xXf76PDa", 1, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_ob1", "UfWnZYBzaM", 2, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_ob2", "ZVjCLMFfv2", 2, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelener_ob3", "VQzTefrJuu", 2, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_ob4", "kNaFzz5BzE", 2, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_ob5", "NZZx4cJ9SD", 2, now());


# rekordy w tabeli restauracje
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Zapiecek", 1,  1, 1, 5);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Zapiecek", 1,  1, 2, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Zapiecek", 1,  1, 3, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Zapiecek", 1,  1, 4, 1);

insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Oberża", 1,  1, 1, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Oberża", 1,  1, 2, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Oberża", 1,  1, 3, 1);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Oberża", 1,  1, 4, 2);

insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Thaisty", 1,  2, 1, 5);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Thaisty", 1,  2, 2, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Thaisty", 1,  2, 3, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Thaisty", 1,  2, 4, 1);

insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Wi-Taj", 1,  2, 1, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Wi-Taj", 1,  2, 2, 4);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Wi-Taj", 1,  2, 3, 4);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Wi-Taj", 1,  2, 4, 1);

insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Trattoria", 1,  3, 1, 5);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Trattoria", 1,  3, 2, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Trattoria", 1,  3, 3, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Trattoria", 1,  3, 4, 1);

insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Sardynia", 1,  3, 1, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Sardynia", 1,  3, 2, 4);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Sardynia", 1,  3, 3, 4);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Sardynia", 1,  3, 4, 1);


insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Miód_Malina", 2,  1, 1, 5);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Miód_Malina", 2,  1, 2, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Miód_Malina", 2,  1, 3, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Miód_Malina", 2,  1, 4, 1);

insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Jarema", 2,  1, 1, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Jarema", 2,  1, 2, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Jarema", 2,  1, 3, 1);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Jarema", 2,  1, 4, 2);

insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("WOK", 2,  2, 1, 5);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("WOK", 2,  2, 2, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("WOK", 2,  2, 3, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("WOK", 2,  2, 4, 1);

insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Samui", 2,  2, 1, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Samui", 2,  2, 2, 4);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Samui", 2,  2, 3, 4);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Samui", 2,  2, 4, 1);

insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Grazie", 2,  3, 1, 5);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Grazie", 2,  3, 2, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Grazie", 2,  3, 3, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Grazie", 2,  3, 4, 1);

insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Calzone", 2,  3, 1, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Calzone", 2,  3, 2, 4);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Calzone", 2,  3, 3, 4);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Calzone", 2,  3, 4, 1);


insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Karlik", 3,  1, 1, 5);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Karlik", 3,  1, 2, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Karlik", 3,  1, 3, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Karlik", 3,  1, 4, 1);

insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Silesian", 3,  1, 1, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Silesian", 3,  1, 2, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Silesian", 3,  1, 3, 1);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Silesian", 3,  1, 4, 2);

insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Bangkok", 3,  2, 1, 5);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Bangkok", 3,  2, 2, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Bangkok", 3,  2, 3, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Bangkok", 3,  2, 4, 1);

insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Prego", 3,  3, 1, 5);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Prego", 3,  3, 2, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Prego", 3,  3, 3, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Prego", 3,  3, 4, 1);

select * from restaurants order by id_rest;

#
#
#	
#
#

# rekordy w tabeli rezerwacje

insert into booking (id_user, id_rest, date_book_start, date_book_stop) values (1, 1, '2017-08-10 20:00', '2017-08-10 22:00');
insert into booking (id_user, id_rest, date_book_start, date_book_stop) values (2, 2, '2017-08-10 22:00', '2017-08-10 23:59');
insert into booking (id_user, id_rest, date_book_start, date_book_stop) values (3, 3, '2017-08-10 18:00', '2017-08-10 20:00');
insert into booking (id_user, id_rest, date_book_start, date_book_stop) values (4, 4, '2017-08-10 16:00', '2017-08-10 18:00');
insert into booking (id_user, id_rest, date_book_start, date_book_stop) values (5, 3, '2017-08-10 18:00', '2017-08-10 20:00');
insert into booking (id_user, id_rest, date_book_start, date_book_stop) values (6, 1, '2017-08-10 20:00', '2017-08-10 22:00');
insert into booking (id_user, id_rest, date_book_start, date_book_stop) values (7, 1, '2017-08-10 22:00', '2017-08-10 23:59');

delete from booking where id_user = 22;

select * from restaurants where name_rest = 'zapiecek';
select * from restaurants where name_rest = 'oberża';
select sum(qty_type_table) from restaurants where name_rest = 'zapiecek';
select *, count(qty_type_table) from restaurants where name_rest = 'Zapiecek';

# rekordy w tabeli zajętości miejsc w obecnej chwili w restauracji

insert into occupancy (id_rest, id_wait, time_occ_start, time_occ_start) values (1, '2017-08-10 20:00', '2017-08-10 22:00');
insert into occupancy (id_rest, id_wait, time_occ_start, time_occ_start) values (3, 3, '2017-08-10 18:00', '2017-08-10 20:00');
insert into occupancy (id_rest, id_wait, time_occ_start, time_occ_start) values (4, 4, '2017-08-10 16:00', '2017-08-10 18:00');


select * from occupancy;

drop table occupancy;

####################
####################
####################
#################### Przeorganizowano tabele !!!! Z tabeli "restauracji" przeniesiono informację o ilości stolików danego typu
#################### do tabeli "rodzaj stolika" i z tej tabeli utworzono tabelę główną !!!
#################### Stworzono tabelę kelnerzy i skorelowano ją z tabelą restauracje
####################
####################
####################


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
    name_rest varchar(30) not null,
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
    id_city int unsigned not null,
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
    qty_chairs int not null,
    id_rest int unsigned not null,
    qty_type_table int not null,
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
    time_occ_stop datetime not null,
    primary key (id_occ),
    foreign key (id_table) references type_tables(id_table),
    foreign key (id_wait) references waiters(id_wait)
);

###
###  !!! Triggery
###

### trigery (do poprawki):
# dodanie rezerwacji przez użytkownika
create trigger add_booking
	after insert on booking
	for each row update type_tables
		set type_tables.qty_type_table = type_tables.qty_type_table - 1
		where type_tables.id_table = new.id_table;
        
# anulowanie rezerwacji przez użytkownika
create trigger rm_booking
	after delete on booking
	for each row update restaurants
		set type_tables.qty_type_table = type_tables.qty_type_table + 1
		where type_tables.id_table = old.id_table;
        
# dodanie zajętość stolika przez restauracje (tzn. zajętość stolika jest wynikiem otwarcia rachunku przez obsługę w systemie restauracji)
create trigger add_occ
	after insert on occupancy
    for each row update restaurants
		set type_tables.qty_type_table = type_tables.qty_type_table - 1
        where type_tables.id_table = new.id_table;

# dodające rezerwacje wykonane przez restauracje (
create trigger rm_occ
	after insert on occupancy
	for each row update restaurants
		set type_tables.qty_type_table = type_tables.qty_type_table + 1
        where type_tables.id_table = old.id_table;
        
###
###  !!! Wpisywanie danych do tabel
###

# rekordy w tabeli miasta
insert into cities (city_name) values ("Warszawa");
insert into cities (city_name) values ("Kraków");
insert into cities (city_name) values ("Katowice");
        
# rekordy w tabeli rodzaje kuchni
insert into cuisines (type_cuisine) values ("polska");
insert into cuisines (type_cuisine) values ("tajska");
insert into cuisines (type_cuisine) values ("włoska");
        
# rekordy w tabeli restauracje
insert into restaurants (name_rest, id_city, id_cuisine) values ("Zapiecek", 1, 1);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Oberża", 1, 1);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Babooshka", 1, 1);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Kukułka", 1, 1);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Belvedere", 1, 1);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Folk Gospoda", 1, 1);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Thaisty", 1, 2);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Wi-Taj", 1, 2);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Mała Tajlandia", 1, 2);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Khuk", 1, 2);
insert into restaurants (name_rest, id_city, id_cuisine) values ("KoPhiPhi", 1, 2);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Trattoria", 1, 3);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Sardynia", 1, 3);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Mała Wenecja", 1, 3);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Smaki Toskanii", 1, 3);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Pasta i basta", 1, 3);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Miód Malina", 2, 1);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Jarema", 2, 1);
insert into restaurants (name_rest, id_city, id_cuisine) values ("WOK", 2, 2);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Samui", 2, 2);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Grazie", 2, 3);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Calzone", 2, 3);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Karlik", 3, 1);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Silesian", 3, 1);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Bangkok", 3, 2);
insert into restaurants (name_rest, id_city, id_cuisine) values ("Prego", 3, 3);

# rekordy w tabeli użytkownicy
insert into users (e_mail, pass, id_city, date_login) values ("maja672@wp.pl", "ULDx2eNRMd", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("jaworski2012@wp.pl@wp.pl", "NRCFaGa7EE", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("paulina.krawczyk@o2.pl", "bn2mBQaLL2", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("jankowskiblaej@onet.pl", "n7cq4C4hUf", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("wrobel9573@gmail.com", "V9xXf76PDa", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("krzysztof7224@onet.pl", "UfWnZYBzaM", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("kozlowska.blanka@interia.pl", "ZVjCLMFfv2", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("malinowski5819@gmail.com", "VQzTefrJuu", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("sebastian2012@interia.pl", "kNaFzz5BzE", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("rutkowska1995@gmail.com", "NZZx4cJ9SD", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("kacper2012@gmail.com", "AdUAwyfnG9", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("filip242@onet.pl", "groQxnQ3oQ", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("majewski2954@gmail.com", "7BfxyH9Hhr", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("szymanski2013@gmail.com", "Mj57j25YNc", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("martyna-dudek@onet.pl", "xu3mKY72sU", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("wojcik1999@o2.pl", "gXWVUV5t4L", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("wiktoria.nowakowska@interia.pl", "kgvPMdfhBt", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("malgorzata-mazur@gmail.com", "TznnkxLRXC", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("piotrowska617@gmail.com", "cDZyZkTudo", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("zielinska891@yahoo.com", "FX4AcgdRXf", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("mikolajpawlowski@o2.pl", "Jhfw4YuegR", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("maria2013@interia.pl", "hSVGQmsae6", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("michalski1761@yahoo.com", "Xkurm67Yov", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("adrian2012@gmail.com", "DxcjtFHnmp", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("jaworska2011@onet.pl", "D3FYaWJ3xp", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("tomaszewska.patrycja@gmail.com", "yU8sKTXhhK", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("krol291@interia.pl", "cmGP5AUcnF", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("grabowski2014@onet.pl", "2r87PHuXbr", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("nadia622@interia.pl", "M9KmZVDoCm", 1, now());
insert into users (e_mail, pass, id_city, date_login) values ("patrycja1996@onet.pl", "yf7EuAEPds", 1, now());
 
# rekordy w tabeli kelnerzy
insert into waiters (login, pass, id_rest, date_login) values ("kelner_zap1", "ULDx2eNRMd", 1, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_zap2", "NRCFaGa7EE", 1, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_zap3", "bn2mBQaLL2", 1, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_zap4", "n7cq4C4hUf", 1, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_zap5", "V9xXf76PDa", 1, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_ob1", "UfWnZYBzaM", 2, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_ob2", "ZVjCLMFfv2", 2, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_ob3", "VQzTefrJuu", 2, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_ob4", "kNaFzz5BzE", 2, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_ob5", "NZZx4cJ9SD", 2, now()); 
insert into waiters (login, pass, id_rest, date_login) values ("kelner_thai1", "NZZx4cJ9SD", 3, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_thai2", "AdUAwyfnG9", 3, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_thai3", "groQxnQ3oQ", 3, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_wi1", "7BfxyH9Hhr", 4, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_wi2", "Mj57j25YNc", 4, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_wi3", "xu3mKY72sU", 4, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_tra1", "gXWVUV5t4L", 5, now()); 
insert into waiters (login, pass, id_rest, date_login) values ("kelner_tra2", "cmGP5AUcnF", 5, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_sar1", "2r87PHuXbr", 6, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_sar2", "M9KmZVDoCm", 6, now());
insert into waiters (login, pass, id_rest, date_login) values ("kelner_sar3", "yf7EuAEPds", 6, now()); 
 
# rekordy w tabeli rodzaj stolika
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (2,1,3,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (4,1,4,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (6,1,2,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (8,1,1,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (2,2,4,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (4,2,2,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (6,2,1,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (8,2,0,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (2,3,2,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (4,3,5,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (6,3,2,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (8,3,1,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (2,4,3,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (4,4,3,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (6,4,2,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (8,4,1,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (2,5,3,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (4,5,4,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (6,5,2,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (8,5,1,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (2,6,4,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (4,6,2,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (6,6,1,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (8,6,0,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (2,7,2,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (4,7,5,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (6,7,2,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (8,7,1,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (2,8,3,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (4,8,3,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (6,8,2,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (8,8,1,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (2,9,3,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (4,9,4,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (6,9,2,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (8,9,1,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (2,10,4,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (4,10,2,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (6,10,1,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (8,10,0,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (2,11,2,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (4,11,5,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (6,11,2,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (8,11,1,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (2,12,3,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (4,12,3,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (6,12,2,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (8,12,1,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (2,13,3,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (4,13,4,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (6,13,2,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (8,13,1,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (2,14,4,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (4,14,2,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (6,14,1,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (8,14,0,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (2,15,2,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (4,15,5,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (6,15,2,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (8,15,1,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (2,16,3,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (4,16,2,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (6,16,3,false,false);
insert into type_tables (qty_chairs, id_rest, qty_type_table, smooking, outside) values (8,16,1,false,false);
 
 # rekordy w tabeli oceny
insert into rating (id_user, id_rest, value_rating) values (5, 1, 8.9);
insert into rating (id_user, id_rest, value_rating) values (6, 1, 4.7);
insert into rating (id_user, id_rest, value_rating) values (7, 1, 9.0);
insert into rating (id_user, id_rest, value_rating) values (8, 1, 5.7);
insert into rating (id_user, id_rest, value_rating) values (9, 2, 8.9);
insert into rating (id_user, id_rest, value_rating) values (10, 2, 7.0);
insert into rating (id_user, id_rest, value_rating) values (11, 2, 6.7);
insert into rating (id_user, id_rest, value_rating) values (12, 3, 7.7);
insert into rating (id_user, id_rest, value_rating) values (13, 3, 4.9);
insert into rating (id_user, id_rest, value_rating) values (14, 3, 6.6);
insert into rating (id_user, id_rest, value_rating) values (15, 4, 6.0);
insert into rating (id_user, id_rest, value_rating) values (21, 5, 4.5);
insert into rating (id_user, id_rest, value_rating) values (22, 5, 7.1);
insert into rating (id_user, id_rest, value_rating) values (23, 6, 3.5);
insert into rating (id_user, id_rest, value_rating) values (24, 6, 8.8);
insert into rating (id_user, id_rest, value_rating) values (25, 7, 4.7);
insert into rating (id_user, id_rest, value_rating) values (26, 7, 7.0);
insert into rating (id_user, id_rest, value_rating) values (27, 8, 6.7);
 
###
###  !!! Operacje użyteczne
###    
        
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
        
# usuwanie tabel w kolejności
drop table rating;
drop table booking;
drop table users;
drop table occupancy;
drop table type_tables;
drop table waiters;
drop table restaurants;
drop table cities;
drop table cuisines;