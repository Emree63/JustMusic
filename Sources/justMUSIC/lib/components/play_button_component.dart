import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_animated_play_button/flutter_animated_play_button.dart';
import 'package:ionicons/ionicons.dart';

import '../model/Music.dart';

class PlayButtonComponent extends StatefulWidget {
  final Music music;
  final Function callback;
  final int index;
  bool playing;
  PlayButtonComponent(
      {Key? key,
      required this.music,
      required this.callback,
      required this.playing,
      required this.index})
      : super(key: key);

  @override
  State<PlayButtonComponent> createState() => _PlayButtonComponentState();
}

class _PlayButtonComponentState extends State<PlayButtonComponent> {
  final player = AudioPlayer();
  void switchStatePlaying() {
    setState(() {
      widget.playing = !widget.playing;
    });
    widget.music.stopSong();
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
    if (widget.playing) {
      widget.music.playSong();
    } else {}
    return !widget.playing
        ? GestureDetector(
            onTap: () {
              widget.callback(widget.index);
            },
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
}
