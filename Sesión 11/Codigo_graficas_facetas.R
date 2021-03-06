options(scipen = 999)
library(tidyverse)
library(palmerpenguins)

# Base de datos
bd <- penguins %>% 
  group_by(island) %>% 
  count() %>% 
  ungroup() %>% 
  mutate(pp = 100*n/sum(n)) 

# Barplot con barras apiladas
ggplot(data =  bd, 
       aes(x = "", # Vacio, no lo necesitamos
           y = pp, # Variable de altura de cada barra (canal altura)
           fill = island # Variable que asignará el color de relleno. 
       )) + 
  geom_col() + # Geometría de columnas
  coord_polar(theta = "y", # Variable del angulo. En este caso, transforma los valores de y de tal forma que representen grados y que el total sea igual a 360.
              start = 0 # A partir de que grado inicia el conteo de grados
  ) + 
  theme_void()

# De donut. ---- 
# Barplot con barras apiladas
ggplot(data =  bd, 
       aes(x = 2, # Vacio, no lo necesitamos
           y = n, # Variable de altura de cada barra (canal altura)
           fill = island # Variable que asignará el color de relleno. 
       )) + 
  geom_col() +
  xlim(0,3.5) + # Geometría de columnas
  coord_polar(theta = "y", # Variable del angulo. En este caso, transforma los valores de y de tal forma que representen grados y que el total sea igual a 360.
              start = 0 # A partir de que grado inicia el conteo de grados
  ) +
  xlim(-2,2.45) 
# + 
#   theme_void()

# 4.	En este y los siguientes ejercicios trabajarán con la base de datos que pueden obtener con el siguiente código:
  
presidente <-    
  read_csv("http://segasi.com.mx/clases/cide/datos/cp_2018_dtto.csv")

# Por favor expliquen lo que hace cada línea del siguiente código para preparar los datos. 

presidente_long <- # Guarda lo que viene en este objeto
  presidente %>% # Toma la base de presidente
  select(edo_min, nombre_distrito, cve_dtto, v_meade, v_amlo, v_anaya, 
         v_bronco, v_nulos_bis) %>% # Quedate con estas vars
  pivot_longer(cols = c(v_meade, v_amlo, v_anaya, 
                        v_bronco, v_nulos_bis), 
               names_to = "Candidato", 
               values_to = "Votos")

# -- Conviertela a formato largo, utilizando las variables edo_min, nombre_distrito como variables constantes, los nombres de las columas como categorias dentro de la nueva variable llamada "Candidato" y los valores de dichas Variables metelas a la variable "Votos".

# OJO: NO hemos visto en clase qué hace la función pivot_longer(). Por favor búsquenla en Internet y discutan entre ustedes qué hace y para qué sirve. Les recomiendo correr el código y revisar las características de los tibbles de antes y después.

# -- Discutamos, pues. Igual y pueden revisar este artículo para repasar que hace el pivot_longer (y checar mas sobe escalas):
# https://medium.com/@jorgejuvenalcamposf/visualizando-pirámides-de-población-en-r-143bd9833f28 o en https://juvenalcampos.com/2020/01/26/visualizando-pirámides-de-población-en-r/


# 5.	Utilizando los datos del objeto presidente_long, generen una gráfica de barras que muestre el número total de votos registrados en cada entidad. Puede ser que tengan que  combinar la magia de {dplyr} y {ggplot2}. ----

presidente_long %>% 
  group_by(edo_min) %>% 
  summarise(total_votos_entidad = sum(Votos)) %>% 
  ggplot(aes(x = fct_reorder(edo_min, total_votos_entidad), 
             y = total_votos_entidad)) + 
  geom_col(fill = "navyblue") + 
  geom_text(aes(label = prettyNum(total_votos_entidad, 
                                  big.mark = ",")),
            hjust = -0.01, 
            color = "navyblue", 
            family = "Poppins") + 
  coord_flip() + 
  labs(x = "", y = "", title = "Votos por entidad", caption = "Fuente: Segasi, 2020", subtitle = "Votos obtenidos en total para todas las entidades de la rep. mexicana\nen el proceso electoral del 2018") + 
  scale_y_continuous(expand = c(0,1), 
                     limits = c(0,9.5e6),
                     label = scales::dollar_format(prefix = "")) + 
  theme(text = element_text(family = "Poppins"),
        plot.title = element_text(hjust = 0.5, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, face = "bold"))


# 6.	Utilizando los datos del objeto presidente_long, generen una gráfica de barras que muestre el total de votos obtenido por cada candidato en la Ciudad de México. Puede ser que tengan que  combinar la magia de {dplyr} y {ggplot2}.
unique(presidente_long$edo_min)

presidente_long %>% 
  filter(edo_min == "Ciudad de México") %>% 
  group_by(nombre_distrito) %>% 
  summarise(total_votos_dtto = sum(Votos)) %>% 
  ggplot(aes(x = reorder(nombre_distrito, total_votos_dtto), 
             y = total_votos_dtto)) + 
  geom_col(fill = "navyblue") + 
  geom_text(aes(label = prettyNum(total_votos_dtto, 
                                  big.mark = ",")),
            hjust = -0.01, 
            color = "navyblue", 
            family = "Poppins") + 
  coord_flip() + 
  labs(x = "", y = "", title = "Votos por Distrito CDMX", caption = "Fuente: Segasi, 2020", subtitle = "Votos obtenidos en total para todos los Distritos de la CDMX\nen el proceso electoral del 2018") + 
  scale_y_continuous(expand = c(0,1), limits = c(0,
                                                 2.5e6),
                     label = scales::dollar_format(prefix = "")) + 
  theme(text = element_text(family = "Poppins"),
        plot.title = element_text(hjust = 0.5, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, face = "bold"))

# 7.	Utilizando los datos del objeto presidente_long,  genera una gráfica de barras que muestre el total de votos obtenido por cada candidato en cada distrito en la Ciudad de México, utilizando como variable de facetas el nombre de los distritos. Por favor usen los argumentos disponibles en facet_wrap() para que la matriz de gráficas que generen sea simétrica (puesto de otra forma, no dejen espacios en blanco).
  
presidente_long %>% 
  filter(edo_min == "Ciudad de México") %>% 
  mutate(nombre_distrito = paste0(nombre_distrito, "-", cve_dtto)) %>% 
  group_by(nombre_distrito, Candidato) %>%
  summarise(total_votos_dtto = sum(Votos)) %>%
  ggplot(aes(x = Candidato, 
             y = total_votos_dtto, 
             fill = Candidato)) + 
  geom_col() + 
  geom_text(aes(label = prettyNum(total_votos_dtto, 
                                  big.mark = ",")),
            hjust = -0.01, 
            color = "navyblue", 
            family = "Poppins") + 
  coord_flip() + 
  labs(x = "", y = "", title = "Votos por Candidato en CDMX", 
       caption = "Fuente: Segasi, 2020", 
       subtitle = "Votos obtenidos en total para todos candidatos en los Distritos de la CDMX\nen el proceso electoral del 2018") + 
  scale_y_continuous(expand = c(0,1), limits = c(0,
                                                 2.5e5),
                     label = scales::dollar_format(prefix = "")) + 
  scale_fill_manual(values = c("brown", "blue", "purple", "red", "gray10")) + 
  theme(text = element_text(family = "Poppins"),
        plot.title = element_text(hjust = 0.5, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, face = "bold")) + 
  facet_wrap(~nombre_distrito, 
             nrow = 4)


# 8.	En este y los siguientes ejercicios usarán la base de datos penguins, incluida en el paquete {palmerpenguins}. 
library(palmerpenguins)

# Después de cargar el paquete, elabora una gráfica que relacione en el eje x la masa corporal (body_mass_g) y la longitud de la aleta (flipper_length_mm) a través de un diagrama de dispersión. 

penguins %>% 
  ggplot(aes(x = body_mass_g, y = flipper_length_mm)) + 
  geom_point(alpha = 0.3)


# 9.	Generen la misma gráfica que en el ejercicio anterior, pero ahora asignen la variable species al canal o elemento estético color, y generen una faceta para cada isla (island).

penguins %>% 
  ggplot(aes(x = body_mass_g, 
             y = flipper_length_mm, 
             color  = species)) + 
  geom_point(alpha = 0.6) + 
  facet_wrap(~island) + 
  theme(legend.position = "bottom")
