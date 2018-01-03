library(ggplot2)
library(gridExtra)

shinyServer(
    function(input, output, session) {
    
        simtime <<- 1
        CH <<- data.frame(t = 0, N = 1000, Mortality = 0)   
    
        type <- reactive({
            input$typeSpecies
        })
    
        observeEvent(input$update, {
            
            t <- type()
            mort <- mortality(t,simtime)
            n <- CH$N[simtime]
            ## show help box
            output$HelpBox = renderUI({
                helpText(helpTextsType[t])
            })
            ##
        
        if (n > 0){
            simtime <<- simtime + 1
        
            CH[simtime,1] <<- simtime * lifescale(t)
            CH[simtime,3] <<- mort
            CH[simtime,2] <<- (1-mort) * n
        
            output$values <- renderTable({
                CH
            })
        
            output$curveplot <- renderPlot({
                q <- p1(CH, type())
                p <- p2(CH, type())
                grid.arrange(p, q, ncol=1)
            })
        }# if (n > 0)
    })

    observeEvent(input$clear, {
        CH <<- data.frame(t = 0, N = 1000, Mortality = 0)   
        simtime <<- 1
        
        output$values <- renderTable({
            CH
        })
        output$curveplot <- renderPlot({
          q <- p1(CH, type())
          p <- p2(CH, type())
          grid.arrange(p, q, ncol=1)
        })
    })
   
    }
)
