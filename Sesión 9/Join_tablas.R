casos <-  tibble::tribble(
    ~Municipios, ~Casos,
     "Ocuituco",    10L,
   "Yecapixtla",    13L,
  "Jonacatepec",    23L,
       "Tetela",     5L,
    "Tepoztlán",    50L
  )

fall <- tibble::tribble(
    ~Municipios, ~Fallecimientos,
   "Yecapixtla",              1L,
  "Jonacatepec",              2L,
    "Tepoztlán",             20L
  )

hosp <- tibble::tribble(
    ~Municipios, ~Hospitales,
     "Ocuituco",          1L,
  "Jonacatepec",          1L,
       "Tetela",          1L,
    "Tepoztlán",          2L
  )

pop <- tibble::tribble(
    ~Municipios, ~Poblacion,
     "Ocuituco",     18000L,
   "Yecapixtla",     40000L,
  "Jonacatepec",     35000L,
       "Tetela",     20000L,
    "Tepoztlán",     45000L
  )

# # Correspondencia 1:1
# cbind.data.frame(pop, casos)
# full_join(pop, casos, by = "Municipios")
# inner_join(pop, casos, by = "Municipios")
# right_join(pop, casos, by = "Municipios")
# left_join(pop, casos, by = "Municipios")
# 
# # Caso 2
# full_join(casos, fall, by = "Municipios")
# inner_join(casos, fall,  by = "Municipios")
# right_join(casos, fall,  by = "Municipios")
# left_join(casos, fall,  by = "Municipios")
# 
# # Caso 3 
# full_join(escuela, alumnos_becados, by = "Clave_Escuela")
# inner_join(escuela, alumnos_becados, by = "Clave_Escuela")
# right_join(escuela, alumnos_becados, by = "Clave_Escuela")
# left_join(escuela, alumnos_becados, by = "Clave_Escuela")
# 
# # Caso 4. Unir tres 
# full_join(escuela, alumnos_becados, by = "Clave_Escuela") %>% 
#   full_join(calificaciones_examen, by = "Individuos")
# 
