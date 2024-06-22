
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/models/weather.dart';

class SearchViewDelegate extends SearchDelegate<String> {
  Weather weather;
  final List<String> data;

  SearchViewDelegate(this.weather,this.data);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> searchQuery = query.isEmpty ? data : data.where((element) => element.toLowerCase().contains(query.toLowerCase())).toList();
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF2E335A),
                Color(0xFF7582F4),
              ]
          )
      ),
      child: ListView.builder(
        itemCount: searchQuery.length,
        itemBuilder: (ctx,index){
          return ListTile(
            onTap: (){
              Navigator.of(context).pop('${searchQuery[index]}');
            },
            title: Text("${searchQuery[index]}"),
            trailing: const Icon(Icons.keyboard_arrow_right),
          );
        },
      ),
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> searchQuery = query.isEmpty ? data : data.where((element) => element.toLowerCase().contains(query.toLowerCase())).toList();
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF2E335A),
                Color(0xFF7582F4),
              ]
          )
      ),
      child: ListView.builder(
        itemCount: searchQuery.length,
        itemBuilder: (ctx,index){
          return ListTile(
            onTap: (){
              Navigator.of(context).pop('${searchQuery[index]}',);
            },
            title: Text("${searchQuery[index]}",style: const TextStyle(color: Colors.white),),
            trailing: const Icon(Icons.keyboard_arrow_right,color: Colors.white,),
          );
        },
      ),
    );

  }
}