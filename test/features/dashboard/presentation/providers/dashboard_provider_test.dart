//test for filename
import 'package:flutter_project/shared/domain/models/either.dart';
import 'package:flutter_project/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:flutter_project/features/dashboard/presentation/providers/state/dashboard_notifier.dart';
import 'package:flutter_project/features/dashboard/presentation/providers/state/dashboard_state.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

import '../../../../fixtures/dashboard/dummy_productlist.dart';
import '../../../../fixtures/dummy_data.dart';

void main() {
  late DashboardRepository dashboardRepository;
  late DashboardNotifier notifier;
  setUpAll(() {
    dashboardRepository = MockDashboardRepository();
    notifier = DashboardNotifier(dashboardRepository);
  });
  stateNotifierTest<DashboardNotifier, DashboardState>(
    'Should fail when error occurs on fetch',
    build: () => DashboardNotifier(dashboardRepository),
    setUp: () {
      when(() => dashboardRepository.fetchProducts(skip: 0)).thenAnswer(
        (invocation) async => Left(ktestAppException),
      );
    },
    actions: (notifier) async {
      await notifier.fetchProducts();
    },
    expect: () => [
      const DashboardState(
        state: DashboardConcreteState.loading,
        page: 0,
        total: 0,
        hasData: false,
      ),
      const DashboardState(
        state: DashboardConcreteState.failure,
        productList: [],
        page: 0,
        total: 0,
        hasData: false,
      ),
    ],
  );
  stateNotifierTest<DashboardNotifier, DashboardState>(
    'Should load list of products on successful fetch',
    build: () => DashboardNotifier(dashboardRepository),
    setUp: () {
      when(() => dashboardRepository.fetchProducts(skip: 0)).thenAnswer(
        (invocation) async => Right(ktestPaginatedResponse()),
      );
    },
    actions: (notifier) async {
      await notifier.fetchProducts();
    },
    expect: () => [
      const DashboardState(
        state: DashboardConcreteState.loading,
      ),
      DashboardState(
        state: DashboardConcreteState.loaded,
        hasData: true,
        productList: ktestProductList,
        page: 1,
        total: 100,
      ),
    ],
  );
  stateNotifierTest<DashboardNotifier, DashboardState>(
    'Should have productList of previous fetch when error occurs on second page',
    build: () => DashboardNotifier(dashboardRepository),
    setUp: () {
      when(() => dashboardRepository.fetchProducts(skip: 0)).thenAnswer(
        (invocation) async => Right(ktestPaginatedResponse()),
      );
      when(() => dashboardRepository.fetchProducts(skip: PRODUCTS_PER_PAGE))
          .thenAnswer(
        (invocation) async => Left(ktestAppException),
      );
    },
    actions: (notifier) async {
      await notifier.fetchProducts();
      await notifier.fetchProducts();
    },
    expect: () => [
      const DashboardState(
        state: DashboardConcreteState.loading,
      ),
      DashboardState(
        state: DashboardConcreteState.loaded,
        hasData: true,
        productList: ktestProductList,
        page: 1,
        total: 100,
      ),
      DashboardState(
        state: DashboardConcreteState.fetchingMore,
        hasData: true,
        productList: ktestProductList,
        page: 1,
        total: 100,
      ),
      DashboardState(
        state: DashboardConcreteState.failure,
        page: 1,
        total: 100,
        hasData: true,
        productList: ktestProductList,
      ),
    ],
  );

  stateNotifierTest<DashboardNotifier, DashboardState>(
    'Should increment page and append product response to the productList on successive fetch',
    build: () => DashboardNotifier(dashboardRepository),
    setUp: () {
      when(() => dashboardRepository.fetchProducts(skip: 0)).thenAnswer(
        (invocation) async => Right(ktestPaginatedResponse()),
      );
      when(() => dashboardRepository.fetchProducts(skip: PRODUCTS_PER_PAGE))
          .thenAnswer(
        (invocation) async =>
            Right(ktestPaginatedResponse(skip: PRODUCTS_PER_PAGE)),
      );
    },
    actions: (notifier) async {
      await notifier.fetchProducts();
      await notifier.fetchProducts();
    },
    expect: () => [
      const DashboardState(
        state: DashboardConcreteState.loading,
        page: 0,
        total: 0,
        hasData: false,
      ),
      DashboardState(
        state: DashboardConcreteState.loaded,
        productList: ktestProductList,
        page: 1,
        total: 100,
        hasData: true,
      ),
      DashboardState(
        state: DashboardConcreteState.fetchingMore,
        hasData: true,
        page: 1,
        total: 100,
        productList: ktestProductList,
      ),
      DashboardState(
        state: DashboardConcreteState.loaded,
        productList: [...ktestProductList, ...ktestProductList],
        page: 2,
        total: 100,
        hasData: true,
      ),
    ],
  );
  group('Dashboard Search state', () {
    stateNotifierTest<DashboardNotifier, DashboardState>(
      'Should fail when error occurs on fetch',
      build: () => DashboardNotifier(dashboardRepository),
      setUp: () {
        when(() => dashboardRepository.searchProducts(skip: 0, query: ''))
            .thenAnswer(
          (invocation) async => Left(ktestAppException),
        );
      },
      actions: (notifier) async {
        await notifier.searchProducts('');
      },
      expect: () => [
        const DashboardState(
          state: DashboardConcreteState.loading,
          page: 0,
          total: 0,
          hasData: false,
        ),
        const DashboardState(
          state: DashboardConcreteState.failure,
          productList: [],
          page: 0,
          total: 0,
          hasData: false,
        ),
      ],
    );
    stateNotifierTest<DashboardNotifier, DashboardState>(
      'Should load list of products on successful fetch',
      build: () => DashboardNotifier(dashboardRepository),
      setUp: () {
        when(() => dashboardRepository.searchProducts(skip: 0, query: ''))
            .thenAnswer(
          (invocation) async => Right(ktestPaginatedResponse()),
        );
      },
      actions: (notifier) async {
        await notifier.searchProducts('');
      },
      expect: () => [
        const DashboardState(
          state: DashboardConcreteState.loading,
        ),
        DashboardState(
          state: DashboardConcreteState.loaded,
          hasData: true,
          productList: ktestProductList,
          page: 1,
          total: 100,
        ),
      ],
    );
    stateNotifierTest<DashboardNotifier, DashboardState>(
      'Should have productList of previous fetch when error occurs on second page',
      build: () => DashboardNotifier(dashboardRepository),
      setUp: () {
        when(() => dashboardRepository.searchProducts(skip: 0, query: ''))
            .thenAnswer(
          (invocation) async => Right(ktestPaginatedResponse()),
        );
        when(() => dashboardRepository.searchProducts(
            skip: PRODUCTS_PER_PAGE, query: '')).thenAnswer(
          (invocation) async => Left(ktestAppException),
        );
      },
      actions: (notifier) async {
        await notifier.searchProducts('');
        await notifier.searchProducts('');
      },
      expect: () => [
        const DashboardState(
          state: DashboardConcreteState.loading,
        ),
        DashboardState(
          state: DashboardConcreteState.loaded,
          hasData: true,
          productList: ktestProductList,
          page: 1,
          total: 100,
        ),
        DashboardState(
          state: DashboardConcreteState.fetchingMore,
          hasData: true,
          productList: ktestProductList,
          page: 1,
          total: 100,
        ),
        DashboardState(
          state: DashboardConcreteState.failure,
          page: 1,
          total: 100,
          hasData: true,
          productList: ktestProductList,
        ),
      ],
    );

    stateNotifierTest<DashboardNotifier, DashboardState>(
      'Should increment page and append product response to the productList on successive fetch',
      build: () => DashboardNotifier(dashboardRepository),
      setUp: () {
        when(() => dashboardRepository.searchProducts(skip: 0, query: ''))
            .thenAnswer(
          (invocation) async => Right(ktestPaginatedResponse()),
        );
        when(() => dashboardRepository.searchProducts(
            skip: PRODUCTS_PER_PAGE, query: '')).thenAnswer(
          (invocation) async =>
              Right(ktestPaginatedResponse(skip: PRODUCTS_PER_PAGE)),
        );
      },
      actions: (notifier) async {
        await notifier.searchProducts('');
        await notifier.searchProducts('');
      },
      expect: () => [
        const DashboardState(
          state: DashboardConcreteState.loading,
          page: 0,
          total: 0,
          hasData: false,
        ),
        DashboardState(
          state: DashboardConcreteState.loaded,
          productList: ktestProductList,
          page: 1,
          total: 100,
          hasData: true,
        ),
        DashboardState(
          state: DashboardConcreteState.fetchingMore,
          hasData: true,
          page: 1,
          total: 100,
          productList: ktestProductList,
        ),
        DashboardState(
          state: DashboardConcreteState.loaded,
          productList: [...ktestProductList, ...ktestProductList],
          page: 2,
          total: 100,
          hasData: true,
        ),
      ],
    );
  });
  group('When the fetch is called while loading', () {
    stateNotifierTest<DashboardNotifier, DashboardState>(
      'Should not load list of products when it is already loading while search',
      build: () => DashboardNotifier(dashboardRepository),
      setUp: () {
        when(() => dashboardRepository.searchProducts(skip: 0, query: ''))
            .thenAnswer(
          (invocation) async => Right(ktestPaginatedResponse()),
        );
      },
      actions: (notifier) async {
        notifier.searchProducts('');
        notifier.searchProducts('');
      },
      expect: () => [
        const DashboardState(
          isLoading: true,
          productList: [],
          hasData: false,
          state: DashboardConcreteState.loading,
        ),
        const DashboardState(
          isLoading: false,
          productList: [],
          total: 0,
          page: 0,
          hasData: false,
          state: DashboardConcreteState.fetchedAllProducts,
          message: 'No more products available',
        ),
        DashboardState(
          isLoading: false,
          productList: ktestProductList,
          total: 100,
          page: 1,
          hasData: true,
          state: DashboardConcreteState.loaded,
        )
      ],
    );
    stateNotifierTest<DashboardNotifier, DashboardState>(
      'Should not load list of products when it is already loading while fetch',
      build: () => DashboardNotifier(dashboardRepository),
      setUp: () {
        when(() => dashboardRepository.fetchProducts(skip: 0)).thenAnswer(
          (invocation) async => Right(ktestPaginatedResponse()),
        );
      },
      actions: (notifier) async {
        notifier.fetchProducts();
        notifier.fetchProducts();
      },
      expect: () => [
        const DashboardState(
          isLoading: true,
          productList: [],
          hasData: false,
          state: DashboardConcreteState.loading,
        ),
        const DashboardState(
          isLoading: false,
          productList: [],
          total: 0,
          page: 0,
          hasData: false,
          state: DashboardConcreteState.fetchedAllProducts,
          message: 'No more products available',
        ),
        DashboardState(
          isLoading: false,
          productList: ktestProductList,
          total: 100,
          page: 1,
          hasData: true,
          state: DashboardConcreteState.loaded,
        )
      ],
    );
  });
  test('Should reset state to initial', () {
    notifier.resetState();

    // ignore: invalid_use_of_protected_member
    expect(notifier.state, const DashboardState.initial());
  });
}

class MockDashboardRepository extends Mock implements DashboardRepository {}
