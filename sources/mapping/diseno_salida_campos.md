# Diseño de la tabla de salida (`salida.csv`)

En este documento se describe el origen y la transformación de cada campo que hará parte del archivo `salida.csv`.

| Campo salida | Tipo dato | Fuente (tabla/colección/csv) | Campo origen | Transformación / Regla | Notas |
|-------------|-----------|-------------------------------|--------------|------------------------|-------|
| PID         | NUMBER    | amesdbtemp                    | pid          | Copia directa          | Clave principal de la propiedad |
| MSSubClass  | NUMBER    | amesdbtemp / mssubclass       | MS SubClass  | Copia / join con `mssubclass` si se requiere descripción |  |
| MSZoning    | VARCHAR   | amesdbtemp / mszoning         | MS Zoning    | Copia / join para obtener descripción |  |
| GrLivArea   | NUMBER    | amesdbtemp                    | 1stFlrSF, 2ndFlrSF, LowQualFinSF | `GrLivArea = 1stFlrSF + 2ndFlrSF + LowQualFinSF` |  |
| FullBath    | NUMBER    | floordetail                   | FullBath     | Suma por `PID` de todos los pisos |  |
| HalfBath    | NUMBER    | floordetail                   | HalfBath     | Suma por `PID` de todos los pisos |  |
| Bedroom     | NUMBER    | floordetail                   | bedrooms     | Suma por `PID` de todos los pisos |  |
| MoSold      | NUMBER    | saleproperty                  | Sale Date    | Mes extraído de la fecha |  |
| YrSold      | NUMBER    | saleproperty                  | Sale Date    | Año extraído de la fecha |  |
| YearRemodAdd| NUMBER    | amesdbtemp                    | YearRemodAdd, YearBuilt | Si `YearRemodAdd` es nulo usar `YearBuilt` |  |
| ...         | ...       | ...                           | ...          | ...                    | ...   |
