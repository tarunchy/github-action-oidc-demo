import os

from flask import (Flask, redirect, render_template, request,
                   send_from_directory, url_for)

app = Flask(__name__)


# Load the usernames and passwords from a JSON file
with open('users.json', 'r') as f:
    users = json.load(f)

@app.route('/')
def home():
    if 'username' in session:
        return render_template('home.html')
    else:
        return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    if 'username' in session:
        return redirect(url_for('home'))

    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        
        if username in users and users[username] == password:
            session['username'] = username
            return redirect(url_for('home'))
        else:
            return 'Invalid username or password'
    else:
        return render_template('login.html')

@app.route('/logout')
def logout():
    session.pop('username', None)
    return redirect(url_for('login'))

@app.route('/process_files', methods=['POST'])
def process_files():
    if not ('image_file' in request.files and 'text_input' in request.form and 'pdf_file' in request.files):
        return jsonify({'error': 'Missing files or text'}), 400

    # Get the uploaded files and text
    image_file = request.files['image_file']
    text_input = request.form['text_input']
    pdf_file = request.files['pdf_file']

    # TODO: Add the code to process the image file and get the image summary
    # For now, let's just use a dummy summary
    image_summary = "This is a dummy image summary."

    # TODO: Add the code to process the text input and get the text summary
    # For now, let's just use a dummy summary
    text_summary = "This is a dummy text summary."

    # TODO: Add the code to process the pdf file and get the pdf summary
    # For now, let's just use a dummy summary
    pdf_summary = "This is a dummy pdf summary."

    # Combine all summaries
    summary = f"Image Summary: {image_summary} | Clinical Note Summary: {text_summary} | Other Doc Summary: {pdf_summary}"

    # Return the combined summary as the result
    return jsonify({'summary': summary}), 200


if __name__ == '__main__':
   app.run()
