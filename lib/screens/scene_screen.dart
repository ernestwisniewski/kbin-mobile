import 'package:flutter/cupertino.dart';
import 'package:kbin_mobile/screens/posts_screen.dart';
import 'package:kbin_mobile/widgets/bottom_nav.dart';

import 'comments_screen.dart';
import 'entries_screen.dart';

class SceneScreen extends StatefulWidget {
  final int? index;

  const SceneScreen({Key? key, this.index}) : super(key: key);

  @override
  _SceneScreenState createState() => _SceneScreenState();
}

class _SceneScreenState extends State<SceneScreen> {
  int? _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBuilder: (BuildContext context, int i) {
          _currentIndex = _currentIndex ?? i;

          if (_currentIndex == 0) {
            _currentIndex = null;
            return const EntriesScreen();
          }
          if (_currentIndex == 1) {
            _currentIndex = null;
            return const CommentsScreen();
          }
          if (_currentIndex == 2) {
            _currentIndex = null;
            return const PostsScreen();
          }
          if (_currentIndex == 3) {
            _currentIndex = null;
          }
          return Container();
        },
        tabBar: buildBottomNavbar(context, _currentIndex ?? 0));
  }
}
