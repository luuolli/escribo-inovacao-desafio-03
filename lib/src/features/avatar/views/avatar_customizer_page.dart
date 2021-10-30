import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:fluttermoji/fluttermojiCustomizer.dart';
import 'package:starwars/src/core/core.dart';

class AvatarCustomizerPage extends StatelessWidget {
  final VoidCallback onBackPressed;
  const AvatarCustomizerPage({
    Key? key,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: StarwarsColors.backgroundDark,
      navigationBar: CupertinoNavigationBar(
        padding: const EdgeInsetsDirectional.only(top: 10),
        backgroundColor: StarwarsColors.backgroundDark,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.back,
            color: StarwarsColors.white,
          ),
          onPressed: onBackPressed,
        ),
        automaticallyImplyLeading: false,
        middle: Text(
          'Edite seu avatar',
          style: TextStyle(color: StarwarsColors.white),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FluttermojiCircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.3,
              backgroundColor: StarwarsColors.greyAccent.withOpacity(0.2),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Material(
                child: FluttermojiCustomizer(
                  outerTitleText: 'Customize',
                  scaffoldWidth: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
