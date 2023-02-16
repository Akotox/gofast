import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofast/exports/export_services.dart';

class PassWord extends StatefulWidget {
  const PassWord({super.key});

  @override
  State<PassWord> createState() => _PassWordState();
}

class _PassWordState extends State<PassWord> {
  final TextEditingController _textController =
      TextEditingController(text: 'example@identity.com');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(CupertinoIcons.back)),
          backgroundColor: Colors.white,
          title: Text(
            "Reset password",
            style: textStyle(16, Colors.black, FontWeight.w700),
          ),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Kindly enter the email address associated with this account into the designated field below and press the Reset button. A password reset link will be promptly sent to the specified email for your convenience.",
                  style: textStyle(12, Colors.black, FontWeight.w500),
                  textAlign: TextAlign.justify,
                  maxLines: 4,
                ),
                const SizedBox(
                  height: 10,
                ),
                CupertinoTextField(
                  padding:
                      const EdgeInsets.only(top: 12.0, bottom: 12, left: 6),
                  controller: _textController,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      ///TODO 1: RESET PASSWORD FUNCTION
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFA1F2B36),
                        backgroundColor: const Color(0xFA1F2B36),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * .3, 15),
                        // side: const BorderSide(color: Color(0xFA1F2B36)),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      child: Text(
                        "Reset Password",
                        style: textStyle(12, Colors.white, FontWeight.w600),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ]));
  }
}
