create table Persona(
    nro_persona int primary key not null,
    nombre varchar(40) not null,
    calle varchar(30) not null,
    ciudad varchar(30) not null,
    nro_supervisor int,
    foreign key (nro_supervisor) references Persona(nro_persona)
);

create table Empresa(
    nro_empresa int primary key not null,
    nombre varchar(40) not null,
    razon_social varchar(40) not null,
    calle varchar(30) not null,
    ciudad varchar(30) not null
);

create table Trabaja(
    nro_persona int not null,
    nro_empresa int not null,
    salario double not null,
    fecha_ingreso date not null,
    primary key(nro_persona, nro_empresa),
    foreign key (nro_persona) references Persona(nro_persona),
    foreign key (nro_empresa) references Empresa(nro_empresa)
);

insert into Persona(nro_persona, nombre, calle, ciudad, nro_supervisor) values (115, 'Juana', 'Iturri', 'La Plata', 100);
insert into Persona(nro_persona, nombre, calle, ciudad, nro_supervisor) values (116, 'Roberto', 'Echeverria', 'Merlo', 100);
insert into Persona(nro_persona, nombre, calle, ciudad, nro_supervisor) values (100, 'Maria', 'Echeverria', 'Ituzaigó', null);

insert into Empresa(nro_empresa, nombre, razon_social, calle, ciudad) values (11, 'Banelco', 'fhjkds', 'Iturri', 'La Plata');
insert into Empresa(nro_empresa, nombre, razon_social, calle, ciudad) values (12, 'Paulinas', 'no se', 'Echeverria', 'Merlo');
insert into Empresa(nro_empresa, nombre, razon_social, calle, ciudad) values (13, 'Tecnosur', 'fjsdañ', 'Acacias', 'Padua');

insert into Trabaja(nro_persona, nro_empresa, salario, fecha_ingreso) values (115, 11, 100.00, '2015-01-22');
insert into Trabaja(nro_persona, nro_empresa, salario, fecha_ingreso) values (115, 12, 1600.00, '2003-05-02');
insert into Trabaja(nro_persona, nro_empresa, salario, fecha_ingreso) values (100, 13, 1600.00, '2004-01-21');
insert into Trabaja(nro_persona, nro_empresa, salario, fecha_ingreso) values (116, 13, 1900.00, '2000-06-11');
insert into Trabaja(nro_persona, nro_empresa, salario, fecha_ingreso) values (115, 13, 1900.00, '2001-01-01');
insert into Trabaja(nro_persona, nro_empresa, salario, fecha_ingreso) values (115, 14, 1900.00, '2002-02-05');
insert into Trabaja(nro_persona, nro_empresa, salario, fecha_ingreso) values (115, 15, 1900.00, '2003-01-01');

/*1. Listar el nombre y ciudad de todas las personas que trabajan en la empresa
“Banelco”.*/
select p.nombre, p.ciudad
from Persona p join Trabaja t on p.nro_persona = t.nro_persona
                join Empresa e on e.nro_empresa = t.nro_empresa
where e.nombre = 'Banelco';

/*2. Listar el nombre, calle y ciudad de todas las personas que trabajan para la
empresa “Paulinas” y ganan más de $1500.*/
select p.nombre, p.calle, p.ciudad
from Persona p join Trabaja t on p.nro_persona = t.nro_persona
                join Empresa e on e.nro_empresa = t.nro_empresa
where e.nombre = 'Paulinas'
and t.salario > 1500

/*3. Listar el nombre de personas que viven en la misma ciudad en la que se halla la
empresa en donde trabajan.*/
select p.nombre
from Persona p 
where exists (select 1
            from Trabaja t join Empresa e on t.nro_empresa = e.nro_empresa
            where p.ciudad = e.ciudad
            and p.nro_persona = t.nro_persona);

/*4. Listar número y nombre de todas las personas que viven en la misma ciudad y en
la misma calle que su supervisor NO ME SALIÓ*/
select p.nro_persona, p.nombre
from Persona p 
where exists (select 1
            from Persona jefe 
            where p.nro_persona = jefe.nro_persona
            and jefe.ciudad = p.ciudad
            and jefe.calle = p.calle)

/*5. Listar el nombre y ciudad de todas las personas que ganan más que cualquier
empleado de la empresa “Tecnosur”. TAMPOCO SALIÓ*/
select p.nombre, p.ciudad
from Persona p join Trabaja t on p.nro_persona = t.nro_persona
                join Empresa e on e.nro_empresa = t.nro_empresa
where t.salario = (select max(t2.salario)
                    from Trabaja t2
                    where t2.nro_persona = p.nro_persona
                    and e.nombre = 'Tecnosur');

/*6. Listar las ciudades en las que todos los trabajadores que vienen en ellas ganan
más de $1000.*/


/*Listar el nombre de los empleados que hayan ingresado en mas de 4 Empresas en
el periodo 01-01-2000 y 31-03-2004*/
select p.nombre
from Persona p join Trabaja t on p.nro_persona = t.nro_persona
group by p.nombre, p.nro_persona
having count(t.nro_empresa) > 4
and t.fecha_ingreso > '2000-01-01'
and t.fecha_ingreso < '2004-03-31';
