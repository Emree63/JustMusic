import 'dart:ui';

import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/music_list_component.dart';
import '../values/constants.dart';

class SearchSongScreen extends StatefulWidget {
  const SearchSongScreen({Key? key}) : super(key: key);

  @override
  State<SearchSongScreen> createState() => _SearchSongScreenState();
}

class _SearchSongScreenState extends State<SearchSongScreen> {
  Future<void> resetFullScreen() async {
    await SystemChannels.platform.invokeMethod<void>(
      'SystemChrome.restoreSystemUIOverlays',
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
            resetFullScreen();
          }
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 25.0,
            sigmaY: 25.0,
          ),
          child: Container(
            color: bgAppBar.withOpacity(0.5),
            height: screenHeight - 50,
            padding: const EdgeInsets.only(
                top: 10, left: defaultPadding, right: defaultPadding),
            child: Column(
              children: [
                Align(
                  child: Container(
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      keyboardAppearance: Brightness.dark,
                      onEditingComplete: resetFullScreen,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'TODO';
                        }
                        return null;
                      },
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      style: GoogleFonts.plusJakartaSans(color: grayText),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                            color: grayColor,
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: grayColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          contentPadding: const EdgeInsets.only(
                              top: 0,
                              bottom: 0,
                              left: defaultPadding,
                              right: defaultPadding),
                          fillColor: searchBarColor,
                          filled: true,
                          focusColor: grayText,
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: grayColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hintText: 'Chercher un son',
                          hintStyle:
                              GoogleFonts.plusJakartaSans(color: grayColor)),
                    ),
                  ),
                ),
                Expanded(
                    child: ScrollConfiguration(
                  behavior: ScrollBehavior().copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Column(
                      children: const [
                        MusicListComponent(),
                        MusicListComponent(),
                        MusicListComponent(),
                        MusicListComponent(),
                        MusicListComponent(),
                        MusicListComponent(),
                        MusicListComponent(),
                        MusicListComponent(),
                        MusicListComponent(),
                        MusicListComponent(),
                        MusicListComponent(),
                        MusicListComponent(),
                        MusicListComponent(),
                        MusicListComponent(),
                        MusicListComponent(),
                        MusicListComponent(),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ));
  }
}
