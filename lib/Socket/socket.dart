import 'dart:async';

class StreamSocket{
  final _socketResponse= StreamController<String>();

  void Function(String) get addchannellist => _socketResponse.sink.add;
  Stream<String> get getchannellist => _socketResponse.stream;

  void dispose(){
    _socketResponse.close();
  }
}