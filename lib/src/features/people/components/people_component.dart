import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class PeopleWidget extends StatelessWidget {
  final int id;
  final bool isFavorite;
  final String name;
  final String year;
  final Function(int id)? onFavorited;

  Color? get _favoriteColorSufix =>
      isFavorite ? StarwarsColors.redFavorite : StarwarsColors.greyAccent;

  IconData get _favoriteIconSufix =>
      isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart;

  const PeopleWidget({
    Key? key,
    required this.id,
    required this.isFavorite,
    required this.name,
    required this.year,
    this.onFavorited,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: StarwarsGradient.darkGradient,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: StarwarsColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  year,
                  style: TextStyle(
                    color: StarwarsColors.greyAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(_favoriteIconSufix, color: _favoriteColorSufix),
              onPressed: onFavorited != null ? () => onFavorited!(id) : null,
            ),
          ],
        ),
      ),
    );
  }
}
