# version_4.1 2017-07-31 22:07

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
###  !!! Tworzenie rekordów w tabelach tabel
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
insert into restaurants (rest_name, id_city, id_cuisine) values ("Zapiecek",1,1);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Oberża",1,1);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Babooshka",1,1);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Kukułka",1,1);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Belvedere",1,1);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Folk Gospoda",1,1);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Thaisty",1,2);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Wi-Taj",1,2);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Mała Tajlandia",1,2);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Khuk",1,2);
insert into restaurants (rest_name, id_city, id_cuisine) values ("KoPhiPhi",1,2);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Trattoria",1,3);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Sardynia",1,3);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Mała Wenecja",1,3);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Smaki Toskanii",1,3);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Pasta i basta",1,3);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Miód Malina",2,1);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Jarema",2,1);
insert into restaurants (rest_name, id_city, id_cuisine) values ("WOK",2,2);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Samui",2,2);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Grazie",2,3);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Calzone",2,3);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Karlik",3,1);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Silesian",3,1);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Bangkok",3,2);
insert into restaurants (rest_name, id_city, id_cuisine) values ("Prego",3,3);

# rekordy w tabeli użytkownicy
insert into users (e_mail, pass, id_city, date_login) values ("user1_1@gmail.com", "user1_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user2_1@gmail.com", "user2_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user3_1@gmail.com", "user3_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user4_1@gmail.com", "user4_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user5_1@gmail.com", "user5_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user6_1@gmail.com", "user6_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user7_1@gmail.com", "user7_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user8_1@gmail.com", "user8_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user9_1@gmail.com", "user9_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user10_1@gmail.com", "user10_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user11_1@gmail.com", "user11_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user12_1@gmail.com", "user12_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user13_1@gmail.com", "user13_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user14_1@gmail.com", "user14_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user15_1@gmail.com", "user15_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user16_1@gmail.com", "user16_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user17_1@gmail.com", "user17_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user18_1@gmail.com", "user18_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user19_1@gmail.com", "user19_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user20_1@gmail.com", "user20_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user21_1@gmail.com", "user21_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user22_1@gmail.com", "user22_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user23_1@gmail.com", "user23_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user24_1@gmail.com", "user24_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user25_1@gmail.com", "user25_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user26_1@gmail.com", "user26_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user27_1@gmail.com", "user27_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user28_1@gmail.com", "user28_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user29_1@gmail.com", "user29_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user30_1@gmail.com", "user30_1pass",1,now());
insert into users (e_mail, pass, id_city, date_login) values ("user1_2@gmail.com", "user1_2pass",2,now());
insert into users (e_mail, pass, id_city, date_login) values ("user2_2@gmail.com", "user2_2pass",2,now());
insert into users (e_mail, pass, id_city, date_login) values ("user3_2@gmail.com", "user3_2pass",2,now());
insert into users (e_mail, pass, id_city, date_login) values ("user4_2@gmail.com", "user4_2pass",2,now());
insert into users (e_mail, pass, id_city, date_login) values ("user5_2@gmail.com", "user5_2pass",2,now());
insert into users (e_mail, pass, id_city, date_login) values ("user1_3@gmail.com", "user1_3pass",3,now());
insert into users (e_mail, pass, id_city, date_login) values ("user2_3@gmail.com", "user2_3pass",3,now());
insert into users (e_mail, pass, id_city, date_login) values ("user3_3@gmail.com", "user3_3pass",3,now());
insert into users (e_mail, pass, id_city, date_login) values ("user4_3@gmail.com", "user4_3pass",3,now());
insert into users (e_mail, pass, id_city, date_login) values ("user5_3@gmail.com", "user5_3pass",3,now());
 
# rekordy w tabeli kelnerzy
insert into waiters (login, pass, id_rest, date_login) values ("waiter_zap1", "waiter_zap1pass",1,now());
insert into waiters (login, pass, id_rest, date_login) values ("waiter_zap2", "waiter_zap2pass",1,now());
insert into waiters (login, pass, id_rest, date_login) values ("waiter_zap3", "waiter_zap3pass",1,now());
insert into waiters (login, pass, id_rest, date_login) values ("waiter_zap4", "waiter_zap4pass",1,now());
insert into waiters (login, pass, id_rest, date_login) values ("waiter_zap5", "waiter_zap5pass",1,now());
insert into waiters (login, pass, id_rest, date_login) values ("waiter_obe1", "waiter_obe1pass",2,now());
insert into waiters (login, pass, id_rest, date_login) values ("waiter_obe2", "waiter_obe2pass",2,now());
insert into waiters (login, pass, id_rest, date_login) values ("waiter_obe3", "waiter_obe3pass",2,now());
insert into waiters (login, pass, id_rest, date_login) values ("waiter_obe4", "waiter_obe4pass",2,now());
insert into waiters (login, pass, id_rest, date_login) values ("waiter_obe5", "waiter_obe5pass",2,now());
insert into waiters (login, pass, id_rest, date_login) values ("waiter_tha1", "waiter_tha1pass",3,now());
insert into waiters (login, pass, id_rest, date_login) values ("waiter_tha2", "waiter_tha2pass",3,now());
insert into waiters (login, pass, id_rest, date_login) values ("waiter_tha3", "waiter_tha3pass",3,now());
insert into waiters (login, pass, id_rest, date_login) values ("waiter_wi1", "waiter_wi1pass",4,now());
insert into waiters (login, pass, id_rest, date_login) values ("waiter_wi2", "waiter_wi2pass",4,now());
insert into waiters (login, pass, id_rest, date_login) values ("waiter_wi3", "waiter_wi3pass",4,now());
insert into waiters (login, pass, id_rest, date_login) values ("waiter_tra1", "waiter_tra1pass",5,now());
insert into waiters (login, pass, id_rest, date_login) values ("waiter_tra2", "waiter_tra2pass",5,now());
insert into waiters (login, pass, id_rest, date_login) values ("waiter_tra3", "waiter_tra3pass",5,now());
insert into waiters (login, pass, id_rest, date_login) values ("waiter_sar1", "waiter_sar1pass",6,now());
insert into waiters (login, pass, id_rest, date_login) values ("waiter_sar2", "waiter_sar2pass",6,now());
insert into waiters (login, pass, id_rest, date_login) values ("waiter_sar3", "waiter_sar3pass",6,now());
 
# rekordy w tabeli rodzaj stolika
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (1,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (1,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (1,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (1,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (1,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (1,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (1,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (1,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (1,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (1,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (2,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (2,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (2,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (2,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (2,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (2,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (2,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (2,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (2,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (2,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (3,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (3,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (3,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (3,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (3,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (3,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (3,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (3,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (3,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (3,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (4,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (4,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (4,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (4,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (4,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (4,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (4,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (4,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (4,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (4,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (5,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (5,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (5,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (5,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (5,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (5,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (5,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (5,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (5,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (5,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (6,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (6,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (6,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (6,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (6,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (6,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (6,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (6,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (6,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (6,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (7,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (7,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (7,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (7,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (7,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (7,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (7,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (7,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (7,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (7,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (8,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (8,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (8,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (8,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (8,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (8,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (8,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (8,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (8,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (8,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (9,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (9,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (9,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (9,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (9,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (9,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (9,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (9,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (9,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (9,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (10,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (10,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (10,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (10,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (10,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (10,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (10,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (10,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (10,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (10,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (11,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (11,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (11,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (11,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (11,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (11,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (11,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (11,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (11,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (11,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (12,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (12,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (12,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (12,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (12,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (12,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (12,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (12,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (12,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (12,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (13,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (13,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (13,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (13,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (13,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (13,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (13,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (13,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (13,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (13,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (14,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (14,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (14,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (14,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (14,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (14,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (14,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (14,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (14,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (14,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (15,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (15,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (15,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (15,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (15,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (15,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (15,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (15,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (15,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (15,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (16,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (16,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (16,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (16,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (16,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (16,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (16,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (16,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (16,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (16,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (17,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (17,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (17,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (17,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (17,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (17,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (17,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (17,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (17,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (17,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (18,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (18,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (18,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (18,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (18,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (18,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (18,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (18,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (18,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (18,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (19,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (19,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (19,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (19,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (19,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (19,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (19,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (19,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (19,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (19,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (20,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (20,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (20,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (20,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (20,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (20,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (20,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (20,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (20,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (20,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (21,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (21,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (21,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (21,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (21,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (21,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (21,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (21,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (21,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (21,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (22,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (22,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (22,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (22,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (22,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (22,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (22,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (22,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (22,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (22,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (23,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (23,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (23,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (23,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (23,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (23,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (23,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (23,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (23,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (23,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (24,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (24,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (24,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (24,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (24,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (24,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (24,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (24,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (24,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (24,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (25,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (25,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (25,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (25,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (25,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (25,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (25,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (25,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (25,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (25,10,8,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (26,1,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (26,2,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (26,3,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (26,4,2,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (26,5,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (26,6,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (26,7,4,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (26,8,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (26,9,6,false,false);
insert into type_tables (id_rest, nr_table, qty_chairs, smooking, outside) values (26,10,8,false,false);

 # rekordy w tabeli oceny
 insert into rating (id_user, id_rest, value_rating) values (1,1,6.2);
insert into rating (id_user, id_rest, value_rating) values (2,1,7.7);
insert into rating (id_user, id_rest, value_rating) values (3,1,3.4);
insert into rating (id_user, id_rest, value_rating) values (4,1,5.7);
insert into rating (id_user, id_rest, value_rating) values (5,2,5.8);
insert into rating (id_user, id_rest, value_rating) values (6,2,7.8);
insert into rating (id_user, id_rest, value_rating) values (7,2,7.8);
insert into rating (id_user, id_rest, value_rating) values (8,2,9.6);
insert into rating (id_user, id_rest, value_rating) values (9,3,3.6);
insert into rating (id_user, id_rest, value_rating) values (10,3,3.8);
insert into rating (id_user, id_rest, value_rating) values (11,3,3.2);
insert into rating (id_user, id_rest, value_rating) values (12,3,4.5);
insert into rating (id_user, id_rest, value_rating) values (13,4,3.6);
insert into rating (id_user, id_rest, value_rating) values (14,4,4.8);
insert into rating (id_user, id_rest, value_rating) values (15,4,8.3);
insert into rating (id_user, id_rest, value_rating) values (16,4,3.5);
insert into rating (id_user, id_rest, value_rating) values (17,5,3.6);
insert into rating (id_user, id_rest, value_rating) values (18,5,6.6);
insert into rating (id_user, id_rest, value_rating) values (19,5,5.1);
insert into rating (id_user, id_rest, value_rating) values (20,5,8.5);
insert into rating (id_user, id_rest, value_rating) values (21,6,7.4);
insert into rating (id_user, id_rest, value_rating) values (22,6,6.5);
insert into rating (id_user, id_rest, value_rating) values (23,6,7.5);
insert into rating (id_user, id_rest, value_rating) values (24,6,7.3);
insert into rating (id_user, id_rest, value_rating) values (25,7,3.3);
insert into rating (id_user, id_rest, value_rating) values (26,7,3.5);
insert into rating (id_user, id_rest, value_rating) values (27,7,6.8);
insert into rating (id_user, id_rest, value_rating) values (28,7,3.9);
insert into rating (id_user, id_rest, value_rating) values (29,8,8.2);
insert into rating (id_user, id_rest, value_rating) values (30,8,9.2);
insert into rating (id_user, id_rest, value_rating) values (1,8,8.2);
insert into rating (id_user, id_rest, value_rating) values (2,8,8.6);
insert into rating (id_user, id_rest, value_rating) values (3,9,7.5);
insert into rating (id_user, id_rest, value_rating) values (4,9,7.5);
insert into rating (id_user, id_rest, value_rating) values (5,9,5.8);
insert into rating (id_user, id_rest, value_rating) values (6,9,3.2);
insert into rating (id_user, id_rest, value_rating) values (7,10,9.1);
insert into rating (id_user, id_rest, value_rating) values (8,10,5.6);
insert into rating (id_user, id_rest, value_rating) values (9,10,6.6);
insert into rating (id_user, id_rest, value_rating) values (10,10,3.8);
insert into rating (id_user, id_rest, value_rating) values (11,11,7.6);
insert into rating (id_user, id_rest, value_rating) values (12,11,3.8);
insert into rating (id_user, id_rest, value_rating) values (13,11,7.3);
insert into rating (id_user, id_rest, value_rating) values (14,11,3.6);
insert into rating (id_user, id_rest, value_rating) values (15,12,6.8);
insert into rating (id_user, id_rest, value_rating) values (16,12,7.6);
insert into rating (id_user, id_rest, value_rating) values (17,12,3.7);
insert into rating (id_user, id_rest, value_rating) values (18,12,6.2);
insert into rating (id_user, id_rest, value_rating) values (19,13,8.6);
insert into rating (id_user, id_rest, value_rating) values (20,13,4.4);
insert into rating (id_user, id_rest, value_rating) values (21,13,3.4);
insert into rating (id_user, id_rest, value_rating) values (22,13,3.5);
insert into rating (id_user, id_rest, value_rating) values (23,14,3.2);
insert into rating (id_user, id_rest, value_rating) values (24,14,3.3);
insert into rating (id_user, id_rest, value_rating) values (25,14,4.9);
insert into rating (id_user, id_rest, value_rating) values (26,14,6.1);
insert into rating (id_user, id_rest, value_rating) values (27,15,3.2);
insert into rating (id_user, id_rest, value_rating) values (28,15,3.1);
insert into rating (id_user, id_rest, value_rating) values (29,15,5.3);
insert into rating (id_user, id_rest, value_rating) values (30,15,3.8);
insert into rating (id_user, id_rest, value_rating) values (1,16,9.5);
insert into rating (id_user, id_rest, value_rating) values (2,16,7.4);
insert into rating (id_user, id_rest, value_rating) values (3,16,6.6);
insert into rating (id_user, id_rest, value_rating) values (4,16,5.3);
insert into rating (id_user, id_rest, value_rating) values (31,17,4.9);
insert into rating (id_user, id_rest, value_rating) values (32,17,5.8);
insert into rating (id_user, id_rest, value_rating) values (33,17,7.6);
insert into rating (id_user, id_rest, value_rating) values (34,17,8.6);
insert into rating (id_user, id_rest, value_rating) values (35,18,7.6);
insert into rating (id_user, id_rest, value_rating) values (31,18,8.8);
insert into rating (id_user, id_rest, value_rating) values (32,18,8.1);
insert into rating (id_user, id_rest, value_rating) values (33,18,5.5);
insert into rating (id_user, id_rest, value_rating) values (34,19,3.7);
insert into rating (id_user, id_rest, value_rating) values (35,19,5.4);
insert into rating (id_user, id_rest, value_rating) values (31,19,7.2);
insert into rating (id_user, id_rest, value_rating) values (32,19,7.8);
insert into rating (id_user, id_rest, value_rating) values (33,20,7.1);
insert into rating (id_user, id_rest, value_rating) values (34,20,6.1);
insert into rating (id_user, id_rest, value_rating) values (35,20,3.9);
insert into rating (id_user, id_rest, value_rating) values (31,20,5.9);
insert into rating (id_user, id_rest, value_rating) values (32,21,6.7);
insert into rating (id_user, id_rest, value_rating) values (33,21,6.1);
insert into rating (id_user, id_rest, value_rating) values (34,21,4.4);
insert into rating (id_user, id_rest, value_rating) values (35,21,6.9);
insert into rating (id_user, id_rest, value_rating) values (31,22,5.5);
insert into rating (id_user, id_rest, value_rating) values (32,22,7.9);
insert into rating (id_user, id_rest, value_rating) values (33,22,9.2);
insert into rating (id_user, id_rest, value_rating) values (34,22,4.5);
insert into rating (id_user, id_rest, value_rating) values (36,23,4.8);
insert into rating (id_user, id_rest, value_rating) values (37,23,3.7);
insert into rating (id_user, id_rest, value_rating) values (38,23,3.6);
insert into rating (id_user, id_rest, value_rating) values (39,23,8.7);
insert into rating (id_user, id_rest, value_rating) values (40,24,8.1);
insert into rating (id_user, id_rest, value_rating) values (37,24,7.1);
insert into rating (id_user, id_rest, value_rating) values (38,24,6.1);
insert into rating (id_user, id_rest, value_rating) values (39,24,3.3);
insert into rating (id_user, id_rest, value_rating) values (40,25,7.3);
insert into rating (id_user, id_rest, value_rating) values (36,25,3.2);
insert into rating (id_user, id_rest, value_rating) values (37,25,4.1);
insert into rating (id_user, id_rest, value_rating) values (38,25,7.7);
insert into rating (id_user, id_rest, value_rating) values (39,26,3.3);
insert into rating (id_user, id_rest, value_rating) values (40,26,6.9);
insert into rating (id_user, id_rest, value_rating) values (36,26,8.3);
insert into rating (id_user, id_rest, value_rating) values (37,26,7.9);

###
###  !!! Zapytania
### 

#
# Zapytania wykomywane od użytkowników
#

# zapytanie o nazwe restauracji w danym mieście
# wszystkie restauracjie
select city_name as 'Miasto', rest_name as 'Nazwa restauracji;' from restaurants natural left join cities;
# restauracjie z Warszawy
select city_name as 'Miasto', rest_name as 'Nazwa restauracji;' from restaurants natural left join cities where city_name = 'Warszawa';
# restauracje z Krakowa
select city_name as 'Miasto', rest_name as 'Nazwa restauracji;' from restaurants natural left join cities where city_name = 'Kraków';
# restauracje z Katowic
select city_name as 'Miasto', rest_name as 'Nazwa restauracji;' from restaurants natural left join cities where city_name = 'Katowice';

# zapytania o ilość stolików w restauracji (pomijając rezerwacje i zajętość stolika)
# ilości stolików i ilości krzeseł przy tym stoliku w restauracji
select city_name as 'Miasto', rest_name  as 'Nazwa restauracji', qty_chairs as 'Ilość krzeseł przy stoliku', count(qty_chairs) as 'Ilość stolików z określoną ilością krzeseł' from restaurants natural right join type_tables natural left join cities group by id_rest, qty_chairs;
# suma wszystkich stolików w restauracji
select city_name as 'Miasto', rest_name as 'Nazwa restauracji', count(id_rest) as 'Ilość wszystkich stolików' from restaurants natural left join type_tables natural left join cities group by city_name desc, rest_name; # suma wszystkich stolików w restauracji
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
select city_name as 'Miasto', rest_name as 'Nazwa restauracji', round(avg(value_rating),1) as 'Ocena' from restaurants natural left join rating natural left join cities group by rest_name order by city_name desc;
# wyświetla restauracje ze średnią oceną powyżej x (np. 5.0)
select city_name as 'Miasto', rest_name as 'Nazwa restauracji', round(avg(value_rating),1) as 'Ocena' from restaurants natural left join rating natural left join cities group by rest_name having round(avg(value_rating),1) > 5.0 order by city_name desc ;

# zapytania o rodzaj kuchni
select city_name as 'Miasto', rest_name as 'Nazwa restauracji', type_cuisine as 'Rodzaj kuchni' from restaurants natural right join cuisines natural left join cities;

# sprawdzenie statusu zajętości stolików w dniu dzisiejszym 
select nr_table, qty_chairs, time_occ_start, time_occ_stop from occupancy natural left join type_tables;

#
# Zapytania wykonywane od kelnerów
#

# wyświetlenie rezerwacji stolików dokonanych przez użytkowników (wszystkich rezerwacji, bez względu na datę)
select e_mail, nr_table, date_book_start, date_book_stop from booking natural left join users natural left join type_tables order by e_mail;
# wyświetlenie rezerwacji stolików dokonanych przez użytkowników w konkretnym dniu
select e_mail, nr_table, date_book_start, date_book_stop from booking natural left join users natural left join type_tables where date_format(date_book_start, '%Y-%m-%d') = '2017-08-10' order by e_mail;
# wyświetla podgląd rezerwacji stolików w dniu wysłyania zapytania (przydatne w momencie kiedy kelner chce wyświetlić ilość rezerwacji w dniu dzisiejszym):
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