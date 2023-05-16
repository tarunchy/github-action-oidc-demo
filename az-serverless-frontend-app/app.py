from flask import Flask, render_template, request, jsonify
import requests

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/api/process', methods=['POST'])
def process_text():
    backend_url = 'http://cs-hack-back-dev.azurewebsites.net/api/process'  # Use your backend DNS name
    text_data = request.get_json()
    response = requests.post(backend_url, json=text_data)

    if response.ok:
        return jsonify(response.json()), 200
    else:
        return jsonify({"error": "Backend processing failed"}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
