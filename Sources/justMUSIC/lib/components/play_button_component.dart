import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_animated_play_button/flutter_animated_play_button.dart';
import 'package:ionicons/ionicons.dart';

class PlayButtonComponent extends StatefulWidget {
  final String? urlPreview;
  const PlayButtonComponent({Key? key, required this.urlPreview})
      : super(key: key);

  @override
  State<PlayButtonComponent> createState() => _PlayButtonComponentState();
}

class _PlayButtonComponentState extends State<PlayButtonComponent> {
  bool isPlaying = true;
  final player = AudioPlayer();
  void switchStatePlaying() {
    setState(() {
      isPlaying = !isPlaying;
    });
    stopSong();
  }

  @override
  void initState() {
    player.onPlayerComplete.listen((event) {
      switchStatePlaying();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isPlaying) {
      playSong();
    } else {}
    return isPlaying
        ? GestureDetector(
            onTap: switchStatePlaying,
            child: Container(
                width: 30,
                height: 30,
                child: Icon(
                  Ionicons.play_circle_outline,
                  color: Colors.grey.withOpacity(0.3),
                  size: 30,
                )),
          )
        : GestureDetector(
            onTap: switchStatePlaying,
            child: Container(
              width: 30,
              height: 30,
              child: AnimatedPlayButton(
                stopped: false,
                color: Colors.grey.withOpacity(0.3),
                onPressed: () {},
              ),
            ));
  }

  Future<void> playSong() async {
    if (widget.urlPreview != null) {
      await player.play(UrlSource(widget.urlPreview ?? ""));
    }
  }

  Future<void> stopSong() async {
    await player.stop();
  }
}
