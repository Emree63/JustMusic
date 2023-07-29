import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justmusic/components/play_button_component.dart';
import '../model/Music.dart';

class MusicListComponent extends StatelessWidget {
  final Music music;
  const MusicListComponent({
    Key? key,
    required this.music,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            if (music.cover != null) {
              return ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: FadeInImage.assetNetwork(
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                    placeholder: "assets/images/loadingPlaceholder.gif",
                    image: music.cover!),
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
            child: Wrap(
              alignment: WrapAlignment.center,
              direction: Axis.vertical,
              runSpacing: 3,
              spacing: 3,
              children: [
                Wrap(
                  verticalDirection: VerticalDirection.up,
                  spacing: 5,
                  runSpacing: 8,
                  runAlignment: WrapAlignment.end,
                  alignment: WrapAlignment.end,
                  children: [
                    Text(
                      music.title ?? "Unknown",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                    Icon(
                      Icons.explicit,
                      color: Colors.grey.withOpacity(0.7),
                      size: 17,
                    )
                  ],
                ),
                Text(
                  music.artists.first.name ?? "Unknown",
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.grey, fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          Spacer(),
          PlayButtonComponent(
            urlPreview: music.previewUrl,
          )
        ],
      ),
    );
  }
}
