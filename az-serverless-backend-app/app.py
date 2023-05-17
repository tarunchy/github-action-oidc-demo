import os
from flask import (Flask, render_template, request, jsonify, send_from_directory, url_for, session)



app = Flask(__name__)
app.secret_key = 'your secret key'

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/generate', methods=['POST'])
def generate():
  
    return jsonify({'response': 'Working Buddy'})


if __name__ == '__main__':
   app.run()
