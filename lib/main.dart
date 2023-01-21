import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_to_cook_demo_flutter_1/providers/themes_provider.dart';
import 'package:what_to_cook_demo_flutter_1/screens/home_screen.dart';
import 'package:what_to_cook_demo_flutter_1/utils/themes.dart';



void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // prevent device orientation changes and force portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final themeModeState = ref.watch(themesProvider);
    return MaterialApp(
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      themeMode: themeModeState,
      //I don't like debug banner so I disable it
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
