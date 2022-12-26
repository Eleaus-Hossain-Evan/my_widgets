import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_easylogger/flutter_logger.dart' as flutter_logger;

import 'application/global.dart';
import 'route/go_router.dart';
import 'utils/api_routes.dart';
import 'utils/network_handler.dart';
import 'utils/strings.dart';
import 'utils/theme.dart';

class ProviderLog extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    flutter_logger.Logger.i('''
{
  "PROVIDER": "${provider.name}; ${provider.runtimeType.toString()}"
  
}''');
    log("$newValue");
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  flutter_logger.Logger.init(
    kDebugMode, // isEnable ，if production ，please false
    isShowFile: false, // In the IDE, whether the file name is displayed
    isShowTime: false, // In the IDE, whether the time is displayed
    levelVerbose: 247,
    levelDebug: 15,
    levelInfo: 10,
    levelWarn: 5,
    levelError: 9,
    phoneVerbose: Colors.white,
    phoneDebug: Colors.lightBlue,
    phoneInfo: Colors.greenAccent,
    phoneWarn: Colors.yellow.shade600,
    phoneError: Colors.redAccent,
  );

  await Hive.initFlutter();
  final box = await Hive.openBox(KStrings.cacheBox);
  final String token =
      Hive.box(KStrings.cacheBox).get(KStrings.token, defaultValue: '');

  final api = CleanApi.instance;

  api.setup(baseUrl: APIRoute.BASE_URL, showLogs: true);
  //api.enableCache(box);
  api.setToken({"Authorization": "Bearer $token"});

  // final myApi = ApiService.instance;

  // myApi.setup(baseUrl: APIRoute.BASE_URL_LOCAL, showLogs: false);
  // myApi.enableCache(box);

  // myApi.setToken(
  //   {'Authorization': 'Bearer ${box.get(KStrings.token, defaultValue: '')}'},
  // );

  final myApi = NetworkHandler.instance;

  myApi.setup(baseUrl: APIRoute.BASE_URL, showLogs: false);
  myApi.enableCache(box);

  myApi.setToken({"Authorization": "Bearer $token"});

  Logger.d('token: $token');

  final _databaseService = DatabaseService();
  await _databaseService.initTheme();
  runApp(
    ProviderScope(
      overrides: [
        databaseService.overrideWithValue(_databaseService),
      ],
      observers: [ProviderLog()],
      child: const MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeProvider).theme;
    final router = ref.watch(routerProvider);
    // final user = ref.watch(loggedInProvider);

    // useEffect(() {
    //   Timer.periodic(
    //     const Duration(seconds: 10),
    //     (timer) async {
    //       user.token.isEmpty
    //           ? timer.cancel()
    //           : ref.read(authProvider.notifier).refreshToken(user.token);
    //       Logger.i("----------------------------------------${user.token}");
    //     },
    //   );

    //   Future.microtask(
    //     () => ref
    //         .read(authProvider.notifier)
    //         .setUser(ref.watch(loggedInProvider).user),
    //   );

    //   return null;
    // }, []);

    return ScreenUtilInit(
      designSize: const Size(411.4, 843.4),
      builder: (context, child) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: MaterialApp.router(
            title: 'LMS',
            debugShowCheckedModeBanner: false,
            themeMode: mode.isEmpty
                ? ThemeMode.system
                : mode == "dark"
                    ? ThemeMode.dark
                    : ThemeMode.light,
            theme: MyTheme.lightTheme,
            darkTheme: MyTheme.darkTheme,
            scaffoldMessengerKey: ref.watch(scaffoldKeyProvider),
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            routeInformationProvider: router.routeInformationProvider,
            scrollBehavior: const ScrollBehavior().copyWith(
              physics: const BouncingScrollPhysics(),
            ),
            // home: child,
            builder: BotToastInit(),
          ),
        );
      },
    );
  }
}
