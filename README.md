# Topic Modeling of US Presidential Speeches 🗣️

This project performs topic modeling on a collection of US presidential speeches to uncover underlying themes and trends.

---

## Overview

Using R and several text mining libraries, this analysis breaks down presidential speeches into topics by:

* Tokenizing speeches into individual words
* Removing common stop words
* Lemmatizing words to their base forms
* Creating document-term matrices for topic modeling
* Applying Latent Dirichlet Allocation (LDA) to identify topics
* Visualizing the most relevant words per topic using ggplot2

---

## Libraries Used

* `tidyverse`
* `tidytext`
* `textstem` (for lemmatization)
* `topicmodels` (for LDA topic modeling)
* `dplyr`
* `stringr`

---

## Workflow

### 1. Data Preparation & Tokenization

* Load presidential speeches dataset (`presidential_speeches_sample.csv`)
* Tokenize speeches into single words
* Remove stop words
* Lemmatize words for consistency

### 2. Topic Modeling

* Build document-term matrices representing word counts per speech or year
* Use LDA to discover 12 latent topics across all speeches, by year, and by party affiliation (Democrats and Republicans)

### 3. Visualization

* Extract top words associated with each topic
* Plot relevant terms per topic using bar charts for intuitive analysis

---

## Project Sections

* **Part 1:** Identify latent topics across all speeches
* **Part 2:** Analyze frequency of topics by year
* **Part 3:** Separate analysis for Democratic and Republican speeches

---

## Usage

* Uncomment the `plot1`, `plot2`, `plot_d`, or `plot_r` lines to generate corresponding topic visualizations
* Adjust the number of topics or words per topic in the LDA model as needed for deeper insights

---

## Data Source

* `presidential_speeches_sample.csv` contains the speech text and metadata

---

## Notes

* The project demonstrates text mining techniques, natural language processing, and visualization applied to political speech data.
* The approach helps reveal thematic shifts over time and across political parties.

