rm(list=ls())

library(raster)

path2019 <- "E:/Landschaftsoekologie_Master/Module/M13_Forschungsprojekt/Data/2019_resampled_0,12m/"
path2021 <- "E:/Landschaftsoekologie_Master/Module/M13_Forschungsprojekt/Data/2021_resampled_0,12m/"
trainpath <- "E:/Landschaftsoekologie_Master/Module/M13_Forschungsprojekt/Data/GT_2021/"
pathseg <- "E:/Landschaftsoekologie_Master/Module/M13_Forschungsprojekt/Data/Segmentierungen/"

### Create rasterstack from all 2019 predictors

BLUE <- raster(paste0(path2019, "BLUE_012.tif"))
CHM <- raster(paste0(path2019, "CHM_012.tif"))
GREEN <- raster(paste0(path2019, "GREEN_012.tif"))
NDVI <- raster(paste0(path2019, "NDVI_012.tif"))
NDWI <- raster(paste0(path2019, "NDWI_012.tif"))
NIR <- raster(paste0(path2019, "NIR_012.tif"))
RE <- raster(paste0(path2019, "RE_012.tif"))
RED <- raster(paste0(path2019, "RED_012.tif"))
RENDVI <- raster(paste0(path2019, "RENDVI_012.tif"))
SFS_L <- raster(paste0(path2019, "SFS_L_012.tif"))
SFS_RATIO <- raster(paste0(path2019, "SFS_Ratio_012.tif"))
SFS_SD <- raster(paste0(path2019, "SFS_SD_012.tif"))
SFS_W <- raster(paste0(path2019, "SFS_W_012.tif"))

pred2019 <- stack(BLUE, CHM, GREEN, NDVI, NDWI, NIR, RE, RED, RENDVI, SFS_L, SFS_RATIO, SFS_SD, SFS_W)

setwd(path2019)
writeRaster(pred2019, "pred2019.grd", overwrite=TRUE)

### Create/calculate missing predictors for 2021

pred2021 <- stack(paste0(path2021, "Nordstrandischmoor_012.tif"))

names(stack2021)
plot(stack2021)

### Create train data rasterstack
library(rgdal)
library(sf)

rm(trainpols)
trainpols<- readOGR(paste0(trainpath, "GT_screen_classes.shp"))

crs(trainpols)
## Index classes

# DONE IN QGIS MANUALLY

## Rasterize Training polygons

?rasterize
names(trainpols)

trainpols$Class <- as.numeric(trainpols$Class)

trainpolsras <- rasterize(trainpols, pred2021, field=trainpols$Class)

writeRaster(trainpolsras, paste0(trainpath, "rasterized_polygons.tif"))

trainpolsras <- raster(paste0(trainpath, "rasterized_polygons.tif"))

## Rasterize Segmentation

seg <- read_sf(paste0(pathseg, "Seg_20_20_20_NSM_AOI_2021.shp"))

segras <- rasterize(seg, pred2021, field=seg$DN)

writeRaster(segras, paste0(pathseg, "rasterized_segmentation.tif"))


