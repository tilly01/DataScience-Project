library("dplyr")
library("tidyr")
library("devtools")
install_github("rajarshi/chemblr")

## creates a list of one column
target_list <- as.list(training_data$V123)

## creates a Class of words in a column (good way to explore how many different features there are)
targets <- unique(training_data$V123)
classify <- unique(compund_annotations$V9)
secnames <- unique(compund_annotations$V7)
csd_well <- unique(complete_singlecell_data$V4)
csd_field <- unique(complete_singlecell_data$V5)

# creates a mini dataset of the original
cds_mini <- tbl_df(complete_singlecell_data)
data.frame(head(cds_mini))

# view all cells for field 1
complete_singlecell_data[complete_singlecell_data$V4==C10 & complete_singlecell_data$V2==P1 & complete_singlecell_data$V3==1]

###### das auswählen einzelner Spalten
#csd_small <- data.frame(complete_singlecell_data %>% select(-(V6:V121)))
#training_translation <- data.frame(training_data %>% select(-(V7:V122)))
#VALI_SMALL <- data.frame(validation_data$V2)
#plot(complete_singlecell_data$V8 > 3)
left_join(complete_singlecell_data, training_data, by ("V121","V118"), keep=FALSE)

#histogramm plotten
hist(complete_singlecell_data$V8, freq=F, breaks = 20)





############################################################################################
## trying annotation and & filtering
arrayfortry <- function (complete_singlecell_data, nWells=40, nPlates=4, nRep=2){
  if (nWells*nPlates*nRep == nrow(complete_singlecell_data))
      stop("Wrong dimension!")

replicate <- rep(c(rep(1, nWells), rep(2, nWells)),
                 nrow(complete_singlecell_data)/(nWells*nRep))
complete_singlecell_data = complete_singlecell_data[order(replicate),]

D=as.matrix(complete_singlecell_data)
}
############################################################################################


##### functions in dplyr
#select, filter, arrange, mutate, summarise, group_by
head(headers)
complete_singlecell_data[, 1:7]

# arange
nuclear_dis <- (arrange(complete_singlecell_data, V121))

# filter
adrenoceptor_training <- training_data [training_data$V123 == "adrenoceptor", ]
AMPA_training <- training_data [training_data$V123 == "AMPA", ]
Tubulin_training <- training_data [training_data$V123 == "Tubulin", ]


#