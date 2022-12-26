import 'package:bot_toast/bot_toast.dart';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_widgets/presentation/home/home_screen.dart';
import 'package:my_widgets/presentation/video_player/video_player_screen.dart';

import '../application/auth/auth_provider.dart';
import '../presentation/splash/splash_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);

  return GoRouter(
      debugLogDiagnostics: true,
      refreshListenable: router,
      // redirect: router._redirectLogic,
      routes: router._routes,
      initialLocation: '/',
      errorPageBuilder: router._errorPageBuilder,
      observers: [BotToastNavigatorObserver()]);
});

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen<bool>(
      loggedInProvider.select((value) => value.isLoggedIn),
      (_, __) => Future.microtask(() => notifyListeners()),
    );
  }

  String? _redirectLogic(BuildContext context, GoRouterState state) {
    final token = _ref.watch(loggedInProvider).token;
    final user = _ref.watch(loggedInProvider).user;

    Logger.i('RouterNotifier: $user = $token');

    // bool isUserIn() => token.isNotEmpty;

    // final areWeLoggingIn = state.location == LoginScreen.routeName;
    // final areWeRegistering = state.location == SignupScreen.routeName;

    // if (!isUserIn() && areWeLoggingIn) {
    //   return areWeLoggingIn ? null : LoginScreen.routeName;
    // }
    // if (!isUserIn() && areWeRegistering) {
    //   return areWeRegistering ? null : SignupScreen.routeName;
    // }

    // if (areWeLoggingIn || areWeRegistering) return MainNav.routeName;

    return null;
  }

  List<GoRoute> get _routes => [
        // GoRoute(
        //   path: SplashScreen.route,
        //   pageBuilder: (context, state) => CustomTransitionPage<void>(
        //     key: state.pageKey,
        //     child: const SplashScreen(),
        //     fullscreenDialog: true,
        //     transitionsBuilder: (BuildContext context,
        //             Animation<double> animation,
        //             Animation<double> secondaryAnimation,
        //             Widget child) =>
        //         SlideTransition(
        //       position: animation.drive(
        //         Tween(
        //           begin: const Offset(1, 0),
        //           end: Offset.zero,
        //         ).chain(
        //           CurveTween(curve: Curves.easeIn),
        //         ),
        //       ),
        //       child: child,
        //     ),
        //   ),
        // ),
        GoRoute(
          path: SplashScreen.route,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: HomeScreen.route,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '${VideoPlayerScreen.route}:title',
          builder: (context, state) => VideoPlayerScreen(
            title: state.params['title']!,
            // fileUrl: state.queryParams['fileUrl']!,
          ),
        ),
      ];
  Page<void> _errorPageBuilder(BuildContext context, GoRouterState state) =>
      MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          // backgroundColor: Theme.of(context).errorColor.withOpacity(.1),
          body: Center(
            child: Text('Error: ${state.error.toString()}'),
          ),
        ),
      );
}
