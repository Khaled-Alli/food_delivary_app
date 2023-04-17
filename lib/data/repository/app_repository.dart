
import 'package:advanced_ecommerce_app/data/web_services/app_web_service.dart';

import '../models/app_model.dart';

class AppRepository{
  AppWebServices appWebServices;
  AppRepository(this.appWebServices);

  Future<AppModel> getPopularProducts()async{
    final popularProducts= await appWebServices.getPopularProducts();
     return AppModel.fromJson(popularProducts);
  }

  Future<AppModel> getRecommendedProducts()async{
    final recommendedProducts= await appWebServices.getRecommendedProducts();
     return AppModel.fromJson(recommendedProducts);
  }
}