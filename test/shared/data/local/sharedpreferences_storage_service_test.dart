import 'package:flutter_project/shared/data/local/shared_prefs_storage_service.dart';
import 'package:flutter_project/shared/data/local/storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/data/user_map.dart';

void main() {
  late StorageService storageService;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({'key': ktestUserMap});
    storageService = SharedPrefsService();
  });

  group(
    'SharedPreferencesStorageServiceTests\n',
    () {
      test(
        'When the prefs is not initialized the hasInitialized should be FALSE',
        () async {
          expect(storageService.hasInitialized, false);

          storageService.init();

          // expect(storageService.hasInitialized, true);
        },
      );
      test('Should perform the CRUD operations with SharedPreferences',
          () async {
        // get the data
        final data = await storageService.get('key');

        expect(data, ktestUserMap);

        // check if data exist
        // should return true
        final hasData = await storageService.has('key');

        expect(hasData, true);
        // remove the data
        final removeData = await storageService.remove('key');

        expect(removeData, true);

        // check if data exist
        // should return false
        final hasData2 = await storageService.has('key');

        expect(hasData2, false);

        // save the data again
        final saved = await storageService.set('key', ktestUserMap.toString());

        expect(saved, true);
        // check if data exist
        // should return true
        final hasData3 = await storageService.has('key');

        expect(hasData3, true);

        // clear the shared preferences
        await storageService.clear();

        // check if data exist
        // should return false
        final hasData4 = await storageService.has('key');

        expect(hasData4, false);
      });
    },
  );
}
