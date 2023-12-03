import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justmusic/values/icons.dart';
import '../components/profile_component.dart';
import '../components/setting_part_component.dart';
import '../config/routes.dart';
import '../main.dart';
import '../values/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    void logout() {
      MyApp.userViewModel.logout();
      Navigator.of(context).push(routeWelcome());
    }

    void _openHistoric() {
      Navigator.of(context).push(routeHistoric());
    }

    void _openDetail() {
      Navigator.of(context).push(routeUser(MyApp.userViewModel.userCurrent));
    }

    void openConfirmationDelete() {
        showCupertinoModalPopup<void>(
          context: context,
          barrierColor: Colors.black.withOpacity(0.7),
          builder: (BuildContext context) => Container(
            child: CupertinoActionSheet(
              title: Text(
                'Supprimer mon compte',
                style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
              ),
              actions: <CupertinoActionSheetAction>[
                CupertinoActionSheetAction(
                  onPressed: () {
                    MyApp.userViewModel.delete();
                    Navigator.pop(context);
                    Navigator.of(context).push(routeWelcome());

                  },
                  child: Text('Confirmer', style: TextStyle(color: Colors.blue),),
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

    void openPassword() {
      Navigator.of(context).push(routePassword());
    }

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
                      "Profile",
                      style:
                          GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
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
          child: RefreshIndicator(
            displacement: 20,
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            onRefresh: _refresh,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: settingPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 68.h, bottom: 40),
                      child: ProfileComponent(user: MyApp.userViewModel.userCurrent),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12, left: defaultPadding),
                      child: Text(
                        "Compte",
                        style: GoogleFonts.plusJakartaSans(color: grayText, fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Column(
                        children: [
                          SettingPartComponent(
                            icon: JustMusicIcon.profile,
                            label: 'Compte',
                            action: _openDetail,
                          ),
                          SettingPartComponent(
                            icon: JustMusicIcon.history,
                            label: 'Historiques des capsules',
                            action: _openHistoric,
                          ),
                          SettingPartComponent(
                            icon: JustMusicIcon.password,
                            label: 'Modifier mon mot de passe',
                            action: openPassword,
                          ),
                          SettingPartComponent(
                            icon: JustMusicIcon.cross,
                            label: 'Déconnexion',
                            important: true,
                            action: logout,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> _refresh() async {
    setState(() {});
  }
}
