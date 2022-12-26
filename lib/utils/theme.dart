//** THEME CONTROLLER */
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final themeProvider = ChangeNotifierProvider<ThemeController>((ref) {
  final database = ref.watch(databaseService);

  return ThemeController(database);
});

class ThemeController with ChangeNotifier {
  ThemeController(this._database);

  late final DatabaseService _database;

  String get theme => _database.savedTheme;

  void toggle(bool mode) {
    (mode)
        ? _database.toggleSaveTheme("dark")
        : _database.toggleSaveTheme("light");

    notifyListeners();
  }
}

//** DATABASE CLASS */
final databaseService = Provider<DatabaseService>((_) => DatabaseService());

class DatabaseService {
  late final Box<String> themeBox;

  String get savedTheme => themeBox.values.first;

  Future<void> initTheme() async {
    await Hive.openBox<String>('theme').then((value) => themeBox = value);

    //first time loading
    if (themeBox.values.isEmpty) {
      themeBox.add('light');
    }
  }

  Future<void> toggleSaveTheme(String mode) async =>
      await themeBox.put(0, mode);
}

class MyTheme {
  static final lightTheme = FlexThemeData.light(
    scheme: FlexScheme.money,
    surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
    blendLevel: 4,
    appBarStyle: FlexAppBarStyle.material,
    tabBarStyle: FlexTabBarStyle.forBackground,
    lightIsWhite: true,
    tooltipsMatchBackground: true,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 40,
      buttonMinSize: Size.fromHeight(40),
      elevatedButtonRadius: 8.0,
      outlinedButtonRadius: 8.0,
      elevatedButtonSchemeColor: SchemeColor.onInverseSurface,
      elevatedButtonSecondarySchemeColor: SchemeColor.primary,
      outlinedButtonOutlineSchemeColor: SchemeColor.primary,
      switchSchemeColor: SchemeColor.primary,
      checkboxSchemeColor: SchemeColor.primary,
      radioSchemeColor: SchemeColor.primary,
      unselectedToggleIsColored: true,
      inputDecoratorSchemeColor: SchemeColor.primaryContainer,
      inputDecoratorRadius: 40.0,
      inputDecoratorUnfocusedHasBorder: false,
      fabUseShape: false,
      snackBarBackgroundSchemeColor: SchemeColor.outline,
      chipSchemeColor: SchemeColor.primaryContainer,
      chipRadius: 40.0,
      dialogRadius: 8.0,
      timePickerDialogRadius: 8.0,
      // buttonMinSize: Size.fromHeight(40),
      bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      bottomNavigationBarUnselectedLabelSchemeColor:
          SchemeColor.onPrimaryContainer,
      bottomNavigationBarSelectedIconSchemeColor: SchemeColor.primary,
      bottomNavigationBarUnselectedIconSchemeColor:
          SchemeColor.onPrimaryContainer,
      navigationBarUnselectedLabelSchemeColor: SchemeColor.onSecondaryContainer,
      navigationBarUnselectedIconSchemeColor: SchemeColor.onSecondaryContainer,
      navigationBarBackgroundSchemeColor: SchemeColor.background,
      appBarBackgroundSchemeColor: SchemeColor.background,
    ),
    keyColors: const FlexKeyColors(
      useSecondary: true,
      useTertiary: true,
      keepPrimary: true,
      keepSecondary: true,
      keepTertiary: true,
      keepPrimaryContainer: true,
      keepSecondaryContainer: true,
      keepTertiaryContainer: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    // To use the playground font, add GoogleFonts package and uncomment
    // fontFamily: GoogleFonts.notoSans().fontFamily,
  );
  static final darkTheme = FlexThemeData.dark(
      scheme: FlexScheme.money,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 15,
      appBarStyle: FlexAppBarStyle.material,
      tabBarStyle: FlexTabBarStyle.forBackground,
      tooltipsMatchBackground: true,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 30,
        buttonMinSize: Size.fromHeight(40),
        elevatedButtonRadius: 8.0,
        outlinedButtonRadius: 8.0,
        elevatedButtonSchemeColor: SchemeColor.onInverseSurface,
        elevatedButtonSecondarySchemeColor: SchemeColor.primary,
        outlinedButtonOutlineSchemeColor: SchemeColor.primary,
        switchSchemeColor: SchemeColor.primary,
        checkboxSchemeColor: SchemeColor.primary,
        radioSchemeColor: SchemeColor.primary,

        unselectedToggleIsColored: true,
        inputDecoratorRadius: 40.0,
        inputDecoratorUnfocusedHasBorder: false,
        fabUseShape: false,
        snackBarBackgroundSchemeColor: SchemeColor.outline,
        chipSchemeColor: SchemeColor.primaryContainer,
        chipRadius: 40.0,
        dialogRadius: 8.0,
        timePickerDialogRadius: 8.0,
        // buttonMinSize: Size.fromHeight(40),
        bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
        bottomNavigationBarUnselectedLabelSchemeColor:
            SchemeColor.onPrimaryContainer,
        bottomNavigationBarSelectedIconSchemeColor: SchemeColor.primary,
        bottomNavigationBarUnselectedIconSchemeColor:
            SchemeColor.onPrimaryContainer,
        navigationBarUnselectedLabelSchemeColor:
            SchemeColor.onSecondaryContainer,
        navigationBarUnselectedIconSchemeColor:
            SchemeColor.onSecondaryContainer,
        navigationBarBackgroundSchemeColor: SchemeColor.background,
        appBarBackgroundSchemeColor: SchemeColor.background,
        dialogBackgroundSchemeColor: SchemeColor.primaryContainer,
      ),
      keyColors: const FlexKeyColors(
        useSecondary: true,
        useTertiary: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      // To use the playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
      textTheme: const TextTheme().copyWith(
        bodyText1: const TextStyle(
          color: Colors.white,
        ),
        bodyText2: const TextStyle(
          color: Colors.white,
        ),
        headline1: const TextStyle(
          color: Colors.white,
        ),
        headline2: const TextStyle(
          color: Colors.white,
        ),
        headline3: const TextStyle(
          color: Colors.white,
        ),
        headline4: const TextStyle(
          color: Colors.white,
        ),
        headline5: const TextStyle(
          color: Colors.white,
        ),
        headline6: const TextStyle(
          color: Colors.white,
        ),
        subtitle1: const TextStyle(
          color: Colors.white,
        ),
        subtitle2: const TextStyle(
          color: Colors.white,
        ),
        caption: const TextStyle(
          color: Colors.white,
        ),
        button: const TextStyle(
          color: Colors.white,
        ),
        overline: const TextStyle(
          color: Colors.white,
        ),
      ));
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,

}
