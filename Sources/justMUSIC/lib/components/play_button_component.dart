import 'package:flutter/Material.dart';
import 'package:flutter_animated_play_button/flutter_animated_play_button.dart';
import 'package:ionicons/ionicons.dart';

import '../main.dart';
import '../model/Music.dart';

class PlayButtonComponent extends StatefulWidget {
  final Music music;
  final Function callback;
  final int index;
  final bool playing;
  const PlayButtonComponent(
      {Key? key, required this.music, required this.callback, required this.playing, required this.index})
      : super(key: key);

  @override
  State<PlayButtonComponent> createState() => _PlayButtonComponentState();
}

class _PlayButtonComponentState extends State<PlayButtonComponent> {
  @override
  void initState() {
    MyApp.audioPlayer.onPlayerComplete.listen((event) {
      widget.callback(widget.index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !widget.playing
        ? GestureDetector(
            onTap: () {
              widget.music.playSong();
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
            onTap: () {
              widget.music.stopSong();

              widget.callback(widget.index);
            },
            child: Container(
              width: 30,
              height: 30,
              child: AnimatedPlayButton(
                stopped: false,
                color: Colors.grey.withOpacity(0.3),
                onPressed: () {
                  print("cc");
                },
              ),
            ));
  }
}
