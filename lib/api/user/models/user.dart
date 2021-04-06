import 'package:public_e_commerce_api_dart/mysql/tables/user_table.dart';


class User {
  late int id;
  late String name;
  late String email;
  late String? image;
  late String? imageThumb;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.imageThumb,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? image,
    String? imageThumb,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      imageThumb: imageThumb ?? this.imageThumb,
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, image: $image, imageThumb: $imageThumb}';
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map[UserTable.COLUMN_ID],
      name: map[UserTable.COLUMN_NAME],
      email: map[UserTable.COLUMN_EMAIL],
      image: map[UserTable.COLUMN_IMAGE],
      imageThumb: map[UserTable.COLUMN_IMAGE_THUMB],
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      UserTable.COLUMN_ID: id,
      UserTable.COLUMN_NAME: name,
      UserTable.COLUMN_EMAIL: email,
      UserTable.COLUMN_IMAGE: image,
      UserTable.COLUMN_IMAGE_THUMB: imageThumb,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
