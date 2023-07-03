library(tidyverse)


df <- read_csv("C:/Users/anfer/OneDrive/Desktop/PCBA/PCBA Notes/Module 3/titanic.csv")

df_copy <- df

dim(df_copy)


# list data type of each feature

sapply(df_copy, class)



# converting data types to categorical(which is represented as factor in R)

df_copy$Name <- as.factor(df_copy$Name)

df_copy$Sex <- as.factor(df_copy$Sex)

df_copy$Ticket <- as.factor(df_copy$Ticket)

df_copy$Cabin <- as.factor(df_copy$Cabin)

df_copy$Embarked <- as.factor(df_copy$Embarked)

df_copy$PassengerId <- as.factor(df_copy$PassengerId)

# verifying the change in data type

sapply(df_copy, class)

# Dropping missing values

