# Plot 1 script

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
makeplot1 <- function() {
    energy <- readItIn()
    png(filename='plot1.png', width=480,height=480)
    with(energy, hist(Global_active_power, col='red',
        xlab='Global Active Power (kilowatts)',
        main='Global Active Power'))
    dev.off()
}