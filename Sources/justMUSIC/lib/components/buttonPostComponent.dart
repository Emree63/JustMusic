import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tuple/tuple.dart';

import '../values/constants.dart';

class PhotoPostComponent extends StatelessWidget {
  final bool empty;
  const PhotoPostComponent({Key? key, required this.empty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return empty
        ? Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: postbutton, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Ionicons.camera,
                      size: 15,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'Prendre un selfie',
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.white, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  ]),
            ))
        : Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: fillButton, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        "Selfie enregistré",
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.white, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.close,
                      size: 12,
                      color: Colors.white,
                    ),
                  ]),
            ));
  }
}

class LocationPostComponent extends StatelessWidget {
  final bool empty;
  final Tuple2<String, String>? location;
  const LocationPostComponent(
      {Key? key, required this.empty, required this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return empty
        ? Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: postbutton, borderRadius: BorderRadius.circular(8)),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 15,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'Ajouter un lieu',
                          style: GoogleFonts.plusJakartaSans(
                              color: Colors.white, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ])),
          )
        : Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: fillButton, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        '${location?.item1}, ${location?.item2}',
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.white, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.close,
                      size: 12,
                      color: Colors.white,
                    ),
                  ]),
            ),
          );
  }
}
