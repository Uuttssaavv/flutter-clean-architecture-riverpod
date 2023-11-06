import 'package:flutter_project/features/authentication/domain/repositories/auth_repository.dart';
import 'package:flutter_project/features/authentication/presentation/providers/state/auth_notifier.dart';
import 'package:flutter_project/features/authentication/presentation/providers/state/auth_state.dart';
import 'package:flutter_project/services/user_cache_service/domain/repositories/user_cache_repository.dart';
import 'package:flutter_project/shared/domain/models/either.dart';
import 'package:flutter_project/shared/domain/models/models.dart';
import 'package:flutter_project/shared/exceptions/http_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

import '../../../../fixtures/dummy_data.dart';

void main() {
  late AuthenticationRepository authRepository;
  late UserRepository userRepository;
  late AuthNotifier authNotifier;

  setUpAll(
    () {
      registerFallbackValue(ktestUser);
    },
  );
  setUp(() {
    authRepository = MockAuthRepository();
    userRepository = MockUserRepository();
    authNotifier = AuthNotifier(
      authRepository: authRepository,
      userRepository: userRepository,
    );
  });

  stateNotifierTest<AuthNotifier, AuthState>(
    'emits [] when no methods are called',
    build: () => authNotifier,
    actions: (_) {},
    expect: () => [],
  );
  group(
    'Authentication test\n',
    () {
      stateNotifierTest<AuthNotifier, AuthState>(
        'emits [AuthState.loading, AuthState.success] when login and cache is success',
        build: () => authNotifier,
        setUp: () {
          when(
            () => authRepository.loginUser(user: any(named: 'user')),
          ).thenAnswer(
              (invocation) async => Right<AppException, User>(ktestUser));

          when(() => userRepository.saveUser(user: any(named: 'user')))
              .thenAnswer(
            (invocation) async => true,
          );
        },
        actions: (stateNotifier) async {
          await stateNotifier.loginUser('', '');
        },
        expect: () => [
          const AuthState.loading(),
          const AuthState.success(),
        ],
      );
      stateNotifierTest<AuthNotifier, AuthState>(
        'emits [AuthState.loading, AuthState.failure] when login is success but cache is fail',
        build: () => authNotifier,
        setUp: () {
          when(
            () => authRepository.loginUser(user: any(named: 'user')),
          ).thenAnswer(
            (invocation) async => Right<AppException, User>(ktestUser),
          );

          when(
            () => userRepository.saveUser(user: any(named: 'user')),
          ).thenAnswer(
            (invocation) async => false,
          );
        },
        actions: (stateNotifier) async {
          await stateNotifier.loginUser('', '');
        },
        expect: () => [
          const AuthState.loading(),
          AuthState.failure(CacheFailureException()),
        ],
      );
      test(
        'when the login fails then the saveUser method is not called',
        () async {
          // arrange
          when(
            () => authRepository.loginUser(user: any(named: 'user')),
          ).thenAnswer((invocation) async =>
              Left<AppException, User>(ktestAppException));

          // assert
          await authNotifier.loginUser('', '');

          //act

          verifyNever(() => userRepository.saveUser(user: ktestUser));
        },
      );

      stateNotifierTest<AuthNotifier, AuthState>(
        'emits [AuthState.loading, AuthState.failure] when login is fail',
        build: () => authNotifier,
        setUp: () {
          when(
            () => authRepository.loginUser(user: any(named: 'user')),
          ).thenAnswer(
            (invocation) async => Left<AppException, User>(ktestAppException),
          );
        },
        actions: (stateNotifier) async {
          await stateNotifier.loginUser('', '');
        },
        expect: () => [
          const AuthState.loading(),
          AuthState.failure(ktestAppException),
        ],
      );
    },
  );
}

class MockAuthRepository extends Mock implements AuthenticationRepository {}

class MockUserRepository extends Mock implements UserRepository {}
