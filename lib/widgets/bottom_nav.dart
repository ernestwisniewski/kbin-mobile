import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/helpers/colors.dart';
import 'package:kbin_mobile/routes/router.gr.dart';

Widget buildBottomNavbar(BuildContext context, int index) {
  return BottomNavigationBar(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    unselectedItemColor: Colors.grey,
    selectedItemColor: (KbinColors()).getBottomNavSelectedColor(context),
    currentIndex: index,
    onTap: (int i) {
      if (index == i) {
        return;
      }

      switch (i) {
        case 0:
          context.router.replace(const MenuRoute());
          break;
        case 1:
          context.router.replace(const EntriesRoute());
          break;
        case 2:
          context.router.replace(const CommentsRoute());
          break;
        case 3:
          context.router.replace(const PostsRoute());
          break;
      }
    },
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Menu',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.format_list_bulleted),
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
        icon: Icon(Icons.person),
        label: 'Profil',
      ),
    ],
  );
}
