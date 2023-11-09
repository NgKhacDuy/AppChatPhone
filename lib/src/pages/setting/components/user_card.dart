import 'package:app_chat/src/config/app_theme.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final Color? backgroundColor;
  final Color? settingColor;
  final double? cardRadius;
  final Color? backgroundMotifColor;
  final Widget? cardActionWidget;
  final String? userName;
  final Widget? userMoreInfo;
  final Widget userProfilePic;
  final void Function()? onPressedAvatar;

  const UserCard({
    super.key,
    this.backgroundColor,
    this.settingColor,
    this.cardRadius = 30,
    required this.userName,
    this.backgroundMotifColor = Colors.white,
    this.cardActionWidget,
    this.userMoreInfo,
    required this.userProfilePic,
    this.onPressedAvatar,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    return Container(
      height: mediaQueryHeight / 4,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).cardColor,
        borderRadius:
            BorderRadius.circular(double.parse(cardRadius!.toString())),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: backgroundMotifColor!.withOpacity(.1),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 400,
              backgroundColor: backgroundMotifColor!.withOpacity(.05),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: (cardActionWidget != null)
                  ? MainAxisAlignment.spaceEvenly
                  : MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // User profile
                    GestureDetector(
                      onTap: () => onPressedAvatar?.call(),
                      child: userProfilePic,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userName!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: mediaQueryHeight / 30,
                            color: Colors.white,
                          ),
                        ),
                        if (userMoreInfo != null) ...[
                          userMoreInfo!,
                        ],
                      ],
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: settingColor ?? Theme.of(context).cardColor,
                  ),
                  child: (cardActionWidget != null)
                      ? cardActionWidget
                      : Container(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
