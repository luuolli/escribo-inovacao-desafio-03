import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwars/src/core/style/styles.dart';

class NavigationitemWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final int page;
  final Function(int page)? onPageChanged;

  const NavigationitemWidget({
    Key? key,
    required this.isActive,
    required this.icon,
    required this.label,
    required this.page,
    this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
        child: ButtonBar(
          buttonPadding: EdgeInsets.zero,
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive
                  ? StarwarsColors.activedButton
                  : StarwarsColors.disabledButton,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                color: isActive
                    ? StarwarsColors.activedButton
                    : StarwarsColors.disabledButton,
              ),
            ),
          ],
        ),
      ),
      onPressed: onPageChanged != null ? () => onPageChanged!(page) : null,
    );
  }
}
