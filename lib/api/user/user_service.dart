import 'package:dartz/dartz.dart';
import 'package:public_e_commerce_api_dart/helpers/db_fail_response.dart';
import 'package:public_e_commerce_api_dart/mysql/db_provider.dart';
import 'package:public_e_commerce_api_dart/mysql/tables/user_table.dart';

import 'models/user.dart';


class UserService {
  static Future<Either<DbFailResponse, List<Map<String, dynamic>>>>
      getUsers({required int lastId}) async {
    final conn = await DBProvider.db.connection;
    try {
      final results = await conn!.query('''
       SELECT * FROM ${UserTable.TABLE_NAME} 
       WHERE ${UserTable.COLUMN_ID} > ? 
       ORDER BY ${UserTable.COLUMN_ID}  
       LIMIT 20
       ''',[lastId]);
      var usersMapList = <Map<String, dynamic>>[];

      for (final rows in results) {
        usersMapList.add(User.fromMap(rows.fields).toMap());
      }

      return Right(usersMapList);
    } catch (err) {
      return Left(DbFailResponse(err.toString()));
    }
  }
  static Future<Either<DbFailResponse, Map<String, dynamic>>> getById(
      int id) async {
    final conn = await DBProvider.db.connection;
    try {
      final res = await conn!.query('''
       SELECT * FROM ${UserTable.TABLE_NAME}  
       WHERE ${UserTable.COLUMN_ID} = ? 
       LIMIT 1
      ''', [id]);
      return Right(User.fromMap(res.first.fields).toMap());
    } catch (err) {
      return Left(DbFailResponse(err.toString()));
    }
  }
}
