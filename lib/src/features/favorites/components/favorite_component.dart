import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwars/src/shared/shared.dart';

class FavoriteWidget extends StatelessWidget {
  final bool isFavorite;
  final FavoriteType type;
  final String name;

  Color get _borderColor {
    switch (type) {
      case FavoriteType.movie:
        return StarwarsColors.red;
      case FavoriteType.personage:
        return StarwarsColors.green;
    }
  }

  IconData get _iconPrefix {
    switch (type) {
      case FavoriteType.movie:
        return Icons.movie;
      case FavoriteType.personage:
        return Icons.emoji_people_rounded;
    }
  }

  const FavoriteWidget({
    Key? key,
    required this.isFavorite,
    required this.type,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            onPressed: null,
            child: Icon(
              Icons.favorite,
              color: StarwarsColors.redFavorite,
            ),
          ),
        ],
      ),
    );
  }
}
