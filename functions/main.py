# Welcome to Cloud Functions for Firebase for Python!
# To get started, simply uncomment the below code or create your own.
# Deploy with `firebase deploy`

from openai import OpenAI

from firebase_functions import https_fn
from firebase_admin import initialize_app
import os

initialize_app()

OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")

client = OpenAI(api_key=OPENAI_API_KEY)
@https_fn.on_request()
def my_chatbot(req: https_fn.Request) -> https_fn.Response:
    try:
        user_query = req.data.decode('utf-8')
        
        response = client.chat.completions.create(
        messages=[
            {
                "role": "user",
                "content": user_query 
            }
        ],
        model="gpt-3.5-turbo"
        )

        generated_text = response.choices[0].text

        return https_fn.Response(generated_text)

    except Exception as e:
        return https_fn.Response(str(e))