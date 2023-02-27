#VALIDATION_DECODING

library(dplyr)

validation_decoding <- function(complete_singlecell_data, training_data, validation_data) {
  
  # creating a smaller sub_datatset for the big three
  csd <- data.frame(complete_singlecell_data %>% select(-(actin.s.area:dist.30.nn)))
  valid <- data.frame(validation_data %>% select(-(actin.s.area:dist.30.nn)))
  valid <- data.frame(valid %>% select(-(well_code)))
  training <- data.frame(training_data %>% select(-(actin.s.area:dist.30.nn)))
  training <- data.frame(training %>% select(-(target)))
  training <- data.frame(training %>% select(-(cell_id:field)))
  
  # validation + training
  merge_valid_training <- merge(training, valid, by = c("nuclear.displacement", "cell_code"), all = TRUE)
  result <- merge_valid_training[merge_valid_training$cell_code %in% valid$cell_code, ]
  
  # backup with data from complete_singlecell_data
  finalmerge <- merge(merge_valid_training, csd, by=c("nuclear.displacement"), all=TRUE)
  finalmerge <- data.frame(finalmerge %>% select(-(nuclear.displacement)))
  
  # subtract the training data for final decoding
  result <- finalmerge[finalmerge$cell_code %in% valid$cell_code, ]
  
  # Return the final dataset
  return(result)
}

# Call the function with your input datasets
result_val_decod <- validation_decoding(complete_singlecell_data, training_data, validation_data)



