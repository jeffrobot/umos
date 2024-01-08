import 'package:flutter/material.dart';
import 'package:umos/registration.dart';
import 'package:umos/chatbot.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
    await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UMOS',
      initialRoute: 'homeView',
      routes: {
        'homeView': (context) => MyHomePage(),
        'registrationView': (context) => RegistrationPage(),
        'chatbotView': (context) => MyChatbotPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image(
                      image: AssetImage('assets/img/galaxy.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    child: Image(
                      image: AssetImage('assets/img/umos_logo.png'),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                      margin: EdgeInsets.only(bottom: 40),
                      width: MediaQuery.of(context).size.width*0.9,
                      height: 56,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xff5F308D),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    
                        ),
                        onPressed: (){
                          Navigator.of(context).pushNamed('registrationView');
                        }, 
                        child: Text('Start', style: TextStyle(fontFamily: "NotoSansKR", color: Colors.white),)
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 50),
                      width: MediaQuery.of(context).size.width*0.9,
                      height: 56,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 48, 141, 119),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    
                        ),
                        onPressed: (){
                          Navigator.of(context).pushNamed('chatbotView');
                        }, 
                        child: Text('chatbot', style: TextStyle(fontFamily: "NotoSansKR", color: Colors.white),)
                      ),
                    )
                ]
      ),
                ]
      )
    )
    );
  }
}
