import json, pyautogui
from PIL import Image
from http.server import HTTPServer, BaseHTTPRequestHandler

HOST = "0.0.0.0"
PORT = 8124

class HTTP(BaseHTTPRequestHandler):
    def do_GET(self):
        pyautogui.screenshot('ss.png')
        img = Image.open('ss.png')
        w,h = img.size
        new = img.resize((w//20,h//20))
        vals = list(new.getdata())
        
        img_data = {
            "data" : vals,
            "size" : new.size,
        }
        
        self.send_response(200)
        self.send_header("Content-type", "application/json")
        self.end_headers()
        self.wfile.write(bytes(json.dumps(img_data), encoding='utf8'))
        
server = HTTPServer((HOST, PORT), HTTP)
server.serve_forever()
server.server_close()
print("Server stopped")
