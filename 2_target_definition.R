#for target definition


set_target <- function(result) {
truth <- data.frame(result)
truth$target <- ifelse(truth$well %in% c("A15", "B12", "M14"), "CDK",
                  ifelse(truth$well %in% c("B20", "B11", "B21", "C18"), "dopaminereceptor",
                  ifelse(truth$well %in% c("F15", "B15", "F19", "P13"), "EGFR",
                  ifelse(truth$well %in% c("D15", "C10", "F18"), "adrenoceptor",
                  ifelse(truth$well %in% c("K10", "C22", "O10"), "Topoll",
                  ifelse(truth$well %in% c("P14", "H22", "D20"), "DNAMetabolism",
                  ifelse(truth$well %in% c("G12", "E11"), "AMPA",                         
                  ifelse(truth$well %in% c("H21", "F17", "L14"), "DNA_Intercalation",
                  ifelse(truth$well %in% c("I23", "G23", "N22"), "Tubulin",
                  ifelse(truth$well %in% c("M11", "H18"), "CellCycle",
                  ifelse(truth$well %in% c("M23", "K23"), "MEK",
                  ifelse(truth$well == "I15", "eNOS",
                  ifelse(truth$well == "I11", "rac1",                          
                  ifelse(truth$well == "N20", "Cdc25",                         
                  ifelse(truth$well == "K20", "AMPA/Ca2",
                  ifelse(truth$well == "E23", "ROCK",
                  ifelse(truth$well == "P16", "Ca2", 
                  ifelse(truth$well =="I13", "cMyc", "  "))))))))))))))))))
return(truth)
}
