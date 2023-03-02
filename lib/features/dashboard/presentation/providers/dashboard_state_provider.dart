//
import 'package:flutter_project/features/dashboard/domain/providers/dashboard_providers.dart';
import 'package:flutter_project/features/dashboard/presentation/providers/state/dashboard_notifier.dart';
import 'package:flutter_project/features/dashboard/presentation/providers/state/dashboard_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardNotifierProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return DashboardNotifier(repository)..fetchProducts();
});
