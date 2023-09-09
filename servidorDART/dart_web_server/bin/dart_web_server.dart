import 'package:shelf/shelf.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:shelf/shelf_io.dart' as io;

void main(List<String> arguments) {
  final pipeline = Pipeline().addMiddleware(logRequests()).addHandler(
      createStaticHandler(
          'C:/Users/higor/OneDrive/Documentos/projetinhosFlutter/auau_gerador/build/web',
          defaultDocument: 'index.html'));

  io.serve(pipeline, 'localhost', 8080).then((server) {
    print('Serving at http://${server.address.host}:${server.port}');
  });
}
