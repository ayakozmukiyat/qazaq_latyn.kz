import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SpeakerWidget extends StatefulWidget {
  final String text;
  final String language;
  const SpeakerWidget({Key key, this.text, this.language = 'ru-RU'}) : super(key: key);

  @override
  _SpeakerWidgetState createState() => _SpeakerWidgetState();
}

class _SpeakerWidgetState extends State<SpeakerWidget> {
  FlutterTts flutterTts;
  double volume = 0.7;
  double pitch = 1.0;
  double rate = 1;

  bool isPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTts();
  }
  initTts() async {
    flutterTts = FlutterTts();
  }

  Future _speak() async{
    //print('started');
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);
    await flutterTts.setLanguage(widget.language);

    if(widget.text != null) {
      if(widget.text.isNotEmpty){
        setState(() {
          isPlaying = true;
        });
        await flutterTts.awaitSpeakCompletion(true);
        await flutterTts.speak(widget.text).whenComplete(() => setState(() {
          isPlaying = false;
          // fluprint('completed');
        }));
      }
    }
  }

  Future _stop() async {
    await flutterTts.stop();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: isPlaying? Icon(Icons.stop) : Icon(Icons.volume_up),
      onTap: (){
        isPlaying? _stop(): _speak();
      },
    );
  }
}
