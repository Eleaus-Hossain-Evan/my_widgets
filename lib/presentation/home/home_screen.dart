import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_widgets/presentation/video_player/video_player_screen.dart';
import 'package:my_widgets/utils/ui_constant.dart';
import 'package:pod_player/pod_player.dart';

import '../video_player/chewie_player.dart';

class HomeScreen extends HookConsumerWidget {
  static const route = '/home';

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final file = "https://www.youtube.com/watch?v=4AoFA19gbLo";
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Column(
            mainAxisAlignment: mainCenter,
            crossAxisAlignment: crossCenter,
            children: [
              const Text('Home Screen'),
              ElevatedButton(
                onPressed: () =>
                    context.push("${VideoPlayerScreen.route}Video"),
                child: const Text('Video Player'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChewiePlayer(
                      videoPlayerController: VideoPlayerController.network(
                        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
                      ),
                    ),
                  ),
                ),
                child: const Text('Chewie'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
