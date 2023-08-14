import 'dart:io';

import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../components/profile_component.dart';
import '../components/recap_component.dart';
import '../main.dart';
import '../model/User.dart';
import '../values/constants.dart';

class UserScreen extends StatefulWidget {
  final User user;
  const UserScreen({super.key, required this.user});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late bool isClicked;
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source, imageQuality: 20);
      if (image == null) return;
      final imageTemp = File(image.path);
      await MyApp.userViewModel.updateImage(imageTemp);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Votre photo de profile a bien été mise à jour",
            style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15.h),
          ),
          backgroundColor: primaryColor,
          closeIconColor: Colors.white,
        ),
      );
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void manageImage() {
    if (image != null) {
      setState(() {
        image = null;
      });
    } else {
      _showActionSheet(context);
    }
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) => Container(
        color: Colors.black,
        child: CupertinoActionSheet(
          title: Text(
            'Ajouter une photo',
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
          ),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              onPressed: () {
                pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              child: const Text('Galerie'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
              child: const Text('Prendre un selfie'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Annuler'),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    isClicked = MyApp.userViewModel.isFriend(widget.user.id);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 58),
        child: Container(
          height: double.infinity,
          color: bgAppBar,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 30,
                      width: 30,
                      child: Image(
                        image: AssetImage("assets/images/return_icon.png"),
                        height: 8,
                      ),
                    )),
                Align(
                  child: Text(
                    widget.user.pseudo,
                    style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: bgColor,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: settingPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 68.h, bottom: 40),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ProfileComponent(user: widget.user),
                      MyApp.userViewModel.userCurrent.id == widget.user.id
                          ? Padding(
                              padding: const EdgeInsets.only(left: 70, bottom: 10),
                              child: GestureDetector(
                                onTap: () {
                                  _showActionSheet(context);
                                },
                                child: ClipOval(
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    color: grayColor,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                MyApp.userViewModel.userCurrent.id != widget.user.id
                    ? Align(
                        alignment: Alignment.topCenter,
                        child: isClicked
                            ? SizedBox(
                                // Définir une largeur minimale pour le bouton "Ajouter"
                                width: 120, // Réglez cette valeur en fonction de vos besoins
                                child: Material(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    color: selectedButton,
                                    child: InkWell(
                                        splashColor: Colors.white.withOpacity(0.3),
                                        onTap: () async {
                                          await MyApp.userViewModel.addOrDeleteFriend(widget.user.id);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Vous ne suivez plus ${widget.user.pseudo}",
                                                style: GoogleFonts.plusJakartaSans(
                                                    color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20.h),
                                              ),
                                              backgroundColor: Colors.red,
                                              closeIconColor: Colors.white,
                                            ),
                                          );
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(28, 7, 28, 7),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(7))),
                                          child: Center(
                                            child: Text("Ajouté",
                                                style: GoogleFonts.plusJakartaSans(
                                                    color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
                                          ),
                                        ))),
                              )
                            : SizedBox(
                                // Définir une largeur minimale pour le bouton "Ajouter"
                                width: 120, // Réglez cette valeur en fonction de vos besoins
                                child: Material(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    color: primaryColor,
                                    child: InkWell(
                                        splashColor: Colors.white.withOpacity(0.3),
                                        onTap: () async {
                                          await MyApp.userViewModel.addOrDeleteFriend(widget.user.id);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              backgroundColor: primaryColor,
                                              content: Text(
                                                "Vous suivez à present ${widget.user.pseudo}",
                                                style: GoogleFonts.plusJakartaSans(
                                                    color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20.h),
                                              ),
                                            ),
                                          );
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(25, 7, 25, 7),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(7))),
                                          child: Center(
                                            child: Text("Ajouter",
                                                style: GoogleFonts.plusJakartaSans(
                                                    color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
                                          ),
                                        )))),
                      )
                    : Container(),
                SizedBox(
                  height: 40,
                ),
                RecapComponent(user: widget.user)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
