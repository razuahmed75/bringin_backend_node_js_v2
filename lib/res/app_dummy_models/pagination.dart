import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Pagination extends StatefulWidget {
  const Pagination({super.key});

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  late ScrollController _controller;
  @override
  void initState() {
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
    super.initState();
  }
  bool _firstLoadRunning = false;
  bool _moreLoadRunning = false;
  bool _hasNextPage = true;
  var _baseUrl = "https://jsonplaceholder.typicode.com/posts";
  int _page = 0;
  int _limit = 20;
  List _post = [];

 void _firstLoad() async{
    setState(() {
       _firstLoadRunning = true; 
    });
    
    var res = await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));
    _post = json.decode(res.body);
    setState(() {
       _firstLoadRunning = false; 
    });
  }
  void _loadMore() async{
    if(_hasNextPage == true &&
       _firstLoadRunning == false &&
       _moreLoadRunning == false &&
       _controller.position.extentAfter < 50){
        setState(() {
          _moreLoadRunning = true;
        });
        _page += 1; // increase _page by 1
       
        var res = await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));
        List fetchedAllData = json.decode(res.body);
         print("all data len is : "+fetchedAllData.length.toString());
        if(fetchedAllData.isNotEmpty){
          setState(() {
            _post.addAll(fetchedAllData);
          });
        }else{
          setState(() {
            _hasNextPage = false;
          });
        }
        setState(() {
          _moreLoadRunning = false;
        });
       }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagination"),
        centerTitle: true,
      ),
      body: _firstLoadRunning ?
      Center(
        child: CircularProgressIndicator(),
      )
      : Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: _post.length,
              itemBuilder: (_,index){
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8, horizontal: 10),
                  child: ListTile(
                    title: Text(_post[index]['title']+" "+index.toString()),
                    subtitle: Text(_post[index]['body']),
                  ),
                );
              }
            ),
          ),
          if(_moreLoadRunning == true)
          Padding(
            padding: EdgeInsets.only(bottom: 30,top: 10),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
         if(_hasNextPage == false)
         Container(
            padding: const EdgeInsets.only(top: 30, bottom: 40),
            color: Colors.amber,
            child: const Center(
              child: Text('You have fetched all of the content'),
            ),
          ),
        ],
      ),
    );
  }
}