import 'package:advanced_ecommerce_app/data/models/app_model.dart';
import 'package:advanced_ecommerce_app/utiles/constants.dart';
import 'package:dio/dio.dart';

class AppWebServices {
  late Dio dio;

  AppWebServices() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseURL,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 60 seconds,
      receiveTimeout: 20 * 1000,
    );
    dio=Dio(baseOptions);
  }

  Future<Map<String,dynamic>> getPopularProducts() async {
    try {
      Response response = await dio.get(Constants.popularEndPoint);
      return response.data;
    } catch (e) {
      return {};
    }
  }

  Future<Map<String,dynamic>> getRecommendedProducts() async {
    try {
      Response response = await dio.get(Constants.recommendedEndPoint);
      return response.data;
    } catch (e) {
      return {};
    }
  }

}
