library(rvest)
library(dplyr)

AP_link = "https://www.hockey-reference.com/leaders/points_adjusted_career.html"
AP_page = read_html(AP_link)

Player = AP_page %>% 
  html_nodes("td.left") %>% 
  html_text()
APTS = AP_page %>% 
  html_nodes("td+ .right") %>% 
  html_text()
Player_links = AP_page %>% html_nodes("td.left a") %>% 
  html_attr("href") %>% paste("https://www.hockey-reference.com", ., sep="")

get_GP = function(player_link) {
  player_page = read_html(player_link)
  player_GP = player_page %>% html_nodes(".p1 div:nth-child(1) p") %>% 
    html_text()
  return(player_GP)
}

GP <- sapply(Player_links, function(link) {
  result <- get_GP(link)
  Sys.sleep(4)
  return(result)
})

CareerAP = data.frame(Player, APTS, stringsAsFactors = FALSE)
View(CareerAP)

print(Player_links)