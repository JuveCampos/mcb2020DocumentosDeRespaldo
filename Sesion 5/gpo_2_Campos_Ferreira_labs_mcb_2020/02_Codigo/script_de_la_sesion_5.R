
# Paquetes y funciones para abrir texto plano y excel
library(tidyverse)
read_delim()
read_csv()
read_tsv()
read_rds()

library(readxl)
read_xlsx()
read_xls()

library(haven)
read_dta()


# 4.	Por favor importen a RStudio el archivo que descargaron en el punto anterior y guárdenlo en un objeto que se llame ciclistas. 

ciclistas <- read_csv("01_Datos/contador-ciclistas.csv")

# 5. 	Por favor descarguen el folder comprimido que está en este enlace y guárdenlo en su folder 01_datos. Contiene un archivo de Excel elaborado por el CONEVAL con diversas variables relacionadas indicadores de pobreza a nivel municipal y estatal. 


# Abran el archivo y échenle un ojo para familiarizarse con el mismo. 

# Ahora por favor importen únicamente las columnas llamadas Clave de entidad, Entidad federativa, Población 2015*(leer nota al fin del cuadro) y las seis columnas correspondientes a Pobreza extrema. 

pobreza <- read_excel("01_Datos/Concentrado, indicadores de pobreza.xlsx", 
                                                 range = "B6:S2465")

names(pobreza)[1] <- "Clave Estado"

pobreza <- pobreza %>% 
  filter(!is.na(`...1`))

