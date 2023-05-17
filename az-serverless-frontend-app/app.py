from flask import Flask, render_template
import logging

app = Flask(__name__)

app.route('/')
def home():
    app.logger.info('Processing home page.')
    try:
        return render_template('index.html')
    except Exception as e:
        app.logger.error(f"Error occurred: {e}")
        return str(e), 500

if __name__ == '__main__':
    app.run()
