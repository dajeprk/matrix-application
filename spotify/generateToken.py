import spotipy
import spotipy.util as util
from spotipy.oauth2 import SpotifyOAuth

scope = 'user-read-currently-playing'
auth = SpotifyOAuth(scope=scope, open_browser=False)
token = auth.get_access_token(as_dict=False)
