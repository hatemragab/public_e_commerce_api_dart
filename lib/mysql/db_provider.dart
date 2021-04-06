import 'package:mysql1/mysql1.dart';

import 'tables/user_table.dart';


class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static MySqlConnection? _connection;

  Future<MySqlConnection?> get connection async {
    if (_connection != null) return _connection;
    // if _database is null we instantiate it

    _connection = await _open();

    return _connection;
  }

  Future<MySqlConnection> _open() async {
    var settings = ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: null,
        db: 'public_ecommerce_api');
    final conn = await MySqlConnection.connect(settings);
    try {
      await UserTable.createTable(conn);
    } catch (err) {
      print('Error while create table is ${err.toString()}');
    }
    return conn;
  }
}
