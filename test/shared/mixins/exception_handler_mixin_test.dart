import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_project/shared/data/remote/remote.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late DioNetworkService mockDioNetworkServide;
  setUpAll(() {
    mockDioNetworkServide = DioNetworkService(MockDio());
  });
  group(
    'ExceptionHandler Mixin Test\n',
    () {
      test(
        'handle exception returns Response on success',
        () async {
          when(() => mockDioNetworkServide.dio.get(any())).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(path: ''),
            ),
          );
          final resp = await mockDioNetworkServide.get('');

          expect(resp.isRight(), true);
        },
      );
      test(
        'handle exception returns AppException on error',
        () async {
          when(() => mockDioNetworkServide.dio.get(any())).thenThrow(
            Exception(),
          );
          final resp = await mockDioNetworkServide.get('');

          expect(resp.isLeft(), true);
        },
      );
      test(
        'handle exception handles SocketException with statusCode 0',
        () async {
          when(() => mockDioNetworkServide.dio.get(any())).thenThrow(
            const SocketException(''),
          );
          final resp = (await mockDioNetworkServide.get(''));
          resp.fold(
            (l) {
              expect(l.statusCode, 0);
            },
            (r) {},
          );
        },
      );
      test(
        'handle exception handles DioException with statusCode 1',
        () async {
          when(() => mockDioNetworkServide.dio.get(any())).thenThrow(
            DioException(requestOptions: RequestOptions(path: '')),
          );
          final resp = await mockDioNetworkServide.get('');
          resp.fold(
            (l) {
              expect(l.statusCode, 1);
            },
            (r) {},
          );
        },
      );
      test(
        'handle exception handles Other Exceptions with statusCode 2',
        () async {
          when(() => mockDioNetworkServide.dio.get(any())).thenThrow(
            Exception(''),
          );
          final resp = await mockDioNetworkServide.get('');
          resp.fold(
            (l) {
              expect(l.statusCode, 2);
            },
            (r) {},
          );
        },
      );
    },
  );
}

class MockDio extends Mock implements Dio {}
