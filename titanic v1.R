library(tidyverse)




df <- read_csv("C:/Users/anfer/OneDrive/Desktop/PCBA/PCBA Notes/Module 3/titanic.csv")

# creating a copy of the data frame

df_copy <- df

dim(df_copy)

df_copy |> head(10)

# list data type of each feature

sapply(df_copy, class)

# view dtypes in a plot

visdat::vis_dat(df_copy, sort_type = F)

## Age and Cabin seem to have missing values


# renaming columns


library(dplyr)

df_copy <- df_copy |>
  rename(
         "parents_children_aboard" = "Parch",
         "port_of_embarkment" = "Embarked")


# converting data types to categorical(which is represented as factor in R)

df_copy$Name <- as.factor(df_copy$Name)

df_copy$Sex <- as.factor(df_copy$Sex)

df_copy$Ticket <- as.factor(df_copy$Ticket)

df_copy$Cabin <- as.factor(df_copy$Cabin)

df_copy$port_of_embarkment <- as.factor(df_copy$port_of_embarkment)

df_copy$PassengerId <- as.factor(df_copy$PassengerId)

# verifying the change in data type

sapply(df_copy, class)


# Analyzing missing values

missing_vals <- df_copy |>
  gather(key = "key", value = "val") |>
  mutate(is_missing = is.na(val)) |>
  group_by(key, is_missing) |> 
  summarise(num_missing = n()) |>
  filter(is_missing == T) |>
  select(-is_missing) |>
  arrange(desc(num_missing))

# visualizing the missing values by %

missing_val_pct <- df_copy |>
  gather(key = "key", value = "val") |>
  mutate(isna = is.na(val)) |>
  group_by(key) |>
  mutate(total = n()) |>
  group_by(key, total, isna) |>
  summarise(num_isna = n()) |>
  mutate(pct = (num_isna / total) * 100)

# creating a percentage plot

  levels <- (missing_val_pct |>
  filter(isna == T) |> arrange(desc(pct)))$key

pct_plot <- missing_val_pct |>
  ggplot() +
  geom_bar(aes(x = reorder(key, desc(pct)),
               y = pct, fill = isna),
           stat = "identity", alpha = 0.9) +
  scale_x_discrete(limits = levels) +
  scale_fill_manual(name = "",
                    values = c('steelblue', 'tomato3'),
                    labels = c("Present", "Missing")) +
  coord_flip() +
  labs(title = "Percentage of missing values", x = 
         "Variable", y = "% of missing values")

pct_plot

# plotting each row to get further insight


row_plot <- df_copy |>
  mutate(id = row_number()) |>
  gather(-id, key = "key", value = "val") |>
  mutate(isna = is.na(val)) |>
  ggplot(aes(key, id, fill = isna)) +
  geom_raster(alpha=0.8) +
  scale_fill_manual(name = "",
                    values = c('steelblue', 'tomato3'),
                    labels = c("Present", "Missing")) +
  scale_x_discrete(limits = levels) +
  labs(x = "Variable",
       y = "Row Number", title = "Missing values in rows") +
  coord_flip()

row_plot



# no patterns / links can be seen between the missing values for cabin & age




