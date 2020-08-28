# SESIÓN 2
# LO QUE REPASAMOS EN EL LABORATORIO DE HOY # 

# Funcion. La función suma toma como argumentos una serie de números
## y el argumento na.rm
sum(9,2,100)

# Para observar el cuerpo de la función, escribe su nombre sin paréntesis
sum

# Para consultar la ayuda de cualquier función, escribe el ? y luego el nombre de la fn. 
?sum()
?sum # Con parentes

# Checa lo que pasa corriendo estos dos renglones de código, y checa
# que es lo que hace el argumento na.rm
sum(NA,9,2,100)
sum(NA,9,2,100, na.rm = TRUE)

# Función creada por nosotros: 
potenciacion <- function(a, b){
  a ^ b # Cuerpo de la función.
}

# Uso de la función - Checa que esto da pie a un numero
potenciacion(a = 9, b = 2)

# Guardamos vectores en un objeto 
# (Los vectores son como cajoneras en donde cada cajón almacena un numero)
# En este caso, las cajoneras A y B almacenan los numeros 8,9 y 10, uno en cada "cajoncito"
# Las cajoneras (vectores) se crean metiendo cada cosa
# que va a ir en los cajones con la función c() (c de cajonera -nosierto-)
A <- c(8,9,10)
B <- c(8,9,10)
# Una vez que usamos la flecha, "<-", se guarda un objeto (y no hay vielta atrás)

# Aqui somos rebeldes y movemos el sentido de la asignación
## NO SE RECOMIENDA HACER ESTO, PERO SE PUEDE...
potenciacion(a = 9, b = 2) -> C

# Cuando guardamos en un objeto, ya podemos trabajar con el, como se ve adelante. 
A + 2 # Le sumamos 2 a cada elemento de cada cajon
sum(A) # Sumamos todos los elementos de la cajonera

# Cuando guardamos información en un objeto, lo que sucede
## es que las funciones se resuelven, generando el valor resultante

# Esto... 
A <- c(potenciacion(2,2), 
       potenciacion(2,3), 
       potenciacion(3,5))

# ... es igual a esto: (checalo en el ambiente!) 
A_ <- c(4,
       8,
       243)

# Lo que pasa es que primero se obtiene el resultado de la función 
# potenciacion y luego estos resultados se combinan en la cajonera

# Guardamos una cadena de texto
foo <- "mi mama me mima"
# Guardamos un número
foo1 <- 1
# Guardamos otro numero
foo2 <- 81

# Llamamos a la librería (nos van a salir warnings)
library(tidyverse)
# Llamamos a la librería, sin provocar conflictos
library(tidyverse, warn.conflicts = FALSE)

# NOTA! Los warnings solo son alertas, no son errores. 
# Podemos trabajar si nos salen warnings, pero no si nos salen errores...

# Función rnorm 
## Genera una serie de numeros aleatorios provenientes de una distribución 
## Normal o Campana de Gauss...
?rnorm
m1 <- rnorm(n = 1000, sd = 2, mean = 10) # 1000 observaciones, con una media 10 y un sd de 2
m2 <- rnorm(10,2,1000) # 10 observaciones. con una media 2 y una sd de 1000

# Recordemos que si no especificamos el nombre de los argumentos (las palanquitas), 
## el orden de los argumentos va a ser el que viene en la ayuda. 

# BONUS: Vemos la grafica de los datos
plot(density(m1))
plot(density(m2))
