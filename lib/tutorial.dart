import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:umos/functions/CRUD.dart';
import 'package:umos/functions/shared_pref.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String username = "";
  String email ="";
  TextEditingController starnameController = TextEditingController();
  CRUD crud = CRUD();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    Helperfunctions.getUserNameSharedPreference().then((value) {
      setState(() {
        username = value!;
      });
    });
    Helperfunctions.getUserEmailSharedPreference().then((value) {
      setState(() {
        email = value!;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CarouselSlider(
        items: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xffF3E7FF)
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: MediaQuery.of(  context).size.width*0.1,
                  bottom: MediaQuery.of(context).size.height*0.3,
                  child: Image(
                    image: AssetImage(
                      'assets/img/umos_tut2.png',
                    ),
                  ).animate().move().shake().shake(),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height*0.24,
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height*0.24,
                    width: MediaQuery.of(context).size.width*0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Hello, ',
                          ),
                          TextSpan(
                            text: '$username\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: SizedBox(height: 20)
                          ),
                          TextSpan(
                            text: 'Thank you for visiting\n'
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: SizedBox(height: 20)
                          ),
                          TextSpan(
                            text: 'Your Cosmos, ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'UMOS.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]
                      ),
                    ),
                  ).animate().fadeIn().move(),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xffF3E7FF)
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: MediaQuery.of(  context).size.width*0.1,
                  bottom: MediaQuery.of(context).size.height*0.3,
                  child: Image(
                    image: AssetImage(
                      'assets/img/umos_tut3.png',
                    ),
                  ).animate().shakeY().shakeY(),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height*0.24,
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height*0.24,
                    width: MediaQuery.of(context).size.width*0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'UMØS is always here \n',
                          ),
                          
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: SizedBox(height: 20)
                          ),
                          TextSpan(
                            text: 'by your side, $username.\n'
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: SizedBox(height: 20)
                          ),
                          TextSpan(
                            text: 'for your better days.\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: SizedBox(height: 40)
                          ),
                          TextSpan(
                            text: 'Feel free to visit anytime!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]
                      ),
                    ),
                  ).animate().fadeIn().move(),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/img/galaxy.png'),
                )
              ),
            child: Center(
              child: Text(
                  "We are currently traveling through the cosmos.",
                  style: TextStyle(
                    color: Colors.white,
                  )
              ).animate().fadeIn(
                duration: Duration(seconds: 2)
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/img/galaxy.png'),
                )
              ),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'This cosmos belongs to ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: "$username's mind\n",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.baseline,
                        baseline: TextBaseline.alphabetic,
                        child: SizedBox(height: 30)
                      ),
                      TextSpan(
                        text: 'Now, you become the master of\n',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'this cosmos and nurture it beautifully.\n',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.baseline,
                        baseline: TextBaseline.alphabetic,
                        child: SizedBox(height: 50)
                      ),
                      TextSpan(
                        text: 'Engage in UMOS programs for\n',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'emotional care, journaling, and walks\n',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'to grow and decorate your stars',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),

                      
                    ]
                  ),
                  
              ).animate().fadeIn(
                duration: Duration(seconds: 2)
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/img/galaxy.png'),
                )
              ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "The beautiful stars that embroider\nthe night sky aren't big and bright\nfrom the beginning.\n",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: SizedBox(height: 30)
                          ),
                          TextSpan(
                            text: "Stars are born from\nspecks of cosmic dust.'",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]
                      ),
                  ).animate().fadeIn(
                    duration: Duration(seconds: 2)
                  ),

                  SizedBox(height: 50,),
                  Image(image: AssetImage('assets/img/umos_stars.png'),),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/img/galaxy.png'),
                )
              ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "To transform this dust\ninto a shining celestial body,\nyour continual interest\nand involvement are crucial.",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          
                        ]
                      ),
                  ).animate().fadeIn(
                    duration: Duration(seconds: 2)
                  ),

                  SizedBox(height: 50,),
                  CarouselSlider(
                    carouselController: CarouselController(),
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height*0.5,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: false,
                      initialPage: 0,
                      autoPlay: true,
                    ),
                    items: [
                      Image(image: AssetImage('assets/img/umos_stars2.png'),).animate().fadeIn(),
                      Image(image: AssetImage('assets/img/umos_stars3.png'),).animate().fadeIn(),
                      Image(image: AssetImage('assets/img/umos_stars4.png'),).animate().fadeIn(),
                    ]
                  )
                ],
              ),
            ),
          ),
          Container(
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "First, would you like to give\na name to your cherished star?",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              
                            ]
                          ),
                      ).animate().fadeIn(
                        duration: Duration(seconds: 2)
                      ),
                      SizedBox(height: 50,),
                      Image(
                        image: AssetImage('assets/img/umos_stars.png'),
                      ).animate().fadeIn(),
                      SizedBox(height: 50,),
                      Container(
                        width: MediaQuery.of(context).size.width*0.9,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                
                                child: TextFormField(
                                  controller: starnameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.purple, width: 3),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintText: 'E.g Stellar',
                                    hintStyle: TextStyle(
                                      color: Color(0xffbbbbbb),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                      
                    ],
                  ),
                ),
                Container(
              margin: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 56,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xffF3E7FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  crud.addMyStarsToUser(email, starnameController.text).then((value) => Navigator.of(context).pushNamed('mainView'));
                  
                },
                child: Text(
                  "I'll go with this name!",
                  style: TextStyle(
                    fontFamily: "NotoSansKR",
                    color: Colors.purpleAccent,
                  ),
                ),
              ),
            ),
              ],
            ),
          ),
          Container(),
          Container(),
          Container(),


        ],
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          enableInfiniteScroll: false,
          initialPage: 0,
          autoPlay: false,
        )
    
      ),
    );
      
  }
}