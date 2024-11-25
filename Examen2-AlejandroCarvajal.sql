
-- Crear la base de datos
CREATE DATABASE GestionEquipos;
GO

-- Usar la base de datos
USE GestionEquipos;
GO

-- Tabla de Usuarios
CREATE TABLE Usuarios (
    UsuarioID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50) NOT NULL,
    Correo NVARCHAR(50) UNIQUE NOT NULL,
    Contraseña NVARCHAR(50) NOT NULL
);

-- Tabla de Técnicos
CREATE TABLE Tecnicos (
    TecnicoID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50) NOT NULL,
    Especialidad NVARCHAR(50) NOT NULL
);

-- Tabla de Equipos
CREATE TABLE Equipos (
    EquipoID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50) NOT NULL,
    Modelo NVARCHAR(50) NOT NULL,
    UsuarioID INT,
    TecnicoID INT,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID) ON DELETE SET NULL,
    FOREIGN KEY (TecnicoID) REFERENCES Tecnicos(TecnicoID) ON DELETE SET NULL
);

CREATE TABLE Reparaciones (
    ReparacionID INT PRIMARY KEY IDENTITY(1,1),
    EquipoID INT NOT NULL,
    FechaSolicitud DATE NOT NULL DEFAULT GETDATE(),
    Estado NVARCHAR(50) NOT NULL,
    FOREIGN KEY (EquipoID) REFERENCES Equipos(EquipoID) ON DELETE CASCADE
);

CREATE TABLE DetallesReparacion (
    DetalleID INT PRIMARY KEY IDENTITY(1,1),
    ReparacionID INT NOT NULL,
    Descripcion NVARCHAR(MAX) NOT NULL,
    FechaInicio DATE NULL,
    FechaFin DATE NULL,
    FOREIGN KEY (ReparacionID) REFERENCES Reparaciones(ReparacionID) ON DELETE CASCADE
);

CREATE TABLE Asignaciones (
    AsignacionID INT PRIMARY KEY IDENTITY(1,1),
    ReparacionID INT NOT NULL,
    TecnicoID INT NOT NULL,
    FechaAsignacion DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (ReparacionID) REFERENCES Reparaciones(ReparacionID) ON DELETE CASCADE,
    FOREIGN KEY (TecnicoID) REFERENCES Tecnicos(TecnicoID) ON DELETE CASCADE
);
-- Procedimientos para la tabla Usuarios
CREATE PROCEDURE InsertarUsuario
    @Nombre NVARCHAR(50),
    @Correo NVARCHAR(50),
    @Contraseña NVARCHAR(50)
AS
BEGIN
    INSERT INTO Usuarios (Nombre, Correo, Contraseña)
    VALUES (@Nombre, @Correo, @Contraseña);
END;

CREATE PROCEDURE ConsultarUsuarios
AS
BEGIN
    SELECT * FROM Usuarios;
END;

CREATE PROCEDURE ActualizarUsuario
    @UsuarioID INT,
    @Nombre NVARCHAR(50),
    @Correo NVARCHAR(50),
    @Contraseña NVARCHAR(50)
AS
BEGIN
    UPDATE Usuarios
    SET Nombre = @Nombre, Correo = @Correo, Contraseña = @Contraseña
    WHERE UsuarioID = @UsuarioID;
END;

CREATE PROCEDURE EliminarUsuario
    @UsuarioID INT
AS
BEGIN
    DELETE FROM Usuarios WHERE UsuarioID = @UsuarioID;
END;

CREATE PROCEDURE InsertarTecnico
    @Nombre NVARCHAR(50),
    @Especialidad NVARCHAR(50)
AS
BEGIN
    INSERT INTO Tecnicos (Nombre, Especialidad)
    VALUES (@Nombre, @Especialidad);
END;

CREATE PROCEDURE ConsultarTecnicos
AS
BEGIN
    SELECT * FROM Tecnicos;
END;

CREATE PROCEDURE ActualizarTecnico
    @TecnicoID INT,
    @Nombre NVARCHAR(50),
    @Especialidad NVARCHAR(50)
AS
BEGIN
    UPDATE Tecnicos
    SET Nombre = @Nombre, Especialidad = @Especialidad
    WHERE TecnicoID = @TecnicoID;
END;

CREATE PROCEDURE EliminarTecnico
    @TecnicoID INT
AS
BEGIN
    DELETE FROM Tecnicos WHERE TecnicoID = @TecnicoID;
END;


