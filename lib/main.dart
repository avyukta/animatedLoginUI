import 'package:flutter/material.dart';
import 'package:loginanimation/fadeAnimation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginanimation/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                FadeAnimation(
                  1,
                  Container(
                    height: 350,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/img/background.png'),
                    )),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                            left: 30,
                            bottom: 120,
                            width: 60,
                            height: 310,
                            child: FadeAnimation(
                              1.5,
                              Container(
                                child: Image(
                                  image: AssetImage('assets/img/light1.png'),
                                ),
                              ),
                            )),
                        Positioned(
                            left: 150,
                            width: 60,
                            height: 110,
                            child: FadeAnimation(
                              2,
                              Container(
                                child: Image(
                                  image: AssetImage('assets/img/light2.png'),
                                ),
                              ),
                            )),
                        Positioned(
                            top: 50,
                            right: 30,
                            width: 50,
                            child: FadeAnimation(
                              3,
                              Container(
                                child: Image(
                                  image: AssetImage('assets/img/clock.png'),
                                ),
                              ),
                            )),
                        Positioned(
                            top: 200,
                            left: 130,
                            child: FadeAnimation(
                              3,
                              Container(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: FadeAnimation(
                      3,
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Colors.grey[100],
                                offset: Offset(0, 10))
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                validator: (input) => input.isEmpty
                                    ? 'Please enter an email'
                                    : null,
                                onSaved: (input) => _email = input,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Email or Phone',
                                    hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.bold)),
                              ),
                              TextFormField(
                                validator: (input) => input.length < 6
                                    ? 'Must enter 6 character'
                                    : null,
                                obscureText: true,
                                onSaved: (input) => _password = input,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 30,
                ),
                FadeAnimation(
                  3,
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: RaisedButton(
                        onPressed: signIn,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60)),
                        padding: EdgeInsets.all(0),
                        color: Colors.white,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xff7F84E3),
                                    Color(0xffC2C2FD)
                                  ])),
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                FadeAnimation(
                    3,
                    Container(
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        AuthResult user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        print(_email);
        print(_password);
      } catch (e) {
        print(e.message);
      }
    }
  }
}
