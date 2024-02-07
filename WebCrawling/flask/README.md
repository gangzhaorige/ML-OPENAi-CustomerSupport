# Flask

## Process

- Install required packages. 

- Crawl Data

- Apply Embedding

- Display

## Install required packages.
Set up environment and install required packages in requirements.txt

- Create python virtual environment
```
pip3 install virtualenv
python -m venv tutorial-env

```
- Activate virtual environment
```
source tutorial-env/bin/activate
```
- Install required packages
```
pip3 install -r requirements.txt
```

- Create .env file.
Replace your_api_key with OpenAi key
```
FLASK_APP=app
FLASK_ENV=development
OPENAI_API_KEY=your_api_key
```

## Crawl data
```
python3 crawl.py
```

## Apply Embedding
```
python3 embed.py
``` 

## Run Project
```
flask run
```
You should now be able to access the app at [http://localhost:5000](http://localhost:3000)!

