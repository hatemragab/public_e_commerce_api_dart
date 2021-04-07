import 'package:palace/palace.dart';
import 'package:public_e_commerce_api_dart/mysql/db_provider.dart';
import 'package:public_e_commerce_api_dart/router/index.dart';

void main(List<String> arguments) async {
  await DBProvider.db.connection;

  final palace = Palace();
  Router(palace);
  await palace.openGates();
}
