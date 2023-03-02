import 'package:dartz/dartz.dart';
import 'package:flutter_project/shared/domain/models/models.dart';
import 'package:flutter_project/shared/exceptions/http_exception.dart';

abstract class AuthenticationRepository {
  Future<Either<AppException, User>> loginUser({required User user});
}
