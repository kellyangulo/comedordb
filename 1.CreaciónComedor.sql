create database Comedor
GO
use Comedor
GO

create table Persona
(
	ID int identity (1,1) not null,
	Nombre varchar(20) not null,
	[Apellidos] varchar(20) not null,
)

alter table Persona
add constraint PK_Persona Primary key (ID)

create table Trabajo
(
	ID int identity (1,1) not null,
	Nombre varchar(20) not null,
)

alter table Trabajo 
add constraint PK_Trabajo Primary key (ID)

alter table Trabajo 
add constraint UQ_NombreTrabajo unique (Nombre)

create table Nivel
(
	ID tinyint identity not null,
	Nombre varchar(30) not null
)

alter table Nivel
add constraint PK_Nivel Primary key (ID)

alter table Nivel
add constraint UQ_NombreNivel unique (Nombre)

create table Menu
(
	ID int identity (1,1) not null,
	Fecha date,
	Costo decimal (3,2) not null
)

alter table Menu
add constraint PK_Menu Primary key (ID)

alter table  Menu
add constraint CK_FechaMenu check (Fecha <= getdate())


create table Alergia
(
	ID int identity (1,1) not null,
	Descripcion varchar (80) not null
)

alter table Alergia
add constraint PK_Alergia Primary key (ID)

alter table Alergia
add constraint UQ_AlergiaDescripcion unique (Descripcion)

create table TipoComida
(
	ID tinyint identity (1,1) not null,
	Nombre varchar (20) not null
)

alter table TipoComida
add constraint PK_TipoComida Primary key (ID)

alter table TipoComida
add constraint UQ_Nombre_TipoComida unique (Nombre)

create table Inventario
(
	ID int identity (1,1) not null,
	Fecha date
)

alter table Inventario
add constraint PK_Inventario Primary key (ID)

alter table  Inventario
add constraint CK_FechaInventario check (Fecha <= getdate())

create table Ingrediente
(
	ID int identity (1,1) not null,
	Nombre varchar (20) not null,
	[Fecha Caducidad] date not null,
	Cantidad int
)

alter table Ingrediente
add constraint PK_Ingrediente Primary key (ID)

alter table  Ingrediente
add constraint CK_FechaCaducidadIngrediente check ([Fecha Caducidad] <= getdate())

alter table Ingrediente
add constraint UQ_Ingrediente unique (Nombre,[Fecha Caducidad])


create table Unidad(
	ID tinyint identity (1,1) not null,
	Nombre varchar (20) not null
)

alter table Unidad
add constraint PK_Unidad Primary key (ID)

alter table Unidad
add constraint UQ_UnidadNombre unique (Nombre)


----------------------CREACI�N DE TABLAS DEPENDIENTES--------------------------

create table Ni�o
(
	IDPersona int not null,
	Fecha_Nacimiento date not null,
	Nivel_ID tinyint not null,
	Grado tinyint not null
)

alter table Ni�o 
add constraint PK_Ni�oPersona Primary key (IDPersona)

alter table Ni�o 
add constraint FK_Persona Foreign key (IDPersona) references Persona (ID)

alter table Ni�o
add constraint FK_Nivel Foreign key (Nivel_ID) references Nivel (ID)

alter table Ni�o
add constraint CK_FechaNacimiento check (Fecha_Nacimiento < getdate())


create table Tutor
(
	IDPersona int not null,
	IDTrabajo int not null
)

alter table Tutor
add constraint FK_PersonaID Foreign key (IDPersona) references Persona (ID)

alter table Tutor
add constraint PK_TutorPersona Primary key (IDPersona)

alter table Tutor
add constraint FK_Trabajo Foreign key (IDTrabajo) references Trabajo (ID)


create table Telefono
(
	IDTutor int not null,
	Lada smallint not null,
	Numero int not null
)

alter table Telefono
add constraint FK_Telefono Foreign key (IDTutor) references Tutor (IDPersona)

alter table Telefono
add constraint UQ_Telefono unique (Lada,Numero)

create table Tutor_Ni�o
(
	IDNi�o int not null,
	IDTutor int not null
)

alter table Tutor_Ni�o
add constraint FK_Ni�oID Foreign key (IDTutor) references Tutor (IDPersona)

alter table Tutor_Ni�o
add constraint FK_TutorID Foreign key (IDNi�o) references Ni�o (IDPersona)

alter table Tutor_Ni�o
add constraint UQ_Tutor_Ni�o unique (IDTutor,IDNi�o)


create table Ni�o_Alergia
(
	IDNi�o int not null,
	IDAlergia int not null
)

alter table Ni�o_Alergia
add constraint UQ_Ni�o_Alergia unique (IDNi�o,IDAlergia)

alter table Ni�o_Alergia
add constraint FK_IDNi�o Foreign key (IDNi�o) references Ni�o (IDPersona)

alter table Ni�o_Alergia
add constraint FK_AlergiaID Foreign key (IDAlergia) references Alergia (ID)

create table Dieta
(
	ID int identity (1,1) not null,
	Costo decimal (3,2) not null,
	Ni�o_ID int not null
)

alter table Dieta
add constraint PK_Dieta Primary key (ID)

alter table  Dieta
add constraint FK_Ni�oID_Dieta Foreign key (Ni�o_ID) references Ni�o (IDPersona)

create table Alimento
(
	ID int identity (1,1) not null,
	Nombre varchar (50) not null,
	TipoComida_ID tinyint not null,
	Grasas decimal (2,2) not null,
	Calorias decimal (2,2) not null,
	Carbohidratos decimal (2,2) not null,
	Proteinas decimal (2,2) not null
)

alter table Alimento
add constraint PK_Alimento Primary key (ID)

alter table Alimento
add constraint FK_TipoComidaID Foreign key (TipoComida_ID) references TipoComida (ID)

create table PorcionIngredienteAlimento
(
	Alimento_ID int not null,
	Ingrediente_ID int not null,
	Unidad_ID tinyint not null,
	Cantidad tinyint not null
)

alter table PorcionIngredienteAlimento
add constraint UQ_Porcion unique (Alimento_ID,Ingrediente_ID,Unidad_ID,Cantidad)

create table Menu_Alimento
(
	IDMenu int not null,
	IDAlimento int not null
)

alter table Menu_Alimento
add constraint FK_IDMenu_Alimento Foreign key (IDMenu) references Menu (ID)

alter table Menu_Alimento
add constraint FK_AlimentoID Foreign key (IDAlimento) references Alimento (ID)

create table Ingrediente_Inventario
(
	IDInventario int not null,
	IDIngrediente int not null,
	CantidadIngrediente int not null,
)

alter table Ingrediente_Inventario
add constraint FK_Ingrediente Foreign key (IDIngrediente) references Ingrediente (ID)

alter table Ingrediente_Inventario
add constraint FK_Inventario Foreign key (IDInventario) references Inventario (ID)

alter table Ingrediente_Inventario
add constraint UQ_Ingrediente_Inventario unique (IDInventario,IDIngrediente)

create table Dieta_Alimento
(
	[ID Dieta] int not null,
	Alimento_ID int not null,
)

alter table Dieta_Alimento
add constraint FK_Dieta_DietaAlimento Foreign key ([ID Dieta]) references Dieta (ID)

alter table Dieta_Alimento
add constraint FK_Alimento_DietaAlimento Foreign key (Alimento_ID) references Alimento (ID)

create table Ni�o_Menu
(
	ID int identity (1,1) not null,
	IDNi�o int not null,
	IDMenu int not null
)
alter table Ni�o_Menu
add constraint PK_MenuID Primary key (ID)

alter table Ni�o_Menu
add constraint FK_IDNi�oMenu
Foreign key (IDNi�o) references Ni�o (IDPersona)

alter table Ni�o_Menu
add constraint FK_MenuID Foreign key (IDMenu) references Menu (ID)

-----PAGOS



