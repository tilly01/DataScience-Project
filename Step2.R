library(dplyr)

#csd_small und valid_small: Spalten mit wichtigen Daten, die wir später vergelichen werden und Messdaten, um genauere Übereinstimmung zwischen complete_singlecell_data_cytodata2019 und validation_datazu finden
#bei valid_small habe ich die ersten zwei Spalten well_code und cell_code weggelassen. 
#well_code finde ich sonst in keiner der Tabellen und cell_code aus validation_data weisen keine Übereinstimmungen weder mit training data noch mit Lösungstabellen decoding, ground truth, file translations

#a<-intersect(validation_data$V2, training_data$V1)
#View(a)
#b<-intersect(validation_data$V2, validation_decoding$cell_code)
#View(b)
#c<-intersect(validation_data$V2, validation_file_translations$cell_code)
#View(c)
#s<-intersect(validation_data$V2, ground_truth_real$cell_code)
#View(s)

csd_small <- data.frame(complete_singlecell_data_cytodata2019 %>% select(-(V23:V117)))
valid_small<- data.frame(validation_data %>% select(-(V20:V114), -(V1:V2)))

#colnames umbenannt um später Vektor c für join zu erstellen
colnames(csd_small) <- c("cell_id",
                         "plate",
                         "replicate",
                         "well",
                         "field",
                         "actin.s.area",
                         "actin.s.perimeter",
                         "actin.s.radius.mean",
                         "actin.s.radius.sd",
                         "actin.s.radius.min",
                         "actin.s.radius.max",
                         "actin.b.mean",
                         "actin.b.sd",
                         "actin.b.mad",
                         "actin.b.q005",
                         "actin.b.q01",
                         "actin.b.q05",
                         "actin.m.cx",
                         "actin.m.cy",
                         "actin.m.majoraxis",
                         "actin.m.eccentricity",
                         "actin.m.theta", 
                         "dist.10.nn",
                         "dist.20.nn",
                         "dist.30.nn",
                         "nuclear.displacement", 
                         "plate_well")
colnames(valid_small)<-c(
  "actin.s.area",
  "actin.s.perimeter", 
  "actin.s.radius.mean",
  "actin.s.radius.sd",
  "actin.s.radius.min",
  "actin.s.radius.max",
  "actin.b.mean",
  "actin.b.sd",
  "actin.b.mad",
  "actin.b.q005",
  "actin.b.q01",
  "actin.b.q05",
  "actin.m.cx",
  "actin.m.cy",
  "actin.m.majoraxis",
  "actin.m.eccentricity",
  "actin.m.theta",
  "dist.10.nn",
  "dist.20.nn",
  "dist.30.nn",
  "nuclear.displacement")

View(csd_small)
View(valid_small)

########################################################

#Tabellen vereinigt, hier komme ich wieder auf 12,958 Zeilen
joins <- right_join(csd_small, valid_small, by = c("actin.s.area", "actin.s.perimeter", "actin.s.radius.mean","actin.s.radius.sd", "actin.s.radius.min","actin.s.radius.max", "actin.b.mean","actin.b.sd",
                                                 "actin.b.mad","actin.b.q005","actin.b.q01","actin.b.q05","actin.m.cx","actin.m.cy","actin.m.majoraxis","actin.m.eccentricity","actin.m.theta",
                                                 "dist.10.nn","dist.20.nn","dist.30.nn","nuclear.displacement"))
View(joins)

#neue Dataframe mit 6 wichtigen Spalten
validation_cells_from_csdfulldata <-data.frame(joins %>% select(c(cell_id, plate, replicate, well, field, plate_well)))

#ich bekam Warnings, dass einige Spalten "char" Datentyp haben, alle in integer umgewandelt
validation_cells_from_csdfulldata<-transform(validation_cells_from_csdfulldata, cell_id=as.numeric(cell_id))
validation_cells_from_csdfulldata<-transform(validation_cells_from_csdfulldata, replicate=as.numeric(replicate))
validation_cells_from_csdfulldata<-transform(validation_cells_from_csdfulldata, field=as.numeric(field))

View(validation_cells_from_csdfulldata)



#########################################################

#zwei Spalten aus Training Data
well_target_trainingdata<-data.frame(training_data$V5, training_data$V123)
View(well_target_trainingdata)

#Ein oder mehrere Targets pro Well
well_target_unique<-well_target_trainingdata %>% distinct()
colnames(well_target_unique)<-c("well", "target")
View(well_target_unique)

# join Targets über wells. 13 542 Einträge, einige cells(plates) haben mehrere Targets
validation_cells_with_targets<-join(validation_cells_from_csdfulldata, well_target_unique, by="well")
View(validation_cells_with_targets)

#######################################################################


#was sind denn die compound ID? Ich glaube nicht von CHEMBL, muss man noch rausfinden

colnames(compund_annotations)<- c("plate",
                                  "well",
                                  "Content",
                                  "compoundID_384",
                                  "compoundID",
                                  "mol.weight.Structure",
                                  "Name",
                                  "SecName",
                                  "Class",
                                  "Enzyme",
                                  "Action",
                                  "Selectivity",
                                  "Description",
                                  "GeneID",
                                  "Selectivity_updated")

#finale Tabelle, join mit Chemikalien Liste
validationCells_targets_compounds<-join (validation_cells_with_targets, compund_annotations, by=c("plate", "well"))
View(validationCells_targets_compounds)

#Spalte mol.weight.Structure gelöscht, brauchen wir wahrscheinlich nicht. Später kann man andere Spalten auch löschen
#weiter habe ich Tabelle nicht gereinigt
#validationCells_targets_compounds<- data.frame(validationCells_targets_compounds %>% select(-(mol.weight.Structure)))
#View(validationCells_targets_compounds)




