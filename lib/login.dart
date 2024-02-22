import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:umos/functions/authentication.dart';

import 'functions/shared_pref.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  AuthManage _authManager = AuthManage();

  Future<void> _loginUser() async {
    final email = _formKey.currentState!.fields['email']!.value;
    final password = _formKey.currentState!.fields['password']!.value;

    if (email.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter email and password.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    final success = await _authManager.signIn(email, password);

    if (success) {
      // Login successful, navigate to the home page
      Navigator.of(context).pushNamed('mainView');
      
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Login failed.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void login() async {
      await _authManager.signIn(
        _formKey.currentState!.fields['email']!.value,
        _formKey.currentState!.fields['password']!.value,
      ).then((result) async {
        if (result != null) {
          QuerySnapshot current_user = await _authManager.getUserByEmail(_formKey.currentState!.fields['email']!.value);
          Helperfunctions.saveUserLoggedInSharedPreference(true);
          Helperfunctions.saveUserEmailSharedPreference(current_user.docs[0].get('userEmail'));
          Helperfunctions.saveUserNameSharedPreference(current_user.docs[0].get('username'));
          Navigator.pushNamed(context, 'mainView');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Email and Password do not match'),
          duration: const Duration(seconds: 2),
        ),
      );
        setState(() {
          //isloading = false;
        });
      }
      });
  
  
  //QuerySnapshot? current_user = await dbMethods.getUserByEmail(emailTextEditingController.text);
  //print(current_user!.docs[0]);
}



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            Expanded(
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        'A Sturdy Star,\n Born from dust.',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Image(
                        image: AssetImage('assets/img/umos_logo.png'),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Email Input Field
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 56,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple, width: 3),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: FormBuilderTextField(
                        name: 'email',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(color: Colors.black),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                        ]),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Password Input Field
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 56,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple, width: 3),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: FormBuilderTextField(
                        name: 'password',
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(color: Colors.black),
                        validator: FormBuilderValidators.required(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 56,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xff5F308D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    // Access form values using _formKey.currentState!.fields
                    // Add your login logic here
                    //_loginUser();
                    login();
                    
                  }
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontFamily: "NotoSansKR",
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 56,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    // Add your navigation logic to the registration view here
                    Navigator.of(context).pushNamed('registrationView');
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(
                            color: Color(0xff707070),
                            fontFamily: "NotoSansKR",
                          ),
                        ),
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "NotoSansKR",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
