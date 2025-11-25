/*
---------------------------------------------------------------------
PROYECTO FINAL - EXTRACTION & TRANSFORMATION (NEON/POSTGRES)
Equipo: E3 CTRL Z
Descripción: 
  Consulta optimizada para extracción de datos relacionales.
---------------------------------------------------------------------
*/

SELECT 
    -- Identificadores y Cálculo de Área Habitable (Transformación)
    t."pid" AS "PID",
    (COALESCE(t."1st Flr SF",0) + COALESCE(t."2nd Flr SF",0) + COALESCE(t."Low Qual Fin SF",0)) AS "GrLivArea",
    
    -- Datos de Venta y Fechas (Transformación de Fecha)
    p."saleprice" AS "SalePrice",
    p."Sale Type" AS "SaleType",
    p."Sale Condition" AS "SaleCondition",
    EXTRACT(MONTH FROM p."Sale Date") AS "MoSold",
    EXTRACT(YEAR FROM p."Sale Date") AS "YrSold",
    
    -- Datos Agregados (Subconsulta de Pisos)
    COALESCE(fd.total_bedrooms,0) AS "Bedroom",
    COALESCE(fd.total_full_bath,0) AS "FullBath",
    COALESCE(fd.total_half_bath,0) AS "HalfBath",
    
    -- Columnas Descriptivas (Mapeo Directo)
    t."MS SubClass" AS "MSSubClass",
    t."MS Zoning" AS "MSZoning",
    t."Exter Qual" AS "ExterQual",
    t."Exter Cond" AS "ExterCond",
    t."Heating QC" AS "HeatingQC",
    t."Kitchen Qual" AS "KitchenQual",
    t."Kitchen AbvGr" AS "Kitchen",
    t."TotRms AbvGrd" AS "TotRmsAbvGrd",
    t."Mas Vnr Area" AS "MasVnrArea",
    t."Mas Vnr Type" AS "MasVnrType",
    t."Central Air" AS "CentralAir",
    t."Roof Style" AS "RoofStyle",
    t."Roof Matl" AS "RoofMatl",
    t."Exterior 1st" AS "Exterior1st",
    t."Exterior 2nd" AS "Exterior2nd",
    t."Paved Drive" AS "PavedDrive",
    t."Wood Deck SF" AS "WoodDeckSF",
    t."Open Porch SF" AS "OpenPorchSF",
    t."Enclosed Porch" AS "EnclosedPorch",
    t."3Ssn Porch" AS "3SsnPorch",
    t."Screen Porch" AS "ScreenPorch",
    t."Fireplace Qu" AS "FireplaceQu",
    t."1st Flr SF" AS "1stFlrSF",
    t."2nd Flr SF" AS "2ndFlrSF",
    t."Low Qual Fin SF" AS "LowQualFinSF",
    t."fireplaces" AS "Fireplaces",
    t."fence" AS "Fence",
    t."foundation" AS "Foundation",
    t."heating" AS "Heating",
    t."electrical" AS "Electrical",
    t."functional" AS "Functional"

FROM "amesdbtemp" t

-- Unión con tabla de Ventas
LEFT JOIN "saleproperty" p ON t."pid" = p."pid"

-- Unión con Subconsulta de Detalles de Piso (Agregación)
LEFT JOIN (
    SELECT 
        "pid", 
        SUM("bedrooms") AS total_bedrooms, 
        SUM("Full Bath") AS total_full_bath, 
        SUM("Half Bath") AS total_half_bath 
    FROM "floordetail" 
    GROUP BY "pid"
) fd ON t."pid" = fd."pid";