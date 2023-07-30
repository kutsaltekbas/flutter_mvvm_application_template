import 'dart:io';
import 'package:flutter_mvvm_app_template/core/extension/string_extension.dart';

import '../constants/enums/locale_keys_enum.dart';
import '../constants/enums/network_route_enum.dart';
import '../init/navigation/route_stream.dart';
import '../init/network/vexana_manager.dart';
import '../init/lang/locale_keys.g.dart';
import 'package:vexana/vexana.dart';
import '../base/model/base_response_model.dart';
import '../base/model/file_model.dart';
import '../init/cache/locale_manager.dart';
import 'package:dio/dio.dart' as dio;

abstract class ServiceHelper {
  requestJson<T extends INetworkModel, R>(
    INetworkManager manager,
    NetworkRoutes route,
    RequestType method, {
    dynamic dataModel,
    String? language,
    bool token = true,
    bool isLogin = false,
    T? dataParser,
    String? urlSuffix = '',
  }) async {
    Options? options;
    if (token) {
      if (isLogin) {
        options = Options(headers: {
          'Authorization': LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN),
          'language': LocaleManager.instance.getStringValue(PreferencesKeys.LANGUAGE),
        });
      } else {
        options = Options(headers: {
          'Authorization': LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN),
          'language': LocaleManager.instance.getStringValue(PreferencesKeys.LANGUAGE),
        });
      }
    } else {
      options = Options(headers: {'language': LocaleManager.instance.getStringValue(PreferencesKeys.LANGUAGE)});
    }

    dynamic dataModelJson;

    if (dataModel != null) {
      dataModelJson = dataModel.toJson();
    }

    var response = await manager.send<BaseResponseModel, BaseResponseModel>(
      route.rawValue,
      parseModel: BaseResponseModel(),
      method: method,
      options: options,
      data: dataModelJson,
      urlSuffix: urlSuffix,
    );

    if (response.data is BaseResponseModel) {
      final data = response.data!.data;
      if (dataParser != null && data is List) {
        response.data!.data = responseParser<T, List<T>>(dataParser, response.data!.data);
      } else if (dataParser != null && data is Map) {
        response.data!.data = responseParser<T, T>(dataParser, response.data!.data);
      }
      return response.data;
    } else {
      if (response.error != null) {
        if (response.error!.statusCode != null) {
          if (response.error!.statusCode == HttpStatus.unauthorized) {
            kickUnauthorized();
            final errorModel = errorParser<BaseResponseModel, BaseResponseModel>(BaseResponseModel(), response.error!.model.toString());
            return errorModel;
          } else if (response.error!.statusCode! < HttpStatus.internalServerError) {
            final errorModel = errorParser<BaseResponseModel, BaseResponseModel>(BaseResponseModel(), response.error!.description);
            return errorModel;
          }
        } else {
          return BaseResponseModel(
            type: false,
            message: response.error!.description ?? LocaleKeys.something_went_wrong.locale,
          );
        }
      }
    }
  }

  requestFormData<T extends INetworkModel, R>(
    INetworkManager manager,
    NetworkRoutes route,
    RequestType method, {
    List<MapEntry<String, List<FileModel>?>>? files,
    dynamic data,
    bool token = true,
    T? dataParser,
    String? urlSuffix = '',
  }) async {
    Map<String, dynamic> options;
    if (token) {
      options = {
        "Authorization": LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN),
        "language": LocaleManager.instance.getStringValue(PreferencesKeys.LANGUAGE),
        "Content-Type": "multipart/form-data",
      };
    } else {
      options = {"Content-Type": "multipart/form-data"};
    }

    var formData = dio.FormData();

    if (data != null) {
      formData = FormData.fromMap({
        'data': data,
      });
    }

    if (files != null) {
      if (files.isNotEmpty) {
        formData.files.addAll(files
            .cast<MapEntry<String, List<FileModel>?>>()
            .map((file) {
              return file.value!.map(
                (e) => MapEntry(
                  file.key,
                  MultipartFile.fromFileSync(e.path, filename: e.filename),
                ),
              );
            })
            .expand((i) => i)
            .toList());
      }
    }

    final dio.Response response;
    BaseResponseModel result;
    try {
      if (method == RequestType.POST) {
        response = await postFormData('${route.rawValue}$urlSuffix', formData, headers: options);
      } else if (method == RequestType.PUT) {
        response = await putFormData('${route.rawValue}$urlSuffix', formData, headers: options);
      } else {
        return BaseResponseModel(
          type: false,
          message: LocaleKeys.something_went_wrong.locale,
        );
      }

      final responseStatusCode = response.statusCode ?? HttpStatus.notFound;

      if (responseStatusCode >= HttpStatus.ok && responseStatusCode <= HttpStatus.multipleChoices) {
        final parsedModel = responseParser<BaseResponseModel, BaseResponseModel>(
          BaseResponseModel(),
          response.data,
        );

        result = BaseResponseModel(data: parsedModel);
      } else if (responseStatusCode == HttpStatus.unauthorized) {
        result = BaseResponseModel(error: BaseErrorResponseModel(description: response.data.toString(), statusCode: responseStatusCode));
      } else {
        result = BaseResponseModel(
          error: BaseErrorResponseModel(
            description: response.data.toString(),
            statusCode: responseStatusCode,
          ),
        );
      }
    } on DioError catch (e) {
      final errorResponse = e.response;
      final errorModel = BaseResponseModel(
          error: BaseErrorResponseModel(
        description: e.message,
        statusCode: errorResponse != null ? errorResponse.statusCode : HttpStatus.internalServerError,
      ));
      print(e);
      errorModel.data = errorResponse!.data;
      result = BaseResponseModel(error: errorModel.error);
    }

    if (result.data is BaseResponseModel) {
      final data = result.data!.data;
      if (dataParser != null && data is List) {
        result.data!.data = responseParser<T, List<T>>(dataParser, result.data!.data);
      } else if (dataParser != null && data is Map) {
        result.data!.data = responseParser<T, T>(dataParser, result.data!.data);
      }
      return result.data;
    } else {
      if (result.error != null) {
        if (result.error!.statusCode == HttpStatus.unauthorized) {
          kickUnauthorized();
          final errorModel = errorParser<BaseResponseModel, BaseResponseModel>(BaseResponseModel(), result.error!.toString());
          return errorModel;
        } else if (result.error!.statusCode! < HttpStatus.internalServerError) {
          final errorModel = errorParser<BaseResponseModel, BaseResponseModel>(BaseResponseModel(), result.error!.description);
          return errorModel;
        } else {
          return BaseResponseModel(
            type: false,
            message: LocaleKeys.something_went_wrong.locale,
          );
        }
      }
    }
  }

  Future<dio.Response<T>> postFormData<T>(String path, FormData data, {Map<String, dynamic>? headers}) async {
    return await dio.Dio(
      VexanaManager.getOptions,
    ).post<T>(path, data: data, options: Options(headers: headers));
  }

  Future<dio.Response<T>> putFormData<T>(String path, FormData data, {Map<String, dynamic>? headers}) async {
    return await dio.Dio(
      VexanaManager.getOptions,
    ).put<T>(path, data: data, options: Options(headers: headers));
  }

  void kickUnauthorized() {
    LocaleManager.instance.setStringValue(PreferencesKeys.TOKEN, '');

    streams.triggerMethod();
  }

  R? responseParser<T extends INetworkModel, R>(T model, dynamic data) {
    if (data is List) {
      return data.map((e) => model.fromJson(e)).toList().cast<T>() as R;
    } else if (data is Map) {
      return model.fromJson(data as Map<String, dynamic>) as R;
    }
    return data as R?;
  }

  R? errorParser<T, R>(BaseResponseModel model, dynamic data) {
    var dataSp = data.replaceAll('{', '').replaceAll('}', '').split(',');
    var mapData = <String, dynamic>{};
    dataSp.forEach((element) {
      mapData[element.split(':')[0].replaceAll(' ', '')] = element.split(':')[0].replaceAll(' ', '') == 'status'
          ? element.split(':')[1].replaceAll(' ', '').toString().parseBool
          : element.split(':')[1];
    });

    return model.fromJson(mapData) as R;
  }
}

extension StringLocalization on String {
  bool get parseBool => toLowerCase() == 'true';
}
