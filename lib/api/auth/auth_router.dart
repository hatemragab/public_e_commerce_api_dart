import 'package:palace/palace.dart';
import 'package:public_e_commerce_api_dart/config/constants.dart';

import 'auth_controller.dart';


class AuthRouter {
  static const String ROUTER_NAME = 'auth';

  AuthRouter(final Palace palace) {
    palace.post(
        Constants.API_VERSION + ROUTER_NAME + '/login', AuthController.login);
    palace.post(Constants.API_VERSION + ROUTER_NAME + '/register',
        AuthController.register);

  }
}
