import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbin_mobile/routes/router.gr.dart';

CupertinoTabBar buildBottomNavbar(BuildContext context, int index) {
  return CupertinoTabBar(
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
        icon: Icon(CupertinoIcons.home),
        label: 'Treści',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.chat_bubble_2),
        label: 'Komentarze',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.square_list),
        label: 'Wpisy',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        label: 'Wyszukaj',
      ),
      // BottomNavigationBarItem(
      //   icon: Icon(CupertinoIcons.profile_circled),
      //   label: 'Profil',
      // ),
    ],
  );
}
