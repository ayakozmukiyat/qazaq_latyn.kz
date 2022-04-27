import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:transliterator_app/base/bloc.dart';
import 'package:transliterator_app/databases/crud.dart';
import 'package:transliterator_app/models/model.dart';
import 'common_util.dart';

class TranslatorProvider extends BaseBloc {
  bool isCyrillicToLatin = true;

  TextEditingController enteredStringController = TextEditingController();
  final translator = GoogleTranslator();
  String inRussian = '';
  String inEnglish = '';
  String inOtherAlphabet = '';
  bool isTranslated = false;
  var db = DBLogic();

  translate() async {
    var cyrillic = isCyrillicToLatin? enteredStringController.text : inOtherAlphabet;
    var latin = !isCyrillicToLatin? enteredStringController.text : inOtherAlphabet;

    await translator
        .translate(cyrillic, from: 'kk', to: 'ru')
        .then((inRu) async {
      await translator
          .translate(cyrillic, from: 'kk', to: 'en')
          .then((inEn) {
        inEnglish = inEn.text;
        inRussian = inRu.text;
        isTranslated = true;

        var translateModel = Translate(
          latin: latin,
          cyrillic: cyrillic
        );
        db.insert(translateModel);
        notifyListeners();
      });
    });
  }

  transliterate(String value) {
    if (isCyrillicToLatin) {
      inOtherAlphabet = translateToLatin(value);
    } else
      inOtherAlphabet = translateToCyrillic(value);
    notifyListeners();
  }

  swapAlphabet() {
    isCyrillicToLatin = !isCyrillicToLatin;
    String str = enteredStringController.text;
    enteredStringController.text = inOtherAlphabet;
    inOtherAlphabet = str;
    notifyListeners();
  }

  void clear() {
    var cyrillic = isCyrillicToLatin? enteredStringController.text : inOtherAlphabet;
    var latin = !isCyrillicToLatin? enteredStringController.text : inOtherAlphabet;
    var translateModel = Translate(
        latin: latin,
        cyrillic: cyrillic
    );
    db.insert(translateModel);
    enteredStringController = new TextEditingController();
    inOtherAlphabet = '';
    isTranslated = false;
    notifyListeners();
  }
}
