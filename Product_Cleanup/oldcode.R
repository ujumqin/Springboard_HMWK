

'''
inventory$company <- gsub("\\w+ps$|\\w+fs$", "philips", inventory$company, ignore.case = TRUE)



url <- title_results %>% html_node(".ForumTopic-timestamp--lastPost") %>% html_attr("href")
url

topic_results <- url.request.ow %>% html_nodes(".ForumTopic--preview")

#prints
title_results
topic_results

#stores title into first_result and topic into first_topic
first_result <- title_results
first_result
first_topic <- topic_results
first_topic

#extracts the title
title <- xml_contents(title_results)[1] %>% html_text(trim = TRUE)
title[1]


#extracts preview
topic <- xml_contents(topic_results)[1] %>% html_text(trim = TRUE)
topic

records <- vector("list", length = length(title_results))

for (i in seq_along(title_results)) {
title <- xml_contents(title_results)[i] %>% html_text(trim = TRUE)
topic <- xml_contents(topic_results)[i] %>% html_text(trim = TRUE)
records[[i]] <- data_frame(title = title, topic = topic)
}

df <- bind_rows(records)
glimpse(df)
df
write.csv(df, file = "OWBoards.csv")

#how do I extract posts in thread? See below. Use ".TopicPost-bodyContent" make sure to use html_nodeS
single_result <- ow.single %>% html_nodes(".TopicPost-bodyContent") 
single_result

#print(span_characters)
#results_text <- results %>% html_node() %>% html_text(trim = FALSE)
#results_text

xmlToDataFrame(results)

df_ow <- data.frame(results, results_topic)

results

#checking url.request
class(url.request)
print(url.request)

#write file to parse manually
write.csv(url.request, file = "OW_request.csv")





####OLD CODE####
#code for putting data in tree
# require("XML")
# url.tree <- htmlTreeParse(url.request, useInternal = TRUE)
# df_url.tree = ldply(url.tree, function(t) t$toDataFrame()) 
# print(url.tree)

#Alternate URL reader
#url_ow <- 'https://us.battle.net/forums/en/overwatch/22813879/'

#reads into webpage
#webpage <- read_html(url_ow)

#print(webpage)
#df_webpage <- table(webpage)
#write(webpage, file = "OW_Webpage")

'
'''


####OLD CODE####
#code for putting data in tree
# require("XML")
# url.tree <- htmlTreeParse(url.request, useInternal = TRUE)
# df_url.tree = ldply(url.tree, function(t) t$toDataFrame()) 
# print(url.tree)

#Alternate URL reader
#url_ow <- 'https://us.battle.net/forums/en/overwatch/22813879/'

#reads into webpage
#webpage <- read_html(url_ow)

#print(webpage)
#df_webpage <- table(webpage)
#write(webpage, file = "OW_Webpage")

'''
for (i in seq_along(title_results)) {
  title <- xml_contents(title_results)[i] %>% html_text(trim = TRUE)
  topic <- xml_contents(topic_results)[i] %>% html_text(trim = TRUE)
  records[[i]] <- data_frame(title = title, topic = topic)
}

str(records)
'''

#stores title into first_result and topic into first_topic
#first_result <- title_results
#first_result
#first_topic <- topic_results
#first_topic

#isolates a link from the full_links file, 3 is test values
single_links <- full_links[3]
single_links

#read the single link html
read_single_links <- read_html(single_links)

#extract the titles & cleanup
title_results <- read_single_links %>% html_nodes(".ForumTopic-title")
title <- xml_contents(title_results) %>% html_text(trim = TRUE)

#extract the topics
topic_results <- read_single_links %>% html_nodes(".ForumTopic--preview")
topic <- xml_contents(topic_results) %>% html_text(trim = TRUE)

title
topic

#create a new dataframe for data
all_data <- data.frame("post_title" = character(n),"post_text" = character(n),"post_link" = character(n))


#write a for loop to iterate through links

ow.scrape <- read_html("https://us.battle.net/forums/en/overwatch/topic/20759286760")

#write file
write.csv(ow.single.output, file = "single.csv")

#scrapes title + text preview from html code
title_results <- url.request.ow %>% html_nodes(".ForumTopic-title")
topic_results <- url.request.ow %>% html_nodes(".ForumTopic--preview")

#prints
title_results
topic_results



#extracts the title
title <- xml_contents(title_results)[1] %>% html_text(trim = TRUE)
title


#extracts preview
topic <- xml_contents(topic_results)[1] %>% html_text(trim = TRUE)
topic

records <- vector("list", length = length(title_results))



df <- bind_rows(records)
glimpse(df)
df
write.csv(df, file = "OWBoards.csv")

#extract posts in thread. See below. Use ".TopicPost-bodyContent" make sure to use html_nodeS
single_result <- ow.single %>% html_nodes(".TopicPost-bodyContent") 
single_result

#removes all the extra information around text
text <- xml_contents(single_result) %>% html_text(trim = TRUE)
text

#print(span_characters)
#results_text <- results %>% html_node() %>% html_text(trim = FALSE)
#results_text

xmlToDataFrame(results)

df_ow <- data.frame(results, results_topic)

results

#checking url.request
class(url.request)
print(url.request)

#write file to parse manually
write.csv(url.request, file = "OW_request.csv")






