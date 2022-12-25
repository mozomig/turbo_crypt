import 'package:flutter/material.dart';
import 'package:turbo_crypt/features/encrypt/encrypt_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/models/utils/override_dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      overrides: await getOverridesDependecy(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turbo Encrypt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EncryptPage(),
    );
  }
}
