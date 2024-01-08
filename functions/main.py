# Welcome to Cloud Functions for Firebase for Python!
# To get started, simply uncomment the below code or create your own.
# Deploy with `firebase deploy`

from firebase_functions import https_fn
from firebase_admin import initialize_app

@https_fn.on_request()
def my_chatbot(req: https_fn.Request) -> https_fn.Response:
    try:
        user_query = req.data.decode('utf-8')
        
        res = "response : "  + user_query
        
        return https_fn.Response(res)

    except Exception as e:
        return https_fn.REsponse(str(e))