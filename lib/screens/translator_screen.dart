import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transliterator_app/base/provider.dart';
import 'package:transliterator_app/provider/theme_manager.dart';
import 'package:transliterator_app/provider/transliterator.dart';
import 'package:transliterator_app/widgets/speaker.dart';
import 'package:provider/provider.dart';

import 'history_screen.dart';



class TranslatorScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BaseProvider<TranslatorProvider>(
      model: TranslatorProvider(),
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildFirstSection(model: model),
                Divider(),
                _buildTextField(model: model),
                model.inOtherAlphabet == ''
                    ? SizedBox()
                    : _buildText(model: model, ctx: context),
                model.isTranslated
                    ? _buildTranslated(model: model)
                    : const SizedBox()
              ],
            ),
          ),
        );
      },
    );
  }

  _buildFirstSection({TranslatorProvider model}) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () {},
              child: SizedBox.expand(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    model.isCyrillicToLatin ? 'Cyrillic' : 'Latin alphabet',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                model.swapAlphabet();
              },
              child: SizedBox.expand(
                child: Icon(Icons.swap_horiz),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () {},
              child: SizedBox.expand(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    !model.isCyrillicToLatin ? 'Cyrillic' : 'Latin alphabet',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildTextField({TranslatorProvider model}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        //color: const Color.fromRGBO(249, 248, 255, 1),
        border: Border.all(
          color: const Color.fromRGBO(169, 140, 225, 1.0),
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SpeakerWidget(
                  text: model.isCyrillicToLatin
                      ? model.enteredStringController.text
                      : model.inOtherAlphabet,
                  language: 'ru-RU',
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  model.isCyrillicToLatin ? 'In Cyrillic': 'In the Latin alphabet',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                Spacer(),
                IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      model.clear();
                    })
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              autocorrect: true,
              cursorColor: Color.fromRGBO(249, 6, 64, 1),
              controller: model.enteredStringController,
              maxLength: 5000,
              onChanged: (value) => model.transliterate(value),
              buildCounter: (context, {currentLength, isFocused, maxLength}) =>
                  Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "$currentLength из $maxLength",
                  style: TextStyle(
                    fontSize: 10,
                    color: const Color.fromRGBO(169, 140, 225, 1),
                  ),
                ),
              ),
              minLines: 1,
              maxLines: 5,
              cursorRadius: Radius.circular(2),
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                  filled: true,
                  //fillColor: const Color.fromRGBO(249, 248, 255, 1),
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                  hintText: 'Enter the text',
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(169, 140, 225, 1), fontSize: 13)),
            ),
          ],
        ),
      ),
    );
  }

  _buildText({TranslatorProvider model, BuildContext ctx}) {
    return Builder(
      builder: (context) {
        return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              //color: const Color.fromRGBO(249, 248, 255, 1),

            ),
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: SelectableText(model.inOtherAlphabet),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: MaterialButton(
                    onPressed: () {
                      model.translate();
                      //print(" value ${model.isDarkMode}");
                      //DataForApp.openDb();
                    },
                    color: Theme.of(ctx).buttonColor,
                    // color: model.getThemeForButton(context.read<ThemeNotifier>().isDarkMode),
                    // textColor: Colors.white,
                    child: Icon(
                      Icons.forward,
                      size: 20,
                    ),
                    padding: EdgeInsets.all(0),
                    shape: CircleBorder(),
                  ),
                )
              ],
            ));
      }
    );
  }

  _buildTranslated({TranslatorProvider model}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        border: Border.all(
          color: const Color.fromRGBO(169, 140, 225, 1),
          width: 1.0,
        ),
        //color: const Color.fromRGBO(241, 237, 151, 1.0),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SpeakerWidget(
                text: model.inRussian,
                language: 'ru-RU',
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Перевод на русском',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          SelectableText(model.inRussian),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SpeakerWidget(
                text: model.inEnglish,
                language: 'en-US',
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'In english',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          SelectableText(
            model.inEnglish,
          ),
        ],
      ),
    );
  }
}



