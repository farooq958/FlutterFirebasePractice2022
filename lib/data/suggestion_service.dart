import 'package:tasky/data/model.dart';

class SuggestionService {
  static List<String> states = [
    "iphone",
    "Samsung",
    "oPOOF19",
    "MACBOOK",
    "HP",
    "PERFUME",
    "Brown",
    "oil",
    "Dal",
    "Elbow",
    "Flying",
    "Wooden",
    "Handcraft"
  ];

  static List<String> getSuggestions(String query, List<Product> products) {
    List<String> matches = [];
    List<String> newArray = [];
    for (var i in products) {
      newArray.add(i.title);
    }
    matches = newArray.toSet().toList();
//matches = near.where((element) => duplicator's.add(element)).toList();
    // matches.addAll(states);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
