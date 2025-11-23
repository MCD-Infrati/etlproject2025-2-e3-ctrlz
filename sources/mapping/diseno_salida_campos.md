# Diseño de la tabla de salida (`salida.csv`)

En este documento se describe el origen y la transformación de cada campo que hará parte del archivo `salida.csv`.  

La referencia de campos y descripciones está tomada del enunciado del proyecto (sección "Salida esperada").  
Cada fila corresponde a una columna en `salida.csv`.

## Campos calculados / transformados

| Campo salida  | Tipo dato | Fuente (tabla/colección/csv) | Campo origen                                        | Transformación / Regla                                                                                          | Notas |
|---------------|-----------|-------------------------------|-----------------------------------------------------|------------------------------------------------------------------------------------------------------------------|-------|
| PID           | INT       | amesdbtemp                    | pid                                                 | Copia directa                                                                                                   | Clave principal |
| GrLivArea     | INT       | amesdbtemp                    | 1stFlrSF, 2ndFlrSF, LowQualFinSF                    | GrLivArea = 1stFlrSF + 2ndFlrSF + LowQualFinSF                                                                   | Indicada en enunciado |
| FullBath      | INT       | floordetail                   | FullBath                                            | Suma por PID de FullBath en todos los pisos                                                                      | Agregación por propiedad |
| HalfBath      | INT       | floordetail                   | HalfBath                                            | Suma por PID de HalfBath en todos los pisos                                                                      | Agregación por propiedad |
| Bedroom       | INT       | floordetail                   | Bedroom / Bedrooms (según nombre en tabla)          | Suma por PID de dormitorios en todos los pisos                                                                   | Agregación por propiedad |
| MoSold        | INT       | saleproperty                  | SaleDate                                            | MoSold = mes(SaleDate)                                                                                           | Solo mes en la salida |
| YrSold        | INT       | saleproperty                  | SaleDate                                            | YrSold = año(SaleDate)                                                                                           | Solo año en la salida |
| YearRemodAdd  | INT       | amesdbtemp                    | YearRemodAdd, YearBuilt                             | Si YearRemodAdd es NULL → usar YearBuilt                                                                         | Regla del enunciado |
| SalePrice     | NUMERIC   | saleproperty                  | SalePrice                                           | Copia directa                                                                                                    | Variable objetivo |


