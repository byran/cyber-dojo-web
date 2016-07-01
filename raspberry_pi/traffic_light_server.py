from flask import Flask
from gpiozero import LED, Buzzer
from time import sleep

# need to "apt-get install python3-flask" before running this script for the first time

red_led = LED(25)
amber_led = LED(8)
green_led = LED(7)
buzzer = Buzzer(4)

buzzer.off()
red_led.off()
amber_led.off()
green_led.off()

app = Flask(__name__)

@app.route('/')
def index():
    print("Access index")
    return 'LEDs set'

@app.route('/red')
def red():
    amber_led.off()
    green_led.off()
    red_led.on()
    print("red")
    return 'OK'

@app.route('/amber')
def amber():
    red_led.off()
    green_led.off()
    amber_led.on()
    print("amber")
    return 'OK'

@app.route('/green')
def green():
    red_led.off()
    amber_led.off()
    green_led.on()
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
