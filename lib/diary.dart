import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:umos/functions/CRUD.dart';
import 'package:umos/functions/shared_pref.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  final TextEditingController _textEditingController = TextEditingController();
  List<String> _diaryEntries = [];
  CRUD crud = new CRUD();
  String email = '';
  Gemini gemini = Gemini.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Helperfunctions.getUserEmailSharedPreference().then((value) {
      setState(() {
        email = value!;
        crud.getDiary(email).then((value) {
          setState(() {
            _diaryEntries = value;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('My Diary',style: TextStyle(color: Color(0xffF3E7FF)),),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil('mainView', (route) => false);
            },
            icon: Icon(Icons.home, color: Color(0xffF3E7FF),
          ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text(
                'Diary Entries',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 24,
                ),
              ),
            ),
            for (String entry in _diaryEntries)
              ListTile(
                title: Text(entry),
              ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/galaxy.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 60,
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffF3E7FF),
                  width: 3,
                ),
              ),
              child: TextField(
                style: TextStyle(
                  color: Color(0xffF3E7FF),
                ),
                controller: _textEditingController,
                maxLines: null,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  hintText: 'Write your diary entry here...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Color(0xffF3E7FF), // Set border color here
                      //width: MediaQuery.of(context).size. * 3 / 4, // Set border width here (3/4 of screen width)
                    ),
                    borderRadius: BorderRadius.circular(8.0), // Adjust border radius as needed
                  ),
                ),
              ),
            ),

            SizedBox(height: 16),
            Container(
                margin: EdgeInsets.only(top:50, bottom: 50),
                width: MediaQuery.of(context).size.width*0.9,
                height: 56,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xff5F308D),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: (){
                    crud.createDiary(email, _textEditingController.text).then((value){
                      _textEditingController.clear();
                    });
                    gemini.text(
                      "'${_textEditingController.text}'. From this diary, give me a single line summary of how he or she feels. Start with 'I feel ...'"
                    ).then((value){
                      print(value?.content?.parts?.last.text);
                      crud.addOrUpdateEmotion(email, value?.content?.parts?.last.text.toString() ?? '');
                    });
                  
                  },
                  child: Text('Save Entry', style: TextStyle(color: Colors.white),)
                ),
              ),
          ],
        ),
      ),
    );
  }
}