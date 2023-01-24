import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_to_cook_demo_flutter_1/providers/is_logging_provider.dart';
import 'package:what_to_cook_demo_flutter_1/providers/themes_provider.dart';
import 'package:what_to_cook_demo_flutter_1/screens/home_screen.dart';
import 'package:what_to_cook_demo_flutter_1/utils/themes.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    closeLoadingScreen();
  }

  Future<void> closeLoadingScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    ref.read(isLoadingProvider.notifier).update((state) => false);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // prevent device orientation changes and force portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final isLoading = ref.watch(isLoadingProvider);
    final themeModeState = ref.watch(themesProvider);

    return MaterialApp(
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      themeMode: themeModeState,
      //I don't like debug banner so I disable it
      debugShowCheckedModeBanner: false,
      home: isLoading
          ? Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              body: Center(
                child: SpinKitThreeInOut(
                  duration: const Duration(seconds: 1),
                  itemBuilder: (context, index) {
                    final colors = [
                      const Color(0xffa4330d),
                      const Color(0xff6c9e4f),
                      const Color(0xffdbcdb5),
                      const Color(0xff5e3c2c),
                    ];
                    final color = colors[index % colors.length];
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                ),
              ),
            )
          : HomeScreen(),
    );
  }
}
