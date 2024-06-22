import 'dart:convert';

import 'package:http/http.dart' as http;
class CitysHttpServices{

  Future<List<String>> getCitys() async{
    List<String> citys = [];
    final api = Uri.parse("https://countriesnow.space/api/v0.1/countries/population/cities");
    final response = await http.get(api);
    List data = jsonDecode(response.body)['data'] as List;
    final citysResponse = jsonDecode(response.body)['data'];
    for(int i = 0;i < data.length;i++)
      if(citysResponse[i]['city'] != 'null' && citysResponse[i]['city'] != 'based')
        citys.add(citysResponse[i]['city']);
    List<String> uzbekistanProvinces = [
      'Andijon',
      'Bukhara',
      'Jizzakh',
      'Karakalpakstan',
      'Qashqadaryo',
      'Tashkent',
    ];

    for(int i = 0;i < uzbekistanProvinces.length;i++)
      citys.add(uzbekistanProvinces[i]);
    return citys;
  }
}