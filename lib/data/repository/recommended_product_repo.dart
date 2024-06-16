import 'package:coffee_shop_project/data/api/api_client.dart';
import 'package:get/get.dart';

import '../../utils/app_contants.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async{
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);

  }
}