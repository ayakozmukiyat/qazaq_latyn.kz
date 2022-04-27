import 'package:transliterator_app/base/bloc.dart';
import 'package:transliterator_app/databases/crud.dart';
import 'package:transliterator_app/models/model.dart';

class HistoryProvider extends BaseBloc {
  var db = DBLogic();
  List<Translate> translates = [];
  init(){
    print('init history');
  }
  delete(translate, List translates){
    db.delete(translate);
  }
}