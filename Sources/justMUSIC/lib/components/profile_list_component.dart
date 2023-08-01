import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import '../model/User.dart';
import '../values/constants.dart';

class ProfileListComponent extends StatefulWidget {
  final User user;
  const ProfileListComponent({super.key, required this.user});

  @override
  State<ProfileListComponent> createState() => _ProfileListComponentState();
}

class _ProfileListComponentState extends State<ProfileListComponent> {
  late bool clicked;

  @override
  Widget build(BuildContext context) {
    clicked = MyApp.userViewModel.isFriend(widget.user.id);
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          ClipOval(
              child: FadeInImage.assetNetwork(
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  placeholder: "assets/images/loadingPlaceholder.gif",
                  image: widget.user.pp)),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.user.pseudo,
                  style: GoogleFonts.plusJakartaSans(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.user.uniquePseudo,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(color: Colors.grey, fontWeight: FontWeight.w400),
                    ),
                    widget.user.followed.contains(MyApp.userViewModel.userCurrent.id)
                        ? Container(
                            padding: const EdgeInsets.all(2),
                            margin: const EdgeInsets.only(left: 10),
                            decoration: const BoxDecoration(
                              color: grayColor,
                              borderRadius: BorderRadius.all(Radius.circular(3)),
                            ),
                            child: Text(
                              "Vous suit",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.grey.withOpacity(0.4), fontWeight: FontWeight.w700, fontSize: 12),
                            ),
                          )
                        : Container(),
                  ],
                )
              ],
            ),
          ),
          Spacer(),
          clicked
              ? Material(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: selectedButton,
                  child: InkWell(
                      splashColor: Colors.white.withOpacity(0.3),
                      onTap: () async {
                        await MyApp.userViewModel.addOrDeleteFriend(widget.user.id);
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
                      )))
              : Material(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: primaryColor,
                  child: InkWell(
                      splashColor: Colors.white.withOpacity(0.3),
                      onTap: () async {
                        await MyApp.userViewModel.addOrDeleteFriend(widget.user.id);
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
                      ))),
        ],
      ),
    );
  }
}
