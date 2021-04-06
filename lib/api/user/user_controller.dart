import 'dart:io';
import 'package:palace/palace.dart';

import 'user_service.dart';

class UserController {
  static void getUsers(Request req, Response res) async {
    // print("------------------- "+req.params['id'].toString());
    int lastId = int.parse(req.params['id']);
    try {
      final result = await UserService.getUsers(lastId:lastId);
      await result.fold((l) {
        return res.json({'success': false, 'data': l.msg},
            statusCode: HttpStatus.badRequest);
      }, (r) {
        return res.json( {'success': true,'data': r } ,
            statusCode: HttpStatus.accepted);
      });
    } catch (err) {
      return res.json({'success': false, 'data': err.toString()},
          statusCode: HttpStatus.badRequest);
    }
  }
}
