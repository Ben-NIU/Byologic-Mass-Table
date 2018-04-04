library(shinydashboard)

dashboardPage(skin="green",
      dashboardHeader(title="Hi, let me create the parent ions list for you!", titleWidth = 700),
      dashboardSidebar(
        sidebarMenu(
          fileInput("inputs", label=span("Input the *.csv generated from Byologic", style="font-family:'calibri'; font-size:12pt")),
          hr()
        )
      ),
      
     dashboardBody(
       fluidRow(
         box(title="Parent ions list", status = "primary", solidHeader = TRUE, collapsible = TRUE, width = 12,
            DT::dataTableOutput("table"))),
       fluidRow(
         box(title="Download me", status="warning", solidHeader = TRUE, collapsible = FALSE, width=4,
             helpText(span("Click the button below to output list", style="font-family:'calibri'; color:blue; font-size: 11pt")),
             downloadButton("Output", label="Download")
         )))
)
          