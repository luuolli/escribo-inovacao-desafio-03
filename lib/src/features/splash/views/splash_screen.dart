import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/core.dart';
import '../components/starwars_logo_componenent.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  FlutterLogoStyle style = FlutterLogoStyle.markOnly;
  double percentSize = 0.0;
  bool showTextPackage = false;
  @override
  void initState() {
    super.initState();
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.addPostFrameCallback(_initStart);
    }
  }

  void _initStart(_) async {
    setState(() {
      percentSize = 0.6;
    });

    Future.delayed(const Duration(seconds: 2), () {
      Modular.to.navigate('../home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: StarwarsColors.backgroundDark,
      elevation: 0,
      child: Center(
        child: PileappLogo(size: 300 * percentSize),
      ),
    );
  }
}
