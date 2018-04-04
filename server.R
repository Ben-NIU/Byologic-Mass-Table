library(DT)
source("Convert.R")

shinyServer(function(input, output) {
  
  FF<-reactive({ 
    validate(
      need(input$inputs$datapath !="", "Please upload a *.csv file")
    )
    read.csv(input$inputs[['datapath']])
  })
  
  

  
  observeEvent(input$inputs, {
    output$table<-DT::renderDataTable({
      Convert(FF())}, rownames=FALSE, options=list(
        lengthMenu=list(c(25, 50, -1), c("25","50", "All")),
        pageLength=25))})
      
  output$Output<-downloadHandler(
    filename = function() {
      paste("Parent-Ion-List_", Sys.Date(), ".csv", sep="")}, 
      content=function(file){
    write.csv(Convert(FF()), file, row.names = FALSE)})
    
})
  