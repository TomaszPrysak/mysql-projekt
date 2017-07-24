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
#	Gotowe polecenia: 
#	23 lipca 2017:

create database wolny_stolik;

use wolny_stolik;






#	Brudnopis:

#
#
#	23 lipca 2017:
#
#

create database wolny_stolik;

use wolny_stolik;

drop table cuisines;

#tabela użytkowników (tabel logowania) STARA WERSJA
create table users (
	id_user int unsigned not null auto_increment,
    e_mail text not null,
    pass blob not null,
    city text not null,
    primary key (id_user)
);

#tabela restauracji STARA WERSJA
create table restaurants (
	id_rest int unsigned not null auto_increment,
    trade_name text not null,
    city text not null,
    cuisine text,
    id_table int unsigned not null,
    qty_type_table int not null,
    id_rating double not null,
    primary key (id_rest),
    foreign key (id_table) references type_tables(id_table)
);

#tabela rodzaju stolika STARA WERSJA
create table type_tables(
	id_table int unsigned not null auto_increment,
    qty_chairs int unsigned not null,
    smoking boolean not null,
    outside boolean not null,
    primary key (id_table)
);

#tabela rezerwacji STARA WERSJA
create table booking (
	id_book int unsigned not null auto_increment,
    id_user int unsigned not null,
    id_rest int unsigned not null,
    id_table int unsigned not null,
	date_book datetime not null,
    primary key (id_book),
    foreign key (id_user) references users(id_user),
    foreign key (id_rest) references restaurants(id_rest)
);

#tabela oceny STARA WERSJA
create table rating (
	id_rating int unsigned not null auto_increment,
	id_user int unsigned not null,
    id_rest int unsigned not null,
    value_rating double unsigned not null,
    primary key (id_rating),
	foreign key (id_user) references users(id_user),
    foreign key (id_rest) references restaurants(id_rest)
);

#tabela zapytanie o dostępności stolika STARA WERSJA
create table request (
	id_req int unsigned not null auto_increment,
    id_book int unsigned not null,
    id_rest int unsigned not null,
    date_req datetime not null,
	primary key (id_req),
    foreign key (id_book) references booking(id_book),
	foreign key (id_rest) references restaurants(id_rest)
);

#
#
#	24 lipca 2017:
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
    qty_chairs int unsigned not null,
    smoking boolean not null,
    outside boolean not null,
    primary key (id_table)
);
# tabela użytkowników
create table users (
	id_user int unsigned not null auto_increment,
    e_mail varchar(60) not null,
    pass varchar(30) not null,
    id_city int unsigned not null,
    date_log datetime not null,
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
    qty_type_table int not null,
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
    id_table int unsigned not null,
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
    value_rating double unsigned not null,
    primary key (id_rating),
	foreign key (id_user) references users(id_user),
    foreign key (id_rest) references restaurants(id_rest)
);
# tabela dostępności !!! NIE UŻYWAĆ !!!
create table request (
	id_req int unsigned not null auto_increment,
    id_book int unsigned not null,
    id_rest int unsigned not null,
    date_req datetime not null,
	primary key (id_req),
    foreign key (id_book) references booking(id_book),
	foreign key (id_rest) references restaurants(id_rest)
);

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
insert into users (e_mail, pass, id_city, date_log) values ("maja672@wp.pl", "ULDx2eNRMd", 1, now());
insert into users (e_mail, pass, id_city, date_log) values ("jaworski2012@wp.pl@wp.pl", "NRCFaGa7EE", 1, now());
insert into users (e_mail, pass, id_city, date_log) values ("paulina.krawczyk@o2.pl", "bn2mBQaLL2", 1, now());
insert into users (e_mail, pass, id_city, date_log) values ("jankowskiblaej@onet.pl", "n7cq4C4hUf", 1, now());
insert into users (e_mail, pass, id_city, date_log) values ("wrobel9573@gmail.com", "V9xXf76PDa", 1, now());
insert into users (e_mail, pass, id_city, date_log) values ("krzysztof7224@onet.pl", "UfWnZYBzaM", 1, now());
insert into users (e_mail, pass, id_city, date_log) values ("kozlowska.blanka@interia.pl", "ZVjCLMFfv2", 1, now());
insert into users (e_mail, pass, id_city, date_log) values ("malinowski5819@gmail.com", "VQzTefrJuu", 1, now());
insert into users (e_mail, pass, id_city, date_log) values ("sebastian2012@interia.pl", "kNaFzz5BzE", 1, now());
insert into users (e_mail, pass, id_city, date_log) values ("rutkowska1995@gmail.com", "NZZx4cJ9SD", 1, now());
insert into users (e_mail, pass, id_city, date_log) values ("kacper2012@gmail.com", "AdUAwyfnG9", 2, now());
insert into users (e_mail, pass, id_city, date_log) values ("filip242@onet.pl", "groQxnQ3oQ", 2, now());
insert into users (e_mail, pass, id_city, date_log) values ("majewski2954@gmail.com", "7BfxyH9Hhr", 2, now());
insert into users (e_mail, pass, id_city, date_log) values ("szymanski2013@gmail.com", "Mj57j25YNc", 2, now());
insert into users (e_mail, pass, id_city, date_log) values ("martyna-dudek@onet.pl", "xu3mKY72sU", 2, now());
insert into users (e_mail, pass, id_city, date_log) values ("wojcik1999@o2.pl", "gXWVUV5t4L", 2, now());
insert into users (e_mail, pass, id_city, date_log) values ("wiktoria.nowakowska@interia.pl", "kgvPMdfhBt", 2, now());
insert into users (e_mail, pass, id_city, date_log) values ("malgorzata-mazur@gmail.com", "TznnkxLRXC", 2, now());
insert into users (e_mail, pass, id_city, date_log) values ("piotrowska617@gmail.com", "cDZyZkTudo", 2, now());
insert into users (e_mail, pass, id_city, date_log) values ("zielinska891@yahoo.com", "FX4AcgdRXf", 2, now());
insert into users (e_mail, pass, id_city, date_log) values ("mikolajpawlowski@o2.pl", "Jhfw4YuegR", 3, now());
insert into users (e_mail, pass, id_city, date_log) values ("maria2013@interia.pl", "hSVGQmsae6", 3, now());
insert into users (e_mail, pass, id_city, date_log) values ("michalski1761@yahoo.com", "Xkurm67Yov", 3, now());
insert into users (e_mail, pass, id_city, date_log) values ("adrian2012@gmail.com", "DxcjtFHnmp", 3, now());
insert into users (e_mail, pass, id_city, date_log) values ("jaworska2011@onet.pl", "D3FYaWJ3xp", 3, now());
insert into users (e_mail, pass, id_city, date_log) values ("tomaszewska.patrycja@gmail.com", "yU8sKTXhhK", 3, now());
insert into users (e_mail, pass, id_city, date_log) values ("krol291@interia.pl", "cmGP5AUcnF", 3, now());
insert into users (e_mail, pass, id_city, date_log) values ("grabowski2014@onet.pl", "2r87PHuXbr", 3, now());
insert into users (e_mail, pass, id_city, date_log) values ("nadia622@interia.pl", "M9KmZVDoCm", 3, now());
insert into users (e_mail, pass, id_city, date_log) values ("patrycja1996@onet.pl", "yf7EuAEPds", 3, now());

select * from users order by id_user;

delete from users where e_mail = "maja672@wp.pl";

alter table users modify e_mail varchar(30);

# rekordy w tabeli restauracje
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Zapiecek", 1,  1, 2, 5);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Zapiecek", 1,  1, 3, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Zapiecek", 1,  1, 4, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Zapiecek", 1,  1, 5, 1);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Oberża", 1,  1, 2, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Oberża", 1,  1, 3, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Oberża", 1,  1, 4, 1);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Oberża", 1,  1, 5, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Thaisty", 1,  2, 2, 5);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Thaisty", 1,  2, 3, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Thaisty", 1,  2, 4, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Thaisty", 1,  2, 5, 1);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Wi-Taj", 1,  2, 2, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Wi-Taj", 1,  2, 3, 4);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Wi-Taj", 1,  2, 4, 4);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Wi-Taj", 1,  2, 5, 1);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Trattoria", 1,  3, 2, 5);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Trattoria", 1,  3, 3, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Trattoria", 1,  3, 4, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Trattoria", 1,  3, 5, 1);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Sardynia", 1,  3, 2, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Sardynia", 1,  3, 3, 4);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Sardynia", 1,  3, 4, 4);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Sardynia", 1,  3, 5, 1);

insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Miód_Malina", 2,  1, 2, 5);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Miód_Malina", 2,  1, 3, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Miód_Malina", 2,  1, 4, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Miód_Malina", 2,  1, 5, 1);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Jarema", 2,  1, 2, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Jarema", 2,  1, 3, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Jarema", 2,  1, 4, 1);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Jarema", 2,  1, 5, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("WOK", 2,  2, 2, 5);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("WOK", 2,  2, 3, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("WOK", 2,  2, 4, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("WOK", 2,  2, 5, 1);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Samui", 2,  2, 2, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Samui", 2,  2, 3, 4);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Samui", 2,  2, 4, 4);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Samui", 2,  2, 5, 1);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Grazie", 2,  3, 2, 5);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Grazie", 2,  3, 3, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Grazie", 2,  3, 4, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Grazie", 2,  3, 5, 1);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Calzone", 2,  3, 2, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Calzone", 2,  3, 3, 4);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Calzone", 2,  3, 4, 4);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Calzone", 2,  3, 5, 1);

insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Karlik", 3,  1, 2, 5);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Karlik", 3,  1, 3, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Karlik", 3,  1, 4, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Karlik", 3,  1, 5, 1);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Silesian", 3,  1, 2, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Silesian", 3,  1, 3, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Silesian", 3,  1, 4, 1);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Silesian", 3,  1, 5, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Bangkok", 3,  2, 2, 5);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Bangkok", 3,  2, 3, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Bangkok", 3,  2, 4, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Bangkok", 3,  2, 5, 1);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Prego", 3,  3, 2, 5);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Prego", 3,  3, 3, 3);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Prego", 3,  3, 4, 2);
insert into restaurants (name_rest, id_city, id_cuisine, id_table, qty_type_table) values ("Prego", 3,  3, 5, 1);

select * from restaurants;

# rekordy w tabeli rezerwacje



# rekordy w tabeli oceny




