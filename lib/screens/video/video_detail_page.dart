import 'package:dominhduong/screens/video/video_detail_view_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/html_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDetailPage extends StatefulWidget {
  const VideoDetailPage({Key? key}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    final article = context.read<VideoDetailViewModel>().articleModel;
    String videoId =
        YoutubePlayer?.convertUrlToId(article.description ?? '') ?? '';
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<VideoDetailViewModel>();
    final article = viewModel.articleModel;
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        aspectRatio: 16 / 9,
        progressIndicatorColor: AppColors.primaryColor,
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: PageAppBarComp(title: (viewModel.categoryName ?? 'Video').toUpperCase()),
          body: Column(
            children: [
              player,
              Expanded(
                  child: SafeArea(
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 10, bottom: 10, right: 10),
                                  child: Text(article.name ?? '',
                                      style: const TextStyle(color: AppColors.secondaryColor, fontSize: 16, fontFamily: 'RobotoSlab', fontWeight: FontWeight.w700)),
                                ),
                                HtmlContent(content: viewModel.content ?? ''),
                              ],
                            ),
                        ),
                      ],
                    ),
                  ),
              ),
            ],
          ),
        );
      },
    );
  }
}
