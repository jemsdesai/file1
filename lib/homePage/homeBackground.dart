import 'package:flutter/material.dart';
import 'package:notes/appTheme.dart';
import 'package:notes/homePage/home.dart';




class homeBG extends StatefulWidget {
  const homeBG({Key? key}) : super(key: key);

  @override
  State<homeBG> createState() => _homeBGState();
}

class _homeBGState extends State<homeBG> {
  int choice=-1;
  List<Tab> myTabs = <Tab>[
  Tab(text: 'Color  BG'),
  Tab(text: 'Image BG'),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            toolbarHeight: allhight(context)*0.08,
            leadingWidth:allwidth(context)*0.12 ,
            titleSpacing: 0.0,
            title: Text(
              "Color & Background",
              style: TextStyle(
                fontSize: allwidth(context) * 0.055,
              ),
              textAlign: TextAlign.left,
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Image.asset("assets/img/vip.png",width: allwidth(context) * 0.12,height: allhight(context)*0.12,)),
            ],
            bottom: TabBar(tabs: myTabs),
          ),
          body: TabBarView(
            children: [
             // colorBG(),
              Container(
                padding: EdgeInsets.all(15),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  shrinkWrap: true,
                  // scrollDirection: Axis.horizontal,
                  itemCount: appColor.noteTheme.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        choice=index;
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home(choice),));
                      },
                      child: Container(
                        margin: EdgeInsets.all(4),
                        // alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          // border:Border.all(width: 2,color: Colors.greenAccent),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.green,width: 3),
                            gradient: LinearGradient(colors:appColor.noteTheme[index])
                        ),
                      ),
                    );
                  },
                ),
              ),
              imageBG()
            ],
          )
        ),
      ),
    );
  }
}


class imageBG extends StatelessWidget {
  const imageBG({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: CircularProgressIndicator(),),);
  }
}
