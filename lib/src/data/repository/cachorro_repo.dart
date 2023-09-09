import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/cachorros_model.dart';

class CachorroRepo {
  Future<CachorrosModel> getDoguinhos() async {
    var dio = Dio();

    var resposta = await dio.get("https://dog.ceo/api/breeds/image/random");

    if (resposta.statusCode == 200) {
      var cachorrosModel = CachorrosModel.fromJson(resposta.data);
      return cachorrosModel;
    } else if (resposta.statusCode == 404) {
      return CachorrosModel(status: "error", message: "Erro ao carregar");
    } else {
      return Future.error("Erro ao carregar");
    }
  }

  Future<void> favoritar(String foto) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("dogs_favoritos", foto);
  }

  Future<String> getFavoritos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("dogs_favoritos") ?? "";
  }
}
