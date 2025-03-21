Aquí tienes el contenido en formato markdown:

# Comprensión del Negocio

## Actividades clave:

1. **Definir objetivos de negocio** para Global Electronics Retailer:
   - Identificar tendencias en ventas globales y patrones de comportamiento de compra
   - Determinar los productos más rentables y de mayor volumen
   - Segmentar clientes para estrategias de marketing personalizadas
   - Analizar el rendimiento por región geográfica y tienda
   - Predecir tendencias futuras para planificación estratégica

2. **Formular preguntas específicas** que quieres responder:
   - ¿Cuáles son las categorías y productos más vendidos y más rentables?
   - ¿Dónde se concentran geográficamente las ventas y los clientes?
   - ¿Qué patrones estacionales existen en las ventas?
   - ¿Cuáles son los segmentos de clientes más valiosos?
   - ¿Qué tiendas tienen mejor desempeño y por qué?
   - ¿Qué productos suelen comprarse juntos?

3. **Definir criterios de éxito** medibles para el proyecto:
   - Identificación de al menos 3 insights accionables
   - Creación de segmentos de clientes claramente diferenciados
   - Desarrollo de un modelo predictivo con error menor al 15%
   - Creación de un dashboard interactivo que responda a todas las preguntas clave

# Análisis de Estructura de Datos para el Proyecto Final

El primer paso es cargar los datos en MySQL utilice la herramienta Reverse Engineering para entender la estructura y las correlaciones


## Uso de MySQL para Exploración de Estructura de Datos

En este proyecto, utilicé MySQL como herramienta inicial para explorar y entender la estructura de las tablas de la base de datos. Esta exploración es fundamental antes de realizar cualquier análisis, ya que permite comprender las características de los datos con los que trabajaremos.

### Comandos utilizados

```sql
DESCRIBE data.sales;
DESCRIBE data.customers;
DESCRIBE data.products;
DESCRIBE data.stores;
DESCRIBE data.exchange_rates;
```

El comando DESCRIBE (o su forma abreviada DESC) muestra información detallada sobre la estructura de cada tabla, incluyendo:

### Tipos de Datos en MySQL

En la salida del comando DESCRIBE, encontramos varios tipos de datos:

- **INT(11)**: Tipo de dato entero que puede almacenar números entre -2,147,483,648 y 2,147,483,647. El número 11 indica la anchura de visualización, pero no limita el rango de valores. Se utiliza para identificadores numéricos como CustomerKey, ProductKey, StoreKey, así como para valores como Quantity.

- **TEXT**: Tipo de dato para almacenar cadenas de texto de longitud variable. Se utiliza para campos como Product_Name, Brand, City, Country, etc. También se usa para fechas que fueron importadas como texto (Order_Date, Delivery_Date, Birthday).

- **DOUBLE**: Tipo de dato de punto flotante de precisión doble, usado para valores decimales como el campo Exchange en la tabla de tipos de cambio. Es adecuado para valores monetarios que requieren decimales.

### Otros Atributos Importantes

- **PK (Primary Key)**: Indica que el campo es una clave primaria, un identificador único para cada registro en la tabla. Por ejemplo, ProductKey es la clave primaria de la tabla products.

- **NULL / NOT NULL**: Indica si el campo puede contener valores nulos (vacíos). Un campo marcado como NOT NULL requiere un valor para cada registro. En nuestra base de datos, el campo Delivery_Date permite NULL, lo que representa pedidos sin fecha de entrega confirmada.

- **Foreign Keys**: Aunque no se muestra explícitamente en DESCRIBE, campos como CustomerKey, ProductKey y StoreKey en la tabla sales son claves foráneas que establecen relaciones con las tablas customers, products y stores respectivamente.

### Importancia de la Exploración de Estructura

Esta exploración inicial con MySQL fue crucial para:

1. **Entender las relaciones entre tablas**: Identificar cómo se conectan las ventas con clientes, productos y tiendas.

2. **Detectar posibles problemas de calidad de datos**: Como fechas almacenadas como TEXT que necesitarían conversión.

3. **Planificar transformaciones necesarias**: Por ejemplo, convertir campos monetarios de TEXT a valores numéricos para cálculos.

4. **Identificar campos clave para análisis**: Determinar qué campos serían fundamentales para segmentación, análisis de rentabilidad y evaluación de rendimiento.

Esta comprensión de la estructura de datos formó la base para el posterior procesamiento con Python y visualización con Power BI, asegurando un análisis preciso y significativo de los patrones de ventas, comportamiento de clientes y rendimiento de productos y tiendas.

## La base de datos está compuesta por 5 tablas principales interconectadas que capturan información sobre ventas minoristas:

### 1. Tabla sales (Ventas)

Contiene los registros de transacciones de ventas:

- Order_Number (INT): Identificador único del pedido
- Line_Item (INT): Número de línea dentro del pedido
- Order_Date (TEXT): Fecha en que se realizó el pedido
- Delivery_Date (TEXT): Fecha de entrega (puede ser NULL si no se ha entregado)
- CustomerKey (INT): Clave foránea del cliente
- StoreKey (INT): Clave foránea de la tienda
- ProductKey (INT): Clave foránea del producto
- Quantity (INT): Cantidad de productos vendidos
- Currency_Code (TEXT): Código de la moneda utilizada en la transacción

### 2. Tabla customers (Clientes)

Almacena información sobre los clientes:

- CustomerKey (INT): Identificador único del cliente
- Gender (TEXT): Género del cliente
- Name (TEXT): Nombre completo
- City (TEXT): Ciudad de residencia
- State_Code (TEXT): Código del estado
- State (TEXT): Nombre del estado
- Zip_Code (INT): Código postal
- Country (TEXT): País de residencia
- Continent (TEXT): Continente
- Birthday (TEXT): Fecha de nacimiento

### 3. Tabla products (Productos)

Contiene el catálogo de productos:

- ProductKey (INT): Identificador único del producto
- Product_Name (TEXT): Nombre del producto
- Brand (TEXT): Marca del producto
- Color (TEXT): Color del producto
- Unit_Cost_USD (TEXT): Costo unitario en dólares
- Unit_Price_USD (TEXT): Precio unitario en dólares
- SubcategoryKey (TEXT): Clave de subcategoría
- Subcategory (TEXT): Nombre de la subcategoría
- CategoryKey (TEXT): Clave de categoría
- Category (TEXT): Nombre de la categoría

### 4. Tabla stores (Tiendas)

Información sobre las tiendas físicas:

- StoreKey (INT): Identificador único de la tienda
- Country (TEXT): País donde se ubica la tienda
- State (TEXT): Estado o provincia
- Square_Meters (INT): Superficie de la tienda en metros cuadrados
- Open_Date (TEXT): Fecha de apertura de la tienda

### 5. Tabla exchange_rates (Tipos de Cambio)

Registra los tipos de cambio de divisas:

- Date (TEXT): Fecha del tipo de cambio
- Currency (TEXT): Código de moneda
- Exchange (DOUBLE): Valor del tipo de cambio

### Relaciones entre tablas

- La tabla sales se relaciona con customers a través de CustomerKey
- La tabla sales se relaciona con products a través de ProductKey
- La tabla sales se relaciona con stores a través de StoreKey
- La tabla sales se relaciona con exchange_rates a través de Currency_Code y Order_Date

### Características clave de los datos

- **Período temporal**: Los datos abarcan desde 2016 hasta 2021
- **Cobertura geográfica**: Principalmente Norteamérica, Europa y Australia
- **Segmentos de clientes**: Diversas edades y perfiles demográficos
- **Categorías de productos**: Múltiples categorías como Audio, Cámaras, Teléfonos, Computadoras, etc.
- **Monedas**: Transacciones en diferentes divisas con tipos de cambio correspondientes

## Comandos SQL para Visualización de Datos


```sql
SELECT * FROM data.sales LIMIT 10;
SELECT * FROM data.customers LIMIT 10;
SELECT * FROM data.products LIMIT 10;
SELECT * FROM data.stores LIMIT 10;
SELECT * FROM data.exchange_rates LIMIT 10;
```

### Propósito y Utilidad

Estos comandos permiten una primera exploración de los datos mediante la visualización de los primeros 10 registros de cada tabla. Esta técnica es fundamental para:

- **Entender el contenido** real de cada tabla y sus formatos
- **Identificar rápidamente** el tipo de información disponible para el análisis
- **Familiarizarse con la naturaleza de los datos** de ventas, clientes, productos, tiendas y tipos de cambio

Al ejecutar estos comandos, obtenemos una "muestra representativa" que nos ayuda a comprender la estructura y contenido de la base de datos antes de proceder con análisis más complejos, convirtiéndose en el punto de partida para la planificación del proyecto de análisis de datos.

# En Python:

## 1. Preparación del Entorno y Carga de Datos

En esta fase inicial:

- Se importan las bibliotecas necesarias (pandas, numpy, matplotlib, seaborn, datetime)
- Se cargan los conjuntos de datos desde archivos CSV:
  - Sales.csv: Datos de ventas
  - Customers.csv: Información de clientes
  - Products.csv: Catálogo de productos
  - Stores.csv: Datos de tiendas
  - Exchange_Rates.csv: Tipos de cambio de divisas
- Se carga también el diccionario de datos que explica cada campo

## 2. Exploración Inicial de Datos

El código realiza una exploración inicial:

- Muestra las primeras filas de cada conjunto de datos con head()
- Ofrece una visión general de la estructura de los datos
- Permite entender rápidamente qué información está disponible

## 3. Análisis de la Estructura de Datos

Se implementa una función analizar_estructura() que proporciona información detallada sobre cada conjunto de datos:

- Dimensiones (número de filas y columnas)
- Tipos de datos de cada columna
- Estadísticas descriptivas
- Información general sobre la memoria utilizada

Los resultados muestran:

- Sales: 62,884 registros de ventas
- Customers: 15,266 clientes
- Products: 2,517 productos
- Stores: 67 tiendas
- Exchange_Rates: 11,215 registros de tipos de cambio

## 4. Detección y Tratamiento de Valores Nulos

Se utiliza la función analizar_nulos() para identificar y visualizar valores nulos:

- Sales: 79.1% de valores nulos en "Delivery Date"
- Customers: 0.1% de valores nulos en "State Code"
- Products: No tiene valores nulos
- Stores: 1.5% de valores nulos en "Square Meters"

**Tratamiento de valores nulos:**

- Las fechas de entrega nulas se interpretan como ventas en tienda física (no requieren entrega)
- Se asigna el código "NA" a los clientes de Nápoles (Italia) sin código de estado
- Se identifica que la tienda sin metros cuadrados corresponde al canal online

## 5. Preparación y Limpieza de Datos

El código realiza varias tareas de limpieza:

- Estandariza los nombres de columnas (reemplaza espacios por guiones bajos)
- Convierte las fechas a formato datetime
- Transforma los campos de precios de texto a valores numéricos
- Crea una columna "Canal_Venta" para clasificar ventas como "At_store" u "Online"

## 6. Unión de Tablas

Se crean conjuntos de datos integrados mediante operaciones de merge:

1. sales_products: Une ventas con productos
2. sales_products_customers: Añade información de clientes
3. sales_complete: Incorpora datos de tiendas
4. dataset_final: Agrega tasas de cambio por fecha y moneda

Esta integración permite realizar análisis más completos considerando todas las dimensiones.

# Análisis de Datos

## 1. Tendencia de Ventas Mensuales

El análisis muestra:

- Una tendencia creciente en ventas hasta finales de 2019
- Una caída pronunciada en 2020-2021 (posiblemente por COVID-19)
- Un patrón cíclico con caídas sistemáticas en abril de cada año
- Caídas pronunciadas en abril probablemente debidas a:
  - Fin del año fiscal en muchos países (31 de marzo)
  - Semana Santa con reducción de días laborables
  - Posible período de inventario o mantenimiento programado anual

## 2. Distribución por Moneda

El gráfico circular muestra:

- USD domina con 53.7% de las ventas
- EUR representa 20.1%
- GBP supone 12.9%
- CAD tiene 8.6%
- AUD representa 4.7%

Esta distribución refleja la presencia global de la empresa y la importancia del mercado estadounidense.

## 3. Análisis de Ventas por Categoría de Producto

Los resultados indican:

- "Computers" es la categoría más vendida
- "Cell phones" ocupa el segundo lugar
- "Music, Movies and Audio Books" es tercera
- "Audio" y "Games and Toys" tienen ventas moderadas
- "TV and Video" muestra el menor volumen

## 4. Patrón de Compra por Día de la Semana

El análisis revela:

- Sábado es el día con mayor volumen de ventas
- Jueves y miércoles siguen en popularidad
- Domingo muestra el volumen más bajo
- Existe un claro patrón de fin de semana con pico en sábado

## 5. Análisis de Temporalidad (Ventas por Mes)

Se observa estacionalidad clara:

- Diciembre y febrero tienen los picos más altos
- Enero también muestra ventas fuertes
- Abril presenta el volumen más bajo (confirma el patrón anual identificado)
- Los meses de verano tienen ventas moderadas-bajas

## 6. Análisis de Frecuencia de Compra

La distribución muestra:

- Media de 2.21 compras por cliente
- La mayoría de clientes realiza entre 1-3 compras
- Una pequeña proporción de clientes fieles realiza más de 5 compras

## 7. Análisis de Tamaño de Compra

Los resultados indican:

- Media de 7.51 items por pedido
- La mayoría de los pedidos incluye entre 1-10 items
- Pocos pedidos superan los 20 items

## 8. Productos con Mayor Volumen de Ventas

El análisis identifica que:

- Los ordenadores de escritorio dominan las ventas
- Las marcas WWI y Adventure Works lideran
- Los productos principales tienen características similares
- Los colores negro, blanco y plata son los más populares

## 9. Segmentación Demográfica

El análisis por país revela:

- Estados Unidos es el mercado dominante
- China ocupa el segundo lugar
- Reino Unido y Alemania le siguen
- Países Bajos muestra preferencia alta por "Computers" y "TV and Video"
- Francia destaca en "Home Appliances"
- Australia tiene alta demanda en "Cell phones"

## 10. Segmentación de Clientes (RFM)

Se implementa un análisis RFM (Recency, Frequency, Monetary) que clasifica a los clientes en:

- Leal (3,298 clientes): Alto valor y frecuencia
- Potencial (3,868 clientes): Buen potencial de crecimiento
- En riesgo (4,025 clientes): Signos de disminución de actividad
- Inactivo (696 clientes): Sin actividad reciente

La distribución por país muestra que EE.UU. tiene proporción más alta de clientes leales, mientras que mercados europeos muestran distribuciones más equilibradas entre segmentos.

## 11. Predicción de Ventas con Prophet

Se implementa un modelo predictivo que:

- Captura adecuadamente patrones históricos hasta 2020
- Muestra deficiencia significativa para 2020-2021 (período COVID)
- Produce métricas de error altas:
  - MAE: 4487.61
  - RMSE: 5257.19
  - MAPE: 272.80%

La principal causa probable es el cambio estructural en las ventas debido a la pandemia, que el modelo no pudo anticipar.

# Conclusiones y Recomendaciones

## Hallazgos Clave

1. **Canal de Ventas**: El canal online (tienda ID 0) representa aproximadamente el 90% de los ingresos entre las principales tiendas.

2. **Estacionalidad**: Existe un patrón claro con caídas en abril y picos en diciembre-febrero.

3. **Categorías de Productos**: "Computers" domina en todos los mercados, pero existen preferencias regionales importantes.

4. **Segmentos de Clientes**: El segmento "En riesgo" es el más numeroso, lo que requiere estrategias de retención.

## Recomendaciones

1. **Estrategias de retención**: Implementar programas de reactivación para el segmento "En riesgo".

2. **Desarrollo de clientes potenciales**: Implementar ventas cruzadas para aumentar frecuencia y valor.

3. **Programas de fidelización**: Recompensar al segmento "Leal" con beneficios exclusivos.

4. **Optimización de inventario**: Ajustar según preferencias regionales identificadas.

5. **Mejora del modelo predictivo**: Reentrenar con datos recientes e incorporar variables externas para capturar cambios estructurales.

## Exportación de Datos

Finalmente, el código exporta los datasets ajustados y trabajados a archivos CSV en la ruta especificada, facilitando su uso posterior en tableros de visualización o análisis adicionales.
