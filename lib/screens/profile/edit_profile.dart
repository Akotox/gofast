import 'package:gofast/exports/export_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPersonalDetails extends StatefulWidget {
  const EditPersonalDetails({super.key});

  @override
  State<EditPersonalDetails> createState() => _EditPersonalDetailsState();
}

class _EditPersonalDetailsState extends State<EditPersonalDetails> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(CupertinoIcons.back)),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Edit my details",
            style: textStyle(16, Colors.black, FontWeight.w700),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  _buildtextfield(
                    controller: _name,
                    hintText: 'Name',
                    onSubmitted: (value) {
                      // ignore: todo
                      ///TODO 2: VALIDATE THE TEXT FIELD
                      setState(() {
                        // company = _name.text;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildtextfield(
                    controller: _address,
                    hintText: 'Phone number',
                    onSubmitted: (String) {
                      setState(() {
                        // address = _address.text;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildtextfield(
                    controller: _address,
                    hintText: 'Innbucks number',
                    onSubmitted: (String) {
                      setState(() {
                        // address = _address.text;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildtextfield(
                    controller: _address,
                    hintText: 'Ecocash number',
                    onSubmitted: (String) {
                      setState(() {
                        // address = _address.text;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 20,
                    ),
                    margin: EdgeInsets.only(
                      top: 20,
                    ),
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width,
                    child: OutlinedButton(
                      // ignore: todo
                      ///TODO 1: Submission function
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        // visualDensity: VisualDensity.compact,
                        elevation: 0,
                        foregroundColor: const Color(0xF8FFFFFF),
                        backgroundColor: Colors.lightBlue.shade600,
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.8, 15),
                        // side: const BorderSide(color: Color(0xFA1F2B36)),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class _buildtextfield extends StatelessWidget {
  const _buildtextfield({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.onSubmitted,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: TextField(
          decoration: InputDecoration(
              hintText: hintText,
              // contentPadding: EdgeInsets.only(left: 24),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.lightBlue.shade600, width: 0.5),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 0.5),
              ),
              disabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 0.5),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 0.5),
              ),
              border: InputBorder.none),
          controller: controller,
          cursorHeight: 25,
          style: textStyle(14, Colors.black, FontWeight.w500),
          onSubmitted: onSubmitted),
    );
  }
}
