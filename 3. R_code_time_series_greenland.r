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
#exercise2: NO2 decrease during the lockdown 
#sentinel data on nitrogen during lockdown dell'Esa
#
#scaricare dati EN.zip
#EN = European nitrogen
#importiamo i dati tramite list.files, lapply, stack

#sul satelliti sentinel = dentro a Copernicus, c'è un satellite con 
#sensore = che è sentinel = sensore di 10 m 
#all'interno del Sentinel = sensore che misura gli ossidi di azoto 
#uso dati 

#oggi analisi con la riduzione di ossidi di azoto
#carichiamo il pacchetto raster
library(raster)
#settiamo la cartella di lavoro 
setwd("D:/UNIVERSITA' MAGISTRALE/1 ANNO/2 SEMESTRE/TELERILEVAMENTO GEO-ECOLOGICO/R/3. 10.03.22/lab/EN")

#1 file 
raster("EN_0001.png")
en01 <- raster("EN_0001.png")
en01
#plottiamo 
cl <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot (en01, col = cl)

#andiamo a vedere il 13 dato 
raster("EN_0013.png")
en13 <- raster("EN_0013.png")
en13
cl <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot (en13, col = cl)
#a marzo 
#si vede molto bene la differenza 

#ora importiamo tutto il data set insieme = let's import the whole set (altogether!)
#exercise: impost the whole as in the Greenland example
#by the following steps: list.files, lapply, stack
list.files(pattern = "EN")
rlist <- list.files(pattern = "EN")
#lapply(X, FUN)
lapply(rlist, raster)
rimp <- lapply(rlist, raster) #mettere la rimp = importare
rimp
#stack
stack(rimp)
en <- stack(rimp)
en
#plottiamo
plot(en, col = cl)
#sono tutte insieme

#esercizio = plottiamo EN01 vicino EN13
#se voglio mettere insieme
par(mfrow = c(1, 2))
plot(en[[1]], col = cl)
plot(en[[13]], col = cl)
#oppure
par(mfrow = c(1, 2))
plot(en[[1]], col = cl)
plot(en[[13]], col = cl)

#oppure 
#faccio uno stack
stack(en[[1]], en[[13]])
en113 <- stack(en[[1]], en[[13]])
en113 #del 1 e del 13
#invece di fare un multiframe = pesco solo il 1 e 13
#poi plot
plot(en113, col = cl)

#let's make the difference:
difen <- en[[1]] - en[[13]] #anche al contrario si può fare
difen
#differenza varia tra -255 a +255
#plottiamo 
#nuova colorRampPalette
cldif <- colorRampPalette(c("blue", "white", "red")) (100)
plot(difen, col = cldif)


##############################
#08.03.22
#tutti i codici della scorsa volta

#oggi andiamo a utilizzare una funzione che serve per utilizzare codice
#che deriva da altre fonti 
#scritto su git hub poi R
?source
#prendere file salvare e lo richiamiamo da r direttamente senza aprirlo
#su git hub codice a disposizione 
library(raster)
#facciamo il settaggio 
setwd("D:/UNIVERSITA' MAGISTRALE/1 ANNO/2 SEMESTRE/TELERILEVAMENTO GEO-ECOLOGICO/R/3. 10.03.22/lab/EN")
#poi carichiamo l'immagine 
en01 <- raster("EN_0001.png")
#plot
cl <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot (en01, col = cl)

#ora mettiamo tutto in un editor di testo 
#es. blocco note 
#e simuliamo un codice che ci arriva da un collega

#salvato nella cartella di lab 
#come R_inputcode.R
#evitare.doc

#andiamo su R 
#fare solo il settaggio della working directory 
#con lab solo 
setwd("D:/UNIVERSITA' MAGISTRALE/1 ANNO/2 SEMESTRE/TELERILEVAMENTO GEO-ECOLOGICO/R/3. 10.03.22/lab")

#la funzione è source

#exercise: use source function and upload the code
#funzione source e mettere il nome del file
source("R_inputcode.r")
#viene fuori l'immagine = solo scrivendo source


#########################################
#ora rimportiamo i dati e facciamo un plot di RGB di 3 immagini dei dati 
#che abbiamo a disposizione
#dati si possono anche importare
#con una list.files con vari file
#funzione lapply alla lista
#e poi un altra funzione con raster
#e unire tutti insieme che si chiama stack
list.files(pattern = "EN")
rlist <- list.files(pattern = "EN")
rlist
lapply(rlist, raster)
rimp <- lapply(rlist, raster)
rimp
stack(rimp)
en <- stack(rimp)
en
#plot di tutto lo stack
plot(en, col = cl)

#visualizziamo tutte le immagini 

#ora facciamo un plotRGB con 3 file insieme
#plotRGB of three files together
?plotRGB
#R = [[1]]
#G = [[7]]
#B = [[13]]
plotRGB(en, r = 1, g = 7, b = 13, stretch = "lin")
plotRGB(en, r = 1, g = 7, b = 13, stretch = "hist")

