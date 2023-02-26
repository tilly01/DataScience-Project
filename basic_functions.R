library("dplyr")
library("tidyr")

##### creates a list of one column
#target_list <- as.list(training_data$V123)

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

###### das auswÃ¤hlen einzelner Spalten
#csd_small <- data.frame(complete_singlecell_data %>% select(-(V6:V121)))
#training_translation <- data.frame(training_data %>% select(-(V7:V122)))
#VALI_SMALL <- data.frame(validation_data$V2)
#plot(complete_singlecell_data$V8 > 3)


#histogramm plotten
hist(complete_singlecell_data$V8, freq=F, breaks = 20)

# Spalten zusammenfügen um Loesungstabelle übersichtlich zu machen
final_solution <- left_join(ground_truth_real, validation_decoding, by = "cell_code")

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


# bringt eine Tabelle mit nur Verbindung mit Ziel Targets hervor
compund_targets <- subset(compund_annotations, V9 %in% c("Adrenoceptor", "AMPA", "Tubulin", "ROCK", "DNA_intercalation", "Topoll", "cMyc", "MEK", "dopaminereceptor", "CDK", "EGFR", "Ca2", "DNAMetabolism", "CellCycle", "rac1", "Cdc25", "eNOS")|
                            V10 %in% c("Adrenoceptor", "AMPA", "Tubulin", "ROCK", "DNA_intercalation", "Topoll", "cMyc", "MEK", "dopaminereceptor", "CDK", "EGFR", "Ca2", "DNAMetabolism", "CellCycle", "rac1", "Cdc25", "eNOS") |
                            V11 %in% c("Adrenoceptor", "AMPA", "Tubulin", "ROCK", "DNA_intercalation", "Topoll", "cMyc", "MEK", "dopaminereceptor", "CDK", "EGFR", "Ca2", "DNAMetabolism", "CellCycle", "rac1", "Cdc25", "eNOS") |
                            V12 %in% c("Adrenoceptor", "AMPA", "Tubulin", "ROCK", "DNA_intercalation", "Topoll", "cMyc", "MEK", "dopaminereceptor", "CDK", "EGFR", "Ca2", "DNAMetabolism", "CellCycle", "rac1", "Cdc25", "eNOS") |
                            V13 %in% c("Adrenoceptor", "AMPA", "Tubulin", "ROCK", "DNA_intercalation", "Topoll", "cMyc", "MEK", "dopaminereceptor", "CDK", "EGFR", "Ca2", "DNAMetabolism", "CellCycle", "rac1", "Cdc25", "eNOS") |
                            V14 %in% c("Adrenoceptor", "AMPA", "Tubulin", "ROCK", "DNA_intercalation", "Topoll", "cMyc", "MEK", "dopaminereceptor", "CDK", "EGFR", "Ca2", "DNAMetabolism", "CellCycle", "rac1", "Cdc25", "eNOS") |
                            V15 %in% c("Adrenoceptor", "AMPA", "Tubulin", "ROCK", "DNA_intercalation", "Topoll", "cMyc", "MEK", "dopaminereceptor", "CDK", "EGFR", "Ca2", "DNAMetabolism", "CellCycle", "rac1", "Cdc25", "eNOS"))


