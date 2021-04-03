import 'package:flutter/material.dart';
import 'package:realcallerapp/src/screens/home.dart';
import 'package:realcallerapp/src/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up",
          style: TextStyle(color: Color(0xff0d0d0d)),
        ),
        centerTitle: true,
        backgroundColor: Color(0xfffafafa),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 42,
                ),
                Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
                ),
                Text(
                  "You've been missed.",
                  style: TextStyle(color: Color(0xffa1a1a1), fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xfff1f1f1),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Username"),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xfff1f1f1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                          ),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Icon(
                        Icons.remove_red_eye_outlined,
                        color: Color(0xffa1a1a1),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forget Password?",
                      style: TextStyle(fontSize: 16, color: Color(0xffa1a1a1)),
                    )
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                MaterialButton(
                    minWidth: double.infinity,
                    height: 50,
                    padding: EdgeInsets.all(6),
                    color: Color(0xff00ca78),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return Home();
                      }));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return RegisterScreen();
                            }));
                          },
                          child: RichText(
                              text: TextSpan(
                                  style: TextStyle(fontSize: 16),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: "Don't have an account? ",
                                    style: TextStyle(color: Color(0xffa1a1a1))),
                                TextSpan(
                                    text: "Sign Up",
                                    style: TextStyle(color: Color(0xff0d0d0d)))
                              ])),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Text(
                          "OR",
                          style:
                              TextStyle(fontSize: 16, color: Color(0xffa1a1a1)),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                MaterialButton(
                    minWidth: double.infinity,
                    height: 50,
                    padding: EdgeInsets.all(6),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                    onPressed: () {},
                    child: Text(
                      "Connect with Google",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
