import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../values/constants.dart';

class SearchBarComponent extends StatefulWidget {
  final String? text;
  final VoidCallback? callback;
  const SearchBarComponent({Key? key, this.text, this.callback})
      : super(key: key);

  @override
  State<SearchBarComponent> createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.callback,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          color: searchBarColor,
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(defaultPadding, 16, defaultPadding, 16),
          child: Text(
            widget.text ?? "Chercher une musique...",
            style: GoogleFonts.plusJakartaSans(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
