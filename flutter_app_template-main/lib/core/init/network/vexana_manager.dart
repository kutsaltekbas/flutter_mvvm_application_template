
import 'package:vexana/vexana.dart';

import '../../base/model/base_response_model.dart';

class VexanaManager {
  static VexanaManager? _instace;
  static VexanaManager get instance {
    if (_instace != null) return _instace!;
    _instace = VexanaManager._init();
    return _instace!;
  }

  VexanaManager._init();

  static get baseUrl => '';

  static get devUrl => '';

  static get localUrl => '';

  static BaseOptions get getOptions => BaseOptions(
        followRedirects: false,
        validateStatus: (status) {
          if (status == 401) {
            return false;
          }
          return status! < 500;
        },
        baseUrl: baseUrl,
      );

  INetworkManager networkManager = NetworkManager<BaseResponseModel>(
    isEnableLogger: true,
    options: getOptions,
  );
}
