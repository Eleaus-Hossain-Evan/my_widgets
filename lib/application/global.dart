import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_widgets/utils/text_theme_style_x.dart';

import '../utils/color_palate.dart';
import '../utils/theme.dart';

final scaffoldKeyProvider = Provider<GlobalKey<ScaffoldMessengerState>>((ref) {
  final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();
  return snackbarKey;
});

final snackBarProvider = Provider.family<
    ScaffoldFeatureController<SnackBar, SnackBarClosedReason>,
    String>((ref, String text) {
  final snackbar = ref.watch(scaffoldKeyProvider).currentState!.showSnackBar(
        SnackBar(content: Text(text)),
      );
  return snackbar;
});

showNotification({
  required String title,
  String? theme,
}) {
  bool isDark = theme != null ? theme == 'dark' : false;
  return BotToast.showSimpleNotification(
    title: title,
    align: Alignment.bottomCenter,
    duration: const Duration(milliseconds: 4000),
    // animationDuration: kThemeAnimationDuration,
    dismissDirections: [DismissDirection.horizontal, DismissDirection.up],
    hideCloseButton: true,
    titleStyle: isDark
        ? TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          )
        : TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
    backgroundColor: isDark ? const Color(0xff8a938b) : const Color(0xff717971),
  );
}

final notification = Provider.family<Function(), String>((ref, String text) {
  final mode = ref.watch(themeProvider).theme;
  final notification = showNotification(theme: mode, title: text);
  return notification;
});

showLoading() => BotToast.showLoading(
      backgroundColor: ColorPalate.botToastBackgroundColor,
    );
closeLoading() => BotToast.closeAllLoading();

showToast(String text) => BotToast.showText(
      text: text,
      duration: const Duration(seconds: 2),
      contentPadding: const EdgeInsets.all(10),
    );

showFloatBottomSheet(
  BuildContext context, {
  required Widget Function(BuildContext context) builder,
}) =>
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (context) => Container(
        // height: height,
        margin: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: IntrinsicHeight(
          child: builder(context),
        ),
      ),
    );

bool? showAlertDialog({
  required bool? Function() cancel,
  required bool? Function() confirm,
  Widget? title,
  Widget? confirmWidget,
  Widget? cancelWidget,
}) {
  BotToast.showAnimationWidget(
      clickClose: false,
      allowClick: false,
      onlyOne: true,
      crossPage: true,
      backButtonBehavior: BackButtonBehavior.close,
      wrapToastAnimation: (controller, cancel, child) => Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {},
                //The DecoratedBox here is very important,he will fill the entire parent component
                child: AnimatedBuilder(
                  builder: (_, child) => Opacity(
                    opacity: controller.value,
                    child: child,
                  ),
                  animation: controller,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(color: Colors.black26),
                    child: SizedBox.expand(),
                  ),
                ),
              ),
              CustomOffsetAnimation(controller: controller, child: child)
            ],
          ),
      toastBuilder: (cancelFunc) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            title: title ?? const Text('this is custom widget'),
            actions: <Widget>[
              SizedBox(
                width: .3.sw,
                child: cancelWidget ??
                    TextButton(
                      onPressed: () {
                        cancelFunc();
                        cancel.call();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
              ),
              SizedBox(
                width: .3.sw,
                child: confirmWidget ??
                    TextButton(
                      onPressed: () {
                        cancelFunc();
                        confirm.call();
                      },
                      child: const Text('Confirm'),
                    ),
              ),
            ],
          ),
      animationDuration: const Duration(milliseconds: 300));
  return cancel() ?? confirm();
}

class CustomOffsetAnimation extends StatefulWidget {
  final AnimationController controller;
  final Widget child;

  const CustomOffsetAnimation(
      {Key? key, required this.controller, required this.child})
      : super(key: key);

  @override
  _CustomOffsetAnimationState createState() => _CustomOffsetAnimationState();
}

class _CustomOffsetAnimationState extends State<CustomOffsetAnimation> {
  late Tween<Offset> tweenOffset;
  late Tween<double> tweenScale;

  late Animation<double> animation;

  @override
  void initState() {
    tweenOffset = Tween<Offset>(
      begin: const Offset(0.0, 0.8),
      end: Offset.zero,
    );
    tweenScale = Tween<double>(begin: 0.3, end: 1.0);
    animation =
        CurvedAnimation(parent: widget.controller, curve: Curves.decelerate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      child: widget.child,
      animation: widget.controller,
      builder: (BuildContext context, Widget? child) {
        return FractionalTranslation(
          translation: tweenOffset.evaluate(animation),
          child: ClipRect(
            child: Transform.scale(
              scale: tweenScale.evaluate(animation),
              child: Opacity(
                child: child,
                opacity: animation.value,
              ),
            ),
          ),
        );
      },
    );
  }
}
