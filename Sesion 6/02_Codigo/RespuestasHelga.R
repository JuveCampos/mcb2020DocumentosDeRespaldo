#Laboratorio 25 de septiembre

#Preguntas:----

#1. Importar toda la base de pobreza a nivel municipal y guardarla en bd_pobreza_mpo.
#Todas las columnas con datos pero el menos posible de renglones vacíos.
#OJO: variables tipo numeric

#2. Usando select() conservar sólo:
#claves y nombres de entidad y municipio
#poblacion 2015
#variables de pobreza extrema con valores para 2015
#porcentaje de población con ingreso inferior a la línea de bienestar en 2015

#3. Usando filter() y select() eliminen los renglones intermedios que están vacíos y elijan nombres sustantivos para las variables

#4. Usando select() o relocate(), reordenen las columnas para que el porcentaje de población con ingreso inferior a la línea de bienestar en 2015 aparezca al lado de población 2015.

#5. Por favor respondan cuántos municipios de veracruz tuvieron un nivel de pobreza extrema entre el 19% y el 29% en 2015. Respalden con código.

#6. ¿Consideraron necesario asignar el objeto al pasar de una pregunta a otra?



#Respuestas:----
#Paquetes:
library(tidyverse) #o library(dyplyr)
library(readxl)
#Importar:
bd_pobreza_mpo <- read_excel("01_datos/Concentrado, indicadores de pobreza.xlsx",
                                   sheet = "Concentrado municipal", 
                                   col_types = c("text","text", "text", "text", "text", 
                                                 "numeric", "text",  "text",  "text",  "text",
                                                 "text", "text",  "text", "numeric",     "text", 
                                                 "numeric", "text", "numeric", "text",   "text",
                                                 "text", "text", "text", "text", "text", "text",
                                                 "text", "text", "text", "text", "text", "text",
                                                 "text", "text", "text", "text", "text", "text",
                                                 "text", "text", "text", "text", "text", "text", 
                                                 "text", "text", "text", "text", "text", "text",
                                                 "text", "text", "text", "text", "text", "text", 
                                                 "text", "text", "text", "text", "text", "text",
                                                 "text", "text", "text", "text", "text", "text",
                                                 "text", "text", "text", "text", "text", "text",
                                                 "text", "text", "text", "text", "text", "text",
                                                 "text", "text", "text", "text", "text", "text",
                                                 "text", "text", "text", "text", "text", "text",
                                                 "text","numeric","text", "text", "text", "text"),
                                   range = "B5:CU2465")

#Explorar los datos:
glimpse(bd_pobreza_mpo) #estructura tipos de variables
head(bd_pobreza_mpo) #nombres de variables
tail(bd_pobreza_mpo) #renglones finales con metadatos

#2. Usar select de 3 maneras para quedarme sólo con las columnas de interés:

bd_pobreza_mpo %>% 
  select(`Clave de entidad`:Municipio, #range para nombres y claves (variables adyacentes)
         contains("2015*"), #Contains para que R reconazca que 2015* como cadena de texto
         ...14, ...16, ...18, ...94) #var_1, ..., var_n

#3. Filter y select para renglones vacíos y NAs

bd_pobreza_mpo %>% 
  filter(!is.na(`Clave de entidad`)) %>% 
  select(`Clave de entidad`:Municipio,
         poblacion_2015 = contains("2015*"),
         porc_pob_pobreza_ext_2015 = ...14,
         personas_pobreza_ext_2015 = ...16,
         carencias_prom_2015 = ...18,
         porc_pob_bajo_bienestar_min_2015 = ...94)

#4. Reordenar columnas
#Camino 1 select():
 bd_pobreza_mpo %>% 
  filter(!is.na(`Clave de entidad`)) %>% 
  select(`Clave de entidad`:Municipio,
         poblacion_2015 = contains("2015*"),
         porc_pob_bajo_bienestar_min_2015 = ...94,
         porc_pob_pobreza_ext_2015 = ...14,
         personas_pobreza_ext_2015 = ...16,
         carencias_prom_2015 = ...18)
 #Camino 2 relocate():
 
 bd_pobreza_mpo %>% 
   filter(!is.na(`Clave de entidad`)) %>% 
   select(`Clave de entidad`:Municipio,
          poblacion_2015 = contains("2015*"),
          porc_pob_pobreza_ext_2015 = ...14,
          personas_pobreza_ext_2015 = ...16,
          carencias_prom_2015 = ...18,
          porc_pob_bajo_bienestar_min_2015 = ...94) %>% 
   relocate(porc_pob_bajo_bienestar_min_2015, .after = poblacion_2015)
 
 
#5. Municipios de Veracruz con pobreza extrema entre 19 y 29 en 2015
 
 bd_pobreza_mpo %>% 
   filter(!is.na(`Clave de entidad`)) %>% 
   select(`Clave de entidad`:Municipio,
          poblacion_2015 = contains("2015*"),
          porc_pob_bajo_bienestar_min_2015 = ...94,
          porc_pob_pobreza_ext_2015 = ...14,
          personas_pobreza_ext_2015 = ...16,
          carencias_prom_2015 = ...18) %>% 
   filter(`Entidad federativa` == "Veracruz",
          porc_pob_pobreza_ext_2015 > 19 & porc_pob_pobreza_ext_2015 < 29)
 
#otro camino:
 
 bd_pobreza_mpo %>% 
   filter(`Entidad federativa` == "Veracruz",
          ...14 > 19 & ...14 < 29)
 
 
#R: 40 municipios
 
 