import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class FavoriteWidget extends StatelessWidget {
  final int id;
  final FavoriteType type;
  final bool isFavorite;
  final String name;
  final Function(int, FavoriteType)? onUnfavorite;
  Color get _borderColor {
    switch (type) {
      case FavoriteType.film:
        return StarwarsColors.red;
      case FavoriteType.people:
        return StarwarsColors.green;
    }
  }

  IconData get _iconPrefix {
    switch (type) {
      case FavoriteType.film:
        return Icons.movie;
      case FavoriteType.people:
        return Icons.emoji_people_rounded;
    }
  }

  const FavoriteWidget({
    Key? key,
    required this.id,
    required this.isFavorite,
    required this.type,
    required this.name,
    this.onUnfavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: StarwarsGradient.darkGradient,
          border: Border.all(color: _borderColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(_iconPrefix, color: StarwarsColors.greyAccent1),
                  const SizedBox(width: 10),
                  Text(
                    name,
                    style: TextStyle(
                      color: StarwarsColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed:
                  onUnfavorite != null ? () => onUnfavorite!(id, type) : null,
              child: Icon(
                Icons.favorite,
                color: StarwarsColors.redFavorite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
