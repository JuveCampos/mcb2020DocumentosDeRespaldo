# Métodos Cuantitativos Básicos - Otoño 2020
# Ejercicios previos al laboratorio de la semana 6
 
# 1.	Esta semana trabajarán con la base de datos de pobreza a nivel municipal publicada por el CONEVAL, que se encuentran en el archivo de Excel que descargaron la semana pasada. 

# Por favor importen toda la base de datos y guárdenla en un objeto llamada bd_pobreza_mpo. En este paso deberán importar todas las columnas que contengan datos, pero el menor número posible de renglones vacíos o que no contengan datos de una variable. 

# Ojito al mosquito: asegúrense de convertir las columnas a tipo numeric, en caso necesario.

# Librerias
library(tidyverse)
library(readxl)

# Importación de la base de datos 
bd_pobreza_mpo <-  read_excel("01_Datos/Concentrado, indicadores de pobreza.xlsx",  skip = 4)

bd_pobreza_mpo$`Pobreza extrema` <- 
  as.numeric(bd_pobreza_mpo$`Pobreza extrema`)


names(bd_pobreza_mpo)[c(1,2,3,4,6, 8, 10, 12, 14, 16,18, 94, 96, 98)]
c(1,2,3,4,6, 8, 10, 12, 14, 16,18, 94, 96, 98)

# 2.	Usando select(), utilicen al menos tres de los métodos para elegir variables que vimos en clase para mantener únicamente aquellas columnas que :
   
# i.	Las claves y nombres de la entidad y del municipio;
# ii.	La población de 2015
# iii.	Las variables de pobreza extrema que contengan valores para el 2015 
# iv.	El porcentaje de población con ingreso inferior a la línea de bienestar mínimo en 2015.

# Metodo 1. 
bd_pobreza_mpo2 <- bd_pobreza_mpo %>% 
  select(c(1,2,3,4,6, 8, 10, 12, 14, 16,18, 94, 96, 98))

# Metodo 2. 
bd_pobreza_mpo3 <- bd_pobreza_mpo %>% 
  select(`Clave de entidad`, `Entidad federativa`, `Clave de municipio`, 
         `Municipio`, `Población 2015*\r\n(leer nota al final del cuadro)`, 
         `...8`, `...10`, `...12`, `...14`, `...16`, `...18`, `...94`, 
         `...96`, `...98`)

names(bd_pobreza_mpo3) <- 
  c("Clave de entidad", "Entidad federativa", "Clave de municipio", 
    "Municipio", "Población 2015", "Pobreza Porcentaje 2015", 
    "Pobreza Personas 2015", "Pobreza Carencias promedio 2015",
    "Pobreza Extrema Porcentaje 2015", 
    "Pobreza Extrema Personas 2015", "Pobreza Extrema Carencias promedio 2015",
    "Bienestar Mínimo Porcentaje 2015", "Bienestar Mínimo Personas 2015", 
    "Bienestar Mínimo Carencias 2015")

# 3.	Usando select() y filter(), eliminen los renglones intermedios que están vacíos y elijan nombres sustantivos para las variables que lo necesiten.
names(bd_pobreza_mpo3) <- 
  c("Clave de entidad", "Entidad federativa", "Clave de municipio", 
    "Municipio", "Población 2015", "Pobreza Porcentaje 2015", 
    "Pobreza Personas 2015", "Pobreza Carencias promedio 2015",
    "Pobreza Extrema Porcentaje 2015", 
    "Pobreza Extrema Personas 2015", "Pobreza Extrema Carencias promedio 2015",
    "Bienestar Mínimo Porcentaje 2015", "Bienestar Mínimo Personas 2015", 
    "Bienestar Mínimo Carencias 2015")

!is.na(bd_pobreza_mpo3$`Entidad federativa`)

bd_pobreza_mpo3 <-  bd_pobreza_mpo3 %>% 
  filter(!is.na(`Entidad federativa`))

bd2 <- bd_pobreza_mpo3 %>% 
  na.omit()

# 4.	Usando select() o realocate(), reordenen las columnas para que el porcentaje de población con ingreso inferior a la línea de bienestar mínimo en 2015 aparezca al lado del porcentaje de población 2015. 
names(bd_pobreza_mpo3)

bd_pobreza_mpo3 <- bd_pobreza_mpo3 %>% 
  select(1:5, 12, 6:11, 13, 14)

b3 %>% relocate(`debajo bienestar`, .after= `poblacion 2015`)

# 5.	Por favor respondan cuántos municipios de Veracruz  tuvieron un nivel de pobreza extrema entre el 19% y el 29 % en 2015.
# Ojito al mosquito: asegúrense de respaldar su respuesta con código.
names(bd_pobreza_mpo3)
bd_ver <- bd_pobreza_mpo3 %>% 
  filter(`Entidad federativa` == "Veracruz") %>% 
  # filter(between(`Pobreza Extrema Porcentaje 2015`, 19,29))
  filter(`Pobreza Extrema Porcentaje 2015` > 19 & `Pobreza Extrema Porcentaje 2015` < 29)

unique(bd_ver$Municipio)
length(unique(bd_ver$Municipio))

# 6.	En todo los pasos anteriores, ¿consideraron necesario asignar el código a un objeto antes de  pasar de una pregunta a otra? Justifiquen su respuesta.

# Si, porque cada objeto nuevo almacena cambios nuevos. Solo imprimir los objetos no nos guarda dichos cambios, y por lo tanto, no podemos ir avanzando en el procesamiento. 

