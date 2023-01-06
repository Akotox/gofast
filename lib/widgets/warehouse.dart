import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:easy_stepper/easy_stepper.dart';


class StorageWidget extends StatefulWidget {
  final String code;
  final String vicility;
  final String address;
  final String availabitity;
  final String status;
  final double capacity;


  const StorageWidget({
    super.key, 
    required this.code,
    required this.vicility,
    required this.address, 
    required this.availabitity,
    required this.status, 
    required this.capacity,
    
  });

  @override
  State<StorageWidget> createState() => _StorageWidgetState();
}
class _StorageWidgetState extends State<StorageWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
    

  @override
  Widget build(BuildContext context) {
    

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.13,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                  image: AssetImage("assets/images/storage.png"),
                  fit: BoxFit.cover,
                  opacity: 0.6),
              color: Theme.of(context).backgroundColor,
                 
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(

                      child: Container(
                        padding: const EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF03608F).withOpacity(0.5),
                        const Color(0xFFFFFFFF).withOpacity(0.5),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.bottomCenter,
                    )),
                        child: Text(
                          widget.code,
                          style: Theme.of(context).textTheme.headline4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                       Text(
                          widget.availabitity,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                  ],
                ),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          MaterialCommunityIcons.warehouse,
                          size: 10,
                          
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.vicility,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Ionicons.location_sharp,
                          size: 10,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.address,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    
                    const SizedBox(
                      height: 8,),

                    Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.status,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 3,
                ),
                SizedBox(
                  height: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: LinearProgressIndicator(
                      value: widget.capacity,
                      color: Theme.of(context).appBarTheme.backgroundColor,
                      backgroundColor: Colors.grey.shade400,
                    ),
                  ),
                ),
              ],
            )
                  ],
                ),
                
              ],
            ),
          ),
         
        ],
      ),
    );
  }

}
