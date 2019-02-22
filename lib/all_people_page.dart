import 'package:flutter/material.dart';
import 'package:flutter_sql_lite_db/DatabaseBloc.dart';
import 'package:flutter_sql_lite_db/home_page.dart';
import 'package:flutter_sql_lite_db/pojos/people_data.dart';

class AllPeople extends StatefulWidget{
  @override
  AllPeopleState createState() {
    return AllPeopleState();
  }
}

class AllPeopleState extends State<AllPeople> {

  final bloc = PeopleBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("All People")),
      body: Container(
        child: StreamBuilder<List<People>>(
          stream: bloc.clients,
          builder: (BuildContext context, AsyncSnapshot<List<People>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,

                itemBuilder: (BuildContext context, int index) {
                  People item = snapshot.data[index];

                  print('Name is : '+(snapshot.data[index].name));

                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(color: Colors.red),
                    onDismissed: (direction) {
                      print('Deleted Email : '+item.email);
                      bloc.delete(item.email);
                    },
                    child: Card(
                      color: Colors.white30,
                      margin: EdgeInsets.all(5.0),
                      elevation: 4.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(width: 3.0, color: Colors.blue, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  text: 'Name : ',
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: item.name,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.pink[700],
                                        fontWeight: FontWeight.normal
                                      )
                                    )
                                  ]
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: 'Gender : ',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: item.gender,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.pink[700],
                                              fontWeight: FontWeight.normal
                                          )
                                      )
                                    ]
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: 'Age : ',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: item.age,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.pink[700],
                                              fontWeight: FontWeight.normal
                                          )
                                      )
                                    ]
                                ),
                              ),

                              RichText(
                                text: TextSpan(
                                    text: 'Phone : ',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: item.phone,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.pink[700],
                                              fontWeight: FontWeight.normal
                                          )
                                      )
                                    ]
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: 'Email : ',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: item.email,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.pink[700],
                                              fontWeight: FontWeight.normal
                                          )
                                      )
                                    ]
                                ),
                              ),

                              // Text(item.name),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: UniqueKey(),
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()
              )
          );
        },
      ),
    );
  }
}