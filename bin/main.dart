import 'package:alfred/alfred.dart';
import 'package:palace/palace.dart';
import 'package:public_e_commerce_api_dart/mysql/db_provider.dart';
import 'package:public_e_commerce_api_dart/router/index.dart';

void main(List<String> arguments) async {
  // await DBProvider.db.connection;
  //
  // final palace = Palace();
  // palace.use(BodyParser());
  // Router(palace);
  // await palace.openGates();

  final app = Alfred();

  app.get("/example", (req, res) => "Hello world");
  app.get("/", (req, res) => "Hello world");

  await app.listen();

  print("Listening on port 3000");
}

