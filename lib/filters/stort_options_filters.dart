enum SortOptions { hot, newest, top, active, commented }

extension ParseToString on SortOptions {
  String toParam() {
    return toString().split('.').last;
  }
}
