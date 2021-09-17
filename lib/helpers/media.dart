import 'package:kbin_mobile/providers/api_provider.dart';

class Media {
  String getThumbUrl(String path) {
    String domain = ApiProvider().getDomain();
    return 'https://' + domain + '/media/' + path;
  }
}
