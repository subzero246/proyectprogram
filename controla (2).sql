-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-01-2026 a las 21:48:38
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `controla`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumnos`
--

CREATE TABLE `alumnos` (
  `Id_alumno` int(11) NOT NULL,
  `No_control` int(11) DEFAULT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Apellido_paterno` varchar(100) NOT NULL,
  `Apellido_materno` varchar(100) DEFAULT NULL,
  `F_nacimiento` date DEFAULT NULL,
  `Sexo` varchar(10) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Correo` varchar(120) DEFAULT NULL,
  `Direccion` varchar(200) DEFAULT NULL,
  `Id_grupo` int(11) DEFAULT NULL,
  `Fecha_creacion` date DEFAULT NULL,
  `Id_tutor` int(11) DEFAULT NULL,
  `Foto` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `alumnos`
--

INSERT INTO `alumnos` (`Id_alumno`, `No_control`, `Nombre`, `Apellido_paterno`, `Apellido_materno`, `F_nacimiento`, `Sexo`, `Telefono`, `Correo`, `Direccion`, `Id_grupo`, `Fecha_creacion`, `Id_tutor`, `Foto`) VALUES
(0, 123456, 'marco', 'candelario', '', NULL, '', '7222222345', NULL, NULL, 0, NULL, NULL, NULL),
(1, 12345, 'jesus', 'nolasquez', '', NULL, '', '7222222222', 'empanasapro@gmail.com', 'peru', 0, '2025-12-04', 1, 'cara de guapo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia`
--

CREATE TABLE `asistencia` (
  `id` int(150) NOT NULL,
  `estud_id` varchar(100) NOT NULL,
  `curs_id` int(100) NOT NULL,
  `fecha` date NOT NULL,
  `hor_regis` varchar(100) NOT NULL,
  `estado` varchar(100) NOT NULL,
  `observaciones` varchar(100) NOT NULL,
  `metod_regis` varchar(100) NOT NULL,
  `fec_crea` date NOT NULL,
  `id_horario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencias`
--

CREATE TABLE `asistencias` (
  `Id_asistencia` int(11) NOT NULL,
  `Id_alumno` int(11) NOT NULL,
  `Id_horario` int(11) NOT NULL,
  `Fecha` date NOT NULL,
  `Estado_asistencia` varchar(50) DEFAULT 'Presente',
  `Observaciones` text DEFAULT NULL,
  `Fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

CREATE TABLE `curso` (
  `id` int(150) NOT NULL,
  `nom_curso` varchar(100) NOT NULL,
  `horario` varchar(100) NOT NULL,
  `aula` varchar(100) NOT NULL,
  `capcidad` varchar(100) NOT NULL,
  `profesor` varchar(100) DEFAULT NULL,
  `activo` varchar(100) NOT NULL,
  `fk` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante`
--

CREATE TABLE `estudiante` (
  `id` int(150) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `grado` varchar(100) NOT NULL,
  `seccion` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefono` varchar(100) NOT NULL,
  `fechnacimiento` date NOT NULL,
  `direccion` text NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `fechacreacion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupos`
--

CREATE TABLE `grupos` (
  `Id_grupo` int(11) NOT NULL,
  `Nombre_grupo` varchar(50) NOT NULL,
  `Semestre` varchar(20) DEFAULT NULL,
  `Turno` varchar(20) DEFAULT NULL,
  `Especialidad` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `grupos`
--

INSERT INTO `grupos` (`Id_grupo`, `Nombre_grupo`, `Semestre`, `Turno`, `Especialidad`) VALUES
(500, '501-A', 'Quinto', 'Matutino', 'Informática');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios`
--

CREATE TABLE `horarios` (
  `Id_horario` int(11) NOT NULL,
  `Id_grupo` int(11) NOT NULL,
  `Id_materia` int(11) NOT NULL,
  `Dia_semana` varchar(20) NOT NULL,
  `Hora_inicio` time NOT NULL,
  `Hora_fin` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

--
-- Volcado de datos para la tabla `horarios`
--

INSERT INTO `horarios` (`Id_horario`, `Id_grupo`, `Id_materia`, `Dia_semana`, `Hora_inicio`, `Hora_fin`) VALUES
(1, 500, 502651, 'lunes', '07:00:00', '23:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `incidencias`
--

CREATE TABLE `incidencias` (
  `id` int(150) NOT NULL,
  `est_id` int(100) DEFAULT NULL,
  `prof_id` int(100) DEFAULT NULL,
  `descripcion` varchar(100) NOT NULL,
  `fecha` date NOT NULL,
  `estado` varchar(100) NOT NULL,
  `severidad` varchar(100) NOT NULL,
  `tipo` varchar(100) NOT NULL,
  `acci_tom` varchar(100) NOT NULL,
  `fech_crea` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materias`
--

CREATE TABLE `materias` (
  `Id_materia` int(11) NOT NULL,
  `Nombre_materia` varchar(100) NOT NULL,
  `Clave_materia` varchar(50) DEFAULT NULL,
  `Semestre` varchar(20) DEFAULT NULL,
  `Horas_semana` int(11) DEFAULT NULL,
  `Id_profesor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `materias`
--

INSERT INTO `materias` (`Id_materia`, `Nombre_materia`, `Clave_materia`, `Semestre`, `Horas_semana`, `Id_profesor`) VALUES
(502651, 'ingles v', 'ingles Anallely', 'quinto', 4, 2147483647);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes`
--

CREATE TABLE `mensajes` (
  `Id_mensaje` int(11) NOT NULL,
  `Id_alumno` int(11) DEFAULT NULL,
  `Id_tutor` int(11) DEFAULT NULL,
  `Id_usuario` int(11) DEFAULT NULL,
  `Fecha_envio` date DEFAULT NULL,
  `Asunto` varchar(150) DEFAULT NULL,
  `Mensaje` text DEFAULT NULL,
  `Tipo_mensaje` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mensajes`
--

INSERT INTO `mensajes` (`Id_mensaje`, `Id_alumno`, `Id_tutor`, `Id_usuario`, `Fecha_envio`, `Asunto`, `Mensaje`, `Tipo_mensaje`) VALUES
(1234567, 1, 1, 2147483647, '2025-12-12', 'pelea', 'niño pendejo se peleo en la escuela', 'formal');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `padre`
--

CREATE TABLE `padre` (
  `id` int(150) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefono` varchar(100) NOT NULL,
  `parentesco` varchar(100) NOT NULL,
  `notiactivas` tinyint(1) NOT NULL,
  `fechcreacion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor`
--

CREATE TABLE `profesor` (
  `id` int(150) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefono` varchar(100) NOT NULL,
  `especialidad` varchar(100) NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `fechcreacion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesores`
--

CREATE TABLE `profesores` (
  `Id_profesor` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Apellido_paterno` varchar(100) NOT NULL,
  `Apellido_materno` varchar(100) DEFAULT NULL,
  `Correo` varchar(120) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Especialidad` varchar(100) DEFAULT NULL,
  `Fecha_creacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `profesores`
--

INSERT INTO `profesores` (`Id_profesor`, `Nombre`, `Apellido_paterno`, `Apellido_materno`, `Correo`, `Telefono`, `Especialidad`, `Fecha_creacion`) VALUES
(2147483647, 'anallely', 'cruz', 'xingu', 'anallelycx@gmail.com', '722455432', 'enseñanza de lenguas extrangeras', '2025-12-25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tutores`
--

CREATE TABLE `tutores` (
  `Id_tutor` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Apellido_paterno` varchar(100) NOT NULL,
  `Apellido_materno` varchar(100) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Correo` varchar(120) DEFAULT NULL,
  `Relacion_alumno` varchar(50) DEFAULT NULL,
  `Id_asistencia` int(11) DEFAULT NULL,
  `Foto` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tutores`
--

INSERT INTO `tutores` (`Id_tutor`, `Nombre`, `Apellido_paterno`, `Apellido_materno`, `Telefono`, `Correo`, `Relacion_alumno`, `Id_asistencia`, `Foto`) VALUES
(1, 'juanito', 'pro', 'player', '7229991212', 'suputamadre21@gmail.com', 'papa', 2, 'sigma');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `Id_usuario` int(11) NOT NULL,
  `Usuario` varchar(50) NOT NULL,
  `Contrasena` varchar(255) NOT NULL,
  `Rol` varchar(50) DEFAULT NULL,
  `Id_profesor` int(11) DEFAULT NULL,
  `Id_alumno` int(11) DEFAULT NULL,
  `Id_tutor` int(11) DEFAULT NULL,
  `Fecha_creacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`Id_usuario`, `Usuario`, `Contrasena`, `Rol`, `Id_profesor`, `Id_alumno`, `Id_tutor`, `Fecha_creacion`) VALUES
(2147483647, 'p-auto', 'adqwer12', 'checador', 2147483647, 1, 1, '2025-12-01'),
(123456, '[user1]', '[boli234]', '[vigilante]', 0, 0, 0, '0000-00-00');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumnos`
--
ALTER TABLE `alumnos`
  ADD PRIMARY KEY (`Id_alumno`),
  ADD KEY `fk_alumno_grupo` (`Id_grupo`),
  ADD KEY `fk_alumno_tutor` (`Id_tutor`);

--
-- Indices de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `asistencias`
--
ALTER TABLE `asistencias`
  ADD PRIMARY KEY (`Id_asistencia`);

--
-- Indices de la tabla `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `grupos`
--
ALTER TABLE `grupos`
  ADD PRIMARY KEY (`Id_grupo`);

--
-- Indices de la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD PRIMARY KEY (`Id_horario`);

--
-- Indices de la tabla `incidencias`
--
ALTER TABLE `incidencias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `padre`
--
ALTER TABLE `padre`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `profesor`
--
ALTER TABLE `profesor`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asistencias`
--
ALTER TABLE `asistencias`
  MODIFY `Id_asistencia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `horarios`
--
ALTER TABLE `horarios`
  MODIFY `Id_horario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
