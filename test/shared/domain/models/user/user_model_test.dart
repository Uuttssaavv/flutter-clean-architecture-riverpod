import 'package:flutter_project/shared/domain/models/user/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/data/user_map.dart';
import '../../../../fixtures/dummy_data.dart';

void main() {
  group(
    'UserModel Test\n',
    () {
      test('Should parse User from json', () {
        expect(User.fromJson(ktestUserMap), ktestUserFromMap);
      });

      test('Should return json from user', () {
        expect(ktestUserFromMap.toJson(), ktestUserMap);
      });
      test('Should return string of user', () {
        expect(ktestUserFromMap.toJson(), isA<Map<String, dynamic>>());
      });
      test('Should update value', () {
        const String updatedToken = 'updated';

        User user = ktestUserFromMap.copyWith(token: updatedToken);
        expect(user.token, updatedToken);

        user = user.copyWith(token: null);
        expect(user.token, updatedToken);
      });
    },
  );
}
