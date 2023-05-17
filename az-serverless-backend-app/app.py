import os
from flask import (Flask, render_template, request, jsonify, send_from_directory, url_for, session)
import openai


app = Flask(__name__)
app.secret_key = 'your secret key'

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/favicon.ico')
def favicon():
    return send_from_directory(os.path.join(app.root_path, 'static'),
                               'favicon.ico', mimetype='image/vnd.microsoft.icon')

@app.route('/generate', methods=['POST'])
def generate():
    prompt = request.json.get('prompt')
    response = openai.Completion.create(
        engine="text-davinci-002",
        prompt=prompt,
        max_tokens=60
    )
    return jsonify({'response': response.choices[0].text.strip()})


if __name__ == '__main__':
   app.run()
