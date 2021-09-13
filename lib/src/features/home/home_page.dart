// ignore_for_file: unnecessary_const

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:starwars/src/features/avatar/views/avatar_customizer_page.dart';

import '../../core/core.dart';
import '../favorites/controllers/favorite_controller.dart';
import '../favorites/views/favorite_list_view.dart';
import '../films/views/film_list_view.dart';
import '../people/views/people_list_view.dart';
import 'components/navigation_item_component.dart';

class HomePage extends StatefulWidget {
  final FavoriteStore favoriteStore;

  const HomePage({
    Key? key,
    required this.favoriteStore,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mainPageScaffoldController = PageController();
  final _pageController = PageController();

  int activePage = 0;

  final pages = [
    FilmListView(),
    PeopleListView(),
    FavoriteListView(),
  ];

  @override
  void initState() {
    super.initState();
    widget.favoriteStore.load();
  }

  void changePage(int page) {
    _pageController
        .animateToPage(
      page,
      curve: Curves.bounceInOut,
      duration: const Duration(milliseconds: 200),
    )
        .whenComplete(() {
      setState(() {
        activePage = page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: StarwarsColors.backgroundDark,
      child: PageView(
        controller: _mainPageScaffoldController,
        children: [
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: StarwarsColors.backgroundDark,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      'https://tecnoblog.net/wp-content/uploads/2021/01/star-wars-ubisoft-e1610543710572.png',
                      fit: BoxFit.cover,
                      color: StarwarsColors.backgroundDark.withOpacity(0.7),
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                  expandedHeight: 180,
                  title: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Icon(Icons.public),
                    onPressed: () {
                      Modular.to.pushNamed('starwars-web', forRoot: true);
                    },
                  ),
                  actions: [
                    CupertinoButton(
                      padding: EdgeInsets.zero.copyWith(right: 20),
                      child: FluttermojiCircleAvatar(
                        radius: 25,
                        backgroundColor: StarwarsColors.white,
                      ),
                      onPressed: () {
                        _mainPageScaffoldController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceInOut,
                        );
                      },
                    ),
                  ],
                  bottom: PreferredSize(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NavigationitemWidget(
                          isActive: activePage == 0,
                          icon: Icons.movie,
                          label: 'Filmes',
                          page: 0,
                          onPageChanged: changePage,
                        ),
                        NavigationitemWidget(
                          isActive: activePage == 1,
                          icon: Icons.emoji_people_rounded,
                          label: 'Personagens',
                          page: 1,
                          onPageChanged: changePage,
                        ),
                        NavigationitemWidget(
                          isActive: activePage == 2,
                          icon: CupertinoIcons.heart_fill,
                          label: 'Favoritos',
                          page: 2,
                          onPageChanged: changePage,
                        ),
                      ],
                    ),
                    preferredSize: const Size(double.maxFinite, 50),
                  ),
                ),
              ];
            },
            body: PageView.builder(
              physics: const BouncingScrollPhysics(),
              padEnds: false,
              controller: _pageController,
              onPageChanged: changePage,
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return pages[index];
              },
            ),
          ),
          AvatarCustomizerPage(
            onBackPressed: () {
              _mainPageScaffoldController.animateToPage(
                0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.bounceOut,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _mainPageScaffoldController.dispose();
    super.dispose();
  }
}
