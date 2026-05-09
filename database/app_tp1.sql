-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-05-2026 a las 22:55:58
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
-- Base de datos: `app_tp1`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE `configuracion` (
  `id` int(11) NOT NULL,
  `dias_expiracion` int(11) DEFAULT NULL,
  `max_imagen` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id`, `dias_expiracion`, `max_imagen`) VALUES
(1, 60, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_noticias`
--

CREATE TABLE `historial_noticias` (
  `id` int(11) NOT NULL,
  `noticia_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `estado_anterior` varchar(50) DEFAULT NULL,
  `estado_nuevo` varchar(50) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historial_noticias`
--

INSERT INTO `historial_noticias` (`id`, `noticia_id`, `usuario_id`, `estado_anterior`, `estado_nuevo`, `fecha`) VALUES
(126, 56, 15, 'Creada', 'Borrador', '2026-05-06 17:36:21'),
(127, 57, 15, 'Creada', 'Borrador', '2026-05-06 17:39:12'),
(128, 58, 15, 'Creada', 'Borrador', '2026-05-06 17:47:51'),
(129, 59, 15, 'Creada', 'Borrador', '2026-05-06 17:50:00'),
(130, 60, 15, 'Creada', 'Borrador', '2026-05-06 17:51:56'),
(131, 56, 15, 'Borrador', 'Lista para Validación', '2026-05-06 18:13:57'),
(132, 56, 16, 'Lista para Validación', 'Publicada', '2026-05-06 18:14:25'),
(133, 57, 15, 'Borrador', 'Lista para Validación', '2026-05-06 18:15:16'),
(134, 58, 15, 'Borrador', 'Lista para Validación', '2026-05-06 18:15:27'),
(135, 59, 15, 'Borrador', 'Lista para Validación', '2026-05-06 18:16:37'),
(136, 58, 16, 'Lista para Validación', 'Para Corrección', '2026-05-06 18:17:31'),
(137, 58, 15, 'Para Corrección', 'Lista para Validación', '2026-05-06 18:18:34'),
(138, 58, 16, 'Lista para Validación', 'Publicada', '2026-05-06 18:20:07'),
(139, 59, 16, 'Lista para Validación', 'Publicada', '2026-05-06 18:20:12'),
(140, 61, 15, 'Creada', 'Borrador', '2026-05-08 09:48:06'),
(141, 62, 15, 'Creada', 'Borrador', '2026-05-08 09:57:46'),
(142, 61, 15, 'Borrador', 'Anulada', '2026-05-08 09:58:23'),
(143, 62, 15, 'Borrador', 'Lista para Validación', '2026-05-08 10:00:02'),
(144, 63, 15, 'Creada', 'Borrador', '2026-05-08 10:04:23'),
(145, 62, 16, 'Lista para Validación', 'Para Corrección', '2026-05-08 10:05:23'),
(146, 63, 15, 'Borrador', 'Lista para Validación', '2026-05-08 10:06:14'),
(147, 63, 16, 'Lista para Validación', 'Para Corrección', '2026-05-08 10:06:42'),
(148, 63, 15, 'Para Corrección', 'Borrador', '2026-05-08 10:07:21'),
(149, 63, 15, 'Borrador', 'Lista para Validación', '2026-05-08 11:12:38'),
(150, 63, 16, 'Lista para Validación', 'Publicada', '2026-05-08 11:13:07'),
(154, 65, 15, 'Creada', 'Borrador', '2026-05-08 19:50:27'),
(155, 65, 15, 'Borrador', 'Lista para Validación', '2026-05-08 19:51:42'),
(156, 57, 16, 'Lista para Validación', 'Para Corrección', '2026-05-08 19:52:44'),
(157, 65, 16, 'Lista para Validación', 'Publicada', '2026-05-08 19:52:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `noticias`
--

CREATE TABLE `noticias` (
  `id` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  `estado` varchar(50) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `imagen` varchar(255) DEFAULT NULL,
  `autor_id` int(11) NOT NULL,
  `fecha_publicacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `noticias`
--

INSERT INTO `noticias` (`id`, `titulo`, `descripcion`, `estado`, `fecha_creacion`, `imagen`, `autor_id`, `fecha_publicacion`) VALUES
(56, 'El regreso más esperado del K-Pop: todo sobre la nueva era de BTS!', 'BTS inicia oficialmente su nueva era el 20 de marzo con un álbum que consolida su \"madurez artística\" tras el servicio militar.\r\nLa gira mundial 2026 revelará su itinerario el 14 de enero, marcando el regreso del máximo referente del K-Pop a los escenarios.\r\nTras la confirmación del regreso de BTS para el próximo 20 de marzo, fanáticos del K-Pop al rededor del mundo centraron su atención en los detalles técnicos y narrativos de esta nueva etapa.\r\n\r\nLa boyband más influyente de la última década vuelve tras completar su servicio militar obligatorio, un proceso que, lejos de debilitarlos, ha fortalecido su narrativa de resiliencia y hermandad.\r\n\r\nSu agencia, BigHit Entertainment, reveló que el próximo álbum contará con 14 canciones que fueron celosamente producidas y grabadas antes de que los miembros finalizaran sus deberes militares.\r\n\r\nPero este lanzamiento no es solo un disco más, sino el manifiesto de un grupo que ha superado la brecha del servicio obligatorio con éxito para asegurar una transición sonora hacia lo que BigHit describió como una \"etapa de madurez artística\".\r\n\r\nEl anuncio de la preventa para el 16 de enero ha desatado una fiebre digital entre ARMY, quienes esperan el regreso grupal tras sus diversos proyectos solistas, sirviendo como el preludio necesario para el anuncio masivo del 14 de enero: las fechas de su gira mundial.\r\nCon el 2026 como escenario, el septeto se prepara para demostrar por qué su legado en el K-Pop es más sólido que nunca, mezclando la veteranía de sus miembros con una frescura sonora nunca antes vista.\r\n', 'Publicada', '2026-05-06 20:36:21', '1778099781_d88982b9c4ff03f3e9f2.jpg', 15, '2026-05-06 21:14:25'),
(57, 'BTS reveló la lista de canciones de su nuevo álbum ‘ARIRANG’: 14 temas', 'A solo 15 días del lanzamiento, se conocieron los títulos de las canciones de su nuevo álbum producido por figuras como Diplo y Kevin Parker.\r\nLa expectativa crece tras el estreno del tráiler oficial en Netflix, que transmitirá el histórico concierto de regreso desde Seúl.\r\nBTS confirmó el listado de canciones para su esperado álbum ARIRANG, que saldrá a la venta el próximo 20 de marzo de 2026.\r\n\r\nLa noticia llega 15 días antes del lanzamiento, una espera que parece interminable para las ARMYs —el club de fans oficial del grupo— tras años de esperar el regreso del septeto más importante del K-pop.\r\n\r\nTras meses de teorías y mucha expectativa por el fin del servicio militar de sus integrantes, la expectativa global alcanzó su punto máximo tras la confirmación de las catorce pistas que componen esta obra de estudio.\r\n\r\nEste álbum no es un lanzamiento más, sino la consolidación de una nueva era que, según RM (líder y rapero del grupo), promete una exploración sonora única incluso para ellos.\r\nCon este lanzamiento, los siete integrantes están listos para retomar su lugar en la cima de la industria y demostrar que su vigencia sigue intacta.\r\n\r\nEl simbolismo detrás de \"ARIRANG\"\r\nEl título elegido posee una carga emocional profunda para el grupo y su país. \"Arirang\" es la canción folclórica más representativa de Corea, considerada un himno de resistencia, unidad y orgullo nacional.\r\nEste concepto no es ajeno al grupo: en 2018, BTS ya había realizado un recordado cover de esta pieza durante una presentación especial. Hoy, sus fans recuperan aquella versión en redes sociales para anticipar lo que será esta nueva interpretación moderna.\r\nLa elección de este nombre sugiere un \"regreso a las raíces\" después de conquistar el mercado global. Con este concepto, se especula que los miembros buscan honrar su identidad nacional mientras inician una etapa artística totalmente renovada.\r\n\r\nColaboraciones de élite y el rol creativo de los miembros\r\nEl álbum destaca por el alto nivel de participación de los integrantes en la producción. RM figura como compositor en 13 de las 14 pistas, mientras que SUGA, j-hope y Jung Kook figuran en la autoría de gran parte del repertorio.\r\nPara este regreso, Bangtan se rodeó de productores como Ryan Tedder, Kevin Parker y Mike WiLL Made-It. Además, el disco cuenta con el regreso de Pdogg, el productor principal que trabajó con ellos desde el inicio y es responsable de sus mayores éxitos.\r\n\r\nDiplo, quien también colaboró en el proyecto, describió el disco en una entrevista reciente como \"una locura absoluta\". Esta mezcla de talentos sugiere una exploración sonora que busca romper cualquier molde previo dentro del género pop.\r\nPara lograr este sonido, los siete integrantes convivieron durante meses en una casa en Los Ángeles. Esta convivencia permitió capturar una esencia grupal que no se veía desde hace seis años.\r\n\r\nEl último álbum completo de los Bangtan Boys, Be, debutó en el No. 1 del Billboard 200 en 2020 y produjo éxitos que encabezaron el Billboard Hot 100 como “Life Goes On” y “Dynamite”.', 'Para Corrección', '2026-05-06 20:39:12', '1778099952_8af21bd3893e52492501.jpg', 15, '2026-05-06 17:39:12'),
(58, 'BTS World Tour 2026', 'La boy band confirmó su regreso a los escenarios con una gira mundial histórica de 79 shows en 34 ciudades. América Latina vuelve a estar en el mapa y Buenos Aires tendrá dos fechas clave en octubre de 2026, en el regreso del grupo completo luego del servicio militar.\r\nEl fenómeno global del k-pop está oficialmente de vuelta. BTS anunció su esperado World Tour 2026, la primera gira conjunta desde Permission to Dance on Stage (2021-2022), y la noticia sacudió tanto a la industria musical como a su base de fans, ARMY, en todo el mundo.\r\n\r\nEl tour llega acompañado por un nuevo disco —el primero como grupo desde Proof (2022)— y marca el regreso definitivo del septeto luego de cumplir con el servicio militar obligatorio en Corea del Sur. Con fechas confirmadas en Asia, América, Europa y Oceanía, la gira consolida a BTS como uno de los pocos actos capaces de llenar estadios a escala planetaria.\r\nEl regreso de BTS: una gira global tras cuatro años de pausa\r\nLa gira empezará el 9 de abril de 2026 en Goyang, Corea del Sur, apenas 20 días después del lanzamiento del nuevo álbum, previsto para el 20 de marzo, según confirmó BigHit Music. Desde allí, BTS recorrerá Japón, Estados Unidos, Canadá, Europa, América Latina y el sudeste asiático.\r\n\r\nEl tour incluye 79 conciertos, un número inédito para la banda, y representa su retorno como formación completa luego de la pausa iniciada en 2022. Durante ese período, cada integrante desarrolló proyectos solistas mientras cumplía con las obligaciones militares exigidas por la legislación surcoreana. El último en finalizar ese proceso fue SUGA, en junio pasado.\r\nAmérica Latina en el centro del mapa: cuándo toca BTS en Argentina\r\nLa confirmación de BTS en América Latina fue uno de los anuncios más celebrados por los fans de la región. La banda se presentará en Bogotá, Lima, Santiago de Chile, Buenos Aires y São Paulo, con fechas consecutivas que anticipan una gira intensa.\r\nEn el caso de la Argentina, BTS tocará los viernes 23 y sábado 24 de octubre de 2026, en recintos que aún no fueron confirmados. El anuncio sacudió la escena musical local, no solo por la magnitud del evento, sino por el antecedente emotivo: en 2022, Jin se presentó en Buenos Aires junto a Coldplay, donde interpretó por primera vez en vivo The Astronaut antes de alistarse.\r\nBTS, historia reciente y un fenómeno que no se detiene\r\nDesde su debut, BTS rompió barreras culturales y lingüísticas, encabezó el Billboard Hot 100 con temas como Dynamite y Butter, y llenó estadios como el SoFi de Los Ángeles o el Allegiant de Las Vegas. Su última gira alcanzó a más de 4 millones de espectadores entre shows presenciales y transmisiones.\r\n\r\nEl CEO de HYBE, Lee Jae-sang, había anticipado que el grupo necesitaría tiempo para descansar y reinventarse tras el servicio militar. Todo indica que ese proceso desemboca ahora en una nueva etapa artística, con un disco inédito y una gira que vuelve a poner al k-pop en el centro de la escena global.\r\n', 'Publicada', '2026-05-06 20:47:51', '1778100471_d3a58ffb9c8d9aa4a536.jpg', 15, '2026-05-06 21:20:07'),
(59, 'BTS: todo lo que hay que saber sobre sus shows en la Argentina', 'La banda más importante del K.Pop coreano confirmó sus fechas en Latinoamérica.\r\nTambién, el modo y los días para sacar los tickets.\r\nHoy, la banda de K-Pop más importante del mundo, BTS, confirmóon los estadios y las coordenadas de venta para la esperadísima etapa latinoamericana del BTS WORLD TOUR ‘ARIRANG’.\r\n\r\nLa gira por Sudamérica de BTS arrancará el viernes 2 de octubre con dos noches al hilo en Bogotá, Colombia (Estadio Nemesio Camacho El Campín), para luego seguir por el Estadio San Marcos en Lima, Perú; el Estadio Nacional en Santiago, Chile; y tendrá tres noches en el Estádio do MorumBIS en São Paulo, Brasil.\r\n\r\nCoronarán este inmenso recorrido al marcar un hito absoluto: sus primeros shows en la historia de Buenos Aires, Argentina, presentándose en el Estadio Único de La Plata, producidos por DF Entertainment.\r\nCómo comprar las entradas para BTS\r\nLas entradas para los shows de BTS en la Argentina estarán disponibles en preventa con ARMY MEMBERSHIP a partir del martes 7 de abril a partir de las 10 de la mañana, a través de allaccess.com con todos los medios de pago. La venta general se habilitará el viernes 10 de abril, también a las 10.\r\nQuienes tengan la membresía GLOBAL deben registrarse sí o sí para la preventa en Weverse antes del jueves 2 de abril a las 16. Solo quienes hagan este paso previo podrán sumarse a la fila virtual. Al momento de comprar, el sistema les pedirá un número de ARMY MEMBERSHIP de 9 dígitos (que empieza con BA) para destrabar el acceso a las entradas.\r\n\r\nBTS: cómo es el tour\r\nEste tramo es parte de lo que ya se perfila como la gira de K-pop más grande de todos los tiempos y la más imponente en la carrera del grupo. El ansiado regreso a los escenarios (2026-2027) abarcará 34 regiones y más de 80 shows alrededor del mundo.\r\nPara asegurar una experiencia inigualable, la producción contará con un diseño de escenario inmersivo de 360 grados, ubicando a los fans en el centro de la escena y ampliando la capacidad general de los recintos.\r\n\r\nEl furor por ver a RM, Jin, SUGA, J-hope, Jimin, V y Jungkook en vivo no tiene precedentes. Tras salir a la venta, BTS agotó las 41 fechas de estadios en Norteamérica, Europa y el Reino Unido, vendiendo casi 2.4 millones de tickets. La demanda fue una locura total, lo que obligó a sumar nuevas funciones sold out en Tampa, Stanford y Las Vegas.\r\nLa gira mundial, que marca su primer tour juntos desde el hito de \"Permission to dance on Stage\" en 2021-2022, arranca el 9 de abril en Goyang, Corea del Sur. Luego de pasar por nuestro continente, el grupo desembarcará en Asia y Australia a fines de año y principios del próximo.\r\n\r\nBTS: las fechas de la gira latinoamericana\r\nViernes 2 de octubre: Bogotá, Colombia, Estadio Nemesio Camacho El Campín.\r\n\r\nSábado 3 de octubre: Bogotá, Colombia, Estadio Nemesio Camacho El Campín.\r\n\r\nViernes 9 de octubre: Lima, Perú, Estadio San Marcos.\r\n\r\nSábado 10 de octubre: Lima, Perú, Estadio San Marcos.\r\n\r\nViernes 16 de octubre: Santiago, Chile, Estadio Nacional.\r\n\r\nSábado 17 de octubre: Santiago, Chile, Estadio Nacional.\r\n\r\nViernes 23 de octubre: Buenos Aires, Argentina, Estadio Único de La Plata.\r\n\r\nSábado 24 de octubre: Buenos Aires, Argentina, Estadio Único de La Plata.\r\n\r\nMiércoles 28 de octubre: San Pablo, Brasil, Estádio do MorumBIS.\r\n\r\nViernes 30 de octubre: San Pablo, Brasil, Estádio do MorumBIS\r\n\r\nSábado 31 de octubre: San Pablo, Brasil, Estádio do MorumBIS.', 'Publicada', '2026-05-06 20:50:00', '1778100600_c2ffb3dd4217e7588426.jpg', 15, '2026-05-06 21:20:12'),
(60, 'BTS suma una tercera fecha para Argentina!', 'Hay furor por la presencia de la banda de K-pop en el Estadio Único de La Plata.\r\nTodo lo que hay que saber para no llevarse sorpresas con la compra.\r\nLa cuenta regresiva terminó. Este martes 7 de abril comenzó la preventa de entradas para los shows de BTS en la Argentina, uno de los recitales más esperados del año. El grupo se presentará el 23 y 24 de octubre en el Estadio Único de La Plata y, después de años de espera, miles de fans ya se preparan para intentar conseguir un lugar. Y como se agotó la preventa para esos días, la banda anunció una nueva fecha: el miércoles 21 de octubre.\r\n\r\nEl regreso de RM, Jin, Suga, J-Hope, Jimin, V y Jungkook tiene un condimento porque será la primera vez que el grupo se presente en el país. Después de la pausa por el servicio militar obligatorio, la banda vuelve con la gira Arirang, un tour mundial que recorrerá más de 30 ciudades y que ya agotó entradas en varios países apenas salieron a la venta.\r\n\r\nLa expectativa es tan grande que, desde anoche, las redes sociales se llenaron de tutoriales, consejos y mensajes de fans tratando de organizarse para entrar a la fila virtual.\r\n\r\nEn foros y grupos de ARMY, muchos recomiendan conectarse con anticipación, tener abierta la cuenta de All Access y chequear que el número de membresía de Weverse esté cargado correctamente para no perder tiempo cuando se habilite el sistema.\r\nCuándo es la tercera fecha\r\nEl recital que agregaron será dos días antes del que iba a ser el primero. Así que quienes quieran ser los primeros en verlos (por ahora, porque puede que agreguen una cuarta fecha. ¿Cuándo sería? ¿El domingo?) podrán ponerse en la fila de la preventa, que arranca este miércoles 8 de abril.\r\n\r\nEntonces, a recordar que la Preventa Army para la nueva fecha a partir del miércoles 8 de abril empieza a las 10 am. Y que la venta general para las tres fechas es a partir del viernes 10 de abril, siempre a las 10 am.\r\n\r\nCómo comprar las entradas para BTS en Argentina\r\nLa preventa exclusiva comenzó hoy a las 10 de la mañana y está destinada únicamente a quienes tengan la membresía oficial ARMY Membership y se hayan registrado previamente en Weverse. Esa instancia estará disponible hasta mañana a las 22.\r\n\r\nQuienes no hayan completado el registro antes del 2 de abril deberán esperar a la venta general, que abrirá como dijimos el viernes 10 de abril, también desde las 10, a través de All Access.\r\n\r\nCómo funciona la preventa de Weverse\r\nPara acceder a la preventa exclusiva no alcanza con tener una cuenta en Weverse. Los fans tuvieron que completar una serie de pasos previos para quedar habilitados:\r\n\r\nTener activa la membresía oficial ARMY Membership en Weverse Shop.\r\nHaber realizado el pre-registro entre el 27 de marzo y el 2 de abril de 2026.\r\nElegir hasta tres ciudades dentro del tour para participar de la preventa.\r\nContar con el número de membresía de nueve dígitos que comienza con las letras “BA”. Ese código es obligatorio para acceder a la fila virtual.\r\n\r\n\r\nSolo quienes hayan cumplido con todos esos requisitos podían participar hoy de la preventa (que se agotó) y acceder al sistema antes de la venta general. Mañana miércoles pueden sacar entradas para el recital que se agregó.\r\n\r\nCuánto valen las entradas\r\nLos precios ya fueron confirmados. Las cabeceras Norte y Sur cuestan $225.000 más cargo por servicio. El campo sale $350.000, mientras que las plateas A y B tienen un valor de $390.000. Las ubicaciones preferenciales llegan a $425.000, sin contar los cargos adicionales de la ticketera.\r\nLa productora, además, advirtió que podrían registrarse demoras por la enorme cantidad de usuarios que intentarán comprar entradas al mismo tiempo.\r\n\r\nCuánto cuestan y qué incluyen las entradas VIP\r\nAdemás de las entradas tradicionales, los fans también podrán intentar conseguir el paquete VIP, la opción más exclusiva para ver a BTS en la Argentina. El valor confirmado es de $1.560.000 y se vende por separado dentro de la misma preventa.\r\n\r\nEl paquete incluye una entrada de campo, acceso a la prueba de sonido previa al show, ingreso anticipado al estadio, prioridad para comprar merchandising oficial antes del recital, una credencial con lanyard y un regalo exclusivo para los asistentes. También habrá un sector de check-in especial y staff dedicado para quienes compren esa opción.\r\n', 'Borrador', '2026-05-06 20:51:56', NULL, 15, '2026-05-06 17:51:56'),
(61, 'Todas las veces que BTS habló de Argentina: la manifestación de un deseo que tardó años en cumplirse', 'De menciones lejanas a realidad: el largo camino de las ARMY argentinas para recibir al septeto más esperado.\r\nBuenos Aires se prepara para recibir el tour ARIRANG con entradas totalmente agotadas en su etapa de preventa.\r\nLa relación entre BTS y el público argentino ha sido, durante mucho tiempo, una historia de amor a la distancia construida a base de señales digitales y una paciencia inquebrantable.\r\n\r\nPara las seguidoras locales, mejor conocidas como ARMY, ver el nombre del país en un mapa de gira oficial no es simplemente una noticia de espectáculos; es la culminación de una espera que por momentos pareció eterna.\r\n\r\nDurante años, la incertidumbre fue la única constante. Mientras otros mercados regionales aseguraban visitas recurrentes, en Argentina el fandom se alimentaba de menciones aisladas en transmisiones en vivo que mantenían viva la esperanza de un encuentro real.\r\n\r\nEsa fe se vio puesta a prueba con el anuncio del receso grupal por el servicio militar obligatorio. Con el grupo en la cima de su popularidad y más de diez años de trayectoria, el temor a que la oportunidad se hubiera esfumado para siempre se volvió una sombra constante.\r\n\r\nSin embargo, el regreso de los siete integrantes y el anuncio de su gira mundial para 2026 cambió el panorama. Lo que muchos imaginaban como un recorrido por los destinos de siempre dio un giro cuando Buenos Aires apareció con dos fechas confirmadas.\r\n\r\nEsta noticia transforma años de resignación en una euforia colectiva difícil de describir. Es el cierre de un círculo para quienes han recolectado cada pequeño gesto del grupo hacia el país como si fuera una promesa de cumplimiento futuro.\r\nLas giras mundiales y el mapa de Latinoamérica\r\nHistóricamente, los grupos de K-pop parecieran evadir el territorio argentino, principalmente por la falta de promotores locales dispuestos a asumir las altas inversiones necesarias para cubrir los costos de los estadios y la logística de grupos grandes, además de la inestabilidad económica local.\r\n\r\nEsta exclusión forzó contemplar viajes a países vecinos como Chile o Brasil. La idea de que un grupo de la magnitud de BTS nunca pisaría suelo nacional era una creencia arraigada, alimentada por años de ser ignorados en los calendarios oficiales.\r\nA pesar de las barreras, la escena local fue pavimentada por pioneros como Super Junior en 2013. A ellos se sumaron MONSTA X, GOT7, P1Harmony, y más recientemente RIIZE en el Lollapalooza 2026, demostrando que el público argentino es un mercado consolidado y no una moda pasajera.\r\n\r\nAsí, la llegada de los referentes máximos del género se percibe ahora como una validación necesaria. Es el reconocimiento a un fandom que, a pesar de la distancia geográfica y los desafíos económicos, se ha mantenido como uno de los más fieles y activos del mundo.\r\n\r\nEl archivo de la esperanza: menciones que acortaron la distancia\r\nEl primer contacto significativo ocurrió en 2014, cuando un BTS recién debutado grabó un saludo especial para Argentina. En aquel video, los integrantes demostraron su conocimiento sobre la cultura local mencionando el asado y figuras del fútbol, dejando claro que el país ya estaba en su mapa mental desde sus inicios.\r\nHacia 2018, durante el detrás de escena del video musical de Airplane pt.2, SUGA profundizó en este interés. El rapero explicó que la atmósfera latinoamericana de la canción le generaba deseos genuinos de visitar Argentina, reafirmando que la identidad cultural del país era una fuente de inspiración creativa para el grupo.\r\nLa conexión se fortaleció con una colaboración promocional junto a Netflix para el estreno de su documental y un esperado regreso musical con un saludo personalizado.\r\nEn 2023, durante un episodio del programa de SUGA, Suchwita, Jin recordó su visita a Buenos Aires para el concierto de Coldplay. El mayor del septeto destacó que, a pesar de las extenuantes horas de viaje, la energía del público fue algo nunca antes visto en su carrera y un motor de inspiración fundamental.\r\nLa confirmación final llegó de la mano de j-hope en una de sus recientes transmisiones en vivo por Instagram. Al leer el comentario de una fan sobre el anuncio de la gira, el artista se mostró visiblemente emocionado y exclamó: \"¡Al fin vamos a ir!\", sellando así una promesa de más de diez años que finalmente se concretará en octubre.\r\n\r\nUn despliegue visual y coreográfico sin precedentes\r\nContra todo pronóstico, la gira de 2026 incluyó presentaciones en el Estadio Único de La Plata. Debido a la demanda arrasadora, la organización confirmó una tercera fecha para octubre, logrando agotar todas las localidades en cuestión de horas.\r\nPara muchas fans, especialmente quienes crecieron con su música, este evento representa la caída de la última barrera que separaba su realidad cotidiana de sus ídolos globales.\r\n\r\nPero el desembarco de BTS no solo destaca por su importancia emocional, sino por una apuesta técnica revolucionaria para el país. Se ha confirmado que el show contará con un diseño de escenario 360 grados, permitiendo una visión periférica desde cualquier punto del estadio.\r\nLa producción incluye pantallas LED de primera calidad y última generación que cubrirán gran parte de la estructura, asegurando una experiencia inmersiva única. Este despliegue visual busca que la conexión entre el grupo y el público sea total, sin importar la ubicación.\r\nA esto se suma la complejidad de sus coreografías, que serán ejecutadas con una precisión milimétrica bajo un sistema de iluminación nunca antes visto en Argentina; un evento que sin duda redefinirá la escala de los espectáculos en vivo.\r\n\r\nLa espera terminó, y lo que comenzó como un sueño lejano, se materializará en tres noches donde el ruidoso fervor argentino y el talento de BTS se volverán uno solo.\r\n', 'Anulada', '2026-05-08 12:48:06', '1778244486_67f2ec9b5fc4a4a1d977.jpg', 15, '2026-05-08 09:48:06'),
(62, 'Contra viento y marea, BTS da inicio a su gira mundial bajo a una fuerte lluvia!', 'El grupo BTS dio el primero de los conciertos de su gira mundial, este jueves en Corea del Sur, sin importar que llovió copiosamente, por lo que su ARMY tuvo que cubrirse con capas y paraguas.\r\nTras su exitoso y esperado regreso, BTS arrancó su gira mundial con el primero de sus conciertos en Goyang, Corea del Sur, y sin importar la fuerte lluvia que cayó, la noche de este jueves se llenó de música, baile y fiesta en el escenario y el graderío con la presencia de las ARMY bien cubiertas con capas y paraguas.\r\nBTS inicia su gira mundial de conciertos con el primer show en Corea del Sur\r\nLas megaestrellas del k-pop BTS iniciaron este jueves una gira global que incluye varias paradas en América Latina, respaldados por el éxito de su nuevo álbum en las listas mundiales y su gigantesco concierto de regreso en el corazón de Seúl.\r\n\r\nCon 85 actuaciones programadas en 34 ciudades de todo el mundo, la expectación es tal que los analistas se han aventurado a estimar que podría incluso superar en ingresos al reciente Eras Tour de Taylor Swift.\r\nLos llamados \"reyes\" del pop coreano pasarán por Asia, Norteamérica, Europa y Latinoamérica, con shows en la Ciudad de México (7, 9 y 10 de mayo en el Estadio GNP), Bogotá, Lima, Santiago, Buenos Aires y Sao Paulo, además de Madrid.\r\n\r\nEl primer show de la gira \"¡empezó!\", comentó este jueves un responsable de HYBE, la discográfica del grupo, a AFP.\r\nLos fans se concentraron en Goyang, a unos 16 km al noroeste de Seúl, que engalanó para la ocasión varios de sus sitios emblemáticos, como el Parque del Lago Ilsan, con iluminación del color púrpura emblemático de BTS.\r\nSin importar la lluvia, BTS arma una fiesta internacional en el primer concierto de su gira \'Arirang\'\r\nLos asistentes al primer concierto de la gira Arirang de BTS, muchos de ellos vestidos de morado, hicieron fila delante del estadio pese a la lluvia. Una multitud que daba cuenta del alcance global de los surcoreanos: entre los que esperaban se oían conversaciones en inglés, español, chino y japonés.\r\n\"Creo que fue el boleto más difícil que haya tenido nunca. Incluso en Corea, con un internet rápido, yo estaba en el puesto 80.000 de la fila\", contó a la AFP Evelyn Soto Villarreal, una mexicana de 27 años que reside en Busan.\r\n\r\n\"La lluvia no va a pararnos\", dijo Czarina Marushka Geronimo, de 33 años. \"Volamos desde Filipinas solo para ver el concierto, estamos muy nerviosos\".\r\n\r\nEn Goyang, donde nació el líder del grupo, RM, hay programados además otros dos conciertos el 11 y el 12 de abril. Para cada uno, se esperan unos 40.000 espectadores.\r\nBTS quiere una cita con \"el público de todo el mundo\"\r\n\"Queremos encontrarnos con el público de todo el mundo lo antes posible y dado que esta es nuestra primera gira mundial en mucho tiempo, queremos experimentar de primera mano la cultura y el ambiente de los conciertos de cada región\", dijo este jueves Jin, uno de los siete integrantes de BTS.\r\n\r\nConsiderada a menudo como la mayor banda masculina del mundo, BTS se reunió de forma íntegra en marzo pasado sobre el escenario por primera vez luego de una pausa de casi cuatro años, para que sus siete miembros cumplieran el servicio militar obligatorio de Corea del Sur.\r\nSu concierto de regreso desde la plaza Gwanghwamun, frente al histórico palacio de Gyeongbokgung de Seúl, congregó a unos cien mil fans, según su sello discográfico.\r\n\r\nSu transmisión en Netflix atrajo a 18.4 millones de espectadores en todo el planeta, informó el gigante del streaming.\r\n\'Arirang\', un nuevo capítulo para BTS\r\nSu nuevo álbum ARIRANG fue presentado un día antes del concierto en Seúl como un reflejo de la identidad coreana de la banda. Toma su nombre de una canción folclórica tradicional que evoca la nostalgia y la separación, y es considerada como el himno nacional oficioso del país asiático.\r\n\r\nCon este disco, el grupo quiso ir más allá de los temas del dolor adolescente y los conflictos internos para adentrarse \"en un ámbito en el que reflexionan más profundamente\" sobre sí mismos, señaló a la AFP Kim Jeong-seob, autor del libro El universo de BTS.\r\nAl describir la gira como el inicio de un \"nuevo capítulo\", Kim Jeong-seob, también especialista en cultura del entretenimiento coreana en la Universidad de Sungshin en Seúl, consideró que los problemas mundiales actuales, como las guerras y los conflictos étnicos y religiosos, podrían reflejarse en su trabajo.', 'Para Corrección', '2026-05-08 12:57:46', NULL, 15, '2026-05-08 09:57:46'),
(63, 'BTS visita el Palacio Presidencial de México', 'iudad de México (AP) — Los integrantes de BTS sorprendieron el miércoles a sus fans mexicanos al asomarse por un balcón del Palacio Nacional acompañados de la mandataria mexicana Claudia Sheinbaum, un día antes de sus conciertos programados en la capital.\r\n\r\nEn cuestión de horas lograron convocar a cerca de 50.000 personas, según compartió Sheinbaum en su cuenta de X. Las fans gritaron de emoción y muchos también lloraron cuando los siete integrantes salieron con ella en uno de los balcones con vista al Zócalo, la principal plaza de México.\r\n\r\n“Muchas gracias por recibirnos”, dijo Kim Nam-joon conocido como RM. “Nos morimos de ganas por el concierto de mañana. ¡Vamos a divertirnos mañana! ¡Te amo, te quiero, muchas gracias!”\r\n\r\nKim Tae-hyung, conocido como V, le siguió en español.\r\n\r\n“Hola, no hablo español muy bien, pero voy a intentarlo, ¿nos extrañaron? Nosotros extrañamos muchísimo más a México, la energía aquí es increíble”, dijo. “Muchas gracias por amarnos tanto, nos vemos la próxima vez, adiós”.\r\n\r\nEn la conferencia matutina, Sheinbaum anunció que recibiría a la agrupación y horas después, la Secretaría de Cultura de México invitó a los integrantes del Army a saludar a su banda favorita de k-pop a las 17:00 en el Zócalo.\r\n\r\n“Ya les dije que tienen que regresar el próximo año”, dijo Sheinbaum desde el balcón junto a la banda.\r\n\r\nLa presidenta también celebró el encuentro en su cuenta de X.\r\n\r\n“Me da mucha alegría haber podido darles este momento de júbilo”, señaló. “El grupo transmite en sus canciones mensajes positivos que fomentan una cultura de paz e inclusión”.\r\n\r\nLa superbanda surcoreana se presentará el jueves en el Estadio GNP Seguros, en la primera de sus tres fechas con entradas agotadas en el país. El estadio tiene una capacidad de 65.000 asistentes.\r\n\r\nSheinbaum había intercedido por los fans de BTS enviando una carta al presidente de Corea del Sur cuando los boletos se agotaron y muchos denunciaron reventa. La presidenta también dijo que se había puesto en contacto con los organizadores para ver si podían abrir más fechas de su gira mundial Arirang.\r\n\r\nLos fans mexicanos habían protestado por los costos poco claros de los boletos y las reventas, lo que llevó a una sanción contra Ticketmaster México.\r\n\r\n“No es justo que en México, siendo un fan tan, tan grande, tenga tantos problemas con los boletos cuando en Corea pueden ellos disfrutarlos por menos costo”, dijo la diseñadora de modas Berenice Jaramillo, de 46 años, una de las Army que asistieron al Zócalo. “No alcancé boleto, por eso para mí esto es un regalo súperespecial”.\r\n\r\nMonserrat Herrera, de 25 años, tenía un tatuaje con el logotipo de la banda que se hizo hace dos años. Se vino corriendo desde su trabajo de recepcionista en el Estado de México e hizo una hora de camino. Tampoco tenía boleto para los conciertos, pero su saludo le pareció “la mejor experiencia”.\r\n\r\n“Muy bien, porque México es el país de Latinoamérica que más escucha BTS”, dijo.', 'Publicada', '2026-05-08 13:04:23', '1778249336_aa0bfa88506b195ec06e.avif', 15, '2026-05-08 14:13:07'),
(65, 'Así fue el primer concierto de BTS en México...', 'Tras casi una década de ausencia, la agrupación surcoreana desató la euforia en el Estadio GNP Seguros con un espectáculo que fusionó la cultura coreana con el fervor mexicano.\r\n\r\nLa noche del jueves 7 de mayo de 2026 quedará grabada en la memoria colectiva del entretenimiento en nuestro país. Tras casi una década de espera, BTS regresó a la Ciudad de México (CDMX) para ofrecer un espectáculo de más de dos horas en el Estadio GNP Seguros, logrando una convocatoria que superó los 60 mil asistentes en una jornada de euforia absoluta que confirma la relevancia económica y cultural del K-pop en la región.\r\n\r\nDesde tempranas horas, la explanada del recinto se transformó en un epicentro de color morado, donde el ARMY mexicano se congregó con banderas, lightsticks y vestuarios temáticos. La atmósfera previa al show alcanzó su punto máximo cuando miles de voces se unieron para entonar el \"Cielito Lindo\", un gesto que anticipaba la profunda conexión emocional que marcaría el resto de la velada.\r\n\r\nUn inicio explosivo y un homenaje a la hermandad cultural\r\nEl reloj marcaba las 8:15 p.m. cuando las luces se extinguieron por completo, dejando al estadio sumergido en un mar de destellos rojos. La pirotecnia anunció el inicio de “Hooligan”, el tema con el que RM, Jin, SUGA, J-hope, Jimin, V y Jungkook aparecieron finalmente sobre el escenario. El grupo, que recientemente fue recibido con honores por la presidenta Claudia Sheinbaum en Palacio Nacional, demostró desde el primer segundo por qué son considerados los máximos exponentes del fenómeno musical global.\r\n\r\n', 'Publicada', '2026-05-08 22:50:27', '1778280627_63502e3339c9da803f2f.webp', 15, '2026-05-08 22:52:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `rol_editor` tinyint(1) DEFAULT 0,
  `rol_validador` tinyint(1) DEFAULT 0,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_expira` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `password`, `rol_editor`, `rol_validador`, `reset_token`, `reset_expira`) VALUES
(15, 'Seyla ', 'editor@gmail.com', '$2y$10$SGel9WFySi4FUbv7d9w/U.CMPc3kmbBCIgkeB/awuoU23EuMW/CVG', 1, 0, NULL, NULL),
(16, 'Jael', 'validador@gmail.com', '$2y$10$YvXYA/Rhh6Cs3oRqAVX8W.NwUDaAizh2fznYZqzlg.jtMWy0AnuoK', 0, 1, NULL, NULL),
(19, 'YoonGi', 'editoryvalidador@gmail.com', '$2y$10$vxEqtQ0sglJSuAUmEn00zuibokP8YfQuF1RPSLA9YDcos/hug1riq', 1, 1, NULL, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `historial_noticias`
--
ALTER TABLE `historial_noticias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `noticias`
--
ALTER TABLE `noticias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `historial_noticias`
--
ALTER TABLE `historial_noticias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=158;

--
-- AUTO_INCREMENT de la tabla `noticias`
--
ALTER TABLE `noticias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
