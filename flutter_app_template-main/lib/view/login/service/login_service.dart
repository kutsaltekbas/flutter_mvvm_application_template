import 'package:vexana/vexana.dart';

import '../../../../core/base/model/base_response_model.dart';
import '../../../../core/utility/service_helper.dart';
import '../../../core/constants/enums/network_route_enum.dart';
import '../model/login_model.dart';
import 'i_login_service.dart';

class LoginService extends ILoginService with ServiceHelper {
  LoginService(INetworkManager manager) : super(manager);

  @override
  Future<BaseResponseModel?> postLogin(LoginModel model) async {
    var response = await requestJson(
      manager,
      NetworkRoutes.LOGIN,
      RequestType.POST,
      dataModel: model,
      isLogin: true,
      token: false,
    );
    return response;
  }
}
