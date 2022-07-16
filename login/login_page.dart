import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tourism/frontpage.dart';
import 'package:tourism/login/forgotpasswordpage.dart';
import 'package:tourism/login/google_controller.dart';
import 'package:tourism/login/google_controller.dart';
import 'package:tourism/login/google_sign_in_controller.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;


  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? storingemailvalue;

  Future signIn() async {
    showDialog(
        context: this.context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });

    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height:MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/loginimage"
                ".png"),
            fit: BoxFit.cover),
      ),
      child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Welcome Back",
            style: GoogleFonts.montserrat(
                fontSize: 30, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Text("You have been missed",
              style: GoogleFonts.montserrat(fontSize: 15)),
           SizedBox(height: 50,),

          Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                // keyboardType: TextInputType.emailAddress,
                // validator: (input) {
                //   if (input!.isEmpty) {
                //     storingemailvalue = input;
                //     return ScaffoldMessenger(child: Text("Enter email"))
                //         .toString();
                //   }
                //   return null;
                // },
                controller: _emailController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(12)),
                    hintText: "Enter Your Email",
                    fillColor: Colors.grey.shade200,
                    filled: true),
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(12)),
                  hintText: "Password",
                  fillColor: Colors.grey.shade200,
                  filled: true,
                ),
                obscureText: true,
              )),

          SizedBox(height: 10,),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage()));
                  },
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: GestureDetector(
              onTap: () {
               // if (storingemailvalue != null)
                  signIn();
                // if(storingemailvalue==null)
                //   {
                //     return Container()
                //
                //   }
              },
              child: Container(
                height: 50,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.shade400,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),

          //not a member register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a member? ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: widget.showRegisterPage,
                child: Text(
                  "Register Now",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
           // loginUI(),
         // loginControllers(context)
        ],
      ),
                    )
          ),
    )
        )
    );
  }

  loginUI() {
    //loggedIn
    //loginControllers

    return Consumer<LoginController>(builder: (context, model, child) {Size
        .fromHeight(10);
      //if we are already logged in
      if (model.userDetails != null) {
        return Center(
          heightFactor: 20,
          child: loggedIn(model),
        );
      }
      if (model.userDetails==null)
     {
        return loginControllers(context);
     }
      else
        return Text("please login");
    });
  }

  loginControllers(BuildContext context) {
    return Center(
      child: GestureDetector(
          child: Image.asset(
            "assets/images/google.png",
            width: 240,
            height: 50,
          ),
          onTap: () {
            Provider.of<LoginController>(context, listen: false).googleLogin();
          }),
    );
  }

  loggedIn(LoginController model) {
      Navigator.push(context,MaterialPageRoute(builder: (context)
    =>tourism()));
  }
 }
