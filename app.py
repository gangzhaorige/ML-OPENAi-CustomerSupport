from flask import Flask, redirect, render_template, request, url_for

app = Flask(__name__)

@app.route("/", methods=("GET"))
def index():
    result = request.args.get("result")
    return render_template("index.html", result=result)