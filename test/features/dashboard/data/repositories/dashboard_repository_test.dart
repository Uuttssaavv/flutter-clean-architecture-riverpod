//test for filename
import 'package:flutter_project/shared/domain/models/either.dart';
import 'package:flutter_project/features/dashboard/data/datasource/dashboard_remote_datasource.dart';
import 'package:flutter_project/features/dashboard/data/repositories/dashboard_repository.dart';
import 'package:flutter_project/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:flutter_project/shared/domain/models/paginated_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/dummy_data.dart';

void main() {
  late DashboardDatasource dashboardDatasource;
  late DashboardRepository dashboardRepository;
  setUpAll(() {
    dashboardDatasource = MockRemoteDatasource();
    dashboardRepository = DashboardRepositoryImpl(dashboardDatasource);
  });

  group('Dashboard Repository Test\n', () {
    test('Should return PaginatedResponse on success', () async {
      // arrange
      when(() => dashboardDatasource.fetchPaginatedProducts(
          skip: any(named: 'skip'))).thenAnswer(
        (_) async => Right(PaginatedResponse.fromJson({}, [])),
      );

      // assert
      final response = await dashboardRepository.fetchProducts(skip: 0);

      // act
      expect(response.isRight(), true);
    });
    test(
      'Should return AppException on failure',
      () async {
        // arrange
        when(() => dashboardDatasource.fetchPaginatedProducts(
            skip: any(named: 'skip'))).thenAnswer(
          (_) async => Left(ktestAppException),
        );

        // assert
        final response = await dashboardRepository.fetchProducts(skip: 1);

        // act
        expect(response.isLeft(), true);
      },
    );
  });
  group('Dashboard Repository Test(Search)\n', () {
    test('Should return PaginatedResponse on success', () async {
      // arrange
      when(() => dashboardDatasource.searchPaginatedProducts(
          skip: any(named: 'skip'), query: any(named: 'query'))).thenAnswer(
        (_) async => Right(PaginatedResponse.fromJson({}, [])),
      );

      // assert
      final response =
          await dashboardRepository.searchProducts(skip: 0, query: '');

      // act
      expect(response.isRight(), true);
    });
    test(
      'Should return AppException on failure',
      () async {
        // arrange
        when(() => dashboardDatasource.searchPaginatedProducts(
            skip: any(named: 'skip'), query: any(named: 'query'))).thenAnswer(
          (_) async => Left(ktestAppException),
        );

        // assert
        final response =
            await dashboardRepository.searchProducts(skip: 1, query: '');

        // act
        expect(response.isLeft(), true);
      },
    );
  });
}

class MockRemoteDatasource extends Mock implements DashboardRemoteDatasource {}
