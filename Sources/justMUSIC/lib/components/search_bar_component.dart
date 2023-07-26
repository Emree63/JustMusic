import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../values/constants.dart';

class SearchBarComponent extends StatefulWidget {
  final String? text;
  const SearchBarComponent({Key? key, this.text}) : super(key: key);

  @override
  State<SearchBarComponent> createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Container(
        color: searchBarColor,
        width: double.infinity,
        padding:
            EdgeInsets.fromLTRB(defaultPadding, 16.sp, defaultPadding, 16.sp),
        child: Text(
          widget.text ?? "Chercher une musique...",
          style: GoogleFonts.plusJakartaSans(color: Colors.white),
        ),
      ),
    );
  }
}
