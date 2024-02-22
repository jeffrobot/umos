import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:umos/functions/CRUD.dart';
import 'package:umos/functions/shared_pref.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final gemini = Gemini.instance;
  String result = '';
  bool isloading = false;
  String? emotion = "";

  //get emotions
  Future<void> getEmotion() async {
    Helperfunctions.getUserEmailSharedPreference().then((value){
      setState(() {
        crud.getEmotion(value!).then((value) {
          setState(() {
            emotion = value;
          });
        });
      });
    });
  }

  List<Content> msgs = [];

  TextEditingController messageController = TextEditingController();

  SpeechToText speech = SpeechToText();
  bool isListening = false;
  bool _speechEnabled = false;
  String username = '';
  CRUD crud = new CRUD();
  // String _lastWords = '';

  

void listenForPermissions() async {
    final status = await Permission.microphone.status;
    switch (status) {
      case PermissionStatus.denied:
        requestForPermission();
        break;
      case PermissionStatus.granted:
        break;
      case PermissionStatus.limited:
        break;
      case PermissionStatus.permanentlyDenied:
        break;
      case PermissionStatus.restricted:
        break;
      case PermissionStatus.provisional:
        // TODO: Handle this case.
    }
  }
  Future<void> requestForPermission() async {
    await Permission.microphone.request();
  }
  

void _initSpeech() async {
    _speechEnabled = await speech.initialize();
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await speech.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 300),
      localeId: "en_En",
      cancelOnError: false,
      partialResults: false,
      listenMode: ListenMode.confirmation,
    );
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await speech.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      // _lastWords = "$_lastWords${result.recognizedWords} ";
      messageController.text = result.recognizedWords;
    });
  }

  @override
  void initState() {
    super.initState();
    //getEmotion().then((value) => print(emotion));
    // getEmotion().then((value){
    //   if(emotion != ''){
    //     print(emotion);
    //     msgs.add(
    //       Content(
    //         parts: [
    //           Parts(
    //             text: "Your task is to act like a supportive friend. $emotion and you will listen to my problems. Give some realistic advices in a friendly manner, which is not in bullet points and talk to me like a real friend. Do NOT give results like a list of role play scripts. I would like you to start by asking how I feel today. Do not say something like “think me as” such things seem unnatural. Do not say things like “Remember, I am …”"
    //             )
    //         ],
    //       role: 'user'
    //       ),
    //     );
    //   } else {
        msgs.add(
          Content(
            parts: [
              Parts(
                text: "Your task is to act like a supportive friend. You will listen to my problems and give some realistic advices in a friendly manner, which is not in bullet points and talk to me like a real friend. Do NOT give results like a list of role play scripts. I would like you to start by asking how I feel today. Do not say something like “think me as” such things seem unnatural. Do not say things like “Remember, I am …”"
                )
            ],
          role: 'user'
          ),
        );
    //   }
    // });
    Helperfunctions.getUserNameSharedPreference().then((value) {
      setState(() {
        username = value!;
      });
    });
    
    listenForPermissions();
    if (!_speechEnabled) {
      _initSpeech();
    }
    gemini.chat(
      msgs,
      )
        .then((value) {
      setState(() {
        isloading = false;
        result = value?.output ?? 'without output';
        msgs.add(Content(parts: [Parts(text: result)], role: 'model'));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/img/galaxy.png'),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 56,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.only(left: 8),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                itemCount: msgs.length - 1, // Start from index 1 to skip the first prompt
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        height: 56,
                        width: 56,
                        child: (msgs[index + 1].role.toString() == 'model') ? Image(
                          image: AssetImage('assets/img/umos_tut1.png'),
                        ):Container(),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(msgs[index + 1].parts?[0].text.toString() ?? '', style: TextStyle(color: Color(0xffF3E7FF)),), // Adjust index
                          subtitle: (msgs[index + 1].role.toString()=='model') ?
                          Text('Dusty', style: TextStyle(color: Colors.white),) :
                          Text(username, style: TextStyle(color: Colors.white),)//Text(msgs[index + 1].role.toString()), // Adjust index
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
      
            Container(
              color: Color(0xffF3E7FF),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap:(){
                      if(isListening){
                        _stopListening();
                        isListening = false;
                      }
                      else{
                        _startListening();
                        isListening = true;
                      }
                    },
                    // onLongPressStart: (details) {
                    //   _startListening();
                    // },
                    // onLongPressEnd: (details) {
                    //   _stopListening();
                    // },
                    child: Text(
                      isListening ? 'Touch to stop':'Touch to speak',
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    )
                  ),
                  TextButton(
                    onPressed: () {
                      if(!messageController.text.isEmpty){
                        sendMessage(messageController.text);
                      } else{
                        SnackBar(content: Text('Please enter a message'));
                      }
                    },
                    child: Text('Send'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage(String message) {
    setState(() {
      isloading = true;
    });
    msgs.add(Content(parts: [Parts(text: message)], role: 'user'));

    gemini.chat(
      msgs,
      )
        .then((value) {
      setState(() {
        isloading = false;
        result = value?.output ?? 'without output';
        msgs.add(Content(parts: [Parts(text: result)], role: 'model'));
      });
    });

    // Clear the input field after sending a message
    messageController.clear();
  }
}
