import 'package:flutter/cupertino.dart';

class PileappLogo extends StatelessWidget {
  final double size;

  PileappLogo({required this.size});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: size,
      height: size,
      curve: Curves.elasticOut,
      duration: Duration(seconds: 2),
      child: Image.asset(
        'assets/logo.png',
      ),
    );
  }
}
