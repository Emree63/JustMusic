import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

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
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Ionicons.camera,
                    size: 15,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Prendre un selfie',
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.white, fontSize: 12),
                  )
                ]),
          )
        : Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: fillButton, borderRadius: BorderRadius.circular(8)),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Selfie enregistré",
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.white, fontSize: 12),
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
          );
  }
}

class LocationPostComponent extends StatelessWidget {
  final bool empty;
  const LocationPostComponent({Key? key, required this.empty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return empty
        ? Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: postbutton, borderRadius: BorderRadius.circular(8)),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 15,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Ajouter un lieu',
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.white, fontSize: 12),
                  )
                ]),
          )
        : Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: fillButton, borderRadius: BorderRadius.circular(8)),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Lieu enregistré",
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.white, fontSize: 12),
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
          );
  }
}
