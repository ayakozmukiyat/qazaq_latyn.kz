import 'dart:async';

import 'package:transliterator_app/databases/crud.dart';
import 'package:transliterator_app/models/model.dart';

class TranslateBloc {
  final DBLogic logic;

  StreamController<List<Translate>> _translates = StreamController.broadcast();

  StreamController<Translate> _incoming = StreamController();

  Stream<List<Translate>> get outgoing => _translates.stream;

  StreamSink<Translate> get inSink => _incoming.sink;

 TranslateBloc(this.logic) {
   _incoming.stream.listen((translates) {

   });
 }

 void dispose() {
   _incoming.close();
   _translates.close();
 }
}