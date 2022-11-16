import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:notes/appTheme.dart';
import 'package:notes/homePage/homeBackground.dart';
import 'package:sqflite/sqflite.dart';
import '../checkList.dart';
import '../notepage.dart';
import 'package:path/path.dart';
//import 'package:http/http.dart' as http;

//Size
allwidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

allhight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
//height: allhight(context)*0.1,width: allwidth(context)*0.1

class home extends StatefulWidget {
  int HomeBgColor, homeBgImage;

  home([this.HomeBgColor = -1, this.homeBgImage = -1]);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  Database? database;
  bool view = true;
  Color currentAppBarColor = appColor.noteTheme[4][1],
      currentBodyColor = appColor.noteTheme[4][0];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            toolbarHeight: allhight(context) * 0.08,
            leading: IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings_rounded,
                    color: Colors.white, size: allwidth(context) * 0.08)),
            title: Text(
              "SUPER NOTE",
              style: TextStyle(
                fontSize: allwidth(context) * 0.055,
              ),
              textAlign: TextAlign.left,
            ),
            leadingWidth: allwidth(context) * 0.12,
            titleSpacing: 0.0,
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.cloud_upload_outlined)),
              IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/img/vip.png",
                    width: allwidth(context) * 0.12,
                    height: allhight(context) * 0.12,
                  )),
              PopupMenuButton(
                onSelected: (value) {
                  int val = value as int;
                  print(val);
                  if (val == 1) {
                    setState(() {
                      view = !view;
                    });
                  } else if (val == 2) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return homeBG();
                      },
                    ));
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    // row has two child icon and text.
                    child: Row(
                      children: [
                        view
                            ? Icon(
                                Icons.grid_view_rounded,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.list,
                                color: Colors.black,
                              ),
                        SizedBox(
                          // sized box with width 10
                          width: 10,
                        ),
                        view ? Text("View by Grid") : Text("View by List")
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    // row has two child icon and text.
                    child: Row(
                      children: [
                        Icon(Icons.format_paint_outlined, color: Colors.black),
                        SizedBox(
                          // sized box with width 10
                          width: 10,
                        ),
                        Text("Colors & Background")
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 3,
                    // row has two child icon and text.
                    child: Row(
                      children: [
                        Icon(Icons.restore_from_trash_outlined,
                            color: Colors.black),
                        SizedBox(
                          // sized box with width 10
                          width: 10,
                        ),
                        Text("Tash")
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 4,
                    // row has two child icon and text.
                    child: Row(
                      children: [
                        Icon(Icons.settings, color: Colors.black),
                        SizedBox(
                          // sized box with width 10
                          width: 10,
                        ),
                        Text("Settings")
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 5,
                    // row has two child icon and text.
                    child: Row(
                      children: [
                        Icon(Icons.question_mark_sharp, color: Colors.black),
                        SizedBox(
                          // sized box with width 10
                          width: 10,
                        ),
                        Text("FAQ")
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 6,
                    // row has two child icon and text.
                    child: Row(
                      children: [
                        Icon(Icons.filter, color: Colors.black),
                        SizedBox(
                          // sized box with width 10
                          width: 10,
                        ),
                        Text("More App")
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 7,
                    // row has two child icon and text.
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/img/vip.png",
                          width: allwidth(context) * 0.1,
                          height: allhight(context) * 0.1,
                        ),
                        SizedBox(
                          // sized box with width 10
                          width: 10,
                        ),
                        Text("Buy VIP")
                      ],
                    ),
                  ),
                ],
                offset: Offset(0, 50),
                color: Color(0xFFF3F2F2),
                elevation: 2,
              )
            ],
          ),
          floatingActionButton: SpeedDial(
            // animationDuration: Duration(seconds: 2),
            elevation: 20,
            childPadding: EdgeInsets.all(8),
            backgroundColor: Colors.green,
            activeBackgroundColor: Color(0xFF3A7732),
            activeForegroundColor: Colors.white,
            spacing: 15,
            animatedIcon: AnimatedIcons.add_event,
            children: [
              SpeedDialChild(
                labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: allwidth(context) * 0.05,
                    fontWeight: FontWeight.w500),
                backgroundColor: Colors.green,
                labelBackgroundColor: Colors.grey,
                child: Image.asset("assets/img/checkList.png"),
                label: "Check List",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return makeChecklist(database!);
                    },
                  ));
                },
              ),
              SpeedDialChild(
                labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: allwidth(context) * 0.05,
                    fontWeight: FontWeight.w500),
                backgroundColor: Colors.green,
                labelBackgroundColor: Colors.grey,
                child: Image.asset(
                  "assets/img/edit_notes.png",
                  height: allhight(context) * 0.05,
                ),
                label: "New Note",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return makeNote(database!);
                    },
                  ));
                },
              ),
            ],
          ),
          body: FutureBuilder(
            future: create_db(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<Map> L;
                List id = [];
                List title = [];
                List note = [];
                List theme = [];
                List isnote = [];
                if (snapshot.hasData) {
                  L = snapshot.data as List<Map>;
                  L.forEach((e) {
                    id.add(e['id']);
                    title.add(e['title']);
                    note.add(e['note']);
                    theme.add(e['theme']);
                    isnote.add(e['isnote']);
                  });
                }
                return Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        gradient: (widget.HomeBgColor != -1)
                            ? LinearGradient(
                                colors: appColor.noteTheme[widget.HomeBgColor],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight)
                            : null),
                    child: view
                        ? ListView.builder(
                            itemCount: id.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: Key(title[index]),
                                direction: DismissDirection.endToStart,
                                onDismissed: (on) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("Are You Sure to  Delete"),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              String sql =
                                                  "delete from noteApp WHERE id=${id[index]}";
                                              //  String TrashSQL="insert into trash values(null,'${title[index]}','${note[index]}','${theme[index]}')";
                                              int d = await database!
                                                  .rawDelete(sql);
                                              // int a= await database2!.rawInsert(TrashSQL);
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                            child: Text("Yes")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              setState(() {});
                                            },
                                            child: Text("No"))
                                      ],
                                    ),
                                  );
                                },
                                //   secondaryBackground:TextButton.icon(onPressed: (){}, icon: Icon(Icons.share_rounded), label:Text("Share",style: TextStyle(color: Colors.blue,fontSize:allwidth(context)*0.04))) ,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        if (isnote[index]==0) {
                                          return makeNote(
                                              database!,
                                              title[index],
                                              note[index],
                                              theme[index],
                                              id[index]);
                                        } else {
                                          return makeChecklist(
                                              database!,
                                              title[index],
                                              note[index],
                                              theme[index],
                                              id[index]);
                                        }
                                      },
                                    ));
                                  },
                                  child: Stack(children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: allhight(context) * 0.10,
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        color: (theme[index] != -1)
                                            ? appColor.noteTheme[theme[index]]
                                                [1]
                                            : Color(0xFFC3EFAC),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                              width: allwidth(context) * 0.05),
                                          (isnote[index]==0)?Image(
                                            width: allwidth(context) * 0.12,
                                            image: AssetImage(
                                                "assets/img/edit_notes.png"),
                                            height: allhight(context) * 0.05,
                                          ):Image(
                                            width: allwidth(context) * 0.12,
                                            image: AssetImage(
                                                "assets/img/checkList.png"),
                                            height: allhight(context) * 0.07,
                                          ),
                                          SizedBox(
                                              width: allwidth(context) * 0.10),
                                          Text(
                                              (title[index] != "")
                                                  ? title[index]
                                                  : "No Title",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      allwidth(context) * 0.05,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      width: allwidth(context) * 0.05,
                                      height: allhight(context) * 0.12,
                                      decoration: BoxDecoration(
                                          color: (theme[index] != -1)
                                              ? appColor.noteTheme[theme[index]]
                                                  [0]
                                              : Color(0xFF428622),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ]),
                                ),
                              );
                            },
                          )
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemCount: id.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Container(
                                    height: allhight(context) * 0.4,
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: (theme[index] != -1)
                                          ? appColor.noteTheme[theme[index]][1]
                                          : Color(0xFFC3EFAC),
                                      borderRadius: BorderRadius.circular(10),
                                      //   border: Border(top: BorderSide(color: Colors.black,width: 3))
                                    ),
                                    child: ListTile(
                                      onLongPress: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title:
                                                Text("Are You Sure to  Delete"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () async {
                                                    String sql =
                                                        "delete from noteApp WHERE id=${id[index]}";
                                                    //  String TrashSQL="insert into trash values(null,'${title[index]}','${note[index]}','${theme[index]}')";
                                                    int d = await database!
                                                        .rawDelete(sql);
                                                    // int a= await database2!.rawInsert(TrashSQL);
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Yes")),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("No"))
                                            ],
                                          ),
                                        );
                                      },
                                      title: Text(
                                          (title[index] != "")
                                              ? title[index]
                                              : "No Title",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize:
                                                  allwidth(context) * 0.05,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic)),
                                      subtitle: Text(note[index], maxLines: 2),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    height: allhight(context) * 0.03,
                                    decoration: BoxDecoration(
                                        color: (theme[index] != -1)
                                            ? appColor.noteTheme[theme[index]]
                                                [0]
                                            : Color(0xFF428622),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ],
                              );
                            },
                          ));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    create_db();
  }

  create_db() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'note.db');

// open the database
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE noteApp (id INTEGER PRIMARY KEY, title TEXT, note TEXT,theme INTEGER,isnote INTEGER)');
    });
    //  await deleteDatabase(path);
    // var url=Uri.https('www.jemsdesai.epizy.com','/file/demo.txt');
    // var responce=await http.get(url);
    // String serverData=responce.body;
    //
    // print("$serverData");
    // await deleteDatabase(path);
    //get Data
    String q = "select * from noteApp";
    List<Map> l = [];
    l = await database!.rawQuery(q);
    return l;
  }
}
