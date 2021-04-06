import 'package:palace_validators/palace_validators.dart';

class RegisterDto {
  @MinLength(4)
  late String name;
  @IsEmail()
  late String email;
  @MinLength(6)
  late String password;

}