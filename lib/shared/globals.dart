import 'dart:io';

final kTestMode = Platform.environment.containsKey('FLUTTER_TEST');
const int PRODUCTS_PER_PAGE = 20;
const String USER_LOCAL_STORAGE_KEY = 'user';
