import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:public_e_commerce_api_dart/config/constants.dart';


class JwtHelper {
  static String create(int id) {
    final jwt = JWT(
      {'id': id, 'time': DateTime.now().millisecondsSinceEpoch.toString()},

    );
    return jwt.sign(
      SecretKey(Constants.JWT_SECRET),
      expiresIn: Duration(days: 365),
    );
  }

  static int verify(String? token) {
    try {
      // Verify a token
      final jwt = JWT.verify(
        token!,
        SecretKey(Constants.JWT_SECRET),

      );
      return jwt.payload['id'];
    } on JWTExpiredError {
      throw ('jwt expired');

    } on JWTError catch (ex) {
      throw (ex.message);

    }
  }
}
