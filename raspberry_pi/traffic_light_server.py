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

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0', port=8080)
