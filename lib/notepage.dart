import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:notes/appTheme.dart';
import 'package:notes/homePage/home.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';
class makeNote extends StatefulWidget {
  Database? database;
  String note,title;
  int id;
  int theme;
  makeNote(this.database,[this.title="",this.note="",this.theme=-1,this.id=-1]);
  @override
  State<makeNote> createState() => _makeNoteState();
}

class _makeNoteState extends State<makeNote> {
  TextEditingController title = new TextEditingController();
  TextEditingController note_ = TextEditingController();
  bool bold_ = false, italic_ = false, underline_ = false;
  Color noteTextColor = Colors.black, noteTextBackColor = Colors.transparent;
  double noteTextSize = 20;
  Color curent_AppBarColor=appColor.appcolor[3],curent_bodyColor=Color(0xFFDFF1D6);
  int currentThemIndex=-1;


  @override
  void initState() {
    super.initState();
    title.text=widget.title;
    note_.text=widget.note;
   // print("${widget.id}");
    if(widget.theme!=-1) {
      currentThemIndex = widget.theme;
      curent_AppBarColor = appColor.noteTheme[currentThemIndex][0];
      curent_bodyColor = appColor.noteTheme[currentThemIndex][1];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: curent_AppBarColor,
        centerTitle: false,
        toolbarHeight: allhight(context) * 0.08,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: TextField(
          controller: title,
          style: TextStyle(
              fontSize: allwidth(context) * 0.05, color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: "Edit Title...",
            hintStyle: TextStyle(
                fontSize: allwidth(context) * 0.05, color: Colors.white60),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                if((note_.text!="" || title.text!="") && widget.id==-1)
                  {
                    String noteTitle= title.text,noteContaint=note_.text;
                    int b,i,u,theme=currentThemIndex;
                    Color tc,tbc;
                    //              'CREATE TABLE Test (id INTEGER PRIMARY KEY, title TEXT, note TEXT, b INTEGER,i INTEGER,u INTEGER,theme INTEGER)');
                    String q="insert into noteApp values(null,'$noteTitle','$noteContaint',$theme,0)";
                    int id=await widget.database!.rawInsert(q);
                    print("Row id = ${id}");
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Saved")));
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => home()));
                  }
                else if((widget.id)!=-1)
                  {
                    String t=title.text,n=note_.text;
                    int tm=currentThemIndex;
                    String sql="update noteApp set title='$t',note='$n',theme='$tm' where id='${widget.id}'";
                    int up=await widget.database!.rawUpdate(sql);
                 //   print("up=$up");
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updated")));
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => home()));

                  }

              },

              icon: Icon(
                Icons.save_outlined,
                color: Colors.white,
              )),
          PopupMenuButton(
            onSelected: (val)async{
              if(val==1)
                {

                }
              else if(val==2)
                {
                  if("${note_.text}"!="")
                          {
                            Share.share('${title.text}\n'+"${note_.text}");
                            String noteTitle= title.text,noteContaint=note_.text;
                            int b,i,u,theme=currentThemIndex;
                            Color tc,tbc;
                            //              'CREATE TABLE Test (id INTEGER PRIMARY KEY, title TEXT, note TEXT, b INTEGER,i INTEGER,u INTEGER,theme INTEGER)');
                            String q="insert into noteApp values(null,'$noteTitle','$noteContaint',$theme,0)";
                            int id=await widget.database!.rawInsert(q);
                            print("Row id = ${id}");

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Saved")));

                          }
                }
              else if(val ==3)
                {
                  showModalBottomSheet(
                    barrierColor: Colors.black12,
                    context: context,
                    builder: (context) {
                      return Container(
                        height: allhight(context) * 0.40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "Theme & Color",
                                style: TextStyle(
                                    fontSize: allwidth(context) * 0.06,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: AutofillHints.addressCity),
                              ),
                            ),
                            Container(
                              height: allhight(context) * 0.27,
                              width: allwidth(context) * 0.9,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: appColor.noteTheme.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: (){
                                      curent_AppBarColor=appColor.noteTheme[index][0];
                                      setState((){});
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(4),
                                      alignment: Alignment.topCenter,
                                      height: allhight(context) * 0.25,
                                      width: allwidth(context) * 0.3,
                                      decoration: BoxDecoration(
                                        // border:Border.all(width: 2,color: Colors.greenAccent),
                                        borderRadius: BorderRadius.circular(10),
                                        color: appColor.noteTheme[index][0],
                                      ),
                                      child: UnconstrainedBox(
                                        child: Container(
                                            margin: EdgeInsets.all(3),
                                            height: allhight(context) * 0.03,
                                            width: allwidth(context) * 0.27,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              color: appColor.noteTheme[index][1],
                                            )),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              else if(val ==4)
                {
                              print("_"+note_.text+"_");
                }
              else if(val==5)
                {
                        Navigator.pop(context);
                }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                // row has two child icon and text.
                child: Row(
                  children: [
                    Icon(Icons.pinch_outlined, color: Colors.black),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text("Pin")
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                // row has two child icon and text.
                child: Row(
                  children: [
                    Icon(Icons.share_rounded, color: Colors.black),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text("Share")
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                // row has two child icon and text.
                child: Row(
                  children: [
                    Icon(Icons.theater_comedy, color: Colors.black),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text("Theme")
                  ],
                ),
              ),
              PopupMenuItem(
                value: 4,
                // row has two child icon and text.
                child: Row(
                  children: [
                    Icon(Icons.remove_red_eye_outlined, color: Colors.black),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text("Reminder")
                  ],
                ),
              ),
              PopupMenuItem(
                value: 5,
                // row has two child icon and text.
                child: Row(
                  children: [
                    Icon(Icons.delete_forever_outlined,
                        color: Colors.redAccent),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: allhight(context) * 0.08,
        width: allwidth(context) * 0.9,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Color(0xFFB9E3BC), borderRadius: BorderRadius.circular(50)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    barrierColor: Colors.black12,
                    context: context,
                    builder: (context) {
                      return Container(
                        height: allhight(context) * 0.40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "Theme & Color",
                                style: TextStyle(
                                    fontSize: allwidth(context) * 0.06,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: AutofillHints.addressCity),
                              ),
                            ),
                            Container(
                              height: allhight(context) * 0.27,
                              width: allwidth(context) * 0.9,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: appColor.noteTheme.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: (){
                                      curent_AppBarColor=appColor.noteTheme[index][0];
                                      curent_bodyColor=appColor.noteTheme[index][1];
                                      currentThemIndex=index;
                                      setState((){});
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(4),
                                      alignment: Alignment.topCenter,
                                      height: allhight(context) * 0.25,
                                      width: allwidth(context) * 0.3,
                                      decoration: BoxDecoration(
                                        // border:Border.all(width: 2,color: Colors.greenAccent),
                                        borderRadius: BorderRadius.circular(10),
                                        color: appColor.noteTheme[index][0],
                                      ),
                                      child: UnconstrainedBox(
                                        child: Container(
                                            margin: EdgeInsets.all(3),
                                            height: allhight(context) * 0.03,
                                            width: allwidth(context) * 0.27,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: appColor.noteTheme[index][1],
                                            )),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: Icon(Icons.format_paint_outlined)),
            IconButton(
              onPressed: () {
                setState(() {
                  bold_ = !bold_;
                });
              },
              icon: Icon(Icons.format_bold_outlined, size: 30),
              color: bold_ ? Colors.green : Colors.black,
            ),
            IconButton(
              onPressed: () {
                setState(() {

                  italic_ = !italic_;

                });
              },
              icon: Icon(Icons.format_italic, size: 30),
              color: italic_ ? Colors.green : Colors.black,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  underline_ = !underline_;
                });
              },
              icon: Icon(Icons.format_underline, size: 30),
              color: underline_ ? Colors.green : Colors.black,
            ),
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    barrierColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Container(
                          height: allhight(context) * 0.50,
                          color: Colors.transparent,
                          child: Center(child: StatefulBuilder(
                            builder: (context, set) {
                              return CircleColorPicker(
                                controller: CircleColorPickerController(
                                    initialColor: Colors.red),
                                onEnded: (color) {
                                  set(() {
                                    noteTextColor = color;
                                  });
                                },
                                onChanged: (color) => set(() {
                                  print(color);
                                }),
                                size: const Size(240, 240),
                                strokeWidth: 4,
                                thumbSize: 36,
                              );
                            },
                          )));
                    },
                  );
                },
                color: Colors.black,
                icon: Icon(
                  Icons.format_color_text,
                  size: 30,
                )),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Container(
                        height: allhight(context) * 0.50,
                        color: Colors.transparent,
                        child: Center(child: StatefulBuilder(
                          builder: (context, set) {
                            return CircleColorPicker(
                              controller: CircleColorPickerController(
                                  initialColor: Colors.red),
                              onEnded: (color) {
                                set(() {
                                  noteTextBackColor = color;
                                });
                              },
                              // onChanged: (color) => set((){print(color);}),
                              size: const Size(240, 240),
                              strokeWidth: 4,
                              thumbSize: 36,
                            );
                          },
                        )));
                  },
                );
              },
              child: Container(
                //margin: EdgeInsets.only(left: allwidth(context)*0.01,right: allwidth(context)*0.01),
                height: allhight(context) * 0.050,
                width: allwidth(context) * 0.1,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Color == Colors.transparent)
                        ? Colors.black
                        : noteTextBackColor,
                    border: Border.all(width: 2.5, color: Colors.white)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right:10 ),
              height: allhight(context) * 0.050,
              width: allwidth(context) * 0.15,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: DropdownButton(
                  onChanged: (val){
                    noteTextSize=val as double;
                  },
                  focusColor: Colors.green,
                  hint: Text("   "+noteTextSize.toString().substring(0,2),textAlign: TextAlign.center,),
                  //dropdownColor: Colors.lightGreenAccent,
                  items: [
                    DropdownMenuItem(
                        onTap: () {
                          setState(() {
                            noteTextSize=24;
                          });
                        },
                        value: 24.0,
                        child: Text(
                          "24",
                          style: TextStyle(color: Colors.green, fontSize: 24),
                        )),
                    DropdownMenuItem(
                        onTap: () {
                          setState(() {
                            noteTextSize=18;
                          });
                        },
                        value: 18.0,
                        child: Text(
                          "18",
                          style: TextStyle(color: Colors.green, fontSize: 18),
                        )),
                    DropdownMenuItem(
                        onTap: () {
                          setState(() {
                            noteTextSize=16;
                          });
                        },
                        value: 16.0,
                        child: Text(
                          "16",
                          style: TextStyle(color: Colors.green, fontSize: 16),
                        )),
                    DropdownMenuItem(
                        onTap: () {
                          setState(() {
                            noteTextSize=14;
                          });
                        },
                        value: 14.0,
                        child: Text(
                          "14",
                          style: TextStyle(color: Colors.green, fontSize: 14),
                        )),
                    DropdownMenuItem(
                        onTap: () {
                          setState(() {
                            noteTextSize=10;
                          });
                        },
                        value: 10.0,
                        child: Text(
                          "10",
                          style: TextStyle(color: Colors.green, fontSize: 10),
                        ))
                  ],

              ),
            ),

          ],
        ),
      ),
      body:  Container(
        height: double.infinity,
        color: curent_bodyColor,
        child: TextField(

            textAlign: TextAlign.start,
             expands: true,
            minLines: null,
            maxLines: null,
            scribbleEnabled: false,
            controller:note_,

            // textAlign: TextAlign.center,
            style: TextStyle(
                color: noteTextColor,
                fontSize: noteTextSize,
                fontWeight:bold_ ? FontWeight.bold : FontWeight.normal,
                fontStyle: italic_ ? FontStyle.italic : FontStyle.normal,
                decoration: underline_
                    ? TextDecoration.underline
                    : TextDecoration.none,
                backgroundColor: noteTextBackColor),
            decoration: InputDecoration(

              border: InputBorder.none,
                hintText: "Put Your Notes......",
                hintStyle: TextStyle(
                    color: noteTextColor,
                    backgroundColor: noteTextBackColor),
                ),
          ),
      ),
      )
    );
  }
}
