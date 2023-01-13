import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Company extends StatefulWidget {
  final dynamic companies;


  const Company({
    super.key,
    this.companies, 
  });

  @override
  State<Company> createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  String productCategory = 'Go-Fasta';
  String selectedTab = 'Go';
  bool? selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                    image: NetworkImage(widget.companies!['image']),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "{widget.companies![widget.i]['name']}",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "{widget.companies![widget.i]['hours']}",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    "{widget.companies![widget.i]['name']}",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Radio(
            activeColor: Theme.of(context).progressIndicatorTheme.color,
            value: "{widget.companies![widget.i]['name']}",
            groupValue: productCategory,
            onChanged: (value) {
              setState(() {
                selected = !selected!;
                productCategory = value.toString();
              });
            },
          ),
        ],
      ),
    );
  }
}
