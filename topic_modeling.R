#install packages
install.packages("tidyverse")
install.packages("tidytext")
install.packages("textstem") # includes functionality to stem/lemmatize words
install.packages("topicmodels") # performs topic modelling
install.packages("dplyr")
install.package("stringr")

# Load libraries
library(tidyverse)
library(tidytext)
library(textstem)
library(topicmodels)
library(dplyr)
library(stringr)

#Part 1: Identity Latent Topic of all the speeches
p_speeches = read_csv("presidential_speeches_sample.csv")

# Tokenize the speech content- split the text up into individual words, one word per row. 
# Unnest the content field into a new field "word"
tokens = unnest_tokens(p_speeches, word, content) # breaks down text into words
head(tokens)

# Time to remove "stopwords" 
stop_words

# To remove stop words, use the anti_join function
tokens = anti_join(tokens, stop_words, by="word")

# To lemmatize words, use the lemmatize_words function
tokens = mutate(tokens, lemma=lemmatize_words(word))
View(head(tokens))

# The topicmodels package needs a matrix of number of each word per document.
# Create a table with word counts by document.
wcounts = group_by(tokens, document, lemma) %>% summarize(count=n())

# Turn it into a matrix that can be used in a topic model.
word_mtx = cast_dtm(wcounts, document, lemma, count)

model = LDA(word_mtx, 12, control=list(seed=42))

# The beta matrix- tells how often words are associated with a particular topic
beta = tidy(model, matrix="beta")
View(beta)

# The beta matrix contains for each topic the probability that each word is associated
# with that topic. 
# Filter 12  words for each topic as these are likely to be quite relevant to the topic.
top_12 = group_by(beta, topic) %>% slice_max(beta, n=12)
top_12

# Plot with ggplot. 
plot1 <-
  ggplot(top_12, aes(y=reorder_within(term, beta, topic), x=beta, fill=factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~topic, scales="free") +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_reordered()

#plot1 #Comment/Uncomment when necessary

# Part 2: Graphing the frequency of 2-4 topics by year
p_speeches$year <- str_extract(p_speeches$document,"(1|2)\\d{3}") #Extracting year from the document column
head(p_speeches)

## Tokenize the speech content- split the text up into individual words, one word per row. 
# Unnest the content field into a new field "word"
tokens_y = unnest_tokens(p_speeches, word, content)
head(tokens_y)

# To remove stop words, use the anti_join function
tokens_y = anti_join(tokens_y, stop_words, by="word")

# To lemmatize words, use the lemmatize_words function
tokens_y = mutate(tokens_y, lemma=lemmatize_words(word))
View(head(tokens_y))

# The topicmodels package needs a matrix of number of each word per document.
# Create a table with word counts by year.
wcounts_y = group_by(tokens_y, year, lemma) %>% summarize(count=n())

# Turn it into a matrix that can be used in a topic model.
word_mtx_y = cast_dtm(wcounts_y, year, lemma, count)

model_y = LDA(word_mtx_y, 12, control=list(seed=42))

# The beta matrix- tells how often words are associated with a particular topic
beta_y = tidy(model_y, matrix="beta")
View(beta_y)

# The beta matrix contains for each topic the probability that each word is associated
# with that topic. 
# Filter 4  words for each topic as these are likely to be quite relevant to the topic.
top_4_y = group_by(beta_y, topic) %>% slice_max(beta, n=4)
top_4_y


#Plot with ggplot
plot2 <-
  ggplot(top_4_y, aes(y=reorder_within(term, beta, topic), x=beta, fill=factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~topic, scales="free") +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_reordered()


#plot2 #Comment/Uncomment when necessary

#Part 3
# Making two new datasets for Democrats and Republicans
democrats <- 
  p_speeches %>% filter(grepl('Barack Obama|William J. Clinton|Jimmy Carter', document))

republicans <- 
  p_speeches %>% filter(grepl('George W. Bush|Ronald Reagan|George Bush', document))

# Making graph for Democrats
# Tokenize the speech content- split the text up into individual words, one word per row. 
# Unnest the content field into a new field "word"
tokens_d = unnest_tokens(democrats, word, content)
head(tokens_d)

# To remove stop words, use the anti_join function
tokens_d = anti_join(tokens_d, stop_words, by="word")

# To lemmatize words, use the lemmatize_words function
tokens_d = mutate(tokens_d, lemma=lemmatize_words(word))
View(head(tokens_d))

# The topicmodels package needs a matrix of number of each word per document.
# Create a table with word counts by document.
wcounts_d = group_by(tokens_d, document, lemma) %>% summarize(count=n())

# Turn it into a matrix that can be used in a topic model.
word_mtx_d = cast_dtm(wcounts_d, document, lemma, count)

model_d = LDA(word_mtx_d, 12, control=list(seed=42))

# The beta matrix- tells how often words are associated with a particular topic
beta_d = tidy(model_d, matrix="beta")
View(beta_d)

# The beta matrix contains for each topic the probability that each word is associated
# with that topic. 
# Filter 12  words for each topic as these are likely to be quite relevant to the topic.
top_12_d = group_by(beta_d, topic) %>% slice_max(beta, n=12)
top_12_d

# Plot with ggplot. 
plot_d <-
  ggplot(top_12_d, aes(y=reorder_within(term, beta, topic), x=beta, fill=factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~topic, scales="free") +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_reordered()

#plot_d #Comment/Uncomment when necessary

# Making graph for Republicans
# Tokenize the speech content- split the text up into individual words, one word per row. 
# Unnest the content field into a new field "word"
tokens_r = unnest_tokens(republicans, word, content)
head(tokens_r)

# To remove stop words, use the anti_join function
tokens_r = anti_join(tokens_r, stop_words, by="word")

# To lemmatize words, use the lemmatize_words function
tokens_r = mutate(tokens_r, lemma=lemmatize_words(word))
View(head(tokens_r))

# The topicmodels package needs a matrix of number of each word per document.
# Create a table with word counts by document.
wcounts_r = group_by(tokens_r, document, lemma) %>% summarize(count=n())

# Turn it into a matrix that can be used in a topic model.
word_mtx_r = cast_dtm(wcounts_r, document, lemma, count)

model_r = LDA(word_mtx_r, 12, control=list(seed=42))

# The beta matrix- tells how often words are associated with a particular topic
beta_r = tidy(model_r, matrix="beta")
View(beta_r)

# The beta matrix contains for each topic the probability that each word is associated
# with that topic. 
# Filter 12  words for each topic as these are likely to be quite relevant to the topic.
top_12_r = group_by(beta_r, topic) %>% slice_max(beta, n=12)
top_12_r

# Plot with ggplot. 
plot_r <-
  ggplot(top_12_r, aes(y=reorder_within(term, beta, topic), x=beta, fill=factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~topic, scales="free") +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_reordered()

#plot_r #Comment/Uncomment when necessary

