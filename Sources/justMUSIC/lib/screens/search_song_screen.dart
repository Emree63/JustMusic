import 'dart:async';
import 'dart:ui';

import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justmusic/model/Music.dart';

import '../components/music_list_component.dart';
import '../values/constants.dart';
import '../main.dart';

class SearchSongScreen extends StatefulWidget {
  const SearchSongScreen({Key? key}) : super(key: key);

  @override
  State<SearchSongScreen> createState() => _SearchSongScreenState();
}

class _SearchSongScreenState extends State<SearchSongScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  Future<void> resetFullScreen() async {
    await SystemChannels.platform.invokeMethod<void>(
      'SystemChrome.restoreSystemUIOverlays',
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _scrollListener() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      filteredData.addAll(await MyApp.musicViewModel.getMusicsWithName(
          _textEditingController.text,
          limit: 10,
          offset: filteredData.length));
      setState(() {
        filteredData = filteredData;
      });
    }
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        Timer(Duration(milliseconds: 1), () => _scrollController.jumpTo(0));
      });
    }
  }

  List<Music> filteredData = [];

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
            sigmaX: 60.0,
            sigmaY: 60.0,
          ),
          child: Container(
            color: bgAppBar.withOpacity(0.5),
            height: screenHeight - 50,
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Align(
                  child: Container(
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Color(0xFF3A3A3A).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: _textEditingController,
                      keyboardAppearance: Brightness.dark,
                      onEditingComplete: resetFullScreen,
                      onChanged: (value) async {
                        if (_textEditingController.text.isEmpty) {
                        } else if (value == " ") {
                          print("popular");
                        } else {
                          filteredData = await MyApp.musicViewModel
                              .getMusicsWithName(value);
                          setState(() {
                            filteredData = filteredData;
                          });
                        }
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
                Flexible(
                    child: ScrollConfiguration(
                  behavior: ScrollBehavior().copyWith(scrollbars: true),
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: MusicListComponent(music: filteredData[index]),
                        );
                      }),
                ))
              ],
            ),
          ),
        ));
  }
}
