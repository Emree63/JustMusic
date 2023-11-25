import 'package:flutter/material.dart';

import '../main.dart';
import '../model/Music.dart';

class ButtonPlayComponent extends StatefulWidget {
  final Music music;
  const ButtonPlayComponent({super.key, required this.music});

  @override
  State<ButtonPlayComponent> createState() => _ButtonPlayComponentState();
}

class _ButtonPlayComponentState extends State<ButtonPlayComponent> {
  bool isPlaying = false;

  @override
  void initState() {
    MyApp.audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isPlaying) {
          widget.music.stopSong();
          setState(() {
            isPlaying = !isPlaying;
          });
        } else {
          widget.music.playSong();
          setState(() {
            isPlaying = !isPlaying;
          });
        }
      },
      child: Icon(
        isPlaying ? Icons.pause_circle : Icons.play_circle,
        color: Colors.white,
        size: 45,
      ),
    );
  }
}
