##PRUEBA_2##
install.packages("sf")
install.packages("tmap")
install.packages("jsonlite")

library(tidyverse)
library(readxl)
library(sf) 
library (kableExtra)
library (knitr)
library(tmaptools)
library(jsonlite)


EF_RSIV <-read_excel(path = "input/RS_IV_REFES (2).xlsx")


##armado de datasets##

##DEPTOS_RSIV <- select(EF_RSIV, "Arrecifes", "Carmen de Areco", "Ramallo", "San Andrés de Giles", "San Pedro", "Baradero", "Colón", "Rojas", "San Antonio de Areco", "Capitán Sarmiento", "Pergamino", "Salto", "San Nicolás")   

            
ESTABLECIMIENTOS_RSIV <- EF_RSIV[c(1,2,3,4,10,13,14,22,23,24,26)]


head(ESTABLECIMIENTOS_RSIV)

##visualización##
ggplot(data = ESTABLECIMIENTOS_RSIV)+
  geom_bar(mapping = aes (x=DEPARTAMENTO)) +
  theme_minimal()+
  labs (title = "Establecimientos de salud por departamento", 
        x = "Departamento",
        y = "Cantidad de establecimientos") +
  coord_flip()

##mapas##


rsiv<- st_read ("input/depart.json")
  

ggplot() + 
  geom_sf(data= rsiv)+
  labs(title = "Mapa de Región Sanitaria IV de Buenos Aires") + 
  theme_void()

##establecimientos de salud en RSIV##
ESTABLECIMIENTOS_RSIV  <- ESTABLECIMIENTOS_RSIV %>% 
  filter(!is.na (LATITUD), !is.na (LONGITUD)) %>% 
  st_as_sf(coords = c("LONGITUD", "LATITUD"), crs = 4326)

ggplot() +
  geom_sf(data = rsiv ) +
  geom_sf (data = ESTABLECIMIENTOS_RSIV,
           color = "blue", alpha = .3) +
  geom_sf_text(data= ESTABLECIMIENTOS_RSIV, aes(label = NOMBRE), size=1.0, colour = "black") +
  labs(title = "Establecimientos de gestión pública y privada",
       x="",
       y="") +
 labs(title = "Mapa de establecimientos sanitarios de la PBA") +
  theme_void()



