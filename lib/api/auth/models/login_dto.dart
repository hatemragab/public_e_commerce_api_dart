import 'package:palace_validators/palace_validators.dart';

class SignInDto {
  @IsRequired()
  late String email;
  @IsRequired()
  late String password;


  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'email': email,
      'password': password,
    } as Map<String, dynamic>;
  }

  @override
  String toString() {
    return 'SignInDto{email: $email, password: $password}';
  }

}
