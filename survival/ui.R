

fluidPage(    
    # Give the page a title
    titlePanel("Survivorship curve"),
  
    # Generate a row with a sidebar
    sidebarLayout(      
        
        # Define the sidebar with one input
        sidebarPanel(
            selectInput("typeSpecies", "Select a Type:", 
                        choices = c( "Type I"= "Human", "Type II" = "Bird", "Type III" = "Fish"),
                        selected = NULL),
            hr(),
            helpText(""),
            actionButton("update", "Simulate"),
            
            actionButton("clear", "Clear"),
            hr(),
            uiOutput("HelpBox"),
            helpText( 
            a("Check out real examples of Human survival curve!", href="http://www.mortality.org/cgi-bin/hmd/country.php?cntr=USA&level=1"))
        ),
        
        mainPanel(
          tabsetPanel(type = "tabs", 
                      tabPanel("Plot",  plotOutput("curveplot")), 
                     # tabPanel("Summary", verbatimTextOutput("summary")), 
                      tabPanel("Table", tableOutput("values"))
          )
        )# mainPanel
    )
)