# Raw data come from <https://qualite-riviere.lesagencesdeleau.fr>

water <- read.csv2(here::here("data/water-quality/stations.csv"), encoding = "cp1252")
water <- water[ , c("LON_WGS84", "LAT_WGS84", "ETAT_VISU")]
water[ , 1] <- as.numeric(water[ , 1])
water[ , 2] <- as.numeric(water[ , 2])
water$"insee" <- NA

water <- sf::st_as_sf(water, coords = 1:2, crs = sf::st_crs(4326))

fls <- list.files(file.path("data", "administrative"))
fls <- fls[grep("^commune", fls)]

for (i in 1:length(fls)) {
  cat(i, "\r")
  shp <- readRDS(file.path("data", "administrative", fls[i]))
  
  inter <- sf::st_intersects(water, shp)
  inter <- which(unlist(lapply(inter, function(x) length(x))) == 1)
  
  if (length(inter) > 0) {
    water[inter, "insee"] <- as.character(sf::st_drop_geometry(shp[1, "insee"]))
  }
}

pos <- which(water$"ETAT_VISU" == "U")
water[pos, "ETAT_VISU"] <- NA
length(which(is.na(water$"ETAT_VISU")))

water$"ETAT_VISU" <- as.numeric(water$"ETAT_VISU")

wqual <- tapply(water$"ETAT_VISU", water$"insee", function(x) {
  x <- x[!is.na(x)]
  if (length(x) > 0) {
    max(x)
  } else {
    NA
  }
})

wqual <- data.frame("insee" = names(wqual), "water" = wqual)
rownames(wqual) <- NULL

wqual$"water" <- gsub("1", "Excellente", wqual$"water")
wqual$"water" <- gsub("2", "Bonne", wqual$"water")
wqual$"water" <- gsub("3", "Moyenne", wqual$"water")
wqual$"water" <- gsub("4", "Médiocre", wqual$"water")
wqual$"water" <- gsub("5", "Mauvaise", wqual$"water")

cities <- readRDS(file.path("data", "administrative", "list_of_cities.rds"))
wqual <- merge(cities, wqual, by = "insee", all = TRUE)
wqual <- wqual[ , c("insee", "nom", "water")]

saveRDS(wqual, file = "data/water-quality/water_quality.rds")
