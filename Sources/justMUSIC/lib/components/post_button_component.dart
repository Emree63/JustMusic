import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostButtonComponent extends StatelessWidget {
  const PostButtonComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF141414),
            Color(0xFF272727),
            Color(0xFF141414)
          ]),
          borderRadius: BorderRadius.circular(10000)),
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: Align(
        child: Text(
          "Publier la capsule",
          style: GoogleFonts.plusJakartaSans(
              color: Color(0xFF474747),
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic,
              fontSize: 24),
        ),
      ),
    );
  }
}
