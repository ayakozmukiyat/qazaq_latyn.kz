import 'package:flutter/material.dart';
import 'package:transliterator_app/base/provider.dart';
import 'package:transliterator_app/provider/history.dart';

class HistoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseProvider<HistoryProvider>(
      model: HistoryProvider()..init(),
      builder: (context, model, snapshot) {
        return FutureBuilder(
          future: model.db.getAllTranslates(),
          builder: (context, snapshot) {
            if(!snapshot.hasData)
              return CircularProgressIndicator();
            List translates = snapshot.data;
            return ListView(
              children: translates.map((translate) => Dismissible(
                key: Key('${translate.id}'),
                onDismissed: (direction){
                  model.delete(translate, translates);
                  translates.remove(translate);
                },
                child: Card(
                  child: Column(
                    children: [
                      // ListTile(
                      //   title: Text("${translate.id}"),
                      // ),
                      ListTile(
                        title: SelectableText("${translate.cyrillic}"),
                        subtitle: SelectableText("${translate.latin}"),
                      ),
                      // ListTile(
                      //   // title: Text("Cyrillic"),
                      //   subtitle: Text("${translate.cyrillic}"),
                      // ),
                    ],
                  ),
                ),
              )).toList(),
            );
          },
        );
      }
    );
  }
}