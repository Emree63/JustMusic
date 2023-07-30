import 'dart:io';
import 'dart:ui';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justmusic/components/back_button.dart';
import 'package:justmusic/screens/search_song_screen.dart';
import 'package:tuple/tuple.dart';
import '../components/editable_post_component.dart';
import '../components/post_button_component.dart';
import '../main.dart';
import '../model/Music.dart';
import '../model/Post.dart';
import '../values/constants.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen>
    with SingleTickerProviderStateMixin {
  final scrollController = ScrollController();
  late AnimationController _controller;

  Music? selectedMusic;
  File? selectedImage;
  Tuple2<String, String>? selectedCity;
  String? description;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    super.initState();
  }

  void _selectMusic(Music music) {
    Navigator.pop(context);
    setState(() {
      selectedMusic = music;
    });
  }

  void _selectImage(File image) {
    setState(() {
      selectedImage = image;
    });
  }

  void _descritpion(String text) {
    setState(() {
      description = text;
    });
  }

  void _selectLocation(Tuple2<String, String> location) {
    setState(() {
      selectedCity = location;
    });
  }

  void openSearchSong() {
    showModalBottomSheet(
      transitionAnimationController: _controller,
      barrierColor: Colors.black.withOpacity(0.7),
      backgroundColor: Colors.transparent,
      elevation: 1,
      constraints: const BoxConstraints(
        maxWidth: 600,
      ),
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: ((context) {
        return ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: SearchSongScreen(callback: _selectMusic));
      }),
    );
  }

  handleSubmit() async {
    await MyApp.postViewModel.addPost(
        description, (selectedMusic?.id)!, selectedImage, selectedCity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bgColor,
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 80),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                left: defaultPadding,
                right: defaultPadding,
                top: defaultPadding),
            child: Row(
              children: [BackButtonComponent()],
            ),
          ),
        ),
      ),
      body: Container(
        padding:
            const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_justMusic.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(scrollbars: false),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 100.h,
                ),
                GestureDetector(
                    onTap: openSearchSong,
                    child: EditablePostComponent(
                        music: selectedMusic,
                        callBackImage: _selectImage,
                        callBackDescription: _descritpion,
                        callBackCity: _selectLocation)),
                SizedBox(
                  height: 40.h,
                ),
                PostButtonComponent(
                  empty: selectedMusic == null,
                  callback: handleSubmit,
                ),
                SizedBox(
                  height: 40.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
