GREEN='\033[1;32m'
NONE='\033[0m'

echo -e "${GREEN}\n\n⠀⠀⠀⠀⠀⠀
      ⠀⢀⣠⣤⣤⣶⣶⣶⣶⣤⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⡀⠀⠀⠀⠀
⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀
⠀⢀⣾⣿⡿⠿⠛⠛⠛⠉⠉⠉⠉⠛⠛⠛⠿⠿⣿⣿⣿⣿⣿⣷⡀⠀
⠀⣾⣿⣿⣇⠀⣀⣀⣠⣤⣤⣤⣤⣤⣀⣀⠀⠀⠀⠈⠙⠻⣿⣿⣷⠀
⢠⣿⣿⣿⣿⡿⠿⠟⠛⠛⠛⠛⠛⠛⠻⠿⢿⣿⣶⣤⣀⣠⣿⣿⣿⡄
⢸⣿⣿⣿⣿⣇⣀⣀⣤⣤⣤⣤⣤⣄⣀⣀⠀⠀⠉⠛⢿⣿⣿⣿⣿⡇
⠘⣿⣿⣿⣿⣿⠿⠿⠛⠛⠛⠛⠛⠛⠿⠿⣿⣶⣦⣤⣾⣿⣿⣿⣿⠃
⠀⢿⣿⣿⣿⣿⣤⣤⣤⣤⣶⣶⣦⣤⣤⣄⡀⠈⠙⣿⣿⣿⣿⣿⡿⠀
⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣾⣿⣿⣿⣿⡿⠁⠀
⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠀⠀⠀
⠀⠀⠀⠀⠈⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠁⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠈⠙⠛⠛⠿⠿⠿⠿⠛⠛⠋⠁\n\n${NONE}"

echo -e -n "${GREEN}For the installation, you will need to set up your Spotify developer account here: ${NONE}"
echo -e "https://developer.spotify.com"
echo -e -n "${GREEN}Have you finished setting up your account and your application? [y/n] ${NONE}"
read
if [[ "$tmp" =~ ^(y|Y)$ ]]; then
	echo "SUCCESS"  
fi

echo
echo -e "${GREEN}Installing...${NONE}"
sudo apt install python3-pip
pip install spotipy --upgrade
pip install pillow --upgrade
sudo apt-get install libopenjp2-7 python3-dbus

echo
echo -e "${GREEN}Spotify Client ID:${NONE}"
read  clientID
export SPOTIPY_CLIENT_ID=$clientID

echo -e "${GREEN}Spotify Client Secret:${NONE}"
read clientSecret
export SPOTIPY_CLIENT_SECRET=$clientSecret

echo -e "${GREEN}Spotify Redirect URI:${NONE}"
read redirectURI
export SPOTIPY_REDIRECT_URI=$redirectURI

export SPOTIFY_TOKEN_PATH="$(pwd)/.cache"

read username
export SPOTIFY_USERNAME=$username
sudo python3 serviceController.py

echo -e "${GREEN}You will be redirected to a page in your browser. Copy the URL and enter it into the terminal.${NONE}"
sleep 2

filename='.cache'
if [ -f $filename ]; then
	rm .cache
fi
python3 generateToken.py

echo
echo -e "${GREEN}Your Spotipy Token Has Been Created Under The Current Directory.${NONE}"
echo -e "$(pwd)/.cache"
export 

echo
echo -e "${GREEN}Installing the RGB Matrix Software.${NONE}"
curl https://raw.githubusercontent.com/adafruit/Raspberry-Pi-Installer-Scripts/master/rgb-matrix.sh > tmp.sh
sed -n '/REBOOT NOW?/q;p' < tmp.sh > rgb-matrix.sh #stop the script from rebooting right away (https://alexharv074.github.io/2019/04/16/a-sed-tutorial-and-reference.html#flags)
rm tmp.sh
sudo bash rgb-matrix.sh
echo -e "${GREEN}Installed the RGB Matrix Software.${NONE}"

echo
echo -e "${GREEN}Configure the RGB Matrix Software.${NONE}"
sudo bash configureMatrix.sh
echo -e "${GREEN}Configured the RGB Matrix Software.${NONE}"

python3 serviceController.py
