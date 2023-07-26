import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/editable_post_component.dart';
import '../components/post_button_component.dart';
import '../components/search_bar_component.dart';
import '../values/constants.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bgColor,
      body: Container(
          padding: EdgeInsets.only(
              left: defaultPadding, top: defaultPadding, right: defaultPadding),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_justMusic.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 150.h,
                    ),
                    EditablePostComponent(),
                    SizedBox(
                      height: 40.sp,
                    ),
                    PostButtonComponent(),
                    SizedBox(
                      height: 40.sp,
                    ),
                  ],
                ),
              ),
              SearchBarComponent(),
            ],
          )),
    );
  }
}
