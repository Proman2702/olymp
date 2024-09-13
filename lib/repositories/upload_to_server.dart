import 'dart:developer';
import 'package:dio/dio.dart';

class UploadAudio {
  Future<int> uploadAudio(String filename, String url) async {
    final BaseOptions options = BaseOptions(
        baseUrl: url,
        validateStatus: (status) => true,
        connectTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 90),
        // responseType: ResponseType.plain,
      );
    final dio = Dio(options);
    final formData =
        FormData.fromMap({"audio": await MultipartFile.fromFile(filename)});

    var response = await dio.post(url, data: formData);

    if (response.statusCode == 200) {
      log('Аудиофайл успешно загружен');
      return response.data["prediction"];
    } else {
      log('Ошибка при загрузке: ${response.statusCode}');
      return 400;
    }
  }
}
