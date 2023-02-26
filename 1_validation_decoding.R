library(dplyr)

### DATA PREP

# Identify rows with empty cells
empty_csd <- which(apply(is.na(complete_singlecell_data), 1, all))
empty_train <- which(apply(is.na(training_data), 1, all))
empty_valid <- which(apply(is.na(validation_data), 1, all))
empty_compound <- which(apply(is.na(compund_annotations), 1, all))
empty_WT <- which(apply(is.na(annotations_WT_H1047_MarcoBreinig), 1, all))

# Subset the dataset to exclude empty rows
complete_singlecell_data <- complete_singlecell_data[complete.cases(complete_singlecell_data), ]
training_data <- training_data[complete.cases(training_data), ]
validation_data <- validation_data[complete.cases(validation_data), ]
compund_annotations <- compund_annotations[complete.cases(compund_annotations), ]
annotations_WT_H1047_MarcoBreinig <- annotations_WT_H1047_MarcoBreinig[complete.cases(annotations_WT_H1047_MarcoBreinig), ]


### VALIDATION DECODING

# creating a smaller sub_datatset for the big three
csd <- data.frame(complete_singlecell_data %>% select(-(actin.s.area:dist.30.nn)))
valid<- data.frame(validation_data %>% select(-(actin.s.area:dist.30.nn)))
valid<- data.frame(valid %>% select(-(well_code)))
training<- data.frame(training_data %>% select(-(actin.s.area:dist.30.nn)))
training<- data.frame(training %>% select(-(target)))
training<- data.frame(training %>% select(-(cell_id:field)))

# validation + training
merge_valid_training <- merge(training, valid, by = c("nuclear.displacement", "cell_code"), all = TRUE)
result <- merge_valid_training[merge_valid_training$cell_code %in% valid$cell_code, ]

# backup with data from complete_singlecell_data
finalmerge <- merge (merge_valid_training, csd, by=c("nuclear.displacement"), all=TRUE)
finalmerge <- data.frame(finalmerge %>% select(-(nuclear.displacement)))

# subtract the training data for final decoding
result <- finalmerge[finalmerge$cell_code %in% valid$cell_code, ]

