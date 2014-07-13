# Plot 4 script

# Make sure to setwd() to correct directory
# Import text file into variable 'energy'
readItIn <- function() {
    textfile <- 'household_power_consumption.txt'
    # since we aren't starting from row 1, we need to grab our
    # column names
    row1names <- read.table(textfile, header=T, sep=';', nrows=1)
    columnNames <- names(row1names)
    # read the table
    energy <- read.table(textfile, sep=';', col.names=columnNames,
                         skip=66637, nrows=2881, as.is=T)
    # adjusting Date characteristics
    energy[,1] <- as.Date(energy[,1], format='%d/%m/%Y')
    # pasting first 2 columns together and formatting
    combined <- paste(energy[,1], energy[,2])
    combined <- strptime(combined, format='%F %T')
    # final table
    energy <- cbind(combined, energy[,3:9])
    energy
}

# complete function - no need to run above function
makeplot4 <- function() {
    energy <- readItIn()
    png(filename='plot4.png', width=480,height=480)
    par(mfrow=c(2,2), mar=c(5.1,4.1,2.1,2.1))
    with(energy, {
        # first plot
        plot(combined, Global_active_power, type='l', xlab='',
             ylab='Global Active Power', cex.axis=0.7)
        # second plot
        plot(combined, Voltage, type='l',
             xlab='datetime', ylab='Voltage')
        # third plot
        plot(combined, Sub_metering_1, type='l', xlab='', 
             ylab='Energy sub metering')
        lines(combined, Sub_metering_2, col='red')
        lines(combined, Sub_metering_3, col='blue')
        legend('topright', col=c('black','red','blue'), lty=1,
               bty='n',legend=c('Sub_metering_1','Sub_metering_2', 'Sub_metering_3'))
        # fourth plot
        plot(combined, Global_reactive_power, type='l',
             xlab='datetime')
    })
    dev.off()
}