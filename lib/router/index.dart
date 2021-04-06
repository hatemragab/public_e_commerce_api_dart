import 'package:palace/palace.dart';
import 'package:public_e_commerce_api_dart/api/auth/auth_router.dart';
import 'package:public_e_commerce_api_dart/api/user/user_router.dart';


const API_PATH = '/api/v1';
class Router{
  Router(final Palace palace) {
    AuthRouter(palace);
    UserRouter(palace);
  }
}