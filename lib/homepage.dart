import 'package:flutter/material.dart';
import 'package:umos/functions/CRUD.dart';
import 'package:umos/functions/shared_pref.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String username = '';
  String useremail = '';
  String starname = '';
  String emotion = '';
  CRUD crud = new CRUD();

  getEmotion(String email) {
      setState(() {
        crud.getEmotion(email).then((value) {
          setState(() {
            emotion = value;
          });
        });
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Helperfunctions.getUserNameSharedPreference().then((value) {
      setState(() {
        username = value!;
      });
    });
    Helperfunctions.getUserEmailSharedPreference().then((value) {
      setState(() {
        useremail = value!;
        crud.getStarName(useremail).then((value) {
          setState(() {
            starname = value!;
            print(starname);
            getEmotion(value);
          });
        });
        print(useremail);
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
          )
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              height: 56,
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: AssetImage('assets/img/umos_logo.png'),
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/8, top: 20),
                    child: RichText(
                      text: TextSpan(
                        text: 'Welcome,\n',
                        style: TextStyle(
                          color: Color(0xffF3E7FF),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: username,
                            style: TextStyle(
                              color: Color(0xffF3E7FF),
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    // height: MediaQuery.of(context).size.width,
                    // width: MediaQuery.of(context).size.width,
                    child: Image(
                      image: AssetImage('assets/img/umos_stars.png'),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Text(
                      starname,
                      style: TextStyle(
                        color: Color(0xffF3E7FF),
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top:20, bottom: 10),
              width: MediaQuery.of(context).size.width*0.9,
              height: 56,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xff5F308D),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: (){
                  Navigator.of(context).pushNamed('chatView');
                },
                child: Text('Talk with Dusty', style: TextStyle(color: Colors.white),)
              ),
            ),

            Container(
              margin: EdgeInsets.only(top:10, bottom: 20),
              width: MediaQuery.of(context).size.width*0.9,
              height: 56,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor:Color(0xffF3E7FF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: (){
                  Navigator.of(context).pushNamed('diaryView');
                
                },
                child: Text('My Mind Diary', style: TextStyle(color: Color(0xff5F308D)),)
              ),
            ),
          ],
        ),
      ),
    );
  }
}