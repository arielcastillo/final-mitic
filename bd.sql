-- 1. Examinar la estructura básica de las tablas principales


-- Ver estructura de tablas
DESCRIBE data.sales;
DESCRIBE data.customers;
DESCRIBE data.products;
DESCRIBE data.stores;
DESCRIBE data.exchange_rates;

-- Propósito: Obtener una visión general de los datos disponibles y su formato
SELECT * FROM data.sales LIMIT 10;
SELECT * FROM data.customers; LIMIT 10;
SELECT * FROM data.products LIMIT 10;
SELECT * FROM data.stores LIMIT 10;
SELECT * FROM data.exchange_rates LIMIT 10;

-- Conteo de registros por tabla
SELECT COUNT(*) AS total_ventas FROM data.sales;
SELECT COUNT(*) AS total_clientes FROM data.customers;
SELECT COUNT(*) AS total_productos FROM data.products;
SELECT COUNT(*) AS total_tiendas FROM data.stores;

-- Conteo de valores únicos en columnas categóricas
SELECT COUNT(DISTINCT Country) AS total_paises FROM data.customers;
SELECT COUNT(DISTINCT Category) AS total_categorias FROM data.products;

-- Distribución de clientes por país
SELECT Country, COUNT(*) AS cantidad_clientes 
FROM data.customers 
GROUP BY Country 
ORDER BY cantidad_clientes DESC;

-- Distribución de productos por categoría
SELECT Category, COUNT(*) AS cantidad_productos 
FROM data.products 
GROUP BY Category 
ORDER BY cantidad_productos DESC;

