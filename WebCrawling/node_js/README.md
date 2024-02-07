# NodeJS

## Setup



1. Install the requirements

   ```
   npm install
   ```

2. Setup environment from python version. NodeJs will be calling api from python script.
[Python Version](https://github.com/gangzhaorige/ML-OPENAi-CustomerSupport/tree/main/flask)


3. Crawl data
   ```
   python3 crawl.py
   ```

4. Apply Embedding
   ```
   python3 embed.py
   ``` 

5. Run the app

   ```
   npm run dev
   ```

You should now be able to access the app at [http://localhost:3000](http://localhost:3000)!
