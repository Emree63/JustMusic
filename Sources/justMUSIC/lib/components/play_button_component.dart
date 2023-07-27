import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_animated_play_button/flutter_animated_play_button.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justmusic/values/constants.dart';

class PlayButtonComponent extends StatefulWidget {
  const PlayButtonComponent({Key? key}) : super(key: key);

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
            child: Icon(
              Ionicons.play_circle_outline,
              color: Colors.grey.withOpacity(0.3),
              size: 30,
            ),
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
    await player.play(UrlSource(
        'https://p.scdn.co/mp3-preview/d38052978a79adced2187cd8b6497bb10bedc452?cid=eb2aab666a43490f82eef0bb064d363f'));
  }

  Future<void> stopSong() async {
    await player.stop();
  }
}
