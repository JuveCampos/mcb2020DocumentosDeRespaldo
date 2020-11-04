options(scipen = 999)
# Librerias
library(tidyverse)

# 1.	¿Cuáles son las tres preguntas que nos debemos hacer antes de crear una visualización? ¿Por qué son relevantes? ¿Cómo guían la elección que hacemos? ----

# 2.	Explica por favor la relación entre marcas, canales, geometrías y elementos estéticos. ¿Cómo se vincula la teoría (mundo de Munzner) con la práctica (mundo de Wickham – {ggplot2})? ----

# Las marcas son los elementos geometricos que muestran elementos y los canales son los elementos que controlan la apariencia de estos. 
# Ref: https://www.taylorfrancis.com/books/9780429088902/chapters/10.1201/b17511-5

# Relación: marcas == geometrías, 
# Relación: canales == Elementos estéticos (posición, color, opacidad, texto...)

# 3.	A partir del siguiente código por favor respondan: ----
  
starwars # PRIMERO LLAMO A LA BASE PARA QUE ESTA SEA PRECARGADA...

bd <- starwars %>% 
  mutate(isYoda = ifelse(test = name == "Yoda", 
                         yes = "Es Yoda", 
                         no = "No es Yoda") %>% 
           factor(levels = c("No es Yoda", "Es Yoda")))


map <- bd %>% #...TOMO LA BASE STARWARS...
  # ENTRO AL MUNDO MÁGICO DE GGPLOT
  ggplot(aes( # DEFINO LOS ELEMENTOS ESTÉTICOS DE LA GRAFICA
    x = height, # DEFINO LA VARIABLE QUE VA A ESTAR EN EL EJE X
    y = mass, # DEFINO LA VARIABLE QUE VA A ESTAR EN EL EJE Y
    color = gender, # DEFINO LA VARIABLE, CUYO VALOR VA A DEFINIR EL COLOR DE CONTORNO DEL ELEMENTO GRÁFICO
    shape = isYoda, 
    size = isYoda
    )) + 
  # AHORA ELIJO UNA CAPA DE GEOMETRÍA COMPATIBLE CON LOS ELEMENTOS ESTÉTICOS DEFINIDOS ARRIBA
  geom_point() 

map %>% 
  plotly::ggplotly()


# SELECCIONO EL ELEMENTO GEOMÈTRICO DE LOS PUNTOS, COMPATIBLE CON LO DE ARRIBA. 


  # a.	¿Cuál es la instrucción detrás de cada línea en el código?

# CONTESTADO ARRIBA

  # b.	¿Qué canales y qué marcas se están utilizando?

# Marcas = Puntos
# Canales = Posición, color. 


  # c.	¿Cambiaría el output al sacar el argumento “color = gender” de la función `aes()`?

# OBVIO MICROBIO... 

  # d.	¿Por qué?
  
# SOLO SE MOSTRARÍA LA UBICACIÓN DE LOS PUNTOS, TODOS DE UN SOLO COLOR. 

# 4.	Para este ejercicio trabajaremos con el paquete {palmerpenguins}. Por favor asegúrense de cargarlo para poder usar los datos. ----

library(palmerpenguins)

bd <- penguins

  # a.	Escribe el código para graficar un diagrama de dispersión que muestre la relación entre “flipper_length_mm” y “body_mass_g”. 

penguins %>% 
  ggplot(aes(x = flipper_length_mm,
                       y = body_mass_g)) + 
  geom_point()

  # b.	Escribe el código para graficar un diagrama de dispersión que muestre la relación entre “flipper_length_mm” y “body_mass_g”, en el que el color de la geometría que empleaste cambie según la especie del pingüino.

bd %>% 
  ggplot(aes(x = flipper_length_mm,
                       y = body_mass_g, 
                       color = species)) + 
  geom_point()

  # c.	Escribe el código para graficar un diagrama de dispersión que muestre la relación entre “flipper_length_mm” y “body_mass_g”, en el que el color de la geometría que empleaste cambie según el sexo del pingüino.

bd %>% 
  ggplot(mapping = aes(x = flipper_length_mm,
                       y = body_mass_g, 
                       color = sex)) + 
  geom_point()

  # d.	Escribe el código para graficar un diagrama de dispersión que muestre la relación entre “flipper_length_mm” y “body_mass_g”, en el que el tono del color de la geometría que usaste sea “salmon” (es uno de los colores que puedes definir por nombre) para todas las unidades.

bd %>% 
  ggplot(mapping = aes(x = flipper_length_mm,
                       y = body_mass_g)) + 
  geom_point(color = "salmon")


# 5.	Identifiquen y corrijan todos los errores que encuentren en el siguiente código: ----
  
diamonds %>% 
  ggplot(aes(x = carat, 
             y = price)) +
  geom_point(aes(color = clarity)) +
  geom_smooth(method = "lm") +
  geom_text(x = 0.5, y = 18000,
            label = "price = -2256 + 7756*carat  R^2 = 0.85")

diamonds %>%
  ggplot() +
  aes(x=carat, y=price) +
  geom_point(aes(color=clarity)) +
  geom_smooth(method="loess")

