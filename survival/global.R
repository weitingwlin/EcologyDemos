
mortality <- function(type, g){
  df <- data.frame(Human = 2^((1:20)/2)/1024,
                   Bird =  rep(0.2, 20),
                   Fish = (20 - (1:20))/40
                   ) 
  if (g <= 20){
      return(df[g,type])
  } else {
      return(df[20,type]) 
  }
}

helpTextsType <- list("Human" = "Type I survivorship curve: mortality rate increases over time, 
                                 as individuals get older (e.g. Human)", 
                      "Bird" = "Type II survivorship curve: mortality does not change (e.g. Bird)", 
                      "Fish" = "Type III survivorship curve: mortality is high when individuals are 
                                young, and decrease after a critical stage (e.g. Fish)")

lifescale <- function(type){
  
  long <- list("Human" = 5, "Bird" = 0.5, "Fish" = 0.5)
  return(as.numeric(long[type]))
}


p1 <- function(D, type){
 # datain <- datain[1:dim(datain)[1],]
  DF <- data.frame(time = D$t, Population = D$N)
  p <- ggplot(data = DF, aes(x = time, y = Population))
  p <- p + geom_line(color='steelblue', size=2, alpha = 0.6) 
  p <- p + xlim(0, 22*lifescale( type) )
  p <- p + ylim(0, 1000 )
  #p <- p + geom_point(color='steelblue', size=3, alpha = 0.8) 
  p <- p + theme_minimal()
  p <- p + theme(axis.text=element_text(size=18),
                 text = element_text(size=20))
  return(p)
}

p2 <- function(Din, type){
  datain <- Din[2:dim(Din)[1],]
  p <- ggplot(data = datain, aes(x = t, y = Mortality))
  p <- p + geom_line(color='darkolivegreen', size=2, alpha = 0.6) 
#  p <- p + geom_point(color='steelblue', size=3, alpha = 0.8) 
  p <- p + xlim(0, 22*lifescale( type) )
  p <- p + ylim(0, 1 )
  p <- p + theme_minimal()
  p <- p + theme(axis.text=element_text(size=18),
                 text = element_text(size=20))
  return(p)
}