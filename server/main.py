from flask import Flask, jsonify, request
import os


import transformers
import numpy as np
import torch
import soundfile as sf
from transformers import HubertForSequenceClassification, Wav2Vec2Processor

app = Flask(__name__)


model = HubertForSequenceClassification.from_pretrained("model.safetensors", local_files_only=True, config="config.json")


processor = Wav2Vec2Processor.from_pretrained('jonatasgrosman/wav2vec2-xls-r-1b-russian')


@app.route('/predict', methods=['POST'])
def predict(audio):
    
    inputs = processor(sf.read(audio)[0], return_tensors="pt", padding=False)
    with torch.no_grad():
        logits = model(**inputs.to("cpu")).logits
    predicted_ids = torch.argmax(logits, dim=-1)
    
    return jsonify({'prediction': predicted_ids.tolist()})



UPLOAD_FOLDER = 'uploads/'
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

@app.route('/upload', methods=['POST'])
def upload_audio():
    if 'audio' not in request.files:
        return 'No file part', 400

    file = request.files['audio']

    if file.filename == '':
        return 'No selected file', 400

    # Сохранение файла
    file_path = os.path.join(UPLOAD_FOLDER, file.filename)
    file.save(file_path)
    print("<server> uploaded")

    prediction = predict(file_path)
    print("<server> predicted")
    file_path = os.remove(file_path)
    # Здесь можно добавить обработку аудиофайла
    return prediction, 200

if __name__ == '__main__':
    app.run(debug=True)