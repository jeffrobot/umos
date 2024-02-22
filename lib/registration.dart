import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:umos/functions/authentication.dart';
import 'package:umos/functions/shared_pref.dart';
import 'package:umos/user.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>{

  static User user = User();
  String selectedgender = '';

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  CarouselController buttonCarouselController = CarouselController();
  AuthManage _authManager = AuthManage();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwCheckController = TextEditingController();
  final TextEditingController _birthyearController = TextEditingController();

  bool isverified = false;
  Timer? verifiytimer;

  void sendverification() async{
    await _authManager.signUp(_emailController.text, _pwController.text).then((value){
      _authManager.thisuser?.sendEmailVerification();
    });
  }

  void register() async {
    if(isverified){
      // packaging data
      // upload user info
      await _authManager.uploadUserInfo(_usernameController.text, _emailController.text, _birthyearController.text, selectedgender).then((value){
        Navigator.pushNamed(context, 'tutorialView');
      });

      //save the user
      Helperfunctions.saveUserLoggedInSharedPreference(true);
      Helperfunctions.saveUserEmailSharedPreference(_emailController.text);
      Helperfunctions.saveUserNameSharedPreference(_usernameController.text);

    } else {
      SnackBar snackBar = SnackBar(content: Text('Please verify your email address'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  

  Widget buildGenderButton(String gender) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedgender = gender;
          print(selectedgender);
        });
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        backgroundColor: selectedgender == gender ? Color(0xff000000) : Color(0xFFD7CDE2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(
        gender,
        style: TextStyle(
          color: Color(0xFF707070),
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w500,
        ),
      ),
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
      body: Builder(
        builder: (context) {
          return CarouselSlider(
            options:CarouselOptions(
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              initialPage: 0,
            ),
            items:[
              /*Container(
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
                      Container(
                        padding: EdgeInsets.only(top:20, left: 20, right: 20, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: MediaQuery.of(context).size.width*0.9,
                        height: 56,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xFFD7CDE2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: (){
                            user.email = _emailController.text;
                            user.username = _usernameController.text;
                            user.password = _pwController.text;
                            user.birthyear = _birthyearController.text;
                            user.gender = selectedgender;
                          },
                          child: Text('Continue', style: TextStyle(fontFamily: "NotoSansKR", color: Color(0xFF707070)),)
                        ),
                      ),
                    ],
                  ),
                )
              */
              Container(
                color: Color(0xFFF3E7FF),
                padding: const EdgeInsets.all(16.0),
                child: FormBuilder(
                  key: _formKey,
                  child: CarouselSlider(
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: false,
                      initialPage: 0,
                    ),
                    items: [
                      Container(
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(top: 20),
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
                                  TextFormField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      labelText: 'Email Address',
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: isverified ? Colors.green : Color(0xFF28143D)),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: isverified ? Colors.green : Color(0xFF28143D)),
                                      ),
                                    ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                      FormBuilderValidators.email(),
                                    ]),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(top: 20),
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
                                  TextFormField(
                                    controller: _usernameController,
                                    decoration: InputDecoration(labelText: 'Username'),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                      FormBuilderValidators.minLength(3),
                                    ]),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(top: 20),
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
                                  TextFormField(
                                    controller: _pwController,
                                    obscureText: true,
                                    decoration: InputDecoration(labelText: 'Password'),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                      FormBuilderValidators.minLength(8),
                                    ]),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                      'Confirm Password',
                                      style: TextStyle(
                                        color: Color(0xFF28143D),
                                        fontSize: 16,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w700,
                                        height: 0.12,
                                      ),
                                    ),
                                  ),
                                  
                                  TextFormField(
                                    controller: _pwCheckController,
                                    obscureText: true,
                                    decoration: InputDecoration(labelText: 'Confirm Password'),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                      FormBuilderValidators.minLength(8),
                                    ]),
                                  ),
                                  
                                  
                                  
                                ],
                              ),
                            ),
                            (isverified)? 
                            Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width*0.9,
                              child: Center(
                                child: Text('Email Verified!', style: TextStyle(color: Colors.green),),
                              ),
                            ):Container(),
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              width: MediaQuery.of(context).size.width*0.9,
                              height: 56,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xffD7CDE2),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            
                                ),
                                onPressed: () {
                                  sendverification();
                                  SnackBar snackBar = SnackBar(content: Text('Verification email sent'));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  setState(() {
                                  verifiytimer = Timer.periodic(Duration(seconds: 2), (timer) {
                                    _authManager.thisuser!.reload();
                                    _authManager.auth.currentUser!.reload();
                                    print(_authManager.auth.currentUser!.emailVerified);
                                    if(_authManager.auth.currentUser!.emailVerified){
                                      isverified = true;
                                    }
                                  });
                                });
                                }, 
                                child: Text('Send Verification', style: TextStyle(color: Color(0xff707070)),)
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              width: MediaQuery.of(context).size.width*0.9,
                              height: 56,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xffD7CDE2),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            
                                ),
                                onPressed: (){
                                  if(isverified){
                                    buttonCarouselController.nextPage();
                                  }
                                  else{
                                    SnackBar snackBar = SnackBar(content: Text('Please verify your email address'));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                  
                                
                                  
                                }, 
                                child: Text('Continue', style: TextStyle(color: Color(0xff707070)),)
                              ),
                            ),
                          ],
                        ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text(
                                    'Birth Year',
                                    style: TextStyle(
                                      color: Color(0xFF28143D),
                                      fontSize: 16,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w700,
                                      height: 0.12,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: _birthyearController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(labelText: 'Birth Year'),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.numeric(),
                                    FormBuilderValidators.maxLength(4),
                                    FormBuilderValidators.minLength(4)
                                  ]),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(top: 20),
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
                                Container(
                                  padding: EdgeInsets.only(top:20, right: 20, bottom: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                                  ),
                                                ),
                              ],
                            ),
                          ),
                          
                          Container(
                              margin: EdgeInsets.only(bottom: 20),
                              width: MediaQuery.of(context).size.width*0.9,
                              height: 56,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xffD7CDE2),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            
                                ),
                                onPressed: (){
                                  register();
                                  verifiytimer?.cancel();
                                  print(_emailController.text);
                                  print(_usernameController.text);
                                  print(_pwController.text);
                                  print(_pwCheckController.text);
                                  print(_birthyearController.text);
                                  print(selectedgender);

                                }, 
                                child: Text('Continue', style: TextStyle(color: Color(0xff707070)),)
                              ),
                            ),
                        ],
                      )
                    )

                    ]
                  ),
                ),
              ),


              
            ]
          );}
      ),
    );
  }

}
