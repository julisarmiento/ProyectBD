SET search_path TO "ciudad";

-- a) Devolver por cada programa, el total de aportes mensuales -- 
SELECT 
    programa.nombre,  
	SUM(aportan.monto) AS total_aportes
FROM 
    aportan JOIN programa ON aportan.id_programa = programa.id_programa
WHERE 
	aportan.frecuencia = 'MENSUAL'
GROUP BY 
    programa.nombre;

-- b) Devolver los donantes que aportan a más de dos programas--

SELECT 
	aportan.dni,
	COUNT(*)
FROM 
	aportan
	
GROUP BY
	aportan.dni
	
HAVING
	COUNT(*) > 2;

-- c)Listado de Donantes con aportes mensuales y los datos de los medios de pago-- 

	SELECT 
		aportan.dni, 
		datos_donante.nombre_y_ape,
		medioPago.id_medio_pago, 
		medioPago.nombre_titular
		
	
	FROM 
		(aportan NATURAL JOIN medioPago
		NATURAL JOIN (SELECT dni, nombre_y_ape FROM padrino)
		AS datos_donante)
		
	WHERE 
    	aportan.frecuencia = 'MENSUAL';
	
		










