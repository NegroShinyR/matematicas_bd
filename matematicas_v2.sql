-- Crear/rehacer la tabla en el esquema PUBLIC
DROP TABLE IF EXISTS public.palabras_clave CASCADE;

CREATE TABLE public.palabras_clave (
  id SERIAL PRIMARY KEY,
  palabra TEXT UNIQUE NOT NULL,
  porcentaje_identidad NUMERIC(5,2) NOT NULL CHECK (porcentaje_identidad BETWEEN 0 AND 100),
  sinonimos TEXT[] NOT NULL DEFAULT '{}',
  CONSTRAINT chk_palabra_sin_espacios CHECK (palabra !~ '\s'),
  -- sin subconsultas en CHECK: validamos que ningún sinónimo tenga espacios
  CONSTRAINT chk_sinonimos_sin_espacios CHECK (array_to_string(sinonimos, '') !~ '\s')
);

-- Verifica que exista:
SELECT current_database() AS db, current_schema() AS schema,
       to_regclass('public.palabras_clave') AS existe_tabla;



-- Función de normalización (completa)
CREATE OR REPLACE FUNCTION public.normalizar_palabra_sinonimos()
RETURNS TRIGGER AS $$
BEGIN
  NEW.palabra := lower(trim(NEW.palabra));
  IF NEW.sinonimos IS NOT NULL THEN
    NEW.sinonimos := (
      SELECT ARRAY(
        SELECT lower(trim(x))
        FROM UNNEST(NEW.sinonimos) AS x
        WHERE x IS NOT NULL AND x <> ''
      )
    );
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger (nota: referimos a public.palabras_clave)
DROP TRIGGER IF EXISTS trg_normalizar_palabra_sinonimos ON public.palabras_clave;
CREATE TRIGGER trg_normalizar_palabra_sinonimos
BEFORE INSERT OR UPDATE ON public.palabras_clave
FOR EACH ROW
EXECUTE FUNCTION public.normalizar_palabra_sinonimos();

-- Índices
CREATE INDEX IF NOT EXISTS idx_palabras_palabra
  ON public.palabras_clave (palabra);
CREATE INDEX IF NOT EXISTS idx_palabras_porcentaje
  ON public.palabras_clave (porcentaje_identidad);


INSERT INTO public.palabras_clave (palabra, porcentaje_identidad, sinonimos) VALUES
('álgebra',95.00,ARRAY['algebra','algebras']),
('geometría',92.00,ARRAY['geometria','geometrico','geometrica']),
('cálculo',96.00,ARRAY['calculo','calculos']),
('topología',85.00,ARRAY['topologia','topologico']),
('combinatoria',88.00,ARRAY['combinatorio']),
('estadística',94.00,ARRAY['estadistica','estadistico','estadisticos']),
('probabilidad',94.00,ARRAY['probabilidades']),
('trigonometría',90.00,ARRAY['trigonometria']),
('aritmética',90.00,ARRAY['aritmetica']),
('logaritmo',86.00,ARRAY['logaritmos','log']),
('derivada',97.00,ARRAY['derivadas','derivar']),
('integral',97.00,ARRAY['integrales','integrar']),
('matriz',93.00,ARRAY['matrices']),
('vector',92.00,ARRAY['vectores','vectorial']),
('escalar',80.00,ARRAY['escalares']),
('tensor',88.00,ARRAY['tensores']),
('límite',95.00,ARRAY['limite','limites']),
('serie',85.00,ARRAY['series']),
('sucesión',84.00,ARRAY['sucesion','sucesiones']),
('polinomio',90.00,ARRAY['polinomios']),
('ecuación',92.00,ARRAY['ecuacion','ecuaciones']),
('función',93.00,ARRAY['funcion','funciones','funcional']),
('conjunto',91.00,ARRAY['conjuntos']),
('número',90.00,ARRAY['numero','numeros','numerico','numérico']),
('entero',86.00,ARRAY['enteros']),
('real',86.00,ARRAY['reales']),
('complejo',88.00,ARRAY['complejos','compleja']),
('racional',84.00,ARRAY['racionales']),
('irracional',84.00,ARRAY['irracionales']),
('primo',86.00,ARRAY['primos']),
('factor',82.00,ARRAY['factores','factorizar']),
('potencia',86.00,ARRAY['potencias']),
('exponente',84.00,ARRAY['exponentes','exponencial']),
('raíz',86.00,ARRAY['raiz','raíces','raices']),
('módulo',80.00,ARRAY['modulo','modular']),
('congruencia',82.00,ARRAY['congruencias']),
('algoritmo',88.00,ARRAY['algoritmos']),
('variable',86.00,ARRAY['variables']),
('constante',84.00,ARRAY['constantes']),
('parámetro',82.00,ARRAY['parametro','parametros','parametrica','paramétrica']),
('gradiente',86.00,ARRAY['gradientes']),
('divergencia',84.00,ARRAY['divergencias']),
('rotacional',82.00,ARRAY['rotacionales']),
('intervalo',84.00,ARRAY['intervalos']),
('dominio',84.00,ARRAY['dominios']),
('rango',82.00,ARRAY['rangos','imagen']),
('hipótesis',80.00,ARRAY['hipotesis']),
('teorema',90.00,ARRAY['teoremas']),
('axioma',88.00,ARRAY['axiomas']),
('lema',82.00,ARRAY['lemas']),
('corolario',82.00,ARRAY['corolarios']);

SELECT COUNT(*) FROM public.palabras_clave;           -- debe dar 50
SELECT * FROM public.palabras_clave ORDER BY palabra; -- lista
