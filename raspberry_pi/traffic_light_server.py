from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    print("Access index")
    return 'LEDs set'

@app.route('/red')
def red():
    print("red")
    return 'OK'

@app.route('/amber')
def amber():
    print("amber")
    return 'OK'

@app.route('/green')
def green():
    print("green")
    return 'OK'

@app.after_request
def after_request(response):
    response.headers.add('Access-Control-Allow-Origin', '*')
    response.headers.add('Access-Control-Allow-Headers', 'Content-Type,Authorization')
    response.headers.add('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE')
    return response

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0', port=8080)
