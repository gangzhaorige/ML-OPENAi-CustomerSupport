import os
from flask_cors import CORS, cross_origin

import openai
from flask import Flask, jsonify, request
from products import products
app = Flask(__name__)
openai.api_key = os.getenv("OPENAI_API_KEY")
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'

delimiter = '```'

def get_completion(
        messages,
        model="gpt-3.5-turbo",
        temperature=0.3,
    ): 
    response = openai.chat.completions.create(
        model=model,
        messages=messages,
        temperature=temperature, 
    )
    return response.choices[0].message.content


def generate_customer_comment(products_data):
    """
    Generate customer comment with provided products_data
    """
    system_message = f"""Assume that you are a customer to an electronic product company.\
The products' are delimited with by tripe backticks.\
Products: {delimiter}{products_data}{delimiter}\
"""

    user_message = f"""
    Provide a 100-word comment regarding the products.
    """
    prompt = [
        {'role' : 'system', 'content' : system_message},
        {'role' : 'user', 'content' : f"{delimiter}{user_message}{delimiter}"},
        {'role' : 'assistant', 'content': 'talk as a customer' }
    ]
    response = get_completion(prompt)
    return response

def generate_email_subject(comment):
    """
    Generate email subject with provided customer comment about a product.
    """
    system_message = f"""Assume that you provide customer support for an electronic product company.\
The following text is the customer's comment about the products. The comment will be delimited by tripe backticks.\
{delimiter}{comment}{delimiter}"""
    
    user_message = f"""Generate a subject in English of the comment.\
The subject will be used as the subject of the email to be sent to the customer."""
    messages =  [  
        {'role' : 'system', 'content' : system_message},    
        {'role':'user', 'content': f"{delimiter}{user_message}{delimiter}"},  
    ] 
    subject = get_completion(messages)  
    return subject

def generate_summary(comment):
    """
    Generate the summary of the customer's comment
    """
    system_message = f"""Assume that you provide customer support for an electronic product company.\
The following text is the comment of products, please generate a summary of the comment. The comment will be delimited by tripe backticks.\
{delimiter}{comment}{delimiter}"""
    
    user_message=f"""Please generate an English summary of the comment."""
    messages =  [  
        {'role' : 'system', 'content' : system_message},    
        {'role':'user', 'content': f"{delimiter}{user_message}{delimiter}"},  
    ] 
    return get_completion(messages)

def analyze_sentiment(comment):
    """
    Analyze Customer Comment Sentiment
    Return True if sentiment analysis is positive
    """
    system_message = f"""Assume that you provide customer support for an electronic product company.\
The comment will be delimited by tripe backticks.\
{delimiter}{comment}{delimiter}"""
    
    user_message = f"""
    Please do sentiment analysis based on the following comment.
    """
    messages =  [  
        {'role' : 'system', 'content' : system_message},    
        {'role' : 'user', 'content': f"{delimiter}{user_message}{delimiter}"},
        {'role' : 'assistant', 'content' : "Return the result of the sentiment analysis as Positive or Negative."}
    ] 
    return get_completion(messages).upper()

def generate_email(comment, subject, summary, sentiment_analysis, selected_language):
    system_message = f"""Assume that you provide customer support for an electronic product company.\
The followings are customer comment, email subject, comment summary, and sentiment analysis.\
The informations will be delimited by tripe backticks.\
1. The customer comment: {delimiter}{comment}{delimiter}\
2. Email subject: {delimiter}{subject}{delimiter}\
3. Comment summary: {delimiter}{summary}{delimiter}\
4. Sentiment analysis: {delimiter}{sentiment_analysis}{delimiter}"""
    user_message = f"""
    Please create an email in {selected_language} to be sent to the customer.
    """
    messages =  [  
        {'role' : 'system', 'content' : system_message},    
        {'role' : 'user', 'content': f"{delimiter}{user_message}{delimiter}"},
    ] 
    return get_completion(messages)

def get_translation(summary, language):
    system_message = f"""Assume you are a professional translator.\
The summary will be delimited by tripe backticks.\
{delimiter}{summary}{delimiter}"""
    user_message = f"""
    Translate the summary into {language} language."""
    messages_translate =  [  
        {'role' : 'system', 'content' : system_message},    
        {'role' : 'user', 'content' : f"{delimiter}{user_message}{delimiter}"}  
    ] 
    return get_completion(messages_translate)




@app.route('/generate', methods=['POST'])
@cross_origin()
def index():

    language = request.form.get('language')
    translate_comment = request.form.get('translate_comment') == 'true'
    translate_email = request.form.get('translate_email') == 'true'

    comment = generate_customer_comment(products)
    subject = generate_email_subject(comment)
    summary = generate_summary(comment)
    sentiment = analyze_sentiment(comment)
    email = generate_email(comment, subject, summary, sentiment, 'English')

    if translate_comment:
        comment = get_translation(comment, language)
    
    if translate_email:
        email = get_translation(email, language)
    
    return jsonify({'comment': comment, 'email': email})

if __name__ == '__main__':
    app.run(debug=True)