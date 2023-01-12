import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemesNotifier extends StateNotifier<ThemeMode?> {
  ThemesNotifier() : super(ThemeMode.system);
  // user will be able to change the theme with this function
  void changeTheme(bool isOn) {
    state = isOn ? ThemeMode.dark : ThemeMode.light;
  }
}

final themesProvider = StateNotifierProvider<ThemesNotifier, ThemeMode?>((_) {
  return ThemesNotifier();
});
