require(raster)
require(stringr)

ncc  <- 'D:/Projects/SpeciesDistributionModeling/_Data/_20m/1.NCC'
sog  <- 'D:/Projects/SpeciesDistributionModeling/_Data/_20m/2.SOG'
qcs  <- 'D:/Projects/SpeciesDistributionModeling/_Data/_20m/3.QCS'
hg   <- 'D:/Projects/SpeciesDistributionModeling/_Data/_20m/4.HG'
wcvi <- 'D:/Projects/SpeciesDistributionModeling/_Data/_20m/5.WCVI'
shelf <- 'D:/Projects/SpeciesDistributionModeling/_Data/_100m/1.NSB_SSB'
sog.50 <- 'D:/Projects/SpeciesDistributionModeling/_Data/_50m'


raster.summary <- function(wd){
  # make list of tif files
  files <- list.files(wd, pattern = '\\.tif$', full.names = TRUE)
  
  # make list of rasters from files
  rasters <- lapply(files, FUN = function(file){
    raster(file)
  })

  # create summary text file
  name <- str_split(wd, "/")
  name <- name[[1]][length(name[[1]])]
  sink(file.path(wd, paste0(name, '_RasterLayers.txt')))
  cat('LAYERS IN DIRECTORY:\n\n')

  # iterator
  iter = 1
  
  # write list of raster names in dir
  for(i in rasters){
    cat(paste(iter, " - ", names(i)))
    cat("\n")
    iter = iter + 1
  } 
  
  cat('\n\nSUMMARY OF EACH LAYER:')
  
  iter = 1

  # write summary information
  for(i in rasters){
    cat(paste0('\n\nLayer: ', names(i), '\n'))
    cat(paste0('Min: ', i@data@min, '\n'))
    cat(paste0('Max: ', i@data@max, '\n'))
  } 
  
  # end sink
  sink()
  
  return(rasters)
  
}



raster.summary(ncc)
raster.summary(sog)
raster.summary(qcs)
raster.summary(hg)
raster.summary(wcvi)
raster.summary(shelf)
raster.summary(sog.50)
