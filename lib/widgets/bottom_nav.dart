import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/routes/router.gr.dart';

Widget buildBottomNavbar(BuildContext context, int index) {
  return BottomNavigationBar(
    unselectedFontSize: 12,
    selectedFontSize: 12,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    unselectedItemColor: Colors.grey,
    selectedItemColor: (KbinColors()).getBottomNavSelectedColor(context),
    currentIndex: index,
    onTap: (int i) {
      if (index == i) {
        return;
      }

      context.router.popUntilRoot();

      switch (i) {
        case 0:
          context.router.replace(const EntriesRoute());
          break;
        case 1:
          context.router.replace(const CommentsRoute());
          break;
        case 2:
          context.router.replace(const PostsRoute());
          break;
        case 3:
          context.router.replace(const SearchRoute());
          break;
      }
    },
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Treści',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.comment),
        label: 'Komentarze',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.article),
        label: 'Wpisy',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Wyszukaj',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profil',
      ),
    ],
  );
}
