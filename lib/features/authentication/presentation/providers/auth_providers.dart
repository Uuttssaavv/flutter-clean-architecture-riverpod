import 'package:flutter_project/features/authentication/domain/providers/login_provider.dart';
import 'package:flutter_project/features/authentication/domain/repositories/auth_repository.dart';
import 'package:flutter_project/features/authentication/presentation/providers/state/auth_notifier.dart';
import 'package:flutter_project/features/authentication/presentation/providers/state/auth_state.dart';
import 'package:flutter_project/services/user_cache_service/domain/providers/user_cache_provider.dart';
import 'package:flutter_project/services/user_cache_service/domain/repositories/user_cache_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) {
    final AuthenticationRepository authenticationRepository =
        ref.watch(authRepositoryProvider);
    final UserRepository userRepository =
        ref.watch(userLocalRepositoryProvider);
    return AuthNotifier(
      authRepository: authenticationRepository,
      userRepository: userRepository,
    );
  },
);
