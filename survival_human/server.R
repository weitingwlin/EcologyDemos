library(ggplot2)
library(gridExtra)

shinyServer(
    function(input, output, session) {
    
       # simtime <<- 1
       # CH <<- data.frame(t = 0, N = 1000, Mortality = 0)   
    
        years <- reactive({
            input$years
        })
        groups <- reactive({
            input$groups
        })
    
        observeEvent(input$show, {
        
            output$curveplot <- renderPlot({
                q <- p1(years(), groups())
                p <- p2(years(), groups())
                grid.arrange(q, p, ncol=1)
            })
        })


   
    }
)
