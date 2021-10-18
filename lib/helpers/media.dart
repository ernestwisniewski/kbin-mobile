import 'package:kbin_mobile/repositories/api_provider.dart';

class Media {
  String getThumbUrl(String path) {
    String domain = ApiProvider().getDomain();
    return 'https://' + domain + '/media/' + path;
  }

  String getEntryThumbUrl(String path) {
    String domain = ApiProvider().getDomain();
    return 'https://' + domain + '/media/cache/entry_thumb/' + path;
  }

  String getMagazineThumbUrl(String path) {
    String domain = ApiProvider().getDomain();
    return 'https://' + domain + '/media/cache/post_thumb/' + path;
  }
}
