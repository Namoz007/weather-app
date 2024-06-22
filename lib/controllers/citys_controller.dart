import 'package:weather/services/citys_http_services.dart';

class CitysController{
  final controller = CitysHttpServices();

  Future<List<String>> getCitys() async{
    return await controller.getCitys();
  }
}