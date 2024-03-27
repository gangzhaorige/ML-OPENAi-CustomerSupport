import json
import pandas as pd

# Read the Excel file into a DataFrame
df = pd.read_excel(
    'Medicine_description.xlsx',
    sheet_name='Sheet1',
    header=0,
    nrows=2000
)

# Get unique reasons
reasons = df["Reason"].unique()
# Create a dictionary to map reasons to indices
reasons_dict = {reason: i for i, reason in enumerate(reasons)}
df["Reason"] = df["Reason"].apply(lambda x: "" + str(reasons_dict[x]))
# Add system message
system_message = {"role": "system", "content": "You are profesional drug classifier."}
# Initialize the list to store messages
messages = []
# Iterate over rows in the DataFrame
for _, row in df.iterrows():
    # Add user message
    user_message = {"role": "user", "content": 'Drug: ' + row["Drug_Name"] + '.'}
    
    # Add assistant message
    assistant_message = {"role": "assistant", "content": row["Reason"]}
    
    # Construct a message group and add it to the list of messages
    message_group = [system_message, user_message, assistant_message]
    messages.append({"messages": message_group})

with open("output.jsonl", "w") as f:
    for msg in messages:
        json.dump(msg, f)
        f.write("\n")


import os
import openai

from test import init_api



init_api()



# Configure the model ID. Change this to your model ID.
model = "ft:gpt-3.5-turbo-0125:learninggpt:mine:97CCXUlH"

# Let's use a drug from each class
drugs = [
    "A CN Gel(Topical) 20gmA CN Soap 75gm",  # Class 0
    "Addnok Tablet 20'S",                    # Class 1
    "ABICET M Tablet 10's",                  # Class 2
]

def get_completion(
        messages,
        model="gpt-4-0125-preview",
        temperature=0,
        max_tokens=1000
    ): 
    response = openai.chat.completions.create(
        model=model,
        messages=messages,
        temperature=temperature, 
        max_tokens=max_tokens
    )
    return response.choices[0].message.content

# Returns a drug class for each drug
for drug_name in drugs:
    prompt = "Drug: {}\nMalady:".format(drug_name)

    messages = [
        {'role' : 'system', 'content' : f'You are profesional drug classifier.'},
        {'role' : 'user', 'content' : prompt},
    ]
    drug_class = get_completion(
        messages=messages,
        model=model,
        temperature=0,
        # max_tokens=,
    )
    print(drug_class)