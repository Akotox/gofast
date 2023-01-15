import 'dart:math';

class Place {
  String name;
  double distance;
  Place(this.name, this.distance);
}

List<Place> places = [
  Place("New York", 100.0),
  Place("Los Angeles", 200.0),
  Place("Chicago", 150.0),
  Place("Houston", 120.0),
  Place("Phoenix", 110.0),
];

double rate = 0.5;

double calculatePrice(double distance, double rate) {
  return distance * rate;
}

void main() {
  var rnd = new Random();
  var randomPlace1 = places[rnd.nextInt(places.length)];
  var randomPlace2 = places[rnd.nextInt(places.length)];

  print("The selected places are: ${randomPlace1.name} and ${randomPlace2.name}");
  print("The distance between them is: ${randomPlace1.distance + randomPlace2.distance} ");
  print("The price is : ${calculatePrice(randomPlace1.distance + randomPlace2.distance, rate)} ");
}
