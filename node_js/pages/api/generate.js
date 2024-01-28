import { Configuration, OpenAIApi } from "openai";

const configuration = new Configuration({
  apiKey: process.env.OPENAI_API_KEY,
});
const openai = new OpenAIApi(configuration);

export default async function (req, res) {
  if (!configuration.apiKey) {
    res.status(500).json({
      error: {
        message: "OpenAI API key not configured, please follow instructions in README.md",
      }
    });
    return;
  }

  const question = req.body.question || '';
  if (question.trim().length === 0) {
    res.status(400).json({
      error: {
        message: "Please enter your question",
      }
    });
    return;
  }
  try {
    var spawn = require("child_process").spawn;
    var process = spawn('python',["answer.py", question]);

    return new Promise((resolve) => {
      process.stdout.on('data', (data) => {
        res.status(200).json({ result: data.toString('utf8') });
      });
      process.stderr.on("data", (x) => {
        process.stderr.write(x.toString());
      });
      process.on("exit", (code) => {
        resolve(code);
      });
    });
  } catch(error) {
    // Consider adjusting the error handling logic for your use case
    if (error.response) {
      console.error(error.response.status, error.response.data);
      res.status(error.response.status).json(error.response.data);
    } else {
      console.error(`Error with OpenAI API request: ${error.message}`);
      res.status(500).json({
        error: {
          message: 'An error occurred during your request.',
        }
      });
    }
  }
}
