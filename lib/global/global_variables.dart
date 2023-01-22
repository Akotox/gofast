import 'package:gofast/models/coordinates.dart';
import 'package:gofast/models/dest_coordinates.dart';
import 'package:gofast/models/user_model.dart';

String loginUrlImage =
    "https://i.pinimg.com/originals/80/cf/b7/80cfb725b38d732dd1c26646eaf2d1e1.jpg";
String apiKey = "AIzaSyDnvwWssH0BbAt-H0tWbr9T3b6bIKWZQss";

List<String> parcelSize = [
  "Food | Non Perishable",
  "Food | Perishable",
  "Daily Necessities",
  "Files",
  "Digital Products",
  "Clothing",
  "Home utilities",
  "Liquids",
];

String? parcelId;

List<String> deliveryPeriod = [
  "< 1 HR"
      "6 HRS",
  "12 HRS",
  "24 HRS",
  "48 HRS",
  "72 HRS"
];

UserData? munhu;

enum Payment { balance, ecocash, innbucks }

String companyid = "rA7H5H7D8fS1Qg2SbaWl";

List<String> type = [
  "assets/images/small.png",
  "assets/images/medium.png",
  "assets/images/large.png",
  "assets/images/custom.png",
];
