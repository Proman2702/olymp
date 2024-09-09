from flask import Flask, jsonify, request
import os
import catboost 
import numpy as np

app = Flask(__name__)


'''model = catboost.CatBoostClassifier()
model.load_model('catboost_model.cbm')

@app.route('/predict', methods=['POST'])
def predict():
    sr=16000
    y, sr = catboost.librosa.load(file_path, sr=sr)
    
    mfccs = catboost.librosa.feature.mfcc(y=y, sr=sr)
    mfccs_mean = np.mean(mfccs.T, axis=0)

    onset_env = catboost.librosa.onset.onset_strength(y=y, sr=sr)
    tempo, _ = catboost.librosa.beat.beat_track(onset_envelope=onset_env, sr=sr)

    rms = catboost.librosa.feature.rms(y=y)
    rms_mean = np.mean(rms.T, axis=0)

    feature=np.hstack([mfccs_mean, 
                       tempo,
                       rms_mean
                       ])
    
    prediction = model.predict(feature)
    return jsonify({'prediction': prediction.tolist()})
'''


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


    # Здесь можно добавить обработку аудиофайла
    return 'File uploaded successfully', 200

if __name__ == '__main__':
    app.run(debug=True)