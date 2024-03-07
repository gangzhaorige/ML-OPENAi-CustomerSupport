import os
from flask_cors import CORS, cross_origin

import openai
from flask import Flask, jsonify, request
from langchain_community.vectorstores import Chroma
from langchain_openai import OpenAIEmbeddings
from langchain_openai import ChatOpenAI
from langchain.chains import ConversationalRetrievalChain
from langchain.memory import ConversationBufferMemory

app = Flask(__name__)
openai.api_key = os.getenv("OPENAI_API_KEY")
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'

persist_directory = 'docs/chroma/'

delimiter = '```'

embedding = OpenAIEmbeddings()

vectordb = Chroma(
    persist_directory=persist_directory,
    embedding_function=embedding
)

llm = ChatOpenAI(model_name='gpt-3.5-turbo', temperature=0)

memory = ConversationBufferMemory(
    memory_key="chat_history",
    # Set return messages equal true
    # - Return the chat history as a  list of messages 
    #   as opposed to a single string. 
    # - This is  the simplest type of memory. 
    #   + For a more in-depth look at memory, go back to  
    #     the first class that I taught with Andrew.  
    return_messages=True
)

retriever = vectordb.as_retriever()
qa = ConversationalRetrievalChain.from_llm(
    llm,
    retriever=retriever,
    memory=memory
)

@app.route('/generate', methods=['POST'])
@cross_origin()
def index():
    question = request.form.get('question')
    print(question)
    result = qa.invoke({"question": question})
    return {'response' : result['answer']}
    

if __name__ == '__main__':
    app.run(debug=True)