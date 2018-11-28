# Coursera Data Science Specialization Course 4 Week 1 Project 1 Script 3


# Acknowledgement for this dataset goes to:
# Georges Hebrail (georges.hebrail '@' edf.fr), Senior Researcher, EDF R&D,
# Clamart, France. Alice Berard, TELECOM ParisTech Master of Engineering
# Internship at EDF R&D, Clamart, France. Accessed from the UCI Machine Learning
# Repository - Individual household electric power consumption data set


# The purpose of this script is to satisfy the requirements of the week 1 course
# project that is part of the Exploratory Data Analysis course within the Data
# Science Specialization on Coursera. As per the instructions the script must
# construct the plot and save it to a PNG file with a width of 480 pixels and a
# height of 480 pixels. The project will consist of four scripts and four plots.
#
# The input for this script is the data set obtained from the url below. The
# output is the PNG plot file.


# Part 1: Download and unzip the data as needed

file.name <- "ProjectData.zip"

# Check if the file exists in the directory before downloading it again
if (!file.exists(file.name)) {
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, file.name)
  rm(url)  # Remove objects that are no longer needed
}

# Check if the file has been unzipped before unzipping again
if (!file.exists("household_power_consumption.txt")) {
  unzip(file.name)
}

rm(file.name)  # Remove objects that are no longer needed


# Part 2: Read in the raw data from the unzipped folder, subset, and prepare

# The instructions specify that only the data from February 1, 2007 to February
# 2, 2007 will be used for this assignment. An brief look into the data shows
# that this corresponds to rows 66637 through 69516. For efficiency read.table
# is hard coded below to read in only until row 69516. The date and time columns
# are read in as characters for now and will be converted later.
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                   colClasses = c("character", "character", rep("numeric", 7)),
                   na.strings = "?", nrows = 69516)
# Subset out only the rows that are needed, the dates from 1/2/2007 to 2/2/2007
data <- data[66637:69516, ]

# Prepare the data by converting the date and time columns to dates and times
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- as.POSIXct(paste(data$Date, data$Time),
                        format = "%Y-%m-%d %H:%M:%S", tz = "Europe/Paris")


# Part 3: Make the plot and save to a .png file

# The instructions specify that the plot should be output as a 480x480 .png file
# The default output is already 480x480 pixels
png("plot3.png")
plot(data$Time, data$Sub_metering_1, type = "l", xlab = "",
     ylab = "Energy sub metering")
points(data$Time, data$Sub_metering_2, type = "l", col = "red")
points(data$Time, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty =1)
dev.off()

rm(data)  # Remove objects that are no longer needed
