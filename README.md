# Cálculo ambulatorio del índice pletismográfico quirúrgico (SPI)

# Parte A

## Procedimiento

1) Para lograr desarrollar un sistema de medición continua del indice pletismográfico (SPI) primero se construyó el circuito de adquisición. Este se hizo a partir del circuito proporcionado en la guiua de laboratorio. Tras hacer el montaje y algunas pruebas, se hicieron algunas modificaciones para adaptar el circuito a las necesidades de la práctica. No se vio necesario agregar la ultima fase de amplificación ya que el circuito captava y mostraba la señal correcta sin el. Además de que fue necesario añadir un offset, para observar la señal en un rango correcto, por medio de la fuente del microcontrolador agregado al circuito con un divisor del voltaje.

<p align="center">
<img width="400"  alt="image" src="https://github.com/user-attachments/assets/c4b0249a-c5be-4507-b2f0-4f7c5450a987" />
</p>
<p align="center">
  <strong>Figura 1. Circuito utilizado para capturar las variaciones del volumen sanguíneo periférico.</strong>
</p>

En el circuito se hace uso de un transistor 2N3904 para controlar la excitación del sensor TCST110. El acoplador óptico TCST110 convierte las variaciones de luz en cambios de corriente, que posteriormente se transforman en una señal de tensión mediante R3. El uso del capacitor C1 y la resistencia R4 permite eliminar parte de la componente continua de la señal. El amplificador operacional LM358 incrementa la amplitud de la señal mediante una configuración no inversora, con una ganancia aproximada de 101 a bajas frecuencias (Av = 1 + R6/R5= 1 + 680kohm / 6.8kohm = 101). C2 modifica la respuesta en frecuencia de la realimentación para reducir componentes de alta frecuencia. Por ultimo, C3, C4, R7 y R8 funcionan como un divisor de voltaje para reducir los 3.3 v de la ESP32 a 1.6v para agregar un offset a la señal.

<p align="center">
<img width="1280" height="720" alt="image" src="https://github.com/user-attachments/assets/0fd8dab3-c10a-4096-aba0-a63fafcdb85f" />
  </p>
<p align="center">
  <strong>Figura 2. Montaje de circuito utilizado para capturar las variaciones del volumen sanguíneo periférico.</strong>
</p>

2) Para hacer este montaje, se modifico el acoplador óptico TCST110 de manera que el fototransitor y el led no estuvieran mirandose entre sí, sino que ambos estuvieran mirando hacia arriba para que al poner el dedo el led transmitiera luz por medio del tejido y el fototransitor detectara su salida para identificar la onda pletismográfica del sujeto.

<p align="center">
<img width="1505" height="1567" alt="image" src="https://github.com/user-attachments/assets/809d5ae9-f567-42e0-8661-a0f6bfbfbfb1" />
  </p>
<p align="center">
  <strong>Figura 3. Sensor modificado para capturar las variaciones del volumen sanguíneo periférico.</strong>
</p>

3) Utilizando el microcontrolador ESP32 al igual que un osciloscopio, se verificó que el circuito era capaz de registrar las variaciones del volumen sanguíneo periférico.

<p align="center">
<img width="400" alt="image" src="https://github.com/user-attachments/assets/52b408fa-cf27-420c-b506-d1e81c147fac" />
</p>
<p align="center">
 <strong>Figura 4. Montaje del circuito capturarando variaciones del volumen sanguíneo periférico en sujeto.</strong>
</p>

<p align="center">
<img width="1280" height="960" alt="image" src="https://github.com/user-attachments/assets/b6dc24e7-fca7-4416-91e1-acc9e0613f85" />
</p>
<p align="center">
 <strong>Figura 5. Registro de variaciones de volumen sanguíneo periférico por medio de osciloscopio.</strong>
</p>

<p align="center">
<img width="1600" height="749" alt="image" src="https://github.com/user-attachments/assets/04ee7a0e-6c98-4772-8b4b-acd7e3388076" />
</p>
<p align="center">
 <strong>Figura 6. Registro de variaciones de volumen sanguíneo periférico por medio de arduino ESP32. </strong>
</p>

# Parte B
# 1) Revisión de la literatura

La fotopletismografía (PPG, Photoplethysmography) es una técnica óptica no invasiva utilizada para detectar variaciones en el volumen sanguíneo de los tejidos. La señal obtenida mediante PPG presenta una componente pulsátil asociada principalmente con las variaciones del volumen sanguíneo producidas por cada ciclo cardíaco y una componente de baja frecuencia relacionada con cambios más lentos en las condiciones ópticas y fisiológicas del tejido. Debido a que permite registrar de manera sencilla las variaciones del flujo y volumen sanguíneo periférico, la PPG es utilizada ampliamente en sistemas de monitorización fisiológica [1].

Durante la anestesia general, las variaciones de la señal fotopletismográfica pueden utilizarse para estudiar respuestas asociadas con la activación del sistema nervioso autónomo frente a estímulos nociceptivos. A partir de este principio se desarrolló el Surgical Pleth Index (SPI), inicialmente denominado Surgical Stress Index (SSI), como un índice destinado a proporcionar una medida cuantitativa de la respuesta relacionada con el estrés quirúrgico y el balance entre nocicepción y antinocicepción durante la anestesia general [2].

El SPI se obtiene a partir de dos características fisiológicas derivadas de la señal fotopletismográfica: la amplitud de la onda de pulso fotopletismográfica (PPGA, Photoplethysmographic Pulse Wave Amplitude) y el intervalo entre latidos (HBI, Heart Beat Interval). Estas variables son normalizadas y posteriormente combinadas mediante una suma ponderada para obtener un índice adimensional con valores entre 0 y 100 [2], [3].

La expresión matemática del SPI puede escribirse como:

$$
\boxed{
SPI = 100 - \left(0.7 \cdot PPGA_{norm} + 0.3 \cdot HBI_{norm}\right)
}
$$


donde ( $$PPGA_{norm} $$) corresponde a la amplitud de la onda pletismográfica normalizada y ($$HBI_{norm}$$) corresponde al intervalo entre latidos normalizado. La ecuación muestra que el SPI combina ambas variables para generar un valor único que representa cambios en la respuesta fisiológica asociada con la nocicepción [2].

En algunas publicaciones y documentos técnicos, los coeficientes de la ecuación aparecen expresados aproximadamente como 0.67 y 0.33. Por esta razón, la ecuación también puede encontrarse escrita como:

$$
\boxed{
SPI=100-\left(0.67,PPGA_{norm}+0.33,HBI_{norm}\right)
}
$$

Estas dos formas representan la misma estructura matemática: una combinación ponderada de las variables normalizadas de la amplitud pletismográfica y del intervalo entre latidos. La literatura utiliza esta formulación para representar mediante un único índice las modificaciones producidas en estas variables durante diferentes niveles de estimulación nociceptiva [2], [3].

La normalización de las variables permite llevarlas a una escala común antes de realizar la combinación ponderada. De forma general, una normalización min–max puede expresarse como:

$$
\boxed{
X_{norm}= 100  *
\frac{X-X_{min}}
{X_{max}-X_{min}}
}
$$

donde (X) corresponde al valor medido de la variable, ($$X_{min}$$) corresponde al límite inferior utilizado para la normalización y ($$X_{max}$$) al límite superior. De esta manera, el resultado queda expresado en una escala comparable con las demás variables que participan en el cálculo [2].

La PPGA corresponde a la amplitud de la onda de pulso registrada mediante PPG. Esta amplitud puede disminuir como consecuencia de la vasoconstricción periférica asociada con un incremento de la actividad simpática. Por otro lado, el HBI corresponde al intervalo temporal entre dos latidos cardíacos consecutivos. Las modificaciones de esta variable permiten incorporar al índice información relacionada con los cambios de la actividad cardiovascular y autonómica [2], [4].

La relación entre las variables utilizadas por el SPI puede representarse conceptualmente mediante el siguiente procedimiento:

$$
\boxed{
\text{Señal PPG}
\rightarrow
\text{detección de pulsos}
\rightarrow
PPGA
}
$$

y:

$$
\boxed{
\text{Señal PPG}
\rightarrow
\text{detección de latidos}
\rightarrow
HBI
}
$$

Posteriormente, ambas variables son normalizadas:


$$
\boxed{
PPGA\rightarrow PPGA_{norm}
}
$$

$$
\boxed{
HBI\rightarrow HBI_{norm}
}
$$

y finalmente se calcula:

$$
\boxed{
PPGA_{norm}+HBI_{norm}
\rightarrow SPI
}
$$

De acuerdo con Huiku et al., el desarrollo del SPI se fundamentó en la relación existente entre las variables derivadas de la PPG y la respuesta fisiológica observada durante estímulos quirúrgicos y diferentes niveles de analgesia. El índice fue diseñado para proporcionar una medida objetiva que pudiera complementar las variables hemodinámicas tradicionales durante la anestesia general [2].

El significado fisiológico del SPI está relacionado principalmente con la activación del sistema nervioso autónomo. Una mayor activación simpática puede producir vasoconstricción periférica y, como consecuencia, modificar la amplitud de la señal PPG. Al mismo tiempo, los cambios en la actividad cardiovascular pueden modificar el intervalo entre latidos. Por esta razón, las dos variables utilizadas en el SPI permiten integrar información relacionada con la respuesta autonómica frente a estímulos nociceptivos [2], [4].

Sin embargo, el SPI no constituye una medición directa del dolor. La nocicepción corresponde al procesamiento neural de estímulos potencialmente dañinos, mientras que el dolor es una experiencia sensorial y emocional que no puede determinarse exclusivamente mediante una señal fisiológica. Esta diferencia es particularmente importante durante la anestesia general, donde el paciente no puede comunicar directamente su percepción. En este contexto, el SPI busca proporcionar información objetiva sobre la respuesta fisiológica asociada con la nocicepción, pero debe interpretarse junto con otras variables y con las condiciones clínicas del paciente [3], [5].

Bonhomme et al. compararon el SPI con variables hemodinámicas durante la anestesia general y encontraron que el índice podía proporcionar información adicional relacionada con el balance entre nocicepción y antinocicepción. No obstante, las respuestas fisiológicas utilizadas por el SPI también pueden modificarse por factores diferentes al estímulo nociceptivo, por lo que un cambio en el índice no debe interpretarse automáticamente como una medida directa de la intensidad del dolor [4].

Entre los factores que pueden afectar la señal PPG se encuentran la perfusión periférica, el tono vascular, la temperatura, los cambios hemodinámicos y otros factores que modifican la circulación periférica. Asimismo, existe variabilidad individual en la respuesta del sistema nervioso autónomo. Por estas razones, el SPI presenta limitaciones cuando se pretende utilizar como único indicador de nocicepción y su interpretación debe realizarse considerando el contexto fisiológico y las demás variables disponibles [3], [5].

### Detección de picos y valles en señales PPG (Método del alpinista)

La detección de picos y valles constituye una etapa fundamental en el procesamiento de señales fotopletismográficas (PPG), debido a que permite identificar las pulsaciones individuales y extraer características temporales y morfológicas de cada ciclo cardíaco. Argüello-Prada propuso el *Mountainner's Method for Peak Detection* (MMPD), un método diseñado específicamente para detectar picos sistólicos y valles en señales PPG. El algoritmo se basa en analizar la tendencia ascendente y descendente de la señal mediante el conteo de muestras consecutivas que mantienen una determinada pendiente, permitiendo localizar los puntos característicos de cada pulsación. [8]

El método MMPD utiliza un umbral para determinar cuándo una variación en la pendiente de la señal puede corresponder a un pico o un valle. Inicialmente, el algoritmo establece un valor de seis muestras y posteriormente actualiza el umbral de acuerdo con el número de pasos consecutivos identificados mediante la expresión:

$$
\boxed{threshold=0.6,num_steps}
$$

donde (num_steps) corresponde al número de muestras consecutivas que mantienen la misma tendencia. Este procedimiento permite adaptar la detección a cambios en la señal y disminuir la dependencia de una amplitud fija, aspecto relevante debido a que la amplitud de la señal PPG puede variar entre sujetos y bajo diferentes condiciones de adquisición. [8]

La detección adecuada de estos puntos es especialmente relevante para el análisis posterior de la señal PPG, ya que permite delimitar cada pulsación y obtener variables como la amplitud del pulso y el intervalo temporal entre latidos. En el contexto del Surgical Pleth Index (SPI), estas características son necesarias para obtener los parámetros asociados con la amplitud de la señal fotopletismográfica y con el intervalo entre latidos, que posteriormente participan en el cálculo del índice. Por lo tanto, aunque el método MMPD no corresponde al algoritmo de cálculo del SPI, constituye una referencia importante para la etapa de procesamiento y detección de eventos de la señal PPG requerida antes de calcular dicho índice. [8]

Otro aspecto relevante señalado por Argüello-Prada es la influencia que pueden tener el ruido y los artefactos de movimiento sobre la detección de picos y valles. El estudio evaluó el comportamiento de diferentes algoritmos bajo distintas amplitudes de señal y condiciones de movimiento, mostrando que la reducción de la amplitud y la presencia de artefactos pueden aumentar la dificultad para identificar correctamente los eventos de la señal. Esto evidencia la importancia de realizar una adecuada adquisición y procesamiento de la señal PPG antes de utilizar sus características para análisis fisiológicos. [8]



### Cold Pressor Test

El Cold Pressor Test (CPT) es una maniobra experimental utilizada para provocar una respuesta cardiovascular y autonómica mediante la exposición de una extremidad, generalmente una mano, a agua fría. La aplicación de este estímulo activa mecanismos del sistema nervioso autónomo y puede producir modificaciones en variables cardiovasculares como la presión arterial y la frecuencia cardíaca. Por esta razón, el CPT puede utilizarse como una maniobra experimental para estudiar la respuesta fisiológica frente a un estímulo aversivo [6].

Wirch et al. evaluaron el CPT como una técnica para estudiar la función autonómica cardiovascular y observaron cambios en la actividad simpática y parasimpática durante la exposición al frío. Estos resultados respaldan el uso del CPT como un estímulo capaz de producir una respuesta autonómica medible [6].

Para esta práctica, la utilización del CPT resulta relevante porque permite generar un estímulo fisiológico controlado durante la adquisición de la señal PPG. La guía establece que el voluntario debe registrar inicialmente el SPI durante 40 segundos, realizar posteriormente el CPT durante otros 40 segundos y finalmente regresar a las condiciones iniciales durante los últimos 40 segundos de la captura de dos minutos.

Por lo tanto, experimentalmente se espera comparar tres condiciones:


$$
\boxed{
\text{Reposo inicial}
\rightarrow
\text{CPT}
\rightarrow
\text{Recuperación}
}
$$

Durante cada una de estas etapas se puede observar la evolución de la señal PPG, calcular las variables necesarias y determinar el SPI correspondiente a cada pulsación. Esto permite analizar si la respuesta autonómica producida por el CPT se acompaña de modificaciones en las características de la señal pletismográfica y, en consecuencia, en el valor calculado del SPI.

Es importante considerar que la respuesta al CPT depende de las condiciones experimentales, incluyendo la temperatura del agua, la duración de la exposición y las características individuales del participante. Por esta razón, estos parámetros deben mantenerse controlados y registrarse durante la práctica para facilitar la interpretación de los resultados [6], [7].

En conclusión, la literatura establece que el SPI es un índice derivado de variables obtenidas principalmente a partir de la señal fotopletismográfica y del intervalo entre latidos. Su formulación matemática combina las variables normalizadas mediante una suma ponderada, de acuerdo con:

$$
\boxed{
SPI=100-\left(0.7,PPGA_{norm}+0.3,HBI_{norm}\right)
}
$$

El análisis de estas variables permite estudiar cambios fisiológicos asociados con la actividad autonómica durante estímulos nociceptivos. En la presente práctica, la adquisición de la PPG y la aplicación del CPT permiten estudiar experimentalmente la relación entre las variaciones del volumen sanguíneo periférico, la respuesta autonómica y el SPI, teniendo en cuenta que este índice no constituye por sí mismo una medición directa de la percepción subjetiva del dolor [2]–[7].




















## Procedimiento:
### 2) MATLAB

Se desarrolló un código en MATLAB para adquirir la señal fotopletismográfica proveniente del circuito de la Parte A y de la ESP32-S3. Inicialmente, el programa limpia las variables y configura los parámetros de adquisición: el puerto serial COM6, una velocidad de transmisión de 115200 baudios, una frecuencia de muestreo de 100 Hz y una duración de captura de 120 segundos. Con estos parámetros se registran un total de 12000 muestras.

Posteriormente, el código crea la conexión serial con la ESP32-S3 y configura el terminador de línea LF, ya que el microcontrolador envía cada muestra como una línea de texto. Después de esperar dos segundos para permitir el reinicio de la placa, se eliminan los datos anteriores almacenados en el búfer serial.

Durante la etapa de adquisición, MATLAB lee cada línea enviada por la ESP32-S3 y la convierte a un valor numérico. Únicamente se almacenan las muestras válidas; de esta manera se genera el vector senalCruda, correspondiente a la señal PPG registrada durante los 120 segundos.

Una vez finalizada la captura, se construye el vector de tiempo a partir de la frecuencia de muestreo. La señal cruda se suaviza utilizando un promedio móvil de cinco muestras mediante la función movmean. Este procesamiento reduce las variaciones rápidas y el ruido presente en la señal, sin modificar de forma significativa la forma general de los pulsos.

Para identificar las características de cada pulso se implementó el método del alpinista o Mountaineer’s Method for Peak Detection (MMPD). El algoritmo analiza los cambios ascendentes y descendentes de la señal suavizada. Cuando detecta una subida con una cantidad suficiente de muestras consecutivas, identifica un posible pico sistólico; además, localiza el valor mínimo anterior como valle de la señal.

El método utiliza inicialmente un umbral de seis muestras consecutivas en ascenso. Después de detectar un pico, este umbral se ajusta de forma adaptativa al 60 % del número de muestras ascendentes detectadas. Esto permite que el algoritmo se adapte a variaciones en la forma y duración de los pulsos PPG.

A partir de los picos sistólicos detectados se calcula una frecuencia cardíaca aproximada. Para ello, se determina el intervalo temporal entre picos consecutivos y se utiliza la relación:

$$ FC = \frac{60}{\overline{RR}} $$

donde RR corresponde al promedio de los intervalos entre picos, expresado en segundos. El resultado se muestra en la ventana de comandos de MATLAB en latidos por minuto.

Finalmente, el programa genera dos gráficas. La primera corresponde a la señal PPG cruda adquirida desde la ESP32-S3. La segunda presenta la señal suavizada junto con los picos sistólicos y valles detectados por el método del alpinista. Además, se guardan el tiempo, la señal cruda y la señal suavizada en el archivo senal_ppgs.csv, el cual se utiliza posteriormente para calcular y representar la evolución temporal del SPI

El código completo utilizado para la adquisición, procesamiento y detección de picos y valles se encuentra disponible en el siguiente enlace:

**Código 1.** [Adquisición de señal PPG y método del alpinista](METODODELALPINIST120SEG.m)

### 3) "Pruebas y Cold Pressor Test"

Para evaluar los cambios en la señal PPG y en el SPI estimado ante un estímulo térmico, se realizó una prueba de 120 segundos con un voluntario sano. Durante toda la prueba, el voluntario permaneció sentado y mantuvo el dedo índice sobre el sensor óptico de reflectancia, procurando no ejercer cambios bruscos de presión ni realizar movimientos que pudieran generar artefactos en la señal.

La adquisición se dividió en tres etapas de 40 segundos. Durante los primeros 40 segundos se registró la señal en condición basal o de reposo. Esta etapa permitió obtener una referencia inicial de las características de la señal PPG y del SPI antes de aplicar el estímulo.

Entre los segundos 40 y 80 se aplicó un estímulo frío mediante una botella previamente enfriada. La botella se ubicó en la región cervical y superior del tórax del voluntario, mientras el dedo utilizado para la adquisición permaneció fijo sobre el sensor. De esta manera, se buscó inducir una respuesta autonómica asociada con la exposición al frío sin interrumpir el registro de la señal PPG.

Finalmente, entre los segundos 80 y 120 se retiró la botella fría y se continuó el registro durante la etapa de recuperación. Esta fase permitió observar el comportamiento de la señal y del SPI estimado después de finalizar el estímulo térmico.

La prueba realizada corresponde a una adaptación del Cold Pressor Test (CPT). En el CPT convencional, una extremidad se sumerge en agua fría; en este caso, se utilizó una botella enfriada como fuente de estímulo frío. Por esta razón, los resultados obtenidos se interpretan como una respuesta fisiológica al frío dentro de las condiciones experimentales del laboratorio y no como una medición clínica de dolor o nocicepción.

Durante las tres etapas se almacenó la señal adquirida en un archivo CSV. Posteriormente, dicho archivo fue procesado mediante el código de verificación del SPI para obtener un valor estimado por cada latido y representar su evolución en función del tiempo.

<p align="center">
 <img width="1280" height="960" alt="image" src="https://github.com/user-attachments/assets/552d9dad-dca4-4594-92a0-f2002c77ab19" />

</p>

<p align="center">
  <strong>Figura 7. Montaje experimental durante la adquisición basal de la señal PPG.</strong>
</p>

<p align="center">
  <img width="1280" height="960" alt="image" src="https://github.com/user-attachments/assets/7391625e-7985-4c63-8f16-633ffc7ef36d" />

</p>

<p align="center">
  <strong>Figura 8. Conexión del sensor óptico y ubicación del dedo del voluntario durante la adquisición.</strong>
</p>

<p align="center">
 <img width="1280" height="960" alt="image" src="https://github.com/user-attachments/assets/2826f710-0afa-46f3-a684-a7fa23da42dc" />

</p>

<p align="center">
  <strong>Figura 9. Aplicación del estímulo frío adaptado mediante una botella previamente enfriada, sin interrumpir la adquisición de la señal PPG.</strong>
</p>


### 4) Evolución del SPI en función del tiempo 

Una vez finalizada la adquisición de la señal PPG, se utilizó el archivo CSV generado por el primer código para calcular la evolución temporal del Surgical Pleth Index (SPI). Para ello se empleó el código **SPI_VERIFICADOR.m**, el cual lee la señal almacenada y realiza nuevamente el procesamiento necesario para obtener el SPI asociado a cada latido.

Inicialmente, el programa carga las columnas de tiempo, señal PPG cruda y señal PPG suavizada desde el archivo CSV. Posteriormente, aplica el método del alpinista de manera interna para identificar los picos sistólicos y valles de la señal. Estos eventos no se muestran en la gráfica final, pero son necesarios para extraer las variables fisiológicas utilizadas en el cálculo del índice.

Para cada pulsación se obtiene la amplitud de la onda pletismográfica, PPGA, calculada como la diferencia entre el pico sistólico y el valle anterior. También se calcula el intervalo entre latidos, HBI, a partir de la diferencia de tiempo entre picos sistólicos consecutivos. Ambas variables se normalizan entre 0 y 100 y se combinan mediante la ecuación:

$$
SPI = 100 - \left(0.7 \cdot PPGA_{norm} + 0.3 \cdot HBI_{norm}\right)
$$

El resultado es un valor de SPI estimado para cada latido detectado. Finalmente, el programa representa estos valores en una gráfica en función del tiempo, con un rango entre 0 y 100. La gráfica permite comparar el comportamiento del índice durante las tres etapas del protocolo experimental: reposo inicial, aplicación del estímulo frío y recuperación.

El código utilizado para esta etapa se encuentra disponible en el siguiente enlace:

**Código 2.** [Cálculo y gráfica de SPI por latido](SPI_VERIFICADOR.m)


# Resultados

## Detección de picos y valles mediante el método del alpinista

La Figura 10 presenta el procesamiento completo de la señal PPG adquirida durante 120 segundos. La señal fue suavizada mediante una media móvil y posteriormente se aplicó el método del alpinista para identificar los picos sistólicos y los valles asociados a cada latido. La detección se mantuvo durante las tres etapas del protocolo.

<p align="center">
<img width="1600" height="485" alt="image" src="https://github.com/user-attachments/assets/c4635e1a-06d5-494f-a7c3-a1c45e6deaf9" />
<p align="center">
  <strong>Figura 10. Señal PPG registrada durante 120 s y detección de picos sistólicos y valles mediante el método del alpinista.</strong>
</p>

## Acercamientos de la señal PPG durante el protocolo

Con el fin de observar con mayor detalle la forma de onda y la detección realizada, se seleccionaron segmentos representativos de las etapas de reposo, estímulo frío y recuperación.

<p align="center">
<img width="1600" height="499" alt="image" src="https://github.com/user-attachments/assets/d6318f3a-9323-4985-ab99-6a5b6583ca1c" />
<p align="center">
  <strong>Figura 11. Acercamiento de la señal PPG durante la etapa de reposo (aproximadamente entre 23 y 37 s).</strong>
</p>

<p align="center">
<img width="1593" height="506" alt="image" src="https://github.com/user-attachments/assets/34b22c74-057c-4f1d-b882-abd5b1f9b399" />
<p align="center">
  <strong>Figura 12. Acercamiento de la señal PPG durante la aplicación del estímulo frío adaptado (aproximadamente entre 41 y 61 s).</strong>
</p>

<p align="center">
<img width="1600" height="502" alt="image" src="https://github.com/user-attachments/assets/cf2fa7bf-924f-411f-ba46-6b6a51394ed1" />
<p align="center">
  <strong>Figura 13. Acercamiento de la señal PPG durante la etapa de recuperación (aproximadamente entre 95 y 109 s).</strong>
</p>

## Evolución temporal del SPI

A partir de los picos y valles detectados se calculó la amplitud de pulso fotopletismográfica (PPGA) y el intervalo entre latidos (HBI). Estas variables se normalizaron y se combinaron para obtener un valor de SPI por cada latido. La Figura 14 muestra la evolución del índice durante los 120 segundos del protocolo.

<p align="center">
<img width="1600" height="742" alt="image" src="https://github.com/user-attachments/assets/e7198dc9-1d38-4d11-b12f-2772b1609e33" />
<p align="center">
  <strong>Figura 14. Señal PPG, picos y valles detectados, y evolución del SPI calculado para cada latido durante el protocolo de reposo, estímulo frío adaptado y recuperación.</strong>
</p>

## Resumen cuantitativo por etapa

La Tabla 1 resume los valores de SPI estimados para cada etapa del protocolo. Además del promedio, se reporta la mediana para reducir la influencia de valores atípicos, como el pico puntual de SPI igual a 100 observado durante la aplicación del estímulo frío.

| Etapa | Intervalo (s) | Latidos analizados | SPI promedio | SPI mediano | SPI mínimo | SPI máximo | FC promedio (lpm) |
|---|---:|---:|---:|---:|---:|---:|---:|
| Reposo basal | 0–40 | 66 | 27.92 | 24.77 | 2.50 | 52.22 | 101.1 |
| Estímulo frío adaptado | 40–80 | 68 | 51.88 | 51.90 | 32.44 | 100.00 | 101.2 |
| Recuperación | 80–120 | 68 | 30.94 | 29.42 | 15.00 | 51.46 | 103.3 |

<p align="center">
  <strong>Tabla 1. Resumen de los valores de SPI y de frecuencia cardíaca estimados durante las tres etapas del protocolo.</strong>
</p>

# Análisis de los Resultados 

En esta práctica de laboratorio se buscó reconocer las características fundamentales de la onda pulso y construir un sistema de obtención de SPI. Para esto se construyó un sistema ambulatorio de medición continua del índice pletismográfico quirúrgico. A este se le validó el funcionamiento mediante la medición de SPI durante una respuesta fisiológica parecida al dolor agudo. En la tabla 1 se observa como los resultados muestran un cambio significante del SPI cuando se aplica el estímulo frío. En promedio, el valor de SPI aumenta considerablemente durante el estimulo, pasando de 27.92 a 51.88. Esto es un incremento del 85.82% (51.88 - 27.92 = 23.96 / 27.92 = 0.8582 *100 = 85.82 %) respecto al valor basal. En el periodo de recuperación, el SPI disminuyó a un promedio de 30.94 acercandose nuevamente al valor basal. Esto indica que la respuesta que fue producida durante el estimulo frio fue transitoria y asociada temporalmente al frío. Otro factor a considerar es que el promedio (51.88) y la mediana (51.90) del SPI en el estímulo son valores muy cercanos sugiere que el comportamiento central se encuentra alrededor de 52, siendo much más representativos de la etapa completa que los máximos y minimos. En las etapas basales y de recuperación los valores de promedio y mediana también son cercanos, mostrando que los rangos de valores se encuentran relativamente correctos.

Continuando, se diferencia una relación entre la amplitud de la señal PPG y el aumento del SPI. En la figura 14 se visualiza como durante el estímulo la amplitud de la señal PPG disminuye mientras que el SPI aumenta. Esta relación está vinculada a la ecuación de SPI: 

$$
\boxed{
SPI = 100 - \left(0.7 \cdot PPGA_{norm} + 0.3 \cdot HBI_{norm}\right)
}
$$

Ya que este valor depende tanto del pulso fotopletismográfico (PPGA) como el intervalo entre latidos (HBI). Fisiológicamente, una activación simpática puede producir vasoconstricción periférica, reduciendo la amplitud de la señal PPG. Esto es precisamente lo que logra el estímulo frío. El aumento de SPI observado durante el estímulo frío es compatible con una respuesta autonómica periférica ante el estímulo térmico. Sin embargo, es necesario resaltar que los resultados no determinan si el sujeto experimentó una determinada intensidad de dolor. 

Por otro lado, la disminución durante la recuperación demuestra que, una vez se retira el estimulo, la respuesta tendió a regresar a los valores en condición basal. A pesar de esto, los valores no son iguales a los basales, lo cuál es atribuible a que la respuesta autonómica no desaparece instantaneamente, a la variación fisiológica normal o factores de la adquisición de la señal. En cuento a la frecuencia cardiaca, la diferencia entre reposo y estímulo fue muy mínima, con tan solo 0.1 lpm de diferencia. En contraste, el SPI aumentó por casi 24. Con esto se puede analizar que el cambio del SPI no estuvo acompañado por un cambio importante en la frecuencia cardíaca promedio. El SPI va a depender de la amplitud de la señal PPG y el intervalo entre latidos, pero se observó como una modificación importante del SPI puede producirse principalmente por cambios en la señal pletismográfica y no necesariamente por una gran modificación de la frecuencia cardíaca.

Continuando, en la figura 11 se visualiza una regularidad en la señal PPG antes del estímulo. En esta etapa, se produce la señal de referencia basal del experimento, y con ella se identifica la forma consistente de cada ciclo cardiáco. En la figura 12, se evidencia una modificación de las características fisiológicas extraídas de la señal PPG. La señal pierde amplitud, asociado a cambios en la perfusión periférica y en la respuesta autonómica inducida por el frío. Con la figura 13, la señal vuelve a aumentar su amplitud para eventualmente regresar a sus valores basales.



# Conclusión


# Preguntas

**• Pregunta 1: ¿Cómo se relacionan las variaciones del volumen sanguíneo
periférico con el balance autonómico?**

Las variaciones del volumen sanguíneo periférico observadas mediante la fotopletismografía (PPG) se relacionan principalmente con los cambios en el tono vascular producidos por el sistema nervioso autónomo. Ante una mayor activación simpática, se produce vasoconstricción de los vasos periféricos, lo que disminuye el volumen sanguíneo pulsátil en el tejido y, por tanto, puede reducir la amplitud de la onda PPG. Por el contrario, una menor vasoconstricción periférica puede favorecer una mayor amplitud de la componente pulsátil de la señal. Por esta razón, la amplitud de la PPG puede utilizarse como indicador indirecto de cambios en la actividad autonómica, aunque no constituye una medición directa del balance simpático-parasimpático. 

Esta relación es importante para el Surgical Pleth Index (SPI), debido a que el índice utiliza información obtenida de la señal fotopletismográfica, específicamente la amplitud de la onda de pulso, junto con el intervalo entre latidos. Durante un estímulo nociceptivo, el incremento de la respuesta simpática puede producir vasoconstricción periférica y una disminución de la amplitud de la PPG; estos cambios contribuyen al aumento del SPI. Sin embargo, la señal también puede verse afectada por factores como la perfusión periférica, el estado hemodinámico, la temperatura y los artefactos de movimiento, por lo que los cambios del SPI deben interpretarse dentro del contexto fisiológico del paciente. 


**• Pregunta 2: ¿Cómo se compara el SPI con otros índices comúnmente
empleados en cirugía, como el índice nocicepción-analgesia (ANI) y el
índice de perfusión?**

El Surgical Pleth Index (SPI) y el Analgesia Nociception Index (ANI) son índices no invasivos utilizados durante la anestesia para evaluar cambios asociados con el balance entre nocicepción y antinocicepción, pero se basan en señales fisiológicas diferentes. El SPI se obtiene principalmente a partir de la señal fotopletismográfica y combina información relacionada con la amplitud de la onda de pulso y el intervalo entre latidos. El ANI, en cambio, se calcula a partir de la variabilidad de la frecuencia cardíaca y está relacionado principalmente con la actividad parasimpática. Por lo tanto, mientras el SPI incorpora una respuesta predominantemente periférica vascular junto con información cardíaca, el ANI se basa en la dinámica de la frecuencia cardíaca y la variabilidad de los intervalos entre latidos. 

El índice de perfusión (PI), por su parte, también se obtiene a partir de una señal PPG, pero su finalidad es diferente. El PI representa la relación entre el componente pulsátil y el componente no pulsátil de la señal óptica y se utiliza como indicador de la perfusión periférica. Por esta razón, un cambio en el PI puede reflejar modificaciones en la perfusión o en el tono vascular, pero el PI por sí mismo no constituye un índice específico de nocicepción. En contraste, el SPI fue desarrollado específicamente para proporcionar una medida relacionada con el balance nocicepción-antinocicepción durante la anestesia. 

En estudios comparativos, tanto SPI como ANI han mostrado cambios ante estímulos nociceptivos durante la anestesia. Sin embargo, sus respuestas no son idénticas porque se basan en mecanismos fisiológicos diferentes. Un estudio que comparó directamente ambos índices durante anestesia con sevoflurano y remifentanilo encontró que tanto ANI como SPI detectaron cambios asociados con eventos nociceptivos, lo que evidencia que pueden proporcionar información complementaria sobre la respuesta del organismo. 


# Referencias

[1] J. Allen, “Photoplethysmography and its application in clinical physiological measurement,” Physiological Measurement, vol. 28, no. 3, pp. R1–R39, 2007, doi: 10.1088/0967-3334/28/3/R01.

[2] M. Huiku, K. Uutela, M. van Gils, I. Korhonen, M. Kymäläinen, P. Meriläinen, M. Paloheimo, M. Rantanen, P. Takala, H. Viertiö-Oja, and A. Yli-Hankala, “Assessment of surgical stress during general anaesthesia,” British Journal of Anaesthesia, vol. 98, no. 4, pp. 447–455, 2007, doi: 10.1093/bja/aem004.

[3] T. Ledowski, “Objective monitoring of nociception: a review of current commercial solutions,” British Journal of Anaesthesia, vol. 123, no. 2, pp. e312–e321, 2019, doi: 10.1016/j.bja.2019.03.024.

[4] V. Bonhomme, K. Uutela, G. Hans, I. Maquoi, J. D. Born, and J. F. Brichant, “Comparison of the Surgical Pleth Index™ with haemodynamic variables to assess nociception-anti-nociception balance during general anaesthesia,” British Journal of Anaesthesia, vol. 106, no. 1, pp. 101–111, 2011, doi: 10.1093/bja/aeq291.

[5] S. Funcke, S. Sauerlaender, H. O. Pinnschmidt, B. Saugel, K. Bremer, D. A. Reuter, R. Nitzschke, et al., “Validation of innovative techniques for monitoring nociception during general anesthesia: a clinical study using tetanic and intracutaneous electrical stimulation,” Anesthesiology, vol. 127, no. 2, pp. 272–283, 2017, doi: 10.1097/ALN.0000000000001670.

[6] J. L. Wirch, L. A. Wolfe, T. L. Weissgerber, and G. A. L. Davies, “Cold pressor test protocol to evaluate cardiac autonomic function,” Applied Physiology, Nutrition, and Metabolism, vol. 31, no. 3, pp. 235–243, 2006, doi: 10.1139/h05-018.

[7] S. Fanninger, P. L. Plener, M. J. M. Fischer, O. D. Kothgassner, and A. Goreis, “Water temperature during the cold pressor test: A scoping review,” Physiology & Behavior, vol. 271, Art. no. 114354, 2023, doi: 10.1016/j.physbeh.2023.114354.

[8] E. J. Argüello-Prada, “The mountaineer's method for peak detection in photoplethysmographic signals,” *Revista Facultad de Ingeniería, Universidad de Antioquia*, no. 90, pp. 42–50, Jan.–Mar. 2019.




