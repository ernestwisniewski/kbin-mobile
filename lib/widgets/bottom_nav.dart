import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

CupertinoTabBar buildBottomNavbar(BuildContext context, int index) {

  return CupertinoTabBar(
    currentIndex: index,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.square_list),
        label: 'Treści',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.chat_bubble_2),
        label: 'Komentarze',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.text_badge_plus),
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
