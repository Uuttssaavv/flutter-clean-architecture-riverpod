import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class Observers extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    log('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "disposed"
}''');
    super.didDisposeProvider(provider, container);
  }
}
