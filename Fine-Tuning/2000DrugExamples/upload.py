from openai import OpenAI

from main import init_api

init_api()
client = OpenAI()

client.files.create(
  file=open("output.jsonl", "rb"),
  purpose="fine-tune"
)