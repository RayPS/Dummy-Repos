import os
import random
import re
from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer

data = {
    "nouns": [],
    "adjectives": []
}

for k in data.keys():
    directory = os.path.join(os.getcwd(), "wordlist", k)
    for txt in os.listdir(directory):
        path = os.path.join(directory, txt)
        words = open(path, "r").readlines()
        data[k].extend(words)


def gen():
    n = random.choice(data["nouns"])
    a = random.choice(data["adjectives"])
    msg = "Make %s %s again" % (n, a)
    return re.sub(r"[\n]*", "", msg)


# Web:
class S(BaseHTTPRequestHandler):
    def _set_headers(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()

    def do_GET(self):
        self._set_headers()
        document = """
        <body sytle="height=100%;">
        <script> document.addEventListener('keypress', (event) => { if (event.keyCode == 32) { location.reload(); } }); </script>
        <div style="display:flex;justify-content:center;align-items:center;font-size:72px;font-weight:bold;height:100%;">
        """ + gen()
        self.wfile.write(document)

    def do_HEAD(self):
        self._set_headers()

port = 8080
print 'Servering at http://localhost:'+str(port)
print 'Press Space Bar to Refresh'
HTTPServer(('', port), S).serve_forever()
