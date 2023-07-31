import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justmusic/components/play_button_component.dart';
import 'package:text_scroll/text_scroll.dart';
import '../model/Music.dart';

class MusicListComponent extends StatelessWidget {
  final Music music;
  final bool playing;
  final int index;
  final Function(int) callback;
  const MusicListComponent({
    Key? key,
    required this.music,
    required this.playing,
    required this.callback,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            if (music.cover != null) {
              return ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: music.cover != null
                    ? FadeInImage.assetNetwork(
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                        placeholder: "assets/images/loadingPlaceholder.gif",
                        image: music.cover!)
                    : Container(
                        height: 60,
                        width: 60,
                        color: Colors.grey,
                      ),
              );
            } else {
              return Image(
                image: AssetImage("assets/images/exemple_cover.png"),
                height: 60,
                width: 60,
              );
            }
          }),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Flexible(
                        flex: 8,
                        child: ScrollConfiguration(
                          behavior: ScrollBehavior().copyWith(scrollbars: false),
                          child: TextScroll(
                            music.title ?? "Unknown",
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),
                            mode: TextScrollMode.endless,
                            pauseBetween: Duration(milliseconds: 2500),
                            velocity: Velocity(pixelsPerSecond: Offset(30, 0)),
                            intervalSpaces: 10,
                          ),
                        )),
                    music.explicit
                        ? Icon(
                            Icons.explicit,
                            color: Colors.grey.withOpacity(0.7),
                            size: 17,
                          )
                        : Container(),
                  ],
                ),
                ScrollConfiguration(
                    behavior: ScrollBehavior().copyWith(scrollbars: false),
                    child: Text(
                      music.artists.first.name ?? "Unknown",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(color: Colors.grey, fontWeight: FontWeight.w400),
                    ))
              ],
            ),
          ),
          Spacer(),
          music.previewUrl != null
              ? PlayButtonComponent(
                  music: music,
                  callback: callback,
                  playing: playing,
                  index: index,
                )
              : Container()
        ],
      ),
    );
  }
}
