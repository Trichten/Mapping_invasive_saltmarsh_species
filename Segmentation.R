rm(list=ls())

library(caret)
library(sf)

path2021 <- "E:/Landschaftsoekologie_Master/Module/M13_Forschungsprojekt/Data/2021_resampled_0,12m/"
pathseg <- "E:/Landschaftsoekologie_Master/Module/M13_Forschungsprojekt/Data/Segmentierungen/"

library(raster)
?train
?rf

# install.packages("remotes")
# remotes::install_github("joaofgoncalves/SegOptim")

## SUPERCELLS APPROACH  ##

# install.packages("supercells", repos = "https://nowosad.r-universe.dev")

library(supercells)
library(terra)
library(sf)

?rast

NSM <- stack(paste0(path2021, "Nordstrandischmoor_012.tif"))

vol <- rast(NSM, package = "supercells")

plot(vol)

names(NSM)

?supercells
vol_slic1 <- supercells(vol, k = 50, compactness = 1, clean = TRUE, minarea = 20, verbose=1)

## SEGOPTIM APPROACH ##

library(SegOptim)

setwd(path2021)
?segmentation_OTB_LSMS
segmentation_OTB_LSMS(inputRstPath = "Nordstrandischmoor_012.tif",
                      outputSegmRst = "Segmentation.tif",
                      SpectralRange = 20,
                      SpatialRange = 20,
                      MinSize = 20,
                      otbBinPath = "E:/OTB-7.4.0-Win64/OTB-7.4.0-Win64/bin")

str(seg2021)
plot(seg2021$SegmentationFinal)

seg <- stack("Segmentation.tif")

NSM <- stack("Nordstrandischmoor_012.tif")


seg_phil <- st_read(paste0(pathseg, "Seg_20_20_20_NSM_AOI_2021.shp"))

plot(seg_phil)



