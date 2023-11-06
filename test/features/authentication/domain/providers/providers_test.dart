import 'package:flutter_project/features/authentication/data/datasource/auth_remote_data_source.dart';
import 'package:flutter_project/features/authentication/domain/providers/login_provider.dart';
import 'package:flutter_project/features/authentication/domain/repositories/auth_repository.dart';
import 'package:flutter_project/shared/domain/providers/dio_network_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final providerContainer = ProviderContainer();
  late dynamic networkService;
  late dynamic dataSource;
  late dynamic authRepository;
  setUpAll(
    () {
      networkService = providerContainer.read(networkServiceProvider);
      dataSource =
          providerContainer.read(authDataSourceProvider(networkService));
      authRepository = providerContainer.read(authRepositoryProvider);
    },
  );
  test('dataSourceProvider is a LoginUserDataSource', () {
    expect(
      dataSource,
      isA<LoginUserDataSource>(),
    );
  });
  test('authRepositoryProvider is a AuthenticationRepository', () {
    expect(
      authRepository,
      isA<AuthenticationRepository>(),
    );
  });
  test('loginUserProvider returns a AuthenticationRepository', () {
    expect(
      providerContainer.read(authRepositoryProvider),
      isA<AuthenticationRepository>(),
    );
  });
}
