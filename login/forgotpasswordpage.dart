import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  //text controller
  final _emailController=TextEditingController();
  @override
  void dispose()
  {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async
  {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());

      showDialog(context: context, builder: (context)
      {
        return AlertDialog(
          content: Text("Password reset link sent! Check your email or spam "
              "folder"),
        );
      }
      );
    }
    on FirebaseAuthException  catch(e)
    {
      print(e);
      showDialog(context: context, builder:(context)=>AlertDialog(content:
      Text(e.message.toString()),));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding:EdgeInsets.symmetric(horizontal: 25),
            child: Text("Enter your email address and we will send a link to "
                "reset your password",textAlign:TextAlign.center,style:
            TextStyle(fontSize: 20),),
          ),

          SizedBox(height: 10,),




          //email textfield





          Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(enabledBorder:
                  OutlineInputBorder(borderSide:BorderSide(color: Colors
                      .white), borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide
                        (color: Colors.blueAccent),borderRadius: BorderRadius
                          .circular(12)),
                      hintText: "Enter your email....",
                      fillColor: Colors.grey.shade200,
                      filled: true
                  )                )
          ),

          SizedBox(height: 10,),

          MaterialButton(onPressed: passwordReset,
          child: Text("Reset Password"),color: Colors.deepPurple.shade200,

          )





        ],
      ),
    ) ;
  }
}
