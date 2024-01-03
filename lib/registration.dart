import 'package:flutter/material.dart';
import 'package:umos/user.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>{

  static User user = User();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _pwCheckController = TextEditingController();
  TextEditingController _birthyearController = TextEditingController();
  String selectedgender = '';

  Widget buildGenderButton(String gender) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedgender = gender;
        });
      },
      style: TextButton.styleFrom(
        backgroundColor: selectedgender == gender ? Color(0xff000000) : Color(0xFFD7CDE2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(gender, style: TextStyle(
            color: Color(0xFF707070),
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w500,
            height: 0.08,
          ),),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF3E7FF),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xFF28143D),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        title: Text(
          'Sign Up',
          style: TextStyle(
            color: Color(0xFF28143D),
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w700,
          ),
          ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Color(0xFFF3E7FF)),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'Email Address',
                style: TextStyle(
                  color: Color(0xFF28143D),
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  height: 0.12,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your email address',
                  hintStyle: TextStyle(
                    color: Color(0xFF28143D),
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    height: 0.12,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF28143D)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF28143D)),
                  ),
                ),
              ),
              ),
              Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'Username',
                style: TextStyle(
                  color: Color(0xFF28143D),
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  height: 0.12,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Enter your username',
                  hintStyle: TextStyle(
                    color: Color(0xFF28143D),
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    height: 0.12,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF28143D)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF28143D)),
                  ),
                ),
              ),
              ),

            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'Password',
                style: TextStyle(
                  color: Color(0xFF28143D),
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  height: 0.12,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                obscureText: true,
                controller: _pwController,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(
                    color: Color(0xFF28143D),
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    height: 0.12,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF28143D)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF28143D)),
                  ),
                ),
              ),
            ),

            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'Password Check',
                style: TextStyle(
                  color: Color(0xFF28143D),
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  height: 0.12,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                obscureText: true,
                controller: _pwCheckController,
                decoration: InputDecoration(
                  hintText: 'Check your password again',
                  hintStyle: TextStyle(
                    color: Color(0xFF28143D),
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    height: 0.12,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF28143D)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF28143D)),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                
                margin: EdgeInsets.only(bottom: 50),
                width: MediaQuery.of(context).size.width*0.9,
                height: 56,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xff5F308D),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              
                  ),
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => 
                          Scaffold(
                            appBar: AppBar(
                                backgroundColor: Color(0xFFF3E7FF),
                                elevation: 0,
                                leading: IconButton(
                                  icon: Icon(Icons.arrow_back_ios),
                                  color: Color(0xFF28143D),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                centerTitle: false,
                                title: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Color(0xFF28143D),
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w700,
                                  ),
                                  ),
                              ),
                            body: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(color: Color(0xFFF3E7FF)),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 20, top: 20),
                                    child: Text(
                                      'Year of Birth',
                                      style: TextStyle(
                                        color: Color(0xFF28143D),
                                        fontSize: 16,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w700,
                                        height: 0.12,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 20, right: 20),
                                    child: TextFormField(
                                      controller: _birthyearController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your year of birth',
                                        hintStyle: TextStyle(
                                          color: Color(0xFF28143D),
                                          fontSize: 16,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w400,
                                          height: 0.12,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFF28143D)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFF28143D)),
                                        ),
                                      ),
                                    ),
                                  ),
            
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 20, top: 20),
                                    child: Text(
                                      'Gender',
                                      style: TextStyle(
                                        color: Color(0xFF28143D),
                                        fontSize: 16,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w700,
                                        height: 0.12,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
            
                                      Row(
                                        children: [
                                          buildGenderButton('Male'),
                                          SizedBox(width: 10),
                                          buildGenderButton('Female'),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          buildGenderButton('Others'),
                                          SizedBox(width: 10),
                                          buildGenderButton('DoNotShow'),
                                        ],
                                      ),
                                    ],
                                  )
            
            
                                  
                                ],
                              ),
                            ),
            
                          )
                      )
                    );
                  }, 
                  child: Text('Continue', style: TextStyle(fontFamily: "NotoSansKR", color: Color(0xFFD7CDE2)),)
                ),
              ),
            ),


            
          ],
        ),
      ),
    );
  }
}
