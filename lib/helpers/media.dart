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
}
