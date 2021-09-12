import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controllers/people_controller.dart';
import '../people_module.dart';

class PeopleListView extends StatefulWidget {
  PeopleListView({Key? key}) : super(key: key) {
    Modular.bindModule(PeopleModule());
  }

  @override
  State<PeopleListView> createState() => _PeopleListViewState();
}

class _PeopleListViewState extends State<PeopleListView> {
  final PeopleStore peopleStore = Modular.get();
  @override
  void initState() {
    super.initState();
    peopleStore.fetchPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (peopleStore.loadingState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (peopleStore.peopleItemList == null) {
          return const Center(
            child: Icon(CupertinoIcons.person_crop_circle_badge_exclam),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
          itemBuilder: (context, index) {
            return peopleStore.peopleItemList![index];
          },
          separatorBuilder: (_, index) {
            return const SizedBox(height: 10);
          },
          itemCount: peopleStore.peopleItemList!.length,
        );
      },
    );
  }
}
