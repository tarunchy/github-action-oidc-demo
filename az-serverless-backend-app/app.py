import os
from flask import (Flask, redirect, render_template, request, send_from_directory, url_for, session)
from flask import jsonify


app = Flask(__name__)
app.secret_key = 'your secret key'

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/favicon.ico')
def favicon():
    return send_from_directory(os.path.join(app.root_path, 'static'),
                               'favicon.ico', mimetype='image/vnd.microsoft.icon')


@app.route('/prompt', methods=['POST'])
def prompt():
    try:
        return jsonify({'response': 'I am from Backend'})
    except Exception as e:
        print(e)
        return str(e), 500


if __name__ == '__main__':
   app.run()
