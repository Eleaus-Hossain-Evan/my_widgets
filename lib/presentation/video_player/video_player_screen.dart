import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pod_player/pod_player.dart';

import '../../utils/api_routes.dart';

class VideoPlayerScreen extends StatefulHookConsumerWidget {
  static const route = '/video-player';

  const VideoPlayerScreen({
    // required this.fileUrl,
    required this.title,
    Key? key,
  }) : super(key: key);

  final String fileUrl =
      "https://mazwai.com/videvo_files/video/free/2015-11/small_watermarked/9th-may_preview.webm";
  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends ConsumerState<VideoPlayerScreen> {
  late final PodPlayerController controller;

  @override
  void initState() {
    super.initState();
    Logger.v(widget.fileUrl);

    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network(
        widget.fileUrl,
      ),
    )..initialise();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Align(
                alignment: const Alignment(0, 0),
                child: PodVideoPlayer(
                  controller: controller,
                  videoTitle: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.w),
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 18.sp,
                          ),
                    ),
                  ),
                  podProgressBarConfig: PodProgressBarConfig(
                    playingBarColor: Theme.of(context).colorScheme.secondary,
                    circleHandlerColor:
                        Theme.of(context).colorScheme.tertiaryContainer,
                    backgroundColor: Colors.grey,
                  ),
                ),
              ),
              // ),
              // const Align(
              //   alignment: Alignment(-1, -1),
              //   child: BackButton(),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
