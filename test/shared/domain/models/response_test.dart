import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/dummy_data.dart';

void main() {
  test(
    'toString() function returns the objects',
    () {
      final expectedString =
          'statusCode=${ktestUserResponse.statusCode}\nstatusMessage=${ktestUserResponse.statusMessage}\n data=${ktestUserResponse.data}';

      final actual = ktestUserResponse.toString();

      expect(actual, expectedString);
    },
  );
}
