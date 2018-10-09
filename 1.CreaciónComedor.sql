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
	Costo decimal (5,2) not null
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
	Nombre varchar (40) not null,
	[Fecha Caducidad] date not null,
)

alter table Ingrediente
add constraint PK_Ingrediente Primary key (ID)

alter table Ingrediente
add constraint UQ_Ingrediente unique (Nombre,[Fecha Caducidad])


create table Unidad
(
	ID tinyint identity (1,1) not null,
	Nombre varchar (20) not null
)

alter table Unidad
add constraint PK_Unidad Primary key (ID)

alter table Unidad
add constraint UQ_UnidadNombre unique (Nombre)

create table TipoPago
(
	ID tinyint identity (1,1) not null,
	Nombre varchar (30)
)

alter table  TipoPago
add constraint PK_TipoPago Primary key (ID)

----------------------CREACIÓN DE TABLAS DEPENDIENTES--------------------------

create table Niño
(
	IDPersona int not null,
	Fecha_Nacimiento date not null,
	Nivel_ID tinyint not null,
	Grado tinyint not null
)
alter table Niño 
add constraint FK_Persona Foreign key (IDPersona) references Persona (ID)

alter table Niño 
add constraint PK_NiñoPersona Primary key (IDPersona)

alter table Niño
add constraint FK_Nivel Foreign key (Nivel_ID) references Nivel (ID)

alter table Niño
add constraint CK_FechaNacimiento check (Fecha_Nacimiento < getdate())

alter table Niño
add constraint CK_GradoMenor check (Grado >= 1 )

alter table Niño
add constraint CK_GradoMayor check (Grado <= 7) 


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

create table Tutor_Niño
(
	IDNiño int not null,
	IDTutor int not null
)

alter table Tutor_Niño
add constraint FK_NiñoID Foreign key (IDTutor) references Tutor (IDPersona)

alter table Tutor_Niño
add constraint FK_TutorID Foreign key (IDNiño) references Niño (IDPersona)

alter table Tutor_Niño
add constraint UQ_Tutor_Niño unique (IDTutor,IDNiño)


create table Niño_Alergia
(
	IDNiño int not null,
	IDAlergia int not null
)

alter table Niño_Alergia
add constraint UQ_Niño_Alergia unique (IDNiño,IDAlergia)

alter table Niño_Alergia
add constraint FK_IDNiño Foreign key (IDNiño) references Niño (IDPersona)

alter table Niño_Alergia
add constraint FK_AlergiaID Foreign key (IDAlergia) references Alergia (ID)


create table Alimento                                      
(
	ID int identity (1,1) not null,
	Nombre varchar (50) not null,
	TipoComida_ID tinyint not null,
	Grasas decimal (4,2) not null,
	Calorias decimal (4,2) not null,
	Carbohidratos decimal (4,2) not null,
	Proteinas decimal (4,2) not null
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
	Cantidad decimal(6,2) not null
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
	Unidad tinyint
)

alter table Ingrediente_Inventario
add constraint FK_IngredienteInventario Foreign key (IDIngrediente) references Ingrediente (ID)

alter table Ingrediente_Inventario
add constraint FK_Inventario Foreign key (IDInventario) references Inventario (ID)

alter table Ingrediente_Inventario
add constraint FK_UnidadInventario Foreign key (Unidad) references Unidad (ID)

alter table Ingrediente_Inventario
add constraint UQ_Ingrediente_Inventario unique (IDInventario,IDIngrediente)


create table Niño_Alimento                                           -----FALTA
(
	IDNiño int not null,
	IDAlimento int not null,
	[Día Consumo] date not null
)

alter table Niño_Alimento
add constraint FK_IDNiñoAlimento Foreign key (IDNiño) references Niño (IDPersona)

alter table Niño_Alimento
add constraint FK_AlimentoNiño Foreign key (IDAlimento) references Alimento (ID)

create table Pago                                          -----FALTA
(
	ID int identity (1,1) not null,
	TipoPagoID tinyint not null,
	Fecha date not null,
	Monto decimal (6,2) not null,
	TutorID int not null,
	NiñoID int not null,
)
alter table Pago 
add constraint FK_TipoPago Foreign key (TipoPagoID) references TipoPago (ID)

alter table Pago 
add constraint FK_PagoNiño Foreign key (NiñoID) references Niño (IDPersona)

alter table Pago 
add constraint FK_PagoTutor Foreign key (TutorID) references Tutor (IDPersona)

alter table Pago 
add constraint CK_FechaPago check (Fecha <= getdate())




