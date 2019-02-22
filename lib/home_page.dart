import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sql_lite_db/DatabaseBloc.dart';
import 'package:flutter_sql_lite_db/all_people_page.dart';
import 'package:flutter_sql_lite_db/pojos/people_data.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:image_picker/image_picker.dart';


class HomePage extends StatefulWidget{
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  People _people = new People();

  int _genderValue;

  List<String> _gender = [
    'Male', 'Female', 'Others'
  ];

  File _image;

  final bloc = PeopleBloc();

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: MediaQuery.of(context).size.width,
        maxWidth: MediaQuery.of(context).size.height/3);
    setState(() {
      _image = image;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _inputCard(String hintText, TextEditingController controller,TextInputType inputType){
      return Card(shape: OutlineInputBorder(
        borderRadius:BorderRadius.circular(6.0),
        borderSide: BorderSide(
            width: 2.5,
            style: BorderStyle.solid,
            color: Colors.redAccent
        ),
      ),
        margin: EdgeInsets.only(
          bottom: 5.0,
          left: MediaQuery.of(context).size.width/10,
          right: MediaQuery.of(context).size.width/10,
          top: 5.0,
        ),
        elevation: 4.0,
        child: TextField(
          keyboardType: inputType,
          style: TextStyle(
              fontSize: 22.0,
              color: Colors.black
          ),
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
              ),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 30.0, vertical: 20.0)
          ),
        ),
      );
    }
    return Scaffold(
      key: _scaffoldKey,
      body: Builder(
        builder: (context) =>
        SliverFab(
          floatingWidget: FloatingActionButton(
            heroTag: 'fab1',
            tooltip: 'Pick Image',
            child: Icon(Icons.add_a_photo),

            onPressed: () {
              getImage();
            }
          ),
          floatingPosition: FloatingPosition(right: 16),
          expandedHeight: MediaQuery.of(context).size.height/3,
          slivers: <Widget>[
            new SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height/3,
              pinned: true,
              flexibleSpace: new FlexibleSpaceBar(
                title: new Text('Flutter SQLite'),
                background: _image != null ? Image.file(_image,fit: BoxFit.cover ) : Image.asset('assets/no_image.jpg',fit: BoxFit.cover),
              ),
            ),
            SliverList(
              delegate:
              SliverChildListDelegate(
                List.generate(
                  1,(int index) =>
                    Container(
                      child: Column(
                        children: <Widget>[
                          _inputCard('Enter your name', _nameController, TextInputType.text),
                          _inputCard('Enter your age', _ageController, TextInputType.number),
                          Card(
                            shape: OutlineInputBorder(
                              borderRadius:BorderRadius.circular(6.0),
                              borderSide: BorderSide(
                                  width: 2.5,
                                  style: BorderStyle.solid,
                                  color: Colors.redAccent
                              ),
                            ),
                            margin: EdgeInsets.only(
                              bottom: 5.0,
                              left: MediaQuery.of(context).size.width/10,
                              right: MediaQuery.of(context).size.width/10,
                              top: 10.0,
                            ),
                            elevation: 4.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: List<Widget>.generate(
                                  3,(int index) {
                                  return ChoiceChip(
                                    shape: OutlineInputBorder(
                                      borderRadius:BorderRadius.circular(30.0),
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          style: BorderStyle.solid,
                                          color: Colors.redAccent
                                      ),
                                    ),
                                    label: Text(_gender[index]),
                                    selected: _genderValue == index,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        _genderValue = selected ? index : null;
                                      });
                                    },
                                  );
                                },
                                ).toList(),
                              ),
                            ),
                          ),
                          _inputCard('Enter your phone', _phoneController, TextInputType.phone),
                          _inputCard('Enter your email', _emailController, TextInputType.emailAddress),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top:10.0, bottom: 10.0, left: 10.0, right: 10.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width/3,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment(0.7, 0.4),
                                    colors: [Colors.deepOrange, Colors.orangeAccent]//Color(0xFF1F0090), Color(0xFF119ED9),],
                                  ),
                                      borderRadius: BorderRadius.circular(6.0),
                                      boxShadow: [BoxShadow(
                                        color: Colors.orange[200],//,Color(0xFF1F0090),
                                        offset: Offset(0.0, 1.5),
                                        blurRadius: 10.0,
                                      ),
                                      ]),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        onTap: (){
                                          if(_nameController.text.isNotEmpty){
                                            if(_ageController.text.isNotEmpty){
                                              if(_genderValue != null){
                                                if(_phoneController.text.isNotEmpty){
                                                  if(_emailController.text.isNotEmpty){
                                                    if(_image != null){

                                                      //Add information from controller to people object
                                                      _people.name = _nameController.text;
                                                      _people.age = _ageController.text;
                                                      _people.gender = _gender[_genderValue];
                                                      _people.phone = _phoneController.text;
                                                      _people.email = _emailController.text;

                                                      //Add people information to SQLite database
                                                      //DBProvider.db.newPeople(_people);

                                                      bloc.add(_people);

                                                      Scaffold.of(context).showSnackBar(
                                                          SnackBar(content: Text('Stored successsfully!'),duration: Duration(seconds: 1),));

                                                      //clear the controllers
                                                      _nameController.clear();
                                                      _ageController.clear();
                                                      _genderValue = null;
                                                      _phoneController.clear();
                                                      _emailController.clear();

                                                    }
                                                    else{
                                                      Scaffold.of(context).showSnackBar(
                                                          SnackBar(content: Text('Please select an image :)'),duration: Duration(seconds: 1),));
                                                    }
                                                  }else{
                                                    Scaffold.of(context).showSnackBar(
                                                        SnackBar(content: Text('Email is not entered!'),duration: Duration(seconds: 1),));
                                                  }
                                                }else{
                                                  Scaffold.of(context).showSnackBar(
                                                      SnackBar(content: Text('Phone number is not entered!'),duration: Duration(seconds: 1),));
                                                }
                                              }else{
                                                Scaffold.of(context).showSnackBar(
                                                    SnackBar(content: Text('Gender is not selcted!'),duration: Duration(seconds: 1),));
                                              }
                                            }else{
                                              Scaffold.of(context).showSnackBar(
                                                  SnackBar(content: Text('Age is not entered!'),duration: Duration(seconds: 1),));
                                            }
                                          }else{
                                            Scaffold.of(context).showSnackBar(
                                                SnackBar(content: Text('Name is not entered!'),duration: Duration(seconds: 2),));
                                          }
                                        },
                                        child: Center(
                                          child: Text('Submit',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 27.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top:10.0, bottom: 10.0, left: 10.0, right: 10.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width/2.5,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment(0.7, 0.4),
                                          colors: [Colors.deepOrange, Colors.orangeAccent]//Color(0xFF1F0090), Color(0xFF119ED9),],
                                      ),
                                      borderRadius: BorderRadius.circular(6.0),
                                      boxShadow: [BoxShadow(
                                        color: Colors.orange[200],//,Color(0xFF1F0090),
                                        offset: Offset(0.0, 1.5),
                                        blurRadius: 10.0,
                                      ),
                                      ]),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        onTap: (){
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (BuildContext context) => AllPeople()
                                              )
                                          );
                                        },
                                        child: Center(
                                          child: Text('All People',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 27.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}