import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostButtonComponent extends StatefulWidget {
  final bool empty;
  final Function callback;
  const PostButtonComponent(
      {Key? key, required this.empty, required this.callback})
      : super(key: key);

  @override
  State<PostButtonComponent> createState() => _PostButtonComponentState();
}

class _PostButtonComponentState extends State<PostButtonComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      animationBehavior: AnimationBehavior.normal,
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.empty) {
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
    return GestureDetector(
      onTap: () {
        widget.callback();
      },
      child: Container(
        width: double.infinity,
        height: 90,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(1000)),
        child: Align(
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      20 + _controller.value * (240),
                      0,
                    ),
                    child: child,
                  );
                },
                child: Container(
                  width: 120,
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xFF9E78FF).withOpacity(0.0),
                      Color(0xFFFDFDFF),
                      Color(0xFFFFFFFF),
                      Color(0xFF9E78FF).withOpacity(0.0)
                    ], stops: const [
                      0,
                      0.4,
                      0.5,
                      1
                    ]),
                  ),
                ),
              ),
              BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10.0,
                    sigmaY: 10.0,
                  ),
                  child: Opacity(
                    opacity: 0.9,
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 400),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xFF633AF4),
                            Color(0xFF9367FF),
                            Color(0xFF633AF4)
                          ]),
                          border:
                              Border.all(width: 5, color: Color(0xFF1C1C1C)),
                          borderRadius: BorderRadius.circular(10000)),
                      padding: EdgeInsets.symmetric(vertical: 25),
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(left: 100),
                        child: Text(
                          "Publier la capsule",
                          style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              fontSize: 22),
                        ),
                      ),
                    ),
                  )),
              ClipOval(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5),
                  child: Image(
                    image: AssetImage("assets/images/rocket_button.png"),
                    height: 65,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
