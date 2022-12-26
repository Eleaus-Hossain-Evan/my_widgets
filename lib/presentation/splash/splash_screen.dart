import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_widgets/presentation/home/home_screen.dart';

class SplashScreen extends HookConsumerWidget {
  static const route = '/';

  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 3), () {
        Router.neglect(context, () {
          context.go(HomeScreen.route);
        });
      });
      return null;
    }, []);
    var size = MediaQuery.of(context).size;
    Logger.v('size: $size');
    return Scaffold(
      body: Center(
          child: Text(
        "Splash Screen",
        style: TextStyle(
          fontSize: 30.sp,
          fontWeight: FontWeight.bold,
        ),
      )),
    );
  }
}
