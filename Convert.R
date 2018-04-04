Convert<-function(csv) {
  library(dplyr)

  ## ppm
  ppm<-as.character(csv$ppm)
  avg.ppm<-function(x){
    round(mean(as.numeric(strsplit(x, split = ";", fixed=TRUE)[[1]]), na.rm=TRUE),2)}
  PPM<-do.call("c", lapply(ppm, avg.ppm))
  
  ## Observed mz
  obs.mz<-as.character(csv$Obs..nm.z)
  obs.M<-as.character(csv$Obs.M)
  avg.obmz<-function(x){
    round(mean(as.numeric(strsplit(x, split=" - ")[[1]])),4)}
  Obs.mz<-do.call("c", lapply(obs.mz, avg.obmz))
  Obs.M<-do.call("c", lapply(obs.M, avg.obmz))
  Z<-csv$z
  RT<-csv$Apex.Time.n.Posit.
  Calc<-round(csv$Calc..nm.z,4)
  ## New dataframe
  new.data<-cbind(csv[,1:6], Calc, Obs.mz, PPM, Z, Obs.M, RT) 
  
  ## Grouping and calculation
  Group.csv<-group_by(new.data, Protein.nname, Start.nAA, End.nAA, Sequence.n.unformatted.,Mod..nNames, Calc,Z)
  Avg<-as.data.frame(summarize(Group.csv, round(mean(RT, na.rm = TRUE),2), round(mean(Obs.mz,na.rm = TRUE),4), round(mean(PPM,na.rm=TRUE),1),format(round(mean(Obs.M,na.rm = TRUE),2), nsmall=2)), check.names=FALSE)

  names(Avg)<-c("Protein name","Start AA", "End AA","Sequence","Mod. Names", "Calc. m/z","z","RT (min)", "Obs. m/z", "ppm", "Observed Monoisotopic Mass (uncharged)")
  return(Avg)
}