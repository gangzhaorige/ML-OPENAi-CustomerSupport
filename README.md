# Generative Ai Using OpenAI API


## Introduction
This project is to use the popular OpenAI models to create a customer support website to answer questions from customers about their website.

**OpenAI API MODELS**

**text-embedding-ada-002**

OpenAI’s text embeddings measure the relatedness of text strings. Embeddings are commonly used for:

* **Search** (where results are ranked by relevance to a query string)
* **Clustering** (where text strings are grouped by similarity)
* **Recommendations** (where items with related text strings are recommended)
* **Anomaly detection** (where outliers with little relatedness are identified)
* **Diversity measurement** (where similarity distributions are analyzed)
* **Classification** (where text strings are classified by their most similar label)

**gpt-3.5-turbo-instruct**

OpenAI has unveiled a new and advanced model, gpt-3.5-turbo-instruct, designed to seamlessly interpret and execute instructions. The new model, which is now the default language models accessible on our API, is engineered to provide coherent and contextually relevant responses, making it a versatile asset for a range of applications. In this article, we’ll explore the functionalities and distinctive features of gpt-3.5-turbo-instruct and discuss why OpenAI embarked on the development of this model.

## Project Design
This project will crawl data from a website.
Using the processed data it will embed using Open AI **text-embedding-ada-002** and answer questions using **gpt-3.5-turbo-instruct**.

Users can inquire about the website and receive answers that are readily available on the site.

**The implementation of this project will follow two distinct approaches:**
- Flask (Python)
- NodeJS (JavaScript)

## Getting Started

- Clone the project.
```
$ git clone https://github.com/gangzhaorige/ML-OPENAi-CustomerSupport.git
```
- Get an API_KEY from OPEN AI
- Setup your API_KEY in .env (See either Flask or NodeJS)

## Crawl
Specify your domain and full url for the website to crawl in **crawl.py**

```python
# Example
domain = "about.fb.com"
full_url = "https://about.fb.com/"
```
Use the following command to start the crawl.
```
python3 crawl.py
```

## Embedding
Use the following command to start the embed using OPEN AI.
```
python3 embed.py
```

## To run Flask Version

```
$ flask run
```

## To run NodeJS Version

```
$ npm run dev
```





