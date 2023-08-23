import 'dart:async';
import 'dart:ui';

import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justmusic/model/Music.dart';

import '../components/music_list_component.dart';
import '../values/constants.dart';
import '../main.dart';

class SearchSongScreen extends StatefulWidget {
  final Function callback;
  const SearchSongScreen({Key? key, required this.callback}) : super(key: key);

  @override
  State<SearchSongScreen> createState() => _SearchSongScreenState();
}

class _SearchSongScreenState extends State<SearchSongScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  PageController controller = PageController();
  bool isCollectionSelected = false;

  int? playingIndex;

  Future<void> resetFullScreen() async {
    await SystemChannels.platform.invokeMethod<void>(
      'SystemChrome.restoreSystemUIOverlays',
    );
  }

  @override
  void initState() {
    super.initState();
    fetchTrendingMusic();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> fetchTrendingMusic() async {
    await MyApp.musicViewModel.getMusicsWithPlaylistId('37i9dQZF1DX1X23oiQRTB5').then((value) {
      setState(() {
        filteredData = value;
      });
    });
  }

  Future<void> _scrollListener() async {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      filteredData.addAll(await MyApp.musicViewModel
          .getMusicsWithName(_textEditingController.text, limit: 10, offset: filteredData.length));
      setState(() {
        filteredData = filteredData;
      });
    }
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
    if (_scrollController.offset <= _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        Timer(Duration(milliseconds: 1), () => _scrollController.jumpTo(0));
      });
    }
  }

  List<Music> filteredData = [];

  void playMusic(int index) {
    if (playingIndex == index) {
      setState(() {
        playingIndex = null;
      });
    } else {
      setState(() {
        playingIndex = index;
      });
    }
  }

  _changePage(int index) {
    /*if (isCollectionSelected) {
      setState(() {
        isCollectionSelected = !isCollectionSelected;
        controller.animateTo(1, duration: Duration(milliseconds: 200), curve: Curves.easeOut);
      });
    } else {
      setState(() {
        isCollectionSelected = !isCollectionSelected;
        controller.animateTo(0, duration: Duration(milliseconds: 200), curve: Curves.easeOut);
      });
    }*/
  }

  Future<List<Music>> _fetchSavedSong() async {
    return await MyApp.musicViewModel.getFavoriteMusicsByUserId(MyApp.userViewModel.userCurrent.id);
  }

  @override
  void dispose() {
    MyApp.audioPlayer.pause();
    super.dispose();
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
                          color: Color(0xFF3A3A3A).withOpacity(0.6), borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: _textEditingController,
                      keyboardAppearance: Brightness.dark,
                      onEditingComplete: resetFullScreen,
                      onSubmitted: (value) async {
                        if (_textEditingController.text.isEmpty) {
                          fetchTrendingMusic();
                        } else {
                          setState(() {
                            filteredData = [];
                          });
                          filteredData = await MyApp.musicViewModel.getMusicsWithNameOrArtistName(value);
                          setState(() {
                            filteredData = filteredData;
                          });
                        }
                        controller.animateTo(0, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
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
                              borderSide: BorderSide(width: 1, color: grayColor),
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          contentPadding:
                              const EdgeInsets.only(top: 0, bottom: 0, left: defaultPadding, right: defaultPadding),
                          fillColor: searchBarColor,
                          filled: true,
                          focusColor: grayText,
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: grayColor),
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          hintText: 'Chercher un son',
                          hintStyle: GoogleFonts.plusJakartaSans(color: grayHint)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: _changePage(0),
                        child: Text(
                          "Recherche",
                          style: GoogleFonts.plusJakartaSans(
                              color: isCollectionSelected ? Color(0xFF9A9A9A) : Colors.white,
                              fontWeight: isCollectionSelected ? FontWeight.w500 : FontWeight.w700),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: _changePage(1),
                        child: Text("Collection",
                            style: GoogleFonts.plusJakartaSans(
                                color: isCollectionSelected ? Colors.white : Color(0xFF9A9A9A),
                                fontWeight: isCollectionSelected ? FontWeight.w700 : FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
                Flexible(
                    child: PageView(
                  controller: controller,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      if (index == 1) {
                        isCollectionSelected = true;
                      } else {
                        isCollectionSelected = false;
                      }
                    });
                  },
                  children: [
                    ScrollConfiguration(
                      behavior: ScrollBehavior().copyWith(scrollbars: true),
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
                          controller: _scrollController,
                          itemCount: filteredData.length,
                          itemBuilder: (context, index) {
                            if (playingIndex == index) {
                              return InkWell(
                                  onTap: () {
                                    widget.callback(filteredData[index]);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: MusicListComponent(
                                      music: filteredData[index],
                                      playing: true,
                                      callback: playMusic,
                                      index: index,
                                    ),
                                  ));
                            }
                            return InkWell(
                                onTap: () {
                                  widget.callback(filteredData[index]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: MusicListComponent(
                                    music: filteredData[index],
                                    playing: false,
                                    callback: playMusic,
                                    index: index,
                                  ),
                                ));
                          }),
                    ),
                    ScrollConfiguration(
                      behavior: ScrollBehavior().copyWith(scrollbars: true),
                      child: FutureBuilder(
                        future: _fetchSavedSong(),
                        builder: (BuildContext context, AsyncSnapshot<List<Music>> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data?.length == 0) {
                              return Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Votre collection est vide.",
                                        style: GoogleFonts.plusJakartaSans(
                                            color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
                                      ),
                                    ),
                                    Image.asset(
                                      "assets/images/empty_collection.png",
                                      width: 300,
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return ListView.builder(
                                  physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
                                  controller: _scrollController,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) {
                                    if (playingIndex == index) {
                                      return InkWell(
                                          onTap: () {
                                            widget.callback((snapshot.data?[index])!);
                                          },
                                          onLongPress: () {
                                            showCupertinoModalPopup<void>(
                                              context: context,
                                              builder: (BuildContext context) => CupertinoAlertDialog(
                                                title: const Text('Supprimer la musique'),
                                                content: Text(
                                                    'Etes-vous sur de vouloir supprimer ${(snapshot.data?[index])!.title} de votre collection?'),
                                                actions: <CupertinoDialogAction>[
                                                  CupertinoDialogAction(
                                                    /// This parameter indicates this action is the default,
                                                    /// and turns the action's text to bold text.
                                                    isDefaultAction: true,
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Annuler'),
                                                  ),
                                                  CupertinoDialogAction(
                                                    /// This parameter indicates the action would perform
                                                    /// a destructive action such as deletion, and turns
                                                    /// the action's text color to red.
                                                    isDestructiveAction: true,
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                                                      await MyApp.musicViewModel
                                                          .addOrDeleteFavoriteMusic((snapshot.data?[index])!.id);
                                                      MyApp.userViewModel.userCurrent.musics_likes
                                                          .remove((snapshot.data?[index])!.id);

                                                      MyApp.audioPlayer.release();
                                                      setState(() {
                                                        playingIndex = null;
                                                      });
                                                    },
                                                    child: const Text('Supprimer'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: MusicListComponent(
                                              music: (snapshot.data?[index])!,
                                              playing: true,
                                              callback: playMusic,
                                              index: index,
                                            ),
                                          ));
                                    }
                                    return InkWell(
                                        onTap: () {
                                          widget.callback((snapshot.data?[index])!);
                                        },
                                        onLongPress: () {
                                          showCupertinoModalPopup<void>(
                                            context: context,
                                            builder: (BuildContext context) => CupertinoAlertDialog(
                                              title: const Text('Supprimer la musique'),
                                              content: Text(
                                                  'Etes-vous sur de vouloir supprimer ${(snapshot.data?[index])!.title} de votre collection?'),
                                              actions: <CupertinoDialogAction>[
                                                CupertinoDialogAction(
                                                  /// This parameter indicates this action is the default,
                                                  /// and turns the action's text to bold text.
                                                  isDefaultAction: true,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Annuler'),
                                                ),
                                                CupertinoDialogAction(
                                                  /// This parameter indicates the action would perform
                                                  /// a destructive action such as deletion, and turns
                                                  /// the action's text color to red.
                                                  isDestructiveAction: true,
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                    await MyApp.musicViewModel
                                                        .addOrDeleteFavoriteMusic((snapshot.data?[index])!.id);
                                                    MyApp.userViewModel.userCurrent.musics_likes
                                                        .remove((snapshot.data?[index])!.id);
                                                    setState(() {});
                                                  },
                                                  child: const Text('Supprimer'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          child: MusicListComponent(
                                            music: (snapshot.data?[index])!,
                                            playing: false,
                                            callback: playMusic,
                                            index: index,
                                          ),
                                        ));
                                  });
                            }
                          } else {
                            return CupertinoActivityIndicator();
                          }
                        },
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}
