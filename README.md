# ETL – Ames Housing (Grupo CTRL+Z)

Este proyecto es parte del curso de **ETL (MCD-Infrati)** de la Maestría en Ciencia de Datos, Universidad Icesi, Cali – Colombia.

El objetivo es diseñar y construir un proceso **ETL en Azure Data Factory** que integre datos relacionales, archivos CSV y datos en MongoDB para generar un archivo final `salida.csv` con las características de las propiedades del conjunto de datos Ames Housing.

#### -- Project Status: Active

---

## Contributing Members

Team Leader: [Angela Villota Gomez](https://github.com/angievig)
- [Miguel Angel Jaramillo Rodriguez](https://github.com/majaramillor)
- [Luisa Castaño](https://github.com/usuario3)
- [Valentina Arana](https://github.com/usuario4)
- [Sebastian Correa](https://github.com/usuario4)

## Contact

Para dudas técnicas o contribuciones, contactar al líder del equipo por GitHub o correo institucional.

---

## Project Intro / Objective

El propósito de este proyecto es construir un flujo ETL completo que:

1. **Extraiga** información de:
   - Base de datos relacional (tablas `amesdbtemp`, `floordetail`, `saleproperty`, `mssubclass`, `mszoning`, `typequality`).
   - Archivo CSV `AmesProperty.csv`.
   - Colecciones de **MongoDB Atlas** (`garage`, `pool`, `bsmt`, `misc`).

2. **Transforme** los datos aplicando reglas específicas:
   - Cálculo de campos derivados (por ejemplo `GrLivArea`, `MoSold`, `YrSold`).
   - Agregación de información por propiedad (baños, habitaciones).
   - Manejo de valores faltantes (uso de `NA` o `0` según el tipo de dato).
   - Unificación de todas las fuentes en una tabla final.

3. **Cargue** el resultado en un archivo `salida.csv` almacenado en un contenedor de **Azure Blob Storage**.

---

## Methods Used

- Modelado y mapeo de datos.
- Diseño de procesos ETL.
- Integración de fuentes relacionales, archivos planos y NoSQL.
- Validación de calidad de datos.

### Technologies

- Azure Data Factory
- Azure SQL Database / SQL Server
- MongoDB Atlas
- Azure Blob Storage
- Git / GitHub

---

## Project Description

El proyecto toma como base el conjunto de datos de Ames Housing y los modelos de base de datos entregados por la profesora (modelo entidad–relación y modelo relacional).

- Los modelos se encuentran en: `sources/docs/Modelos.pdf`.
- El enunciado del proyecto se encuentra en: `sources/docs/2025-1_EnunciadoProyecto.docx`.

Toda la lógica de transformación de campos hacia la tabla final `salida.csv` se documentará en:

- `sources/mapping/diseno_salida_campos.md`.

Los pipelines y dataflows de **Azure Data Factory** se exportarán y versionarán en:

- `pipelines/`.

El archivo final generado por el proceso ETL se almacenará en:

- `out/salida.csv`.

---

## Getting Started

1. **Clonar el repositorio**

   ```bash
   git clone https://github.com/MCD-Infrati/etlproject2025-2-e3-ctrlz.git
   cd etlproject2025-2-e3-ctrlz


