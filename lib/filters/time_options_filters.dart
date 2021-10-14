enum TimeOptions { fromall, from6h, from12h, from1d, from1w, from1m, from1y }

extension ParseToString on TimeOptions {
  String toParam() {
    return toString().split('.').last.split('from').last;
  }
}
