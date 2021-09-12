import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class FilmWidget extends StatelessWidget {
  final bool isFavorite;
  final String title;
  final int episodeId;
  final String releaseDate;
  final Function(bool)? onFavorted;

  Color? get _favoriteColorSufix =>
      isFavorite ? StarwarsColors.redFavorite : null;

  IconData get _favoriteIconSufix =>
      isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart;

  const FilmWidget({
    Key? key,
    required this.isFavorite,
    required this.title,
    required this.episodeId,
    required this.releaseDate,
    this.onFavorted,
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
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: StarwarsColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Episódio $episodeId",
                      style: TextStyle(
                        color: StarwarsColors.greyAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 40),
                    Text(
                      releaseDate,
                      style: TextStyle(
                        color: StarwarsColors.greyAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(_favoriteIconSufix, color: _favoriteColorSufix),
              onPressed:
                  onFavorted != null ? () => onFavorted!(!isFavorite) : null,
            ),
          ],
        ),
      ),
    );
  }
}
