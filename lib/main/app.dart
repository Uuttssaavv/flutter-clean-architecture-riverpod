import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/routes/app_route.gr.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initializationProvider = FutureProvider<Unit>(
  (ref) async {
    // final authNotifier = ref.read(authNotifierProvider.notifier);
    // await authNotifier.checkIfAuthenticated();
    return unit;
  },
);

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter TDD',
      routeInformationParser: appRouter.defaultRouteParser(),
      routerDelegate: appRouter.delegate(),
      debugShowCheckedModeBanner: false,
    );
  }
}
