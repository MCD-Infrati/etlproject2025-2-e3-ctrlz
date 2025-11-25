# Diseño de la tabla de salida (`salida.csv`)

En este documento se describe el origen y la transformación de cada campo que hará parte del archivo `salida.csv`.  

La referencia de campos y descripciones está tomada del enunciado del proyecto (sección "Salida esperada").  
Cada fila corresponde a una columna en `salida.csv`.

## Campos calculados / transformados

| Campo salida  | Tipo dato | Fuente (tabla/colección/csv) | Campo origen                                        | Transformación / Regla                                                                                          | Notas |
|---------------|-----------|-------------------------------|-----------------------------------------------------|------------------------------------------------------------------------------------------------------------------|-------|
| PID           | INT       | amesdbtemp                    | pid                                                 | Copia directa                                                                                                   | Clave principal |
| GrLivArea     | INT       | amesdbtemp                    | 1stFlrSF, 2ndFlrSF, LowQualFinSF                    | GrLivArea = 1stFlrSF + 2ndFlrSF + LowQualFinSF                                                                   | Indicada en enunciado |
| FullBath      | INT       | floordetail                   | Full Bath                                           | Suma por PID de FullBath en todos los pisos                                                                      | Agregación por propiedad |
| HalfBath      | INT       | floordetail                   | Half Bath                                           | Suma por PID de HalfBath en todos los pisos                                                                      | Agregación por propiedad |
| Bedroom       | INT       | floordetail                   | Bedroom                                             | Suma por PID de dormitorios en todos los pisos                                                                   | Agregación por propiedad |
| MoSold        | INT       | saleproperty                  | SaleDate                                            | MoSold = mes(SaleDate)                                                                                           | Solo mes en la salida |
| YrSold        | INT       | saleproperty                  | SaleDate                                            | YrSold = año(SaleDate)                                                                                           | Solo año en la salida |
| YearRemodAdd  | INT       | amesdbtemp                    | YearRemodAdd, YearBuilt                             | Si YearRemodAdd es NULL → usar YearBuilt                                                                         | Regla del enunciado |
| SalePrice     | NUMERIC   | saleproperty                  | SalePrice                                           | Copia directa                                                                                                    | Variable objetivo |

## Campos provenientes de MongoDB (garage, pool, bsmt, misc)

> Regla general: si no hay registro para un `PID` en la colección correspondiente,
> - campos numéricos = 0  
> - campos categóricos = "NA".

### Colección `bsmt` (12 campos, 2851 documentos)

| Campo salida   | Tipo dato | Fuente (Mongo) | Campo origen       | Transformación / Regla                                            | Notas |
|----------------|-----------|----------------|--------------------|--------------------------------------------------------------------|-------|
| BsmtQual       | VARCHAR   | bsmt           | Bsmt Qual          | Si NULL o sin documento → "NA"                                     | Altura del sótano |
| BsmtCond       | VARCHAR   | bsmt           | Bsmt Cond          | Si NULL → "NA"                                                     | Condición del sótano |
| BsmtExposure   | VARCHAR   | bsmt           | Bsmt Exposure      | Si NULL → "NA"                                                     | Exposición del sótano |
| BsmtFinType1   | VARCHAR   | bsmt           | BsmtFin Type 1     | Si NULL → "NA"                                                     | Tipo de área terminada 1 |
| BsmtFinSF1     | INT       | bsmt           | BsmtFin SF 1       | Si NULL → 0                                                        | Área terminada 1 (pies²) |
| BsmtFinType2   | VARCHAR   | bsmt           | BsmtFin Type 2     | Si NULL → "NA"                                                     | Tipo de área terminada 2 |
| BsmtFinSF2     | INT       | bsmt           | BsmtFin SF 2       | Si NULL → 0                                                        | Área terminada 2 (pies²) |
| BsmtUnfSF      | INT       | bsmt           | Bsmt Unf SF        | Si NULL → 0                                                        | Área de sótano sin terminar |
| TotalBsmtSF    | INT       | bsmt           | Total Bsmt SF      | Si NULL → 0                                                        | Área total de sótano |
| BsmtFullBath   | INT       | bsmt           | Bsmt Full Bath     | Si NULL → 0                                                        | Baños completos en sótano |
| BsmtHalfBath   | INT       | bsmt           | Bsmt Half Bath     | Si NULL → 0                                                        | Medios baños en sótano |
| PID            | INT       | bsmt           | PID                | Copia directa (para joins por propiedad)                           | Clave de unión |

### Colección `garage` (8 campos, 2773 documentos)

| Campo salida   | Tipo dato | Fuente (Mongo) | Campo origen     | Transformación / Regla                                            | Notas |
|----------------|-----------|----------------|------------------|--------------------------------------------------------------------|-------|
| GarageType     | VARCHAR   | garage         | Garage Type      | Si NULL o sin documento → "NA"                                     | Ubicación / tipo de garaje |
| GarageYrBlt    | INT       | garage         | Garage Yr Blt    | Si NULL → 0                                                        | Año de construcción del garaje |
| GarageFinish   | VARCHAR   | garage         | Garage Finish    | Si NULL → "NA"                                                     | Terminación interior |
| GarageCars     | INT       | garage         | Garage Cars      | Si NULL → 0                                                        | Capacidad en número de carros |
| GarageArea     | INT       | garage         | Garage Area      | Si NULL → 0                                                        | Área del garaje |
| GarageQual     | VARCHAR   | garage         | Garage Qual      | Si NULL → "NA"                                                     | Calidad del garaje |
| GarageCond     | VARCHAR   | garage         | Garage Cond      | Si NULL → "NA"                                                     | Condición del garaje |
| PID            | INT       | garage         | PID              | Copia directa (para joins por propiedad)                           | Clave de unión |

### Colección `pool` (3 campos, 13 documentos)

| Campo salida   | Tipo dato | Fuente (Mongo) | Campo origen | Transformación / Regla                                            | Notas |
|----------------|-----------|----------------|-------------|--------------------------------------------------------------------|-------|
| PoolArea       | INT       | pool           | Pool Area   | Si NULL o sin documento → 0                                        | Área de la piscina |
| PoolQC         | VARCHAR   | pool           | Pool QC     | Si NULL → "NA"                                                     | Calidad de la piscina |
| PID            | INT       | pool           | PID         | Copia directa (para joins por propiedad)                           | Clave de unión |

### Colección `misc` (3 campos, 106 documentos)

| Campo salida   | Tipo dato | Fuente (Mongo) | Campo origen  | Transformación / Regla                                            | Notas |
|----------------|-----------|----------------|--------------|--------------------------------------------------------------------|-------|
| MiscFeature    | VARCHAR   | misc           | Misc Feature | Si NULL o sin documento → "NA"                                     | Característica miscelánea |
| MiscVal        | INT       | misc           | Misc Val     | Si NULL → 0                                                        | Valor asociado a la característica |
| PID            | INT       | misc           | PID          | Copia directa (para joins por propiedad)                           | Clave de unión |

## Campos provenientes de la tabla `amesdbtemp`

Estos son los campos tal como existen en la tabla `amesdbtemp` y cómo se llamarán en el archivo de salida `salida.csv`.  
En general la regla es: **copiar el valor y solo cambiar el nombre a la convención del dataset (sin espacios).**

| Campo salida    | Tipo dato | Tabla fuente | Campo origen (amesdbtemp) | Transformación / Regla                    | Notas |
|-----------------|-----------|--------------|---------------------------|-------------------------------------------|-------|
| PID             | INT       | amesdbtemp   | PID                       | Copia directa                             | Clave de la propiedad |
| MSSubClass      | INT       | amesdbtemp   | MS SubClass               | Copia directa (solo cambio de nombre)     | Building class |
| MSZoning        | VARCHAR   | amesdbtemp   | MS Zoning                 | Copia directa                             | Zoning classification |
| RoofStyle       | VARCHAR   | amesdbtemp   | Roof Style                | Copia directa                             | Tipo de techo |
| RoofMatl        | VARCHAR   | amesdbtemp   | Roof Matl                 | Copia directa                             | Material del techo |
| Exterior1st     | VARCHAR   | amesdbtemp   | Exterior 1st              | Copia directa                             | Revestimiento exterior principal |
| Exterior2nd     | VARCHAR   | amesdbtemp   | Exterior 2nd              | Copia directa                             | Segundo revestimiento exterior |
| MasVnrType      | VARCHAR   | amesdbtemp   | Mas Vnr Type              | Copia directa                             | Tipo de mampostería |
| MasVnrArea      | INT       | amesdbtemp   | Mas Vnr Area              | Copia directa                             | Área de mampostería |
| ExterQual       | VARCHAR   | amesdbtemp   | Exter Qual                | Copia directa                             | Calidad del exterior |
| ExterCond       | VARCHAR   | amesdbtemp   | Exter Cond                | Copia directa                             | Condición del exterior |
| Foundation      | VARCHAR   | amesdbtemp   | Foundation                | Copia directa                             | Tipo de cimentación |
| Heating         | VARCHAR   | amesdbtemp   | Heating                   | Copia directa                             | Tipo de calefacción |
| HeatingQC       | VARCHAR   | amesdbtemp   | Heating QC                | Copia directa                             | Calidad de calefacción |
| CentralAir      | VARCHAR   | amesdbtemp   | Central Air               | Copia directa                             | ¿Tiene aire central? (Y/N) |
| Electrical      | VARCHAR   | amesdbtemp   | Electrical                | Copia directa                             | Sistema eléctrico |
| 1stFlrSF        | INT       | amesdbtemp   | 1st Flr SF                | Copia directa                             | Área 1er piso (pies²) |
| 2ndFlrSF        | INT       | amesdbtemp   | 2nd Flr SF                | Copia directa                             | Área 2º piso (pies²) |
| LowQualFinSF    | INT       | amesdbtemp   | Low Qual Fin SF           | Copia directa                             | Área de baja calidad terminada |
| KitchenAbvGr    | INT       | amesdbtemp   | Kitchen AbvGr             | Copia directa                             | Nº cocinas sobre el suelo |
| KitchenQual     | VARCHAR   | amesdbtemp   | Kitchen Qual              | Copia directa                             | Calidad de la cocina |
| TotRmsAbvGrd    | INT       | amesdbtemp   | TotRms AbvGrd             | Copia directa                             | Nº total de cuartos sobre el suelo |
| Functional      | VARCHAR   | amesdbtemp   | Functional                | Copia directa                             | Funcionalidad de la vivienda |
| Fireplaces      | INT       | amesdbtemp   | Fireplaces                | Copia directa                             | Nº chimeneas |
| FireplaceQu     | VARCHAR   | amesdbtemp   | Fireplace Qu              | Copia directa                             | Calidad de chimeneas |
| PavedDrive      | VARCHAR   | amesdbtemp   | Paved Drive               | Copia directa                             | Tipo de entrada pavimentada |
| WoodDeckSF      | INT       | amesdbtemp   | Wood Deck SF              | Copia directa                             | Área de deck en madera |
| OpenPorchSF     | INT       | amesdbtemp   | Open Porch SF             | Copia directa                             | Área de porch abierto |
| EnclosedPorch   | INT       | amesdbtemp   | Enclosed Porch            | Copia directa                             | Área de porch cerrado |
| 3SsnPorch       | INT       | amesdbtemp   | 3Ssn Porch                | Copia directa                             | Área de porch 3 estaciones |
| ScreenPorch     | INT       | amesdbtemp   | Screen Porch              | Copia directa                             | Área de porch con malla |
| Fence           | VARCHAR   | amesdbtemp   | Fence                     | Copia directa                             | Calidad de la cerca |

## Campos provenientes de la tabla `SaleProperties` (5 columnas, 2930 filas)

| Campo salida  | Tipo dato | Tabla fuente    | Campo origen (SaleProperties) | Transformación / Regla                               | Notas                         |
|--------------|-----------|-----------------|-------------------------------|------------------------------------------------------|-------------------------------|
| MoSold       | INT       | SaleProperties  | Sale Date                     | Mes(Sale Date)                                       | Extraer solo el mes (1–12)   |
| YrSold       | INT       | SaleProperties  | Sale Date                     | Año(Sale Date)                                       | Extraer solo el año          |
| SaleType     | VARCHAR   | SaleProperties  | Sale Type                     | Copia directa                                        | Tipo de venta                 |
| SaleCondition| VARCHAR   | SaleProperties  | Sale Condition                | Copia directa                                        | Condición de la venta         |
| SalePrice    | NUMERIC   | SaleProperties  | SalePrice                     | Copia directa                                        | Precio final de la propiedad |
| PID          | INT       | SaleProperties  | PID                           | Copia directa (para join por propiedad)             | Clave de unión con otras tablas |

## Campos provenientes de la tabla `FloorDetail` (5 columnas, 4182 filas)

> Para cada `PID` hay una fila por piso (`Floor`) con la cantidad de habitaciones y baños.  
> En `salida.csv` queremos el total por propiedad, sin distinguir pisos.

| Campo salida | Tipo dato | Tabla fuente | Campos origen (FloorDetail)           | Transformación / Regla                                          | Notas                            |
|--------------|-----------|-------------|---------------------------------------|------------------------------------------------------------------|----------------------------------|
| FullBath     | INT       | FloorDetail | Full Bath                             | Suma por PID de `Full Bath` en todos los pisos                  | Total baños completos por propiedad |
| HalfBath     | INT       | FloorDetail | Half Bath                             | Suma por PID de `Half Bath` en todos los pisos                  | Total medios baños por propiedad |
| Bedroom      | INT       | FloorDetail | Bedroom                               | Suma por PID de `Bedroom` en todos los pisos                    | Total habitaciones por propiedad |
| PID          | INT       | FloorDetail | PID                                   | Copia directa (usada en el `group by` y en joins posteriores)   | Clave de unión                   |
| Floor        | VARCHAR/INT| FloorDetail | Floor                                 | Solo se usa en el detalle por piso, **no va en salida.csv**     | Puede ignorarse en el dataset final |

