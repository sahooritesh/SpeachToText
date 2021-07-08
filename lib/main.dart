import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:txtspeach/webview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SpeechToTextScreen(),
    );
  }
}

class SpeechToTextScreen extends StatefulWidget {
  const SpeechToTextScreen({ Key key }) : super(key: key);

  @override
  _SpeechToTextScreenState createState() => _SpeechToTextScreenState();
}

class _SpeechToTextScreenState extends State<SpeechToTextScreen> {

final Map<String,HighlightedWord> _highlights={
  'jerry':HighlightedWord(
    onTap: ()=>print("Jerry"),
    textStyle: const TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold
    )
  ),

  'flutter':HighlightedWord(
    onTap: ()=>print("Flutter"),
    textStyle: const TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold
    )
  ),
  'voice':HighlightedWord(
    onTap: ()=>print("voice"),
    textStyle: const TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold
    )
  ),
  'welcome':HighlightedWord(
    onTap: ()=>print("welcome"),
    textStyle: const TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold
    )
  ),
  'Ritesh':HighlightedWord(
    onTap: ()=>print("Ritesh"),
    textStyle: const TextStyle(
      color: Colors.green,
      fontWeight: FontWeight.bold
    )
  ),
  'whats':HighlightedWord(
    onTap: ()=>print("what\'s up"),
    textStyle: const TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.bold
    )
  ),
  'google':HighlightedWord(
    onTap: ()=>print("what\'s up"),
    textStyle: const TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.bold
    )
  ),

};


  stt.SpeechToText _speech;
  bool _isListning=false;
  String _text="Press the button and start speaking";
  double _confidence=1.0;
  bool _done=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speech=stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Confidence ${(_confidence*100).toStringAsFixed(1)}"),
      ),
      floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat ,
      floatingActionButton: AvatarGlow(
        animate: true,//_isListning,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
              child: FloatingActionButton(
            
          onPressed:(){
             _listen();
             if(_done){
               Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context)=>
                  Webb(_text))
                );

             }
          },
          child: Icon(
            _isListning?Icons.mic:Icons.mic_none
          ),
        ),
      ),
      body:SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 150),
          child: TextHighlight(
            text: _text,
            words: _highlights,
            textStyle: const TextStyle(
              fontSize: 32,
              color: Colors.black,
              fontWeight: FontWeight.w400
            ),
          ),
        ),
      ) ,
      
    );
  }

  void _listen() async{
    if(!_isListning){
      _done=false;
      bool available=await _speech.initialize(
        onStatus: (val)=>print('onStatus:$val'),
        onError: (val)=>print('onError:$val'),
      );
      if(available){
        setState((){
          _isListning=true;
        });
        _speech.listen(
          onResult:(val)=>setState((){
            _done=true;
            _text=val.recognizedWords;
            if(val.hasConfidenceRating && val.confidence>0){
              _confidence=val.confidence;
            }
          }) 
          );
      }
    }
    else{
      setState(()=>_isListning=false);
      _speech.stop();
      // _done=true;
    }
  }


}
