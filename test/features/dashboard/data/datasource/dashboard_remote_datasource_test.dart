import 'package:flutter_project/features/dashboard/data/datasource/dashboard_remote_datasource.dart';
import 'package:flutter_project/shared/data/remote/network_service.dart';
import 'package:flutter_project/shared/domain/models/response.dart';
import 'package:flutter_project/shared/exceptions/http_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/dashboard/dummy_productlist.dart';
import '../../../../fixtures/dummy_data.dart';

void main() async {
  late NetworkService mockNetworkService;
  late DashboardDatasource dashboardDatasource;
  setUpAll(() {
    mockNetworkService = MockNetworkService();
    dashboardDatasource = DashboardRemoteDatasource(mockNetworkService);
  });
  group(
    'Dahboard Remote Datasource Test\n',
    () {
      test(
          'should return PaginatedResponse on success and the data is in valid format',
          () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            statusMessage: '',
            data: ktestProductResponse,
          ).toRight,
        );

        // act
        final resp = await dashboardDatasource.fetchPaginatedProducts(skip: 0);

        // assert
        expect(resp.isRight(), true);
      });
      test(
          'should return PaginatedResponse on success and the data is not in valid format',
          () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            statusMessage: '',
            data: {},
          ).toRight,
        );

        // act
        final resp = await dashboardDatasource.fetchPaginatedProducts(skip: 0);

        // assert
        expect(resp.isRight(), true);
      });
      test('should return AppException on success but the data is null',
          () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            statusMessage: '',
            data: null,
          ).toRight,
        );

        // act
        final resp = await dashboardDatasource.fetchPaginatedProducts(skip: 0);

        // assert
        expect(resp.isLeft(), true);
      });
      test('should return AppException on failure', () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => ktestAppException.toLeft,
        );

        // act
        final resp = await dashboardDatasource.fetchPaginatedProducts(skip: 0);

        // assert
        expect(resp.isLeft(), true);
      });
    },
  );
  group(
    'Dahboard Remote Datasource Test(Search)\n',
    () {
      test(
          'Should return PaginatedResponse on success and the data is in valid format',
          () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            statusMessage: '',
            data: ktestProductResponse,
          ).toRight,
        );

        // act
        final resp = await dashboardDatasource.searchPaginatedProducts(
            skip: 0, query: '');

        // assert
        expect(resp.isRight(), true);
      });
      test(
          'should return PaginatedResponse on success and the data is not in valid format',
          () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            statusMessage: '',
            data: {},
          ).toRight,
        );

        // act
        final resp = await dashboardDatasource.searchPaginatedProducts(
            skip: 0, query: '');

        // assert
        expect(resp.isRight(), true);
      });
      test('should return AppException on success but the data is null',
          () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            statusMessage: '',
            data: null,
          ).toRight,
        );

        // act
        final resp = await dashboardDatasource.searchPaginatedProducts(
            skip: 0, query: '');

        // assert
        expect(resp.isLeft(), true);
      });
      test('should return AppException on failure', () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => ktestAppException.toLeft,
        );

        // act
        final resp = await dashboardDatasource.searchPaginatedProducts(
            skip: 0, query: '');

        // assert
        expect(resp.isLeft(), true);
      });
    },
  );
}

class MockNetworkService extends Mock implements NetworkService {}
