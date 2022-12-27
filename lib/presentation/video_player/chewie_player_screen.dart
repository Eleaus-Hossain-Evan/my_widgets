// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewiePlayerScreen extends StatefulWidget {
  const ChewiePlayerScreen({
    required this.url,
    required this.dataSourceType,
    Key? key,
  }) : super(key: key);

  final String url;
  final DataSourceType dataSourceType;

  @override
  _ChewiePlayerScreenState createState() => _ChewiePlayerScreenState();
}

class _ChewiePlayerScreenState extends State<ChewiePlayerScreen> {
  late ChewieController _chewieController;
  late VideoPlayerController _videoPlayerController;

  init() async {
    await _videoPlayerController.initialize().then((_) {
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          aspectRatio: 16 / 9,
          // Prepare the video to be played and display the first frame
          autoInitialize: true,
          looping: false,
          autoPlay: true,
          // Errors can occur for example when trying to play a video
          // from a non-existent URL
          errorBuilder: (context, errorMessage) {
            return Center(
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();

    // final videoPlayerController = VideoPlayerController.network(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
    //   ..initialize().whenComplete(() => _chewieController = ChewieController(
    //         videoPlayerController: _videoPlayerController,
    //         aspectRatio: 16 / 9,
    //         // Prepare the video to be played and display the first frame
    //         autoInitialize: true,
    //         looping: widget.looping,
    //         // Errors can occur for example when trying to play a video
    //         // from a non-existent URL
    //         errorBuilder: (context, errorMessage) {
    //           return Center(
    //             child: Text(
    //               errorMessage,
    //               style: const TextStyle(color: Colors.white),
    //             ),
    //           );
    //         },
    //       ));

// final chewieController = ChewieController(
//   videoPlayerController: videoPlayerController,
//   autoPlay: true,
//   looping: true,
// );
    // Wrapper on top of the videoPlayerController
    // _chewieController = ChewieController(
    //   videoPlayerController: widget.videoPlayerController,
    //   aspectRatio: 16 / 9,
    //   // Prepare the video to be played and display the first frame
    //   autoInitialize: true,
    //   looping: widget.looping,
    //   // Errors can occur for example when trying to play a video
    //   // from a non-existent URL
    //   errorBuilder: (context, errorMessage) {
    //     return Center(
    //       child: Text(
    //         errorMessage,
    //         style: const TextStyle(color: Colors.white),
    //       ),
    //     );
    //   },
    // );

    switch (widget.dataSourceType) {
      case DataSourceType.asset:
        _videoPlayerController = VideoPlayerController.asset(widget.url);
        break;
      case DataSourceType.network:
        _videoPlayerController = VideoPlayerController.network(widget.url);
        break;
      case DataSourceType.file:
        _videoPlayerController = VideoPlayerController.file(File(widget.url));
        break;
      case DataSourceType.contentUri:
        _videoPlayerController =
            VideoPlayerController.contentUri(Uri.parse(widget.url));
        break;
      default:
    }

    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.dataSourceType.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _videoPlayerController.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Chewie(
                        controller: _chewieController,
                      ),
                    )
                  : const CircularProgressIndicator(),
            ),
            // Text(_chewieController.)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // IMPORTANT to dispose of all the used resources
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
