import 'package:dz_shopping/shared_preference/dark_theme_preference.dart';
import 'package:flutter/material.dart';

class DarkTheme extends ChangeNotifier{
  DarkThemePreference darkThemePreference = DarkThemePreference();
   bool _isDark = false;
   bool get  isDark => _isDark;
   set darkTheme(bool value){
     _isDark = value;
     darkThemePreference.setDarkTheme(value);
     notifyListeners();
   }
}