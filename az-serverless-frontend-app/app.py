from flask import Flask, render_template, request, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/api/process', methods=['POST'])
def process_text():
    # For now, we just echo the incoming JSON back to the client
    text_data = request.get_json()
    return jsonify(text_data), 200

if __name__ == '__main__':
    app.run()
