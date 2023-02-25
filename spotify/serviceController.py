import time
import requests
from PIL import Image
from rgbmatrix import RGBMatrix, RGBMatrixOptions
import os, sys
import configparser
from getSongInfo import getSongInfo
from io import BytesIO

dir = os.path.dirname(__file__)
print(dir)
filename = os.path.join(dir, "../config/matrixOptions.ini")
print(filename)

config = configparser.ConfigParser()
config.read(filename)

options = RGBMatrixOptions()
options.rows = int(config["DEFAULT"]["rows"])
options.cols = int(config["DEFAULT"]["cols"])
options.chain_length = int(config["DEFAULT"]["chain_length"])
options.parallel = int(config["DEFAULT"]["parallel"]) 
options.hardware_mapping = config["DEFAULT"]["hardware_mapping"]
options.gpio_slowdown = int(config["DEFAULT"]["gpio_slowdown"])
options.brightness = int(config["DEFAULT"]["brightness"])
options.limit_refresh_rate_hz = int(config["DEFAULT"]["refresh_rate"])

matrix = RGBMatrix(options = options)

prevSong = ""
currentSong = ""

try:
	while True:
		try:
			imageURL = getSongInfo(SPOTIFY_USERNAME, SPOTIFY_TOKEN_PATH)[1]
			currentSong = imageUrl

			if(prevSong != currentSong):
				response = requests.get(imageURL)
				image = Image.open(BytesIO(response.content))
				image.thumbnail((matrix.width, matrix.height), Image.ANTIALIAS)
				matrix.SetImage(image.convert("RGB"))
				prevSong = currentSong

			time.sleep(1)
		except Exception as e:
			print(e)
			time.sleep(1)
except KeyboardInterrupt:
	sys.exit(0)
