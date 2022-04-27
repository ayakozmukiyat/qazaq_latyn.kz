import 'package:sembast/sembast.dart';
import 'package:transliterator_app/databases/database.dart';
import 'package:transliterator_app/models/model.dart';

class DBLogic {
  static const String STORE = 'translates';

  final _translates = intMapStoreFactory.store(STORE);

  Future<Database> get db async => await TranslatorDB.instance.db;

  Future insert(Translate translate) async {
    await _translates.add(await db, translate.toMap());
  }

  Future update(Translate translate) async {
    final finder = Finder(filter: Filter.byKey(translate.id));
    await _translates.update(
        await db,
        translate.toMap(),
        finder: finder
    );
  }

  Future delete(Translate translate) async {
    final finder = Finder(filter: Filter.byKey(translate.id));
    await _translates.delete(
        await db,
        finder: finder
    );
  }

  Future deleteAll() async {
    await _translates.delete(
        await db,
    );
  }

  Future<List<Translate>> getAllTranslates() async {
    final snapshot = await _translates.find(await db);

    return snapshot.map((map){
      final translate = Translate.fromMap(map.value);
      translate.id = map.key;
      return translate;
    }).toList();
  }
}
