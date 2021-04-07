import 'dart:io';
import 'package:palace/palace.dart';
import 'package:public_e_commerce_api_dart/helpers/validation.dart';

import 'auth_service.dart';
import 'models/login_dto.dart';
import 'models/register_dto.dart';

class AuthController {
  static void login(Request req, Response res) async {
    validateDto(SignInDto);
    try {
      final dto = validationHandler<SignInDto>(req);
      var result = await AuthService.login(dto);
      return result.fold(
          (l) => res.json({'success': false, 'data': l.msg},
              statusCode: HttpStatus.badRequest), (r) {
        return res.json({'success': true, 'data': r},
            statusCode: HttpStatus.accepted);
      });
    } on BadRequest catch (err) {
      return res.json({'success': false, 'data': err.data.toString()},
          statusCode: HttpStatus.badRequest);
    } catch (err) {
      return res.json({'success': false, 'data': err.toString()},
          statusCode: HttpStatus.badRequest);
    }
  }

  static void register(Request req, Response res) async {
    try {
      final dto = validationHandler<RegisterDto>(req);
      final result = await AuthService.createUser(dto);
      await result.fold((l) {
        return res.json({'success': false, 'data': l.msg},
            statusCode: HttpStatus.badRequest);
      }, (r) {
        return res
            .json({'success': true, 'data': r}, statusCode: HttpStatus.created);
      });
    } on BadRequest catch (err) {
      return res.json({'success': false, 'data': err.data.toString()},
          statusCode: HttpStatus.badRequest);
    } catch (err) {
      return res.json({'success': false, 'data': err.toString()},
          statusCode: HttpStatus.badRequest);
    }
  }
}
