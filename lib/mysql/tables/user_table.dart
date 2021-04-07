import 'package:mysql1/mysql1.dart';

class UserTable {
  static const TABLE_NAME = 'tb_user';

  static const COLUMN_ID = '${TABLE_NAME}_id';
  static const COLUMN_NAME = '${TABLE_NAME}_name';
  static const COLUMN_EMAIL = '${TABLE_NAME}_email';
  static const COLUMN_PASSWORD = '${TABLE_NAME}_password';
  static const COLUMN_IMAGE = '${TABLE_NAME}_image';
  static const COLUMN_IMAGE_THUMB = '${TABLE_NAME}_image_thumb';

  static Future<void> recreateTable(MySqlConnection connection) async {
    await connection.query('''
          DROP TABLE IF EXISTS $TABLE_NAME
        ''');
    await UserTable.createTable(connection);
  }

  static Future<void> createTable(MySqlConnection connection) async {
    await connection.query('''
          CREATE TABLE IF NOT EXISTS $TABLE_NAME (
            $COLUMN_ID       BIGINT(25) AUTO_INCREMENT PRIMARY KEY ,
            $COLUMN_NAME     VARCHAR(25) NOT NULL,
            $COLUMN_EMAIL    VARCHAR(50) UNIQUE NOT NULL,
            $COLUMN_IMAGE_THUMB    VARCHAR(50) DEFAULT 'default_user_image.png',
            $COLUMN_IMAGE    VARCHAR(50) DEFAULT 'default_user_image.png',
            $COLUMN_PASSWORD    TEXT
           )      
             
          ''');
  }
}
