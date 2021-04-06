import 'dart:io';
import 'package:palace/palace.dart';

import 'auth_service.dart';
import 'models/login_dto.dart';
import 'models/register_dto.dart';

class AuthController {
  static void login(Request req, Response res) async {
    final dto = req.validate<SignInDto>();
    try {
      var result = await AuthService.login(dto);
      return result.fold(
          (l) => res.json({'success': false, 'data': l.msg},
              statusCode: HttpStatus.badRequest), (r) {
        return res.json({'success': true, 'data': r},
            statusCode: HttpStatus.accepted);
      });
    } catch (err) {
      return res.json({'success': false, 'data': err.toString()},
          statusCode: HttpStatus.badRequest);
    }
  }

  static void register(Request req, Response res) async {
    final dto = req.validate<RegisterDto>();
    try {
      final result = await AuthService.createUser(dto);
      await result.fold((l) {
        return res.json({'success': false, 'data': l.msg},
            statusCode: HttpStatus.badRequest);
      }, (r) {
        return res
            .json({'success': true, 'data': r}, statusCode: HttpStatus.created);
      });
    } catch (err) {
      return res.json({'success': false, 'data': err.toString()},
          statusCode: HttpStatus.badRequest);
    }
  }
}
