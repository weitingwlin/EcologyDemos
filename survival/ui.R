

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
            helpText("(Click [Simulate] to simulate one time step)"),
            actionButton("update", "Simulate"),
            
            actionButton("clear", "Clear"),
            hr(),
            uiOutput("HelpBox"),
            helpText( 
            a("Check out real examples of Human survival curve!", href=" https://weitingwlin.shinyapps.io/survival_human/"))
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