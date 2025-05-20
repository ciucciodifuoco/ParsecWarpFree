from mitmproxy import http
from mitmproxy.script import concurrent
import json 
@concurrent
def request(flow: http.HTTPFlow) -> None:
    return

@concurrent
def response(flow: http.HTTPFlow) -> None:
    
    
    if flow.request.pretty_url.endswith("/me"):
        
        data = json.loads(flow.response.content)
        if "data" in data and "warp" in data["data"]:
            data["data"]["warp"] = True

        # Update the response content with the modified JSON
        flow.response.text = json.dumps(data)