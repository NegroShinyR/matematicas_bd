

--  Crear tabla
CREATE TABLE palabras_clave (
  palabra TEXT PRIMARY KEY,
  porcentaje_identidad NUMERIC(5,2) CHECK (porcentaje_identidad BETWEEN 0 AND 100),
  sinonimos TEXT[] NOT NULL
);

-- Insertar datos (40+ filas)
INSERT INTO palabras_clave (palabra, porcentaje_identidad, sinonimos) VALUES
('Álgebra', 95.00, ARRAY['álgebra elemental','estructuras algebraicas','operaciones']),
('Geometría', 95.00, ARRAY['figuras','formas','geometría euclidiana','geometría analítica']),
('Cálculo diferencial', 92.00, ARRAY['derivadas','tasa de cambio','gradiente']),
('Cálculo integral', 92.00, ARRAY['integrales','área bajo la curva','antiderivadas']),
('Álgebra lineal', 94.00, ARRAY['matrices','vectores','espacios vectoriales']),
('Trigonometría', 90.00, ARRAY['senos','cosenos','ángulos']),
('Probabilidad', 90.00, ARRAY['aleatoriedad','eventos','espacio muestral']),
('Estadística', 88.00, ARRAY['distribuciones','inferencia','desviación estándar']),
('Análisis real', 89.00, ARRAY['límites','continuidad','series']),
('Análisis complejo', 88.00, ARRAY['números complejos','funciones holomorfas','residuos']),
('Ecuaciones diferenciales', 91.00, ARRAY['EDO','EDP','modelado']),
('Combinatoria', 86.00, ARRAY['conteo','permutaciones','combinaciones']),
('Teoría de números', 87.00, ARRAY['primos','congruencias','aritmética modular']),
('Topología', 84.00, ARRAY['espacios topológicos','continuidad','abiertos']),
('Lógica matemática', 85.00, ARRAY['proposicional','predicados','demostraciones']),
('Matemática discreta', 88.00, ARRAY['grafos','conjuntos','algoritmos']),
('Geometría analítica', 90.00, ARRAY['coordenadas','rectas','cónicas']),
('Métodos numéricos', 86.00, ARRAY['aproximación','iteración','error']),
('Optimización', 87.00, ARRAY['programación lineal','mínimos','máximos']),
('Teoría de grafos', 83.00, ARRAY['nodos','aristas','caminos']),
('Transformada de Fourier', 82.00, ARRAY['series de Fourier','frecuencia','espectro']),
('Transformada de Laplace', 82.00, ARRAY['sistemas lineales','resolución de EDO','dominio s']),
('Funciones', 93.00, ARRAY['mapeos','aplicaciones','relaciones']),
('Polinomios', 89.00, ARRAY['raíces','coeficientes','teorema fundamental']),
('Límites', 91.00, ARRAY['tendencia','epsilon-delta','continuidad']),
('Derivadas', 92.00, ARRAY['diferenciación','tasa de cambio','gradiente']),
('Integrales', 92.00, ARRAY['antiderivadas','área','regla de Barrow']),
('Series', 88.00, ARRAY['convergencia','sumas infinitas','serie de potencias']),
('Regresión', 80.00, ARRAY['ajuste de datos','modelo lineal','predicción']),
('Inferencia estadística', 82.00, ARRAY['estimación','pruebas de hipótesis','intervalos de confianza']),
('Hipótesis', 78.00, ARRAY['H0','H1','contraste']),
('Correlación', 78.00, ARRAY['dependencia','coeficiente de Pearson','asociación']),
('Varianza', 78.00, ARRAY['dispersión','desviación cuadrática','sigma^2']),
('Teorema de Pitágoras', 76.00, ARRAY['triángulo rectángulo','catetos','hipotenusa']),
('Fracciones', 74.00, ARRAY['racionales','proporciones','partes']),
('Logaritmos', 80.00, ARRAY['exponentes inversos','base','ln']),
('Exponenciales', 80.00, ARRAY['crecimiento','decaimiento','e^x']),
('Matrices', 89.00, ARRAY['determinantes','operadores lineales','fila-columna']),
('Vectores', 88.00, ARRAY['dirección','magnitud','componentes']),
('Estadística bayesiana', 80.00, ARRAY['Bayes','probabilidad a posteriori','verosimilitud']);

-- Ejemplos de consulta
-- select * from palabras_clave;

-- Buscar por palabra
-- SELECT * FROM palabras_clave WHERE palabra ILIKE '%álgebra%';

-- Top 10 términos más relacionados
-- SELECT * FROM palabras_clave ORDER BY porcentaje_identidad DESC LIMIT 10;


