import 'package:flutter_project/shared/exceptions/http_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final AppException exception =
      AppException(message: 'message', statusCode: 1, identifier: 'identifier');
  test(
    'toString() function returns the objects',
    () {
      final expectedString =
          'statusCode=${exception.statusCode}\nmessage=${exception.message}\nidentifier=${exception.identifier}';

      final actual = exception.toString();

      expect(actual, expectedString);
    },
  );
}
