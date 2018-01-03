

fluidPage(    
    # Give the page a title
    titlePanel("Human survivorship"),
  
    # Generate a row with a sidebar
    sidebarLayout(      
        
        # Define the sidebar with one input
        sidebarPanel(
            checkboxGroupInput("years", "select birth years:",
                              allyears, selected = c("1930-1934")),
            hr(),
            checkboxGroupInput("groups", "Select groups:",
                               c("Total", "Female", "Male"), selected = c("Total")),
            
            actionButton("show", "Show"),
            hr(),
            uiOutput("HelpBox"),
            helpText( 
            a("Go back to the survivorship curve", href="https://weitingwlin.shinyapps.io/introeco1/"))
        ),
        
        mainPanel(
          tabsetPanel(type = "tabs", 
                      tabPanel("Plot",  plotOutput("curveplot")), 
                      tabPanel("Summary",  includeMarkdown("moreinfo.md"))
                    
          )
        )# mainPanel
    )
)