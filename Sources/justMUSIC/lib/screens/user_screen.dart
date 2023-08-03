import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  child: ProfileComponent(user: widget.user),
                ),
                Align(
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
                ),
                SizedBox(
                  height: 40,
                ),
                RecapComponent()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
