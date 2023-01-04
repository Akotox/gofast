import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gofast/exports/export_pages.dart';
import 'package:gofast/exports/export_services.dart';
import 'package:gofast/global/global_methods.dart';

import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
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
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

//animation
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
    super.initState();
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).iconTheme.color
                // image: const DecorationImage(
                //   image: AssetImage("assets/images/wallp.png"),
                //   fit: BoxFit.cover,
                // ),
                ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 80),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 80, right: 80),
                    child: Image.asset(
                      'assets/images/digi.png',
                    ),
                  ),
                  Form(
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
                          height: 20,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const ForgotPasswordPage();
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forgot Password',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          onPressed: _submitFormOnLogin,
                          color: Colors.green,
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Login ',
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
                        const SizedBox(height: 20),

                        //Sign up
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.white54,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const Register();
                                }));
                              },
                              child: Text(
                                ' Register now',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
