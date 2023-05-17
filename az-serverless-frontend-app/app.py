import os
from flask import (Flask, redirect, render_template, request, send_from_directory, url_for, session)

app = Flask(__name__)
app.secret_key = 'your secret key'

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/favicon.ico')
def favicon():
    return send_from_directory(os.path.join(app.root_path, 'static'),
                               'favicon.ico', mimetype='image/vnd.microsoft.icon')

@app.route('/login', methods=['POST'])
def login():
    username = request.form.get('username')
    password = request.form.get('password')

    # Here we hardcode the username and password. In a real application, you would validate against a database
    if username == 'devops' and password == 'tarun':
        session['username'] = username
        return redirect(url_for('home'))
    else:
        return redirect(url_for('index'))

@app.route('/prompt', methods=['POST'])
def prompt():
    backend_url = 'csapi-app-2.azurewebsites.net'
    prompt = request.form.get('prompt')
    response = requests.post(f'{backend_url}/generate', json={'prompt': prompt})
    return jsonify(response.json())

@app.route('/home')
def home():
    if 'username' in session:
        return render_template('hello.html', username=session['username'])
    else:
        return redirect(url_for('index'))

@app.route('/upload', methods=['POST'])
def upload():
    if 'username' not in session:
        return redirect(url_for('index'))

    file = request.files.get('file')

    if file:
        filename = file.filename

        # Here we just save the file to the filesystem. You can process the file as needed
        file.save(os.path.join('uploads', filename))

        return 'File uploaded successfully'
    else:
        return redirect(url_for('home'))

if __name__ == '__main__':
   app.run()
