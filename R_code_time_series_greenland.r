#Time series analysis of Greenland LST data 
#Analisi delle serie temporali dei dati LST della Groenlandia
#inserire pacchetti 
library(raster)
#cartella di lavoro 
setwd("D:/UNIVERSITA' MAGISTRALE/1 ANNO/2 SEMESTRE/TELERILEVAMENTO GEO-ECOLOGICO/R/3. 10.03.22/lab/greenland")
#aggiungere anche la cartella greenland

?raster

#importiamo immagine 2000
raster("lst_2000.tif")
lst2000 <- raster("lst_2000.tif")
lst2000
#plottiamo 
plot(lst2000)

#Exercise: import all the data 
#importiamo tutti i dati del 2005, 2010, 2015
#2005
raster("lst_2005.tif")
lst2005 <- raster("lst_2005.tif")
lst2005
#2010
raster("lst_2010.tif")
lst2010 <- raster("lst_2010.tif")
lst2010
#2015
raster("lst_2015.tif")
lst2015 <- raster("lst_2015.tif")
lst2015

#creiamo una nostra colorRampPalete
cl <- colorRampPalette(c("blue", "light blue", "pink", "red")) (100)

#exercise: multiframe con 4 dati = 2 righe e 2 colonne
par(mfrow = c(2, 2))
plot(lst2000, col = cl)
plot(lst2005, col = cl)
plot(lst2010, col = cl)
plot(lst2015, col = cl)

#come importare questo set tutto insieme
?lapply

#utilizzeremo tanto 
?list.files #list dot files
#lista di file = dire in che cartella deve prenderli 
#parametro importante è il pattern = serve per spiegare una caratteristica 
#comune di tutti i file che vogliamo caricare

#import the whole set altogether!
#1. fare la lista del file = con list.files
list.files(pattern = "lst")
rlist <- list.files(pattern = "lst")
rlist

#la lista si chiama rlist
#ora il raster 
lapply(rlist, raster)
import <- lapply(rlist, raster)
import

#stack = mette tutto insieme
?stack
#blocco comune di tutti i dati 
#stack di import
stack(import)
#altro nome tgr = temperation greenland
tgr <- stack(import)
tgr
#raster stack tutto insieme 
#brick = importavamo per immagine satellitare
#stack = per singoli dati 

#layer 4 = con valori 65535
#invece di fare il multiframe 
#io faccio una lista -> applico la funzione lapply che mi applica alla funzione
#raster alla lista e poi faccio uno stack

#plot con lo stesso colorRampPalette
plot(tgr, col = cl)

#ora se vogliamo plottare anche il primo elemento dello stack 
#o con $ o elemento 
plot(tgr$lst_2000, col = cl)
#oppure
plot(tgr[[1]], col = cl)

#plotRGB
#lst_2000 ==> R
#lst_2005 ==> G
#lst_2010 ==> B
?plotRGB #con sintassi
plotRGB(tgr, r = 1, g = 2, b = 3, stretch = "lin")

#########################
#?colorist 
#colorazione delle specie 

#########################




