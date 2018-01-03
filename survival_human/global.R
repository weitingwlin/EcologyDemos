
allyears <- c("1930-1934", "1940-1944", "1950-1954", "1960-1964")

## loading and preparing data
library("ggplot2")
library("dplyr")
library("reshape")
data <- read.table("data/USA_5x5.txt",header = TRUE, sep = "", skip = 1)

data <- data[data$Total != ".",]
data <- data[table(data$Year)[data$Year] > 8, ]

data$Age <-as.numeric( 
    regmatches( as.character(data$Age) ,regexpr("([0-9]*$)", as.character(data$Age) ))
)

data$Age[data$Age == 0] <- 1
data$Age[is.na(data$Age)] <- 110
data$Female <-as.numeric(as.character(data$Female))
data$Male <-as.numeric(as.character(data$Male))
data$Total <-as.numeric(as.character(data$Total))
##
yeardata <- data[data$Year %in% allyears,]
yearcurve <- NULL
for (y in allyears){
    subdata <- data[data$Year == y ,]
    curve <-subdata
    curve[1, 3:5] <- 1 # initialize
    for (t in 2:length(curve$Age)){
        curve[t, 3:5] <- curve[t-1, 3:5] *(1 - subdata[t-1, 3:5] )
    }
    yearcurve <- rbind(yearcurve, curve)
}

meltyear <- melt(yeardata, id.vars = c( "Year","Age"))
meltcurve <- melt(yearcurve, id.vars = c( "Year","Age"))
##



p1 <- function(years, groups){
    subdata <- meltyear[meltyear$Year %in% years & meltyear$variable %in% groups, ]
    colnames(subdata)[4] <- "Mortality"
    
    p <- ggplot(data = subdata, aes(x = Age, y = Mortality) )
    if (length(years)>1) {
            p <- p + geom_line( size=1, alpha = 0.6, aes(color = Year)) 
            p <- p + facet_grid(.~ variable)}else 
        {
            p <- p + geom_line( size=1, alpha = 0.6, aes(color = variable))   
        }
    p <- p + theme(axis.text=element_text(size=18),
                   text = element_text(size=20))
  return(p)
}

p2 <- function(years, groups){
    subcurve <- meltcurve[meltcurve$Year %in% years & meltcurve$variable %in% groups, ]
    colnames(subcurve)[4] <- "Survival"
    
    p <- ggplot(data = subcurve, aes(x = Age, y = Survival) )
    if (length(years)>1) {
        p <- p + geom_line( size=1, alpha = 0.6, aes(color = Year)) 
        p <- p + facet_grid(.~ variable)}else 
        {
            p <- p + geom_line( size=1, alpha = 0.6, aes(color = variable))   
        }
    p <- p + theme(axis.text=element_text(size=18),
                   text = element_text(size=20))
    return(p)
}