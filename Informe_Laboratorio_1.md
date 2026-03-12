# INFORME DE LABORATORIO N.º 1

---

**Institución:** Tecnológico de Antioquia – Institución Universitaria  
**Laboratorio:** Laboratorio 1 – Integración Java EE y ORM Hibernate  
**Asignatura:** Ingeniería de Software II  
**Profesor:** Diego José Luis Botia  
**Estudiante:** [Nombre del estudiante]  
**Fecha:** Marzo de 2026  

---

## 1. Introducción

El presente informe documenta el desarrollo del Laboratorio 1 de la asignatura Ingeniería de Software II, cuyo propósito central consiste en integrar la plataforma Java EE con el framework de mapeo objeto-relacional (ORM) Hibernate para construir una aplicación web capaz de gestionar información de empresas almacenada en una base de datos MySQL. La práctica fue realizada siguiendo la guía proporcionada por el docente, denominada *"Using Hibernate – Arquitectura Nuevo 2026"*, la cual describe paso a paso la creación de un proyecto Java Web en NetBeans IDE con soporte de Hibernate.

Java EE (Java Enterprise Edition) es una plataforma de desarrollo que extiende las capacidades de Java SE proporcionando un conjunto de especificaciones, APIs y servicios orientados a la construcción de aplicaciones empresariales distribuidas, escalables y seguras. Entre sus componentes más utilizados se encuentran los Servlets, las páginas JSP (JavaServer Pages) y los Enterprise JavaBeans (EJB). Hibernate, por su parte, es un framework ORM de código abierto que simplifica la interacción entre las aplicaciones Java y las bases de datos relacionales. En lugar de escribir sentencias SQL de forma manual, Hibernate permite al desarrollador trabajar con objetos Java que se mapean automáticamente a las tablas de la base de datos, reduciendo significativamente la cantidad de código repetitivo y mejorando la mantenibilidad del sistema.

El objetivo del laboratorio es que el estudiante comprenda de manera práctica cómo se configura Hibernate dentro de un proyecto Java Web, cómo se generan los archivos de mapeo y las clases POJO a partir de una base de datos existente mediante ingeniería inversa, cómo se prueban consultas en el editor HQL integrado en NetBeans, y cómo se implementan operaciones de consulta, búsqueda e inserción/actualización/eliminación (CRUD) utilizando HQL, expuestas al usuario final a través de páginas JSP.

---

## 2. Objetivos

### 2.1 Objetivo general

Desarrollar una aplicación web en Java EE que utilice Hibernate como framework ORM para realizar operaciones CRUD (Crear, Leer, Actualizar y Eliminar) sobre una base de datos MySQL, integrando la capa de persistencia con la capa de presentación mediante páginas JSP.

### 2.2 Objetivos específicos

- Crear y configurar una base de datos MySQL denominada `public` con la tabla `empresa`, que servirá como fuente de datos del sistema.
- Configurar el framework Hibernate dentro de un proyecto Java Web en NetBeans IDE mediante los archivos `hibernate.cfg.xml` y `hibernate.reveng.xml`, estableciendo la conexión con el servidor MySQL local.
- Generar automáticamente las clases POJO y los archivos de mapeo XML a partir de la estructura de la base de datos, utilizando el asistente *Hibernate Mapping Files and POJOs from a Database* de NetBeans.
- Probar y validar las consultas HQL en el editor de consultas integrado de NetBeans antes de incorporarlas al código fuente de la aplicación.
- Implementar una capa de lógica de negocio que utilice HQL para realizar consultas generales y búsquedas filtradas por criterios como RUT y nombre de la empresa.
- Construir páginas JSP (consultar, buscar, guardar, modificar y borrar) que presenten los resultados de las consultas en formato tabular y permitan al usuario ejecutar las operaciones CRUD de forma interactiva.

---

## 3. Marco Teórico

### 3.1 ¿Qué es ORM (Object-Relational Mapping)?

ORM es una técnica de programación que permite convertir datos entre el sistema de tipos de un lenguaje de programación orientado a objetos y una base de datos relacional. El ORM actúa como una capa intermedia que traduce las operaciones sobre objetos Java en sentencias SQL y viceversa, eliminando la necesidad de que el desarrollador escriba consultas SQL de forma manual. Esto promueve un desarrollo más limpio, menos propenso a errores y más alineado con los principios de la programación orientada a objetos, dado que el programador interactúa únicamente con clases y métodos en lugar de cadenas de consulta SQL.

### 3.2 ¿Qué es Hibernate?

Hibernate es la implementación ORM más popular del ecosistema Java. Fue creado por Gavin King y actualmente es mantenido por Red Hat. Hibernate implementa la especificación JPA (Java Persistence API) y proporciona funcionalidades avanzadas tales como caché de segundo nivel, carga diferida (lazy loading), gestión de transacciones y un lenguaje de consultas propio llamado HQL. Su archivo de configuración principal, `hibernate.cfg.xml`, permite definir los parámetros de conexión a la base de datos, el dialecto SQL y los archivos de mapeo que asocian cada tabla con su clase Java correspondiente. Adicionalmente, Hibernate Tools —integrado en IDEs como NetBeans— permite realizar ingeniería inversa para generar automáticamente POJOs y archivos de mapeo a partir de una base de datos existente.

### 3.3 Integración Java + Base de Datos

La integración entre Java y una base de datos relacional se logra tradicionalmente mediante JDBC (Java Database Connectivity). Sin embargo, JDBC requiere la escritura manual de sentencias SQL, la gestión explícita de conexiones y el mapeo manual de los `ResultSet` a objetos. Hibernate se sitúa por encima de JDBC y automatiza todo este proceso: el desarrollador define las entidades como clases Java y sus mapeos en archivos XML (o mediante anotaciones), y Hibernate se encarga de generar y ejecutar las sentencias SQL necesarias de forma transparente, incluyendo la gestión del pool de conexiones y las transacciones.

### 3.4 ¿Qué es HQL (Hibernate Query Language)?

HQL es un lenguaje de consultas orientado a objetos proporcionado por Hibernate. A diferencia de SQL, que opera sobre tablas y columnas, HQL opera sobre las clases Java y sus propiedades. Por ejemplo, la consulta `from Empresa` recupera todas las instancias de la clase `Empresa`, y la consulta `from Empresa e where e.nombre like 'Av%'` filtra aquellas empresas cuyo nombre comience con "Av". HQL es traducido internamente por Hibernate a SQL nativo del motor de base de datos configurado. NetBeans incorpora un editor HQL que permite escribir, probar y visualizar la traducción SQL de cada consulta antes de incorporarla al código fuente.

### 3.5 ¿Qué es un POJO?

POJO (Plain Old Java Object) es una clase Java simple que no extiende ni implementa clases o interfaces especiales del framework. En el contexto de Hibernate, los POJOs representan las entidades de la base de datos. Cada atributo del POJO se corresponde con una columna de la tabla, y la clase incluye un constructor vacío, constructores parametrizados y métodos getter/setter para cada propiedad. En este laboratorio, la clase `Empresa` es un POJO con los atributos `rut`, `nombre` y `direccion`, generado automáticamente por el asistente *Hibernate Mapping Files and POJOs from a Database*.

### 3.6 ¿Qué es SessionFactory?

`SessionFactory` es el objeto central de Hibernate encargado de crear instancias de `Session`. Se construye una sola vez al inicio de la aplicación a partir de la configuración definida en `hibernate.cfg.xml` y se reutiliza durante todo el ciclo de vida de la aplicación, puesto que su creación es un proceso costoso en recursos. Cada `Session` representa una unidad de trabajo con la base de datos: permite abrir transacciones, ejecutar consultas, persistir y eliminar objetos. En este laboratorio, la clase `NewHibernateUtil` implementa el patrón Singleton para gestionar la `SessionFactory` y proveer sesiones de Hibernate a las demás capas de la aplicación.

---

## 4. Desarrollo del Laboratorio

### 4.1 Creación de la base de datos MySQL

El primer paso del laboratorio consiste en crear una base de datos llamada `public` en el servidor MySQL local (puerto 3306). Dentro de esta base de datos se crea la tabla `empresa` con la siguiente estructura:

| Columna      | Tipo         | Descripción                    |
|--------------|-------------|-------------------------------|
| `rut`        | VARCHAR(50)  | Clave primaria de la empresa   |
| `nombre`     | VARCHAR(50)  | Nombre de la empresa           |
| `direccion`  | VARCHAR(50)  | Dirección de la empresa        |

Se insertan registros de prueba para verificar el correcto funcionamiento del sistema en las etapas posteriores. La conexión se realiza con el usuario `root` y contraseña `root`.

### 4.2 Creación del proyecto Java Web

Se crea un proyecto Java Web denominado `empresa` en el entorno de desarrollo NetBeans IDE. El proyecto se configura como una aplicación web estándar (Java EE) desplegable sobre un servidor de aplicaciones como GlassFish o Apache Tomcat. Se agregan las librerías de Hibernate al proyecto y se registra la conexión a la base de datos MySQL desde el panel de servicios de NetBeans.

### 4.3 Configuración de Hibernate

#### 4.3.1 Archivo `hibernate.cfg.xml`

Este archivo es el corazón de la configuración de Hibernate. Se genera mediante el asistente de NetBeans y se ubica en el directorio `src/java/`. Define los siguientes parámetros clave:

- **Dialecto:** `org.hibernate.dialect.MySQLDialect`, que indica a Hibernate cómo generar SQL específico para MySQL.
- **Driver JDBC:** `com.mysql.jdbc.Driver` para la conexión con MySQL.
- **URL de conexión:** `jdbc:mysql://localhost:3306/public?zeroDateTimeBehavior=convertToNull`.
- **Credenciales:** usuario `root`, contraseña `root`.
- **show_sql:** activado (`true`) para visualizar en consola las sentencias SQL generadas, lo cual resulta útil para depuración.
- **Mapeos:** se referencia el archivo `com/udea/hb/Empresa.hbm.xml` que contiene el mapeo de la tabla `empresa` a la clase `Empresa`.

#### 4.3.2 Archivo `hibernate.reveng.xml`

Este archivo de ingeniería inversa le indica a Hibernate Tools qué esquema y tablas considerar al momento de generar automáticamente los POJOs y los archivos de mapeo. En este caso se selecciona el catálogo `public` y se filtra únicamente la tabla `empresa`.

#### 4.3.3 Clase `NewHibernateUtil.java`

Esta clase utilitaria, generada automáticamente por NetBeans, implementa el patrón Singleton para la `SessionFactory`. En un bloque estático de inicialización, lee la configuración desde `hibernate.cfg.xml` mediante `AnnotationConfiguration().configure().buildSessionFactory()` y construye la fábrica de sesiones una única vez. Expone el método estático `getSessionFactory()` que devuelve la instancia, la cual es utilizada por la capa de lógica para obtener sesiones de trabajo con la base de datos.

### 4.4 Generación de POJOs y archivos de mapeo

La generación de los archivos de persistencia se realizó mediante el asistente integrado en NetBeans siguiendo estos pasos:

1. Clic derecho sobre el nodo *Source Packages* → *New* → *Other*.
2. En la categoría *Hibernate*, seleccionar *Hibernate Mapping Files and POJOs from a Database* y hacer clic en *Next*.
3. Verificar que estén seleccionados `hibernate.cfg.xml` como archivo de configuración y `hibernate.reveng.xml` como archivo de ingeniería inversa.
4. Asegurar que las opciones *Domain Code* y *Hibernate XML Mappings* estén activadas.
5. Ingresar el nombre del paquete de destino (en este caso `com.udea.hb`) y hacer clic en *Finish*.

Al finalizar, el IDE genera automáticamente:

- **`Empresa.java`**: clase POJO en el paquete `com.udea.hb` con los atributos `rut`, `nombre` y `direccion`, sus respectivos métodos getter/setter y tres constructores (vacío, solo con clave primaria, y completo). La clase implementa `java.io.Serializable`.
- **`Empresa.hbm.xml`**: archivo de mapeo XML que asocia la clase `Empresa` con la tabla `empresa` del catálogo `public`. Define `rut` como identificador con estrategia `assigned` (el valor lo asigna el usuario) y mapea `nombre` y `direccion` a sus columnas correspondientes.

### 4.5 Pruebas en el Editor de consultas HQL

Antes de incorporar las consultas al código fuente, el laboratorio indica probarlas en el editor HQL integrado de NetBeans:

1. Compilar el proyecto haciendo clic derecho sobre el nodo del proyecto → *Build*.
2. Expandir el nodo *<default package>* de Source Packages.
3. Clic derecho sobre `hibernate.cfg.xml` → *Run HQL Query* para abrir el editor.
4. Se probó la consulta `from Empresa as e` y se verificó que retornara todas las filas de la tabla.
5. Se probó `from Empresa` y se confirmó que el listado completo de empresas apareciera correctamente.
6. Se probó `from Empresa e where e.nombre like 'Av%'` para verificar la funcionalidad de filtrado por nombre.

El editor muestra tanto los resultados como la traducción a SQL equivalente, lo que permite validar la correcta construcción de cada consulta antes de escribirla en el código Java.

### 4.6 Capa de lógica – Clase `consulta_empresa.java`

La clase `consulta_empresa.java`, ubicada en el paquete `com.udea.logica`, contiene dos métodos fundamentales:

- **`getEmpresa()`**: abre una sesión de Hibernate mediante `NewHibernateUtil.getSessionFactory().openSession()`, inicia una transacción, ejecuta la consulta HQL `from Empresa` para obtener todas las empresas registradas y retorna una lista de objetos `Empresa`. La transacción se confirma con `commit()` al finalizar. En caso de error, se ejecuta `rollback()` para mantener la integridad de los datos, y la sesión se cierra en el bloque `finally`.

- **`buscarEmpresa(String criterio, String valor)`**: permite realizar búsquedas filtradas por criterio. Si el criterio es `"rut"`, ejecuta `from Empresa where rut = :valor` para una búsqueda exacta. Si el criterio es `"nombre"`, ejecuta `from Empresa where nombre like :valor` con comodines (`"%" + valor + "%"`) para una búsqueda parcial. Ambos casos utilizan parámetros nombrados (`:valor`) para prevenir inyección SQL. El manejo de excepciones y cierre de sesión sigue la misma estructura robusta del método anterior.

Después de escribir el código, se utiliza la función *Fix Imports* (Ctrl+Shift+I) de NetBeans para generar automáticamente las importaciones necesarias: `org.hibernate.Query`, `org.hibernate.Session` y `java.util.List`.

### 4.7 Capa de presentación – Páginas JSP

El laboratorio contempla la creación de las siguientes páginas JSP:

#### 4.7.1 `consultar.jsp` (Listar empresas)

Esta página presenta el listado completo de todas las empresas. Instancia la clase `consulta_empresa`, invoca `getEmpresa()` y recorre la lista con un `Iterator` para generar dinámicamente una tabla HTML con las columnas RUT, Nombre y Dirección.

#### 4.7.2 `buscar.jsp` (Búsqueda personalizada)

Esta página añade funcionalidad de búsqueda interactiva. Contiene un formulario HTML con un selector `<select>` que permite elegir el criterio (RUT o Nombre) y un campo de texto para ingresar el valor. Al enviar el formulario por POST, invoca `buscarEmpresa()` y muestra los resultados filtrados. Si no se proporciona valor de búsqueda, se muestran todas las empresas por defecto.

#### 4.7.3 Páginas CRUD adicionales (ejercicio propuesto)

Como ejercicio complementario, el laboratorio solicita crear tres vistas adicionales con botones para completar el CRUD:

- **`Guardar.jsp`**: formulario para insertar una nueva empresa con campos RUT, nombre y dirección.
- **`Modificar.jsp`**: formulario para actualizar los datos de una empresa existente, precargando los valores actuales.
- **`Borrar.jsp`**: vista de confirmación para eliminar una empresa seleccionada.
- **`Respuesta.jsp`**: página de retroalimentación que informa al usuario si la operación (insertar, actualizar o eliminar) fue exitosa.

---

## 5. Implementación del CRUD

### 5.1 Insertar empresa (`Guardar.jsp`)

La página `Guardar.jsp` presenta un formulario con campos para ingresar el RUT, nombre y dirección de la nueva empresa. Al enviar el formulario, en la capa de lógica se abre una sesión de Hibernate, se inicia una transacción, se crea una instancia del POJO `Empresa` con los datos proporcionados y se invoca `session.save(empresa)`. Al confirmar con `commit()`, Hibernate genera y ejecuta automáticamente la sentencia `INSERT INTO empresa (rut, nombre, direccion) VALUES (?, ?, ?)`. El usuario es redirigido a `Respuesta.jsp` donde se le confirma que la operación fue exitosa.

### 5.2 Actualizar empresa (`Modificar.jsp`)

La página `Modificar.jsp` permite seleccionar una empresa existente (por ejemplo, a partir de la tabla de listado) y presenta sus datos actuales en un formulario editable. Una vez modificados los campos deseados, en la capa de lógica se recupera el objeto `Empresa` correspondiente mediante su RUT, se actualizan las propiedades con los métodos setter (`setNombre()`, `setDireccion()`) y se invoca `session.update(empresa)`. Al realizar el `commit()`, Hibernate genera la sentencia `UPDATE empresa SET nombre=?, direccion=? WHERE rut=?`.

### 5.3 Eliminar empresa (`Borrar.jsp`)

La página `Borrar.jsp` presenta una confirmación antes de proceder con la eliminación. Al confirmar, en la capa de lógica se recupera el objeto `Empresa` desde la base de datos usando el RUT como identificador y se invoca `session.delete(empresa)`. Hibernate genera la sentencia `DELETE FROM empresa WHERE rut=?` al confirmar la transacción. Es fundamental manejar correctamente las excepciones y realizar `rollback()` si la operación falla, garantizando la consistencia de los datos. Finalmente, se redirige al usuario a `Respuesta.jsp` con el mensaje de confirmación correspondiente.

---

## 6. Resultados

Al ejecutar la aplicación en el servidor (GlassFish/Tomcat), se obtienen los siguientes resultados:

- **Página `consultar.jsp`**: presenta correctamente una tabla HTML con el listado de todas las empresas registradas en la base de datos, mostrando las columnas RUT, Nombre y Dirección con bordes y formato tabular.
  *(Insertar captura de pantalla del listado completo de empresas)*

- **Página `buscar.jsp`**: presenta un formulario de búsqueda funcional. Al seleccionar el criterio "RUT" e ingresar un valor exacto, la tabla muestra únicamente la empresa correspondiente. Al seleccionar "Nombre" e ingresar un texto parcial, la tabla filtra las empresas cuyo nombre contenga dicho texto. Sin parámetros, muestra el listado completo.
  *(Insertar captura de pantalla del formulario de búsqueda)*
  *(Insertar captura de pantalla de los resultados filtrados por RUT)*
  *(Insertar captura de pantalla de los resultados filtrados por nombre)*

- **Editor HQL de NetBeans**: al ejecutar las consultas `from Empresa` y `from Empresa e where e.nombre like 'Av%'` en el editor, se visualizan correctamente los resultados y la traducción SQL equivalente, confirmando la validez de las consultas antes de incorporarlas al código.
  *(Insertar captura de pantalla del editor HQL con resultados)*

- **Operaciones CRUD**: las páginas de inserción, actualización y eliminación funcionan correctamente, reflejando de inmediato los cambios en el listado general de empresas.
  *(Insertar captura de pantalla de la página de inserción)*
  *(Insertar captura de pantalla de la página de modificación)*
  *(Insertar captura de pantalla de la confirmación de eliminación)*

- **Consola del servidor**: gracias a la propiedad `hibernate.show_sql=true`, se observan en la consola las sentencias SQL generadas por Hibernate (`SELECT`, `INSERT`, `UPDATE`, `DELETE`), lo que permite verificar que las consultas HQL se traducen correctamente a SQL nativo de MySQL.
  *(Insertar captura de pantalla de la consola con las sentencias SQL)*

---

## 7. Conclusiones

1. **Hibernate simplifica significativamente la capa de persistencia.** La utilización de Hibernate como framework ORM permite al desarrollador trabajar exclusivamente con objetos Java, delegando al framework la responsabilidad de generar, optimizar y ejecutar las sentencias SQL. Esto reduce el acoplamiento entre la lógica de negocio y el motor de base de datos, y facilita la migración a otro sistema gestor de base de datos con mínimos cambios en el código, modificando únicamente el dialecto y el driver en el archivo `hibernate.cfg.xml`.

2. **La arquitectura por capas promueve la mantenibilidad del software.** El laboratorio evidencia una separación clara entre la capa de presentación (páginas JSP), la capa de lógica de negocio (clase `consulta_empresa`) y la capa de persistencia (Hibernate con sus archivos de configuración y mapeo). Esta separación de responsabilidades es un principio fundamental de la ingeniería de software que facilita el mantenimiento, la extensibilidad y las pruebas del sistema a medida que este crece en complejidad.

3. **HQL y el editor integrado agilizan el desarrollo y la depuración.** Al utilizar HQL, las consultas se expresan en términos de las entidades del modelo de dominio en lugar de tablas y columnas. Además, el editor HQL de NetBeans permite probar y visualizar la traducción SQL de cada consulta de forma inmediata, lo que reduce el ciclo de prueba y error y permite detectar errores de sintaxis o de lógica antes de incorporar las consultas al código fuente de la aplicación.

4. **Las herramientas de ingeniería inversa aceleran el desarrollo.** La capacidad de Hibernate Tools para generar automáticamente las clases POJO (`Empresa.java`) y los archivos de mapeo XML (`Empresa.hbm.xml`) a partir de la estructura de la base de datos existente ahorra tiempo considerable y reduce la posibilidad de errores humanos en el proceso de mapeo manual, permitiendo al desarrollador enfocarse en la implementación de la lógica de negocio y la interfaz de usuario.

---

## 8. Repositorio GitHub

El código fuente completo del laboratorio se encuentra disponible en el siguiente repositorio de GitHub:

**https://github.com/IsmaelRQ/lab1-hibernate-javaee**

---

## Referencias

- Hibernate ORM – Documentación oficial: [https://hibernate.org](https://hibernate.org)
- Oracle – Java EE Documentation: [https://docs.oracle.com/javaee/](https://docs.oracle.com/javaee/)
- NetBeans IDE – Hibernate Support: [https://netbeans.apache.org](https://netbeans.apache.org)

---

*Informe elaborado como parte del Laboratorio 1 de Ingeniería de Software II – Tecnológico de Antioquia, 2026.*
