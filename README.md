# ETL – Ames Housing (Grupo CTRL+Z)

Este proyecto es parte del curso de ETL (MCD-Infrati) de la Maestría en Ciencia de Datos, Universidad Icesi, Cali – Colombia.

El objetivo es diseñar y construir un proceso ETL en Azure Data Factory que integre datos relacionales, archivos CSV y datos en MongoDB para generar un archivo final `salida.csv` con las características de las propiedades del conjunto de datos Ames Housing.

**Project Status:** Active

---

##  Contributing Members

**Team Leader:** Angela Villota Gomez

**Team Members:**
* Miguel Angel Jaramillo Rodriguez
* Luisa Castaño
* Valentina Arana
* Sebastian Correa

###  Contact
Para dudas técnicas o contribuciones, contactar al líder del equipo por GitHub o correo institucional.

---

##  Project Intro / Objective

El propósito de este proyecto es construir un flujo ETL completo que:

### 1. **Extracción (Extract)**
   * **Base de datos relacional Azure SQL:** 
     - `amesdbtemp`, `floordetail`, `saleproperty`
     - `mssubclass`, `mszoning`, `typequality`
   * **Archivo CSV:** `AmesProperty.csv`
   * **Colecciones MongoDB Atlas:** 
     - `garage`, `pool`, `bsmt`, `misc`

### 2. **Transformación (Transform)**
   * Cálculo de campos derivados (ej: `GrLivArea`, `MoSold`, `YrSold`)
   * Agregación de información por propiedad (baños, habitaciones)
   * Manejo de valores faltantes:
     - Variables cualitativas: `"NA"`
     - Variables cuantitativas: `0`
   * Aplicación de reglas de calidad de datos
   * Unificación de todas las fuentes en una tabla final

### 3. **Carga (Load)**
   * Generación del archivo `salida.csv`
   * Almacenamiento en Azure Blob Storage

---

##  Methods Used

* Modelado y mapeo de datos
* Diseño de procesos ETL
* Integración de fuentes relacionales, archivos planos y NoSQL
* Validación de calidad de datos
* Control de versiones con Git

---

##  Technologies

| Categoría | Tecnología | Versión/Uso |
|-----------|-----------|-------------|
| **Orquestación ETL** | Azure Data Factory | Pipeline principal |
| **Base de datos relacional** | Azure SQL Database | Tablas dimensionales y hechos |
| **Base de datos NoSQL** | MongoDB Atlas | Colecciones garage, pool, bsmt, misc |
| **Almacenamiento** | Azure Blob Storage | Contenedor para salida.csv |
| **Lenguaje** | Python | Scripts de validación |
| **Librerías** | Pandas, PyMongo | Transformación y conexión |
| **Control de versiones** | Git / GitHub | Colaboración y versionado |

---

##  Project Description

El proyecto toma como base el conjunto de datos de **Ames Housing** y los modelos de base de datos proporcionados.

###  Estructura del Repositorio

```
etlproject2025-2-e3-ctrlz/
├── sources/
│   ├── docs/
│   │   ├── Modelos.pdf                    # Modelos ER y relacional
│   │   └── 2025-1_EnunciadoProyecto.docx  # Especificaciones del proyecto
│   └── mapping/
│       └── diseno_salida_campos.md        # Documentación de transformaciones
├── pipelines/                              # Pipelines de Azure Data Factory
├── notebooks/                              # Notebooks de validación
├── out/
│   └── salida.csv                         # Archivo final generado
└── README.md
```

###  Documentación Clave

* **Modelos de datos:** `sources/docs/Modelos.pdf`
* **Enunciado del proyecto:** `sources/docs/2025-1_EnunciadoProyecto.docx`
* **Mapeo de transformaciones:** `sources/mapping/diseno_salida_campos.md`
* **Pipelines de ADF:** Exportados en `pipelines/`

---

##  Getting Started

### 1. Clonar el repositorio

```bash
git clone https://github.com/MCD-Infrati/etlproject2025-2-e3-ctrlz.git
cd etlproject2025-2-e3-ctrlz
```

### 2. Requisitos previos

* Cuenta de Azure con los siguientes servicios configurados:
  - Azure Data Factory
  - Azure SQL Database
  - Azure Blob Storage
* Cuenta de MongoDB Atlas
* Python 3.8+ (para notebooks de validación)

### 3. Instalación de dependencias

```bash
pip install -r requirements.txt
```

### 4. Configuración de variables de entorno

Crear un archivo `.env` en la raíz del proyecto:

```bash
# Azure SQL Database
SQL_SERVER=<tu-servidor>.database.windows.net
SQL_DATABASE=<nombre-base-datos>
SQL_USERNAME=<usuario>
SQL_PASSWORD=<contraseña>

# MongoDB Atlas
MONGO_CONNECTION_STRING=<tu-cadena-conexion>
MONGO_DATABASE=<nombre-base-datos>

# Azure Blob Storage
BLOB_CONNECTION_STRING=<cadena-conexion-blob>
BLOB_CONTAINER=<nombre-contenedor>
```

### 5. Ejecutar el pipeline

Desde Azure Data Factory:
1. Importar los pipelines desde la carpeta `pipelines/`
2. Configurar los linked services con las credenciales apropiadas
3. Ejecutar el pipeline principal `PL_ETL_AmesHousing_Main`

### 6. Validar resultados

Ejecutar el notebook de validación:

```bash
jupyter notebook notebooks/validacion_salida.ipynb
```

---

##  Resultados Esperados

El archivo `salida.csv` debe contener:

* **Dimensiones esperadas:** 2,930 filas × 82 columnas
* **Sin valores nulos** en columnas obligatorias
* **Formato correcto** según especificaciones del proyecto
* **Tipos de datos validados:**
  - Variables cualitativas con `"NA"` para faltantes
  - Variables cuantitativas con `0` para faltantes

---

##  Testing & Validation

### Notebook de Validación

El archivo `notebooks/validacion_salida.ipynb` incluye:

*  Verificación de dimensiones del dataset
*  Detección de valores nulos
*  Validación de nombres de columnas
*  Pruebas de transformaciones obligatorias
*  Pruebas de transformaciones opcionales
*  Validación de calidad de datos
*  Verificación de extracción desde MongoDB

---

##  Lecciones Aprendidas

### Desafíos Principales
1. **Integración de múltiples fuentes:** Coordinar datos relacionales, CSV y NoSQL requirió un diseño cuidadoso de las claves de unión
2. **Manejo de valores faltantes:** Implementar reglas consistentes para datos cualitativos vs cuantitativos
3. **Optimización de pipelines:** Balancear el rendimiento con la legibilidad del código

### Soluciones Implementadas
* Uso de dataflows en ADF para transformaciones complejas
* Validación en capas (extracción, transformación, carga)
* Documentación exhaustiva del mapeo de campos

### Aprendizajes Técnicos
* Arquitectura de Azure Data Factory
* Integración de servicios cloud (SQL, Blob, ADF)
* Mejores prácticas en diseño ETL

### Aprendizajes No Técnicos
* Colaboración efectiva en equipo usando Git
* Gestión de tiempo en proyectos complejos
* Documentación como parte integral del desarrollo

---

##  Sugerencias de Mejora

1. **Automatización completa:** Implementar triggers automáticos en ADF para ejecución programada
2. **Monitoreo avanzado:** Integrar Azure Monitor para alertas en tiempo real
3. **Versionado de datos:** Implementar estrategia de versionado para salida.csv
4. **Testing automatizado:** Crear suite de pruebas unitarias para cada transformación
5. **Documentación dinámica:** Generar documentación automática desde los metadatos del pipeline
