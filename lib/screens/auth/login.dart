import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gofast/exports/export_services.dart';
import 'package:gofast/global/global_methods.dart';
import 'package:gofast/screens/auth/forget_password.dart';
import 'package:gofast/screens/auth/registration.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late final TextEditingController _emailController =
      TextEditingController(text: '');
  late final TextEditingController _passwordController =
      TextEditingController(text: '');

  final FocusNode _passwordFocusNode = FocusNode();
  bool _obsecureText = true;
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }



  void _submitFormOnLogin() async {
    final isValid = _loginFormKey.currentState!.validate();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim().toLowerCase(),
          password: _passwordController.text.trim(),
        );
        // Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (error) {
        setState(() {
          if (mounted) {
            _isLoading = false;
          }
        });
        GlobalMethod.showErrorDialog(error: error.toString(), ctx: context);
        print('error occured $error');
      }
    }
    setState(() {
      if (mounted) {
        _isLoading = false;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
          height: MediaQuery.of(context).size.height*0.3,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
              const Icon(MaterialCommunityIcons.truck_fast_outline, size: 90,),
               
              Text("GoFasta", style: textStyle(40,Colors.black, FontWeight.bold),)
            ]),
          ),
        ),
        
        Container(
          height: MediaQuery.of(context).size.height*0.7,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).iconTheme.color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(60)
            )
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(12, 100, 12, 12),
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                    
                      //email
                      TextFormField(
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_passwordFocusNode),
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty || !value.contains("@")) {
                            return "Please enter a valid email address";
                          } else {
                            return null;
                          }
                        },
                        style: textStyle(18, Colors.white, FontWeight.normal),
                        decoration: InputDecoration(
                          hintText: 'Email ',
                          prefixIcon: const Icon(
                            CupertinoIcons.mail,
                            color: Colors.white,
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.all(6),
                          hintStyle:
                              textStyle(16, Colors.grey, FontWeight.normal),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    
                      const SizedBox(
                        height: 20,
                      ),
                    
                      //password
                      TextFormField(
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.next,
                        focusNode: _passwordFocusNode,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        obscureText: !_obsecureText,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 8) {
                            return "Please enter a valid password";
                          } else {
                            return null;
                          }
                        },
                        style: textStyle(18, Colors.white, FontWeight.normal),
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obsecureText = !_obsecureText;
                              });
                            },
                            child: Icon(
                              _obsecureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                          ),
                          hintText: 'Password ',
                          prefixIcon: const Icon(
                            CupertinoIcons.lock_circle,
                            color: Colors.white,
                            size: 30,
                          ),
                          hintStyle:
                              textStyle(16, Colors.grey, FontWeight.normal),
                          isDense: true,
                          contentPadding: EdgeInsets.all(6),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    
                      const SizedBox(
                        height: 50,
                      ),
                    
                    
                    ],
                  ),
                ),
              ),
            
            
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
                    child: Column(
                      children: [
                        MaterialButton(
                      onPressed: _submitFormOnLogin,
                      color: Color(0xFFFFFFFF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login your account'.toUpperCase(),
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                                  MaterialButton(
                      onPressed: _submitFormOnLogin,
                      color: Color(0xFF043F60),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Create an account'.toUpperCase(),
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                      ],
                    ),
                  ),
                  
                 
            ],
          ),
        )
      ]),
    );
  }
}