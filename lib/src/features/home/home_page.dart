// ignore_for_file: unnecessary_const

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwars/src/core/core.dart';
import 'package:starwars/src/features/films/views/film_list_view.dart';
import 'package:starwars/src/features/home/components/navigation_item_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController();
  int activedPage = 0;

  final pages = [
    FilmListView(),
    Container(color: StarwarsColors.redFavorite),
    Container(color: StarwarsColors.blue),
  ];

  void changePage(int page) {
    setState(() {
      activedPage = page;
    });
    _pageController.animateToPage(
      activedPage,
      curve: Curves.bounceInOut,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: StarwarsColors.backgroundDark,
      child: PageView(
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
                  title: const CupertinoButton(
                      child: Icon(Icons.public), onPressed: null),
                  actions: const [
                    CupertinoButton(child: Icon(Icons.person), onPressed: null),
                  ],
                  bottom: PreferredSize(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NavigationitemWidget(
                          isActive: activedPage == 0,
                          icon: Icons.movie,
                          label: 'Filmes',
                          page: 0,
                          onPageChanged: changePage,
                        ),
                        NavigationitemWidget(
                          isActive: activedPage == 1,
                          icon: Icons.emoji_people_rounded,
                          label: 'Personagens',
                          page: 1,
                          onPageChanged: changePage,
                        ),
                        NavigationitemWidget(
                          isActive: activedPage == 2,
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
              itemCount: pages.length,
              onPageChanged: changePage,
              itemBuilder: (context, index) {
                return pages[index];
              },
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}
