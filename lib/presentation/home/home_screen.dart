import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_widgets/presentation/video_player/batter_player_screen.dart';
import 'package:my_widgets/presentation/video_player/video_player_screen.dart';
import 'package:my_widgets/utils/ui_constant.dart';
import 'package:pod_player/pod_player.dart';

import '../video_player/chewie_player_screen.dart';
import '../video_player/youtube_player_screen.dart';

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
                    builder: (context) => const ChewiePlayerScreen(
                      // url:
                      //     "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
                      url:
                          "https://mazwai.com/videvo_files/video/free/2015-11/small_watermarked/9th-may_preview.webm",
                      dataSourceType: DataSourceType.contentUri,
                    ),
                  ),
                ),
                child: const Text('Chewie'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NormalPlayerPage(),
                  ),
                ),
                child: const Text('Batter player'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => YoutubeVideoScreen(),
                  ),
                ),
                child: const Text('Youtube'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
