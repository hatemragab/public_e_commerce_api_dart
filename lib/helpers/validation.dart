import 'package:palace/palace.dart';
import 'package:palace/utils/dto_builder.dart';

T validationHandler<T>(Request request) {
  T? dto;

  dto = buildDto<T>(request.body);
  final erros = validateDto(dto!);
  if (erros.isNotEmpty) {
    /// some rules faild
    throw(erros.first.toString());
  }
  return dto;
}
