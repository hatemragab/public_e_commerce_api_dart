import 'package:crypt/crypt.dart';
import 'package:dartz/dartz.dart';
import 'package:public_e_commerce_api_dart/api/user/models/user.dart';
import 'package:public_e_commerce_api_dart/api/user/user_service.dart';
import 'package:public_e_commerce_api_dart/helpers/db_fail_response.dart';
import 'package:public_e_commerce_api_dart/helpers/jwt.dart';
import 'package:public_e_commerce_api_dart/mysql/db_provider.dart';
import 'package:public_e_commerce_api_dart/mysql/tables/user_table.dart';

import 'models/login_dto.dart';
import 'models/register_dto.dart';

class AuthService {
  static Future<Either<DbFailResponse, Map<String, dynamic>>> login(
      SignInDto dto) async {
    final conn = await DBProvider.db.connection;

    try {
      final res = await conn!.query('''
       SELECT * FROM ${UserTable.TABLE_NAME}  
       WHERE ${UserTable.COLUMN_EMAIL} = ? 
       LIMIT 1
      ''', [dto.email]);

      final h = Crypt(res.first.fields[UserTable.COLUMN_PASSWORD].toString());
      if (!h.match(dto.password)) {
        return Left(DbFailResponse('No Users Found try again !'));
      }

      var userMap = User.fromMap(res.first.fields).toMap();

      var token = JwtHelper.create(userMap[UserTable.COLUMN_ID]);
      userMap['auth_token'] = token;
      return Right(userMap);
    } catch (err) {
      return Left(DbFailResponse(err.toString() == 'Bad state: No element'
          ? 'No Users Found try again !'
          : err.toString()));
    }
  }

  static Future<Either<DbFailResponse, Map<String, dynamic>>> createUser(
      RegisterDto dto) async {
    final conn = await DBProvider.db.connection;
    final hashPass = Crypt.sha256(dto.password);
    try {
      final result = await conn!.query('''
       INSERT INTO ${UserTable.TABLE_NAME} (${UserTable.COLUMN_NAME}, ${UserTable.COLUMN_EMAIL}, ${UserTable.COLUMN_PASSWORD} )
       VALUES (?,?,?)
      ''', [dto.name, dto.email, hashPass.toString()]);
      final userRes = await UserService.getById(result.insertId!);

      return userRes.fold((l) => Left(DbFailResponse(l.msg)), (r) {
        final token = JwtHelper.create(r[UserTable.COLUMN_ID]);
        r['auth_token'] = token;
        return Right(r);
      });
    } catch (err) {
      return Left(DbFailResponse(err.toString()));
    }
  }


}
