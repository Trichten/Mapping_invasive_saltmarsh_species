if(!requireNamespace("remotes")){
  install.packages("remotes")
}
remotes::install_github("joaofgoncalves/SegOptim")

library(raster)
library(randomForest)
library(SegOptim)

Segpath <- "E:/Landschaftsoekologie_Master/Module/M13_Forschungsprojekt/Data/Segmentierungen/"
otbPath <- "E:/OTB-7.4.0-Win64/OTB-7.4.0-Win64/bin"
trainDatapath <- "E:/Landschaftsoekologie_Master/Module/M13_Forschungsprojekt/Data/GT_2021/"
Predpath <- "E:/Landschaftsoekologie_Master/Module/M13_Forschungsprojekt/Data/2021_resampled_0,12m/"

NSM_2021 <- stack(paste0(Predpath, "Nordstrandischmoor_012.tif"))

outSegmRst.path <- "E:/Landschaftsoekologie_Master/Module/M13_Forschungsprojekt/Data/Segmentierungen./segmRaster.tif"
outClassRst.path <- "E:/Landschaftsoekologie_Master/Module/M13_Forschungsprojekt/Data/Klassifikationen./NSM_2021_First_Try.tif"


outSegmRst <- segmentation_OTB_LSMS(
  inputRstPath = NSM_2021,
  SpectralRange = 20,
  SpatialRange = 20,
  MinSize = 20,
  outputSegmRst = outSegmRst.path,
  verbose = TRUE,
  otbBinPath = otbPath,
  lsms_maxiter = 50
)

print(outSegmRst)

segmRst <- raster(outSegmRst$SegmentationFinal)



