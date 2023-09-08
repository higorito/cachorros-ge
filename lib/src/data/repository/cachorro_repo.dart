import 'package:dio/dio.dart';

import '../model/cachorros_model.dart';

class CachorroRepo {
  Future<CachorrosModel> getDoguinhos() async {
    var dio = Dio();

    var resposta = await dio.get("https://dog.ceo/api/breeds/image/random");

    var cachorrosModel = CachorrosModel.fromJson(resposta.data);
    return cachorrosModel;
  }
}
