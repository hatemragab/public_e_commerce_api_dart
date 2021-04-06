import 'dart:convert';
import 'dart:io';
import 'package:palace/palace.dart';
import 'package:public_e_commerce_api_dart/config/constants.dart';
import 'package:public_e_commerce_api_dart/helpers/jwt.dart';

import 'user_controller.dart';
import 'user_service.dart';


class UserRouter {
  static const String ROUTER_NAME = 'user';

  UserRouter(final Palace palace) {
  //  palace.use(AuthGuard());
    palace.get(
      Constants.API_VERSION + ROUTER_NAME +"/all/:id",
      UserController.getUsers,
    );
  }
}

class AuthGuard {
  void call(Request req, Response res, next) async {
    var token = req.headers.value('Authorization');
    //return await res.json({'body',req.body.runtimeType});
    if (token == null) {
      return await res.json(
          jsonEncode(
              {'success': 'false', 'data': 'Auth Token Must Provided !'}),
          statusCode: HttpStatus.badRequest);
    } else {
      var userId = JwtHelper.verify(token);

      final result = await UserService.getById(userId);
      return result.fold((l) async {
        return await res.json(
            jsonEncode({
              'success': 'false',
              'data': 'No User Found In Database You have to register !'
            }),
            statusCode: HttpStatus.badRequest);
      }, (r) async {
          print(req.body.runtimeType);
           req.body['userData'] =r;

        return await next();
      });
    }
  }
}
