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

create database wolny_stolik;

use wolny_stolik;

#tabela użytkowników (tabel logowania)
create table users (
	id_user int unsigned not null auto_increment,
    e_mail text not null,
    pass blob not null,
    city text not null,
    primary key (id_user)
);

#tabela restauracji
create table restaurats (
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

#tabela rodzaju stolika
create table type_tables(
	id_table int unsigned not null auto_increment,
    qty_chairs int unsigned,
    smoking boolean not null,
    outside boolean not null,
    primary key (id_table)
);

#tabela rezerwacji
create table booking (
	id_book int unsigned not null auto_increment,
    id_user int unsigned not null,
    id_rest int unsigned not null,
    id_table int unsigned not null,
	date_book datetime not null,
    primary key (id_book),
    foreign key (id_user) references users(id_user),
    foreign key (id_rest) references restaurats(id_rest)
);

#tabela oceny 
create table rating (
	id_rating int unsigned not null auto_increment,
	id_user int unsigned not null,
    id_rest int unsigned not null,
    value_rating double unsigned not null,
    primary key (id_rating),
	foreign key (id_user) references users(id_user),
    foreign key (id_rest) references restaurats(id_rest)
);