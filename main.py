# import built-in packages
import io
import os
import time
# import third-party packages
import requests
from PIL import Image
from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel
from dotenv import load_dotenv

load_dotenv()

API_URL: str = "https://api-inference.huggingface.co/models/black-forest-labs/FLUX.1-schnell"
headers: dict[str, str] = {
	"Authorization": f"Bearer {os.getenv('HUGGINGFACE_API_KEY')}"
}
PHOTO_PATH: str = os.path.join(os.getcwd(), "photos")
app = FastAPI()

class Item(BaseModel):
    input: str

@app.post("/api/photo")
def create_photo(item: Item):
    item_dict = item.model_dump()
    response = requests.post(API_URL, headers=headers, json={
          "inputs": item_dict["input"]
    })
    image = Image.open(io.BytesIO(response.content))
    timestamp = str(int(time.time()))
    image.save(os.path.join(PHOTO_PATH, "image_"+timestamp +".png"))
    # return
    return {"status": "success"}

if not os.path.exists(PHOTO_PATH):
    os.makedirs(PHOTO_PATH)
app.mount("/photos/", StaticFiles(directory="photos", html=True), name="photos")
