// ignore_for_file: constant_identifier_names

enum NetworkRoutes {
  DEFAULT,
  LOGIN,
}

extension NetworkRoutesString on NetworkRoutes {
  String get rawValue {
    switch (this) {
      case NetworkRoutes.DEFAULT:
        return '';
      case NetworkRoutes.LOGIN:
        return 'account/v1/login';
      default:
        throw Exception('Routes Not Found');
    }
  }
}
