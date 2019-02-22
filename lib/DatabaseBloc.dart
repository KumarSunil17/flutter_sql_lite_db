import 'dart:async';

import 'package:flutter_sql_lite_db/db_provider.dart';
import 'package:flutter_sql_lite_db/pojos/people_data.dart';

class PeopleBloc {
  final _clientController = StreamController<List<People>>.broadcast();

  get clients => _clientController.stream;

  dispose() {
    _clientController.close();
  }

  getClients() async {
    _clientController.sink.add(await DBProvider.db.getAllPeople());
  }

  PeopleBloc(){
    DBProvider.db.database;
    getClients();
  }

  delete(String email) {
    DBProvider.db.deletePeople(email);
    getClients();
  }

  add(People people) {
    DBProvider.db.newPeople(people);
    getClients();
  }
}