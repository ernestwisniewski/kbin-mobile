import 'package:flutter/material.dart';

class Media {
  String getThumbUrl(String path, String domain) {
    return 'https://' + domain + '/media/' + path;
  }

  String getEntryThumbUrl(String path, String domain) {
    return 'https://' + domain + '/media/cache/entry_thumb/' + path;
  }

  String getMagazineThumbUrl(String path, String domain) {
    return 'https://' + domain + '/media/cache/post_thumb/' + path;
  }

  Widget getImage(url, BoxFit? fit, double? size) {
    try {
      return Image.network(
        url,
        fit: fit ?? BoxFit.none,
        width: size,
      );
    } catch (e) {
      return Container();
    }
  }
}
