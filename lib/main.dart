import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_to_cook_demo_flutter_1/providers/themes_provider.dart';
import 'package:what_to_cook_demo_flutter_1/services/sign_in_screen.dart';
import 'package:what_to_cook_demo_flutter_1/utils/themes.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final themeModeState= ref.watch(themesProvider);
    return MaterialApp(
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      themeMode: themeModeState,
      //I don't like debug banner so I disable it
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}
