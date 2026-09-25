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




<p align="center">
<img width="400" alt="image" src="https://github.com/user-attachments/assets/52b408fa-cf27-420c-b506-d1e81c147fac" />
</p>

<p align="center">
 <strong>Figura 2. Montaje del circuito para capturar las variaciones del volumen sanguíneo periférico.</strong>
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
X_{norm}=
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





















# 2) MATLAB

# 3) "Pruebas y Cold Pressor Test"



# 4) Evolución del SPI en función del tiempo 




# Parte C



# Análisis de los Resultados 



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




