
library(dplyr)

### DATA PREP

prep <- function(complete_singlecell_data, training_data, validation_data, compund_annotations, annotations_WT_H1047_MarcoBreinig) {
  
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
  
  # Return the modified datasets
  return(list(complete_singlecell_data = complete_singlecell_data,
              training_data = training_data,
              validation_data = validation_data,
              compund_annotations = compund_annotations,
              annotations_WT_H1047_MarcoBreinig = annotations_WT_H1047_MarcoBreinig))
}

#### Call the function with your input datasets
result_prep <- prep(complete_singlecell_data, training_data, validation_data, compund_annotations, annotations_WT_H1047_MarcoBreinig)



