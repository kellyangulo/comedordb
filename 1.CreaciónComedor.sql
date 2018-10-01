create database Comedor

GO

use Comedor

use cacas
create table Persona
(
	ID int identity (1,1) not null,
	Nombre varchar(20) not null,
	[Apellido Paterno] varchar(20) null,
)

alter table Persona
add constraint PK_Persona
Primary key (ID)

create table Trabajo
(
	ID int identity (1,1) not null,
	Nombre varchar(20) not null,
	Descripcion varchar (30)
)

alter table Trabajo
add constraint PK_Trabajo
Primary key (ID)

create table Niño
(
	IDPersona int not null,
	Fecha_Nacimiento date not null,
	Nivel tinyint,
	Grado tinyint
)

alter table Niño 
add constraint PK_NiñoPersona
Primary key (IDPersona)

alter table Niño
add constraint FK_Persona
Foreign key (IDPersona) references Persona (ID)

create table Tutor
(
	IDPersona int not null,
	IDTrabajo int not null
)

alter table Tutor
add constraint PK_TutorPersona
Primary key (IDPersona)

alter table Tutor
add constraint FK_PersonaID
Foreign key (IDPersona) references Persona (ID)

alter table Tutor
add constraint FK_Trabajo
Foreign key (IDTrabajo) references Trabajo (ID)

create table Telefono
(
	IDTutor int not null,
	Lada smallint,
	Numero float not null,
)

alter table Telefono
add constraint FK_Telefono
Foreign key (IDTutor) references Tutor (IDPersona)

create table Tutor_Niño
(
	IDNiño int not null,
	IDTutor int not null
)

alter table Tutor_Niño
add constraint FK_NiñoID
Foreign key (IDTutor) references Tutor (IDPersona)

alter table Tutor_Niño
add constraint FK_TutorID
Foreign key (IDNiño) references Niño (IDPersona)

create table Alergia
(
	ID int identity (1,1) not null,
	Descripcion varchar (80) not null
)

alter table Alergia
add constraint PK_Alergia
Primary key (ID)

create table Niño_Alergia
(
	IDNiño int not null,
	IDAlergia int not null
)

alter table Niño_Alergia
add constraint FK_IDNiño
Foreign key (IDNiño) references Niño (IDPersona)


alter table Niño_Alergia
add constraint FK_AlergiaID
Foreign key (IDAlergia) references Alergia (ID)

create table Dieta
(
	ID int identity (1,1) not null,
	Costo money not null
)

alter table Dieta
add constraint PK_Dieta
Primary key (ID)

create table Niño_Dieta
(
	IDNiño int not null,
	[ID Dieta] int not null
)

alter table Niño_Dieta
add constraint FK_IDNiñoDiet
Foreign key (IDNiño) references Niño (IDPersona)

alter table Niño_Dieta
add constraint FK_DietaID
Foreign key ([ID Dieta]) references Dieta (ID)

create table Menu
(
	ID int identity (1,1) not null,
	Fecha date,
	Costo smallint not null
)

alter table Menu
add constraint PK_Menu
Primary key (ID)

create table Niño_Menu
(
	IDNiño int not null,
	IDMenu int not null
)

alter table Niño_Menu
add constraint FK_IDNiñoMenu
Foreign key (IDNiño) references Niño (IDPersona)

alter table Niño_Menu
add constraint FK_MenuID
Foreign key (IDMenu) references Menu (ID)

create table Alimento
(
	ID int identity (1,1) not null,
	Grasas decimal (2,2) not null,
	Calorias decimal (2,2) not null,
	Carbohidratos decimal (2,2) not null,
	Proteinas decimal (2,2) not null
)

alter table Alimento
add constraint PK_Alimento
Primary key (ID)

create table Comida
(
	IDAlimento int not null,
	Nombre varchar not null,
	Descripcion varchar
)

alter table Comida
add constraint FK_IDAlimentoC
Foreign key (IDAlimento) references Alimento (ID)

alter table Comida
add constraint PK_Comida
Primary key (IDAlimento)

create table Bebida
(
	IDAlimento int not null,
	Nombre varchar not null,
	Descripcion varchar
)

alter table Bebida
add constraint FK_IDAlimentoB
Foreign key (IDAlimento) references Alimento (ID)

alter table Bebida
add constraint PK_Bebida
Primary key (IDAlimento)

create table Postre
(
	IDAlimento int not null,
	Nombre varchar not null,
	Descripcion varchar
)

alter table Postre
add constraint  FK_IDAlimentoP
Foreign key (IDAlimento) references Alimento (ID)

alter table Postre
add constraint PK_Postre
Primary key (IDAlimento)

create table Menu_Alimento
(
	IDMenu int not null,
	IDAlimento int not null
)

alter table Menu_Alimento
add constraint FK_IDMenu_Alimento
Foreign key (IDMenu) references Menu (ID)

alter table Menu_Alimento
add constraint FK_AlimentoID
Foreign key (IDAlimento) references Alimento (ID)

create table Cantidad
(
	ID int identity (1,1) not null,
	Descripcion varchar (25) not null
)
alter table Cantidad
add constraint PK_Cantidad
Primary key (ID)

create table Ingrediente
(
	ID int identity (1,1) not null,
	Nombre varchar (20) not null,
	IDCantidad int not null,
	[Fecha Caducidad] date not null
)

alter table Ingrediente
add constraint FK_Cantidad
Foreign key (IDCantidad) references Cantidad (ID)

alter table Ingrediente
add constraint PK_Ingrediente
Primary key (ID)

create table Alimento_Ingrediente
(
	IDAlimento int not null,
	IDIngrediente int not null
)

alter table Alimento_Ingrediente
add constraint FK_IDAlimento__AlimentoIngrediente
Foreign key (IDAlimento) references Alimento (ID)

alter table Alimento_Ingrediente
add constraint FK_IDIngrediente_AlimentoIngrediente
Foreign key (IDIngrediente) references Ingrediente (ID)

create table Inventario
(
	ID int identity (1,1) not null,
	Fecha date
)

alter table Inventario
add constraint PK_Inventario
Primary key (ID)

create table Ingrediente_Inventario
(
	IDIngrediente int not null,
	IDInventario int not null
)

alter table Ingrediente_Inventario
add constraint FK_Ingrediente
Foreign key (IDIngrediente) references Ingrediente (ID)

alter table Ingrediente_Inventario
add constraint FK_Inventario
Foreign key (IDInventario) references Inventario (ID)
