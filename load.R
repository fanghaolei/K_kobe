library(ggplot2)
library(data.table)
df <- read.csv('data.csv')
df <- setDT(df)
# exclude team_id, team_name
df[, team_id := NULL]
df[, game_id := NULL]
df[, team_name := NULL]
df[, shot_made_flag:= as.factor(shot_made_flag)]

# parse out home vs. away
df[matchup %like% "@", matchup := 'Away']
df[matchup %like% "vs.", matchup := 'Home']

# set game_date into data format
df[, game_date:= as.Date(game_date)]

train <- df[!is.na(shot_made_flag), ]
test <- df[is.na(shot_made_flag), ]


# load basketball court
library(jpeg)
library(grid)
courtimg <- readJPEG('lakers.jpg')
courtimg <- rasterGrob(courtimg, width=unit(1,"npc"), height=unit(1,"npc"))
