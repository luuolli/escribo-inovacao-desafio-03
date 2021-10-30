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
<<<<<<< HEAD
      case FavoriteType.movie:
        return Icons.movie;
      case FavoriteType.personage:
=======
      case FavoriteType.film:
        return Icons.movie;
      case FavoriteType.people:
>>>>>>> f0d34f2f41b911bd1593f9ec4f01d2fb3a2db59a
        return Icons.emoji_people_rounded;
    }
  }

  const FavoriteWidget({
    Key? key,
<<<<<<< HEAD
    required this.isFavorite,
    required this.type,
    required this.name,
=======
    required this.id,
    required this.isFavorite,
    required this.type,
    required this.name,
    this.onUnfavorite,
>>>>>>> f0d34f2f41b911bd1593f9ec4f01d2fb3a2db59a
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
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
>>>>>>> f0d34f2f41b911bd1593f9ec4f01d2fb3a2db59a
      ),
    );
  }
}
