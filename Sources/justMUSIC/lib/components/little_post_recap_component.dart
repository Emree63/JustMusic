import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../values/constants.dart';

class LittleCapsule extends StatelessWidget {
  final bool isEmpty;
  final DateTime date;
  const LittleCapsule({super.key, required this.isEmpty, required this.date});

  @override
  Widget build(BuildContext context) {
    if (isEmpty) {
      return Flexible(
        child: Container(
          constraints: BoxConstraints(maxWidth: 45, maxHeight: 45),
          decoration: BoxDecoration(
            color: searchBarColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Color(0xFF282828), width: 1),
          ),
          child: const Center(
            child: Icon(
              Icons.rocket_launch,
              color: Color(0xFF464646),
              size: 18,
            ),
          ),
        ),
      );
    }
    return Flexible(
      child: Container(
        constraints: BoxConstraints(maxWidth: 45, maxHeight: 45),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [bgModal, bgModal.withOpacity(0)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 1]),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            date.day.toString(),
            style: GoogleFonts.plusJakartaSans(color: Color(0xFF464646), fontWeight: FontWeight.w800, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
