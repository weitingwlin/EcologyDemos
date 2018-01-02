

fluidPage(    
    # Give the page a title
    titlePanel("Survival curve"),
  
    # Generate a row with a sidebar
    sidebarLayout(      
        
        # Define the sidebar with one input
        sidebarPanel(
            selectInput("species", "Select a Species:", 
                        choices = c( "Human", "Bird", "Fish"),
                        selected = "Bird"),
            hr(),
            helpText("Different species have different survival curves."),
            actionButton("update", "Simulate a generation"),
            
            actionButton("clear", "Clear")
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