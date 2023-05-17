from flask import Flask, request
app = Flask(__name__)


@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/process', methods=['POST'])
def process_text():
    data = request.json
    text = data.get('text', '')
    # TODO: Process the text here
    processed_text = text.upper()  # For example, convert to uppercase
    return {'result': processed_text}

if __name__ == '__main__':
    app.run()
