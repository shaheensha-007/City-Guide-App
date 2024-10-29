
import 'package:flutter/material.dart';
import 'package:flutter_interview/ui/restaurants.dart';

import '../widgets/NavigationServies.dart';
import 'Review And rate.dart';
import 'events.dart';
import 'location tracking.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> status = ["Restaurants","Events"];
  @override
  Widget build(BuildContext context) {
    var mheight=MediaQuery.of(context).size.height;
    var mwidth=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueGrey,
       shape: RoundedRectangleBorder(
         borderRadius:BorderRadius.circular(5)
       ),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           Center(child: Text("Home")),
            Spacer(),
            IconButton(onPressed: (){
              NavigationService.push(NearbyAttractionsMap());
            }, icon: Icon(Icons.location_on,color: Colors.blue,),),
            IconButton(onPressed: (){
             NavigationService.push(ReviewScreen());
            }, icon: Icon(Icons.login_sharp,color: Colors.blue,),),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: mheight*0.03,
          ),
          Padding(
            padding:EdgeInsets.only(left: mwidth*0.05),
            child: Container(
              height:mheight*0.05,
              width: mwidth*0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey,
              ),
              child: Padding(
                  padding: EdgeInsets.only(left: mwidth * 0.03),
                  child: DropdownButtonFormField<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    items: status.map((employeed) {
                      return DropdownMenuItem(
                        alignment: Alignment.bottomLeft,
                        value: employeed,
                        child: Container(
                          height: mheight*0.05,
                          width: mwidth*0.2,
                          child: Text(employeed, style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            fontFamily: "regulartext",
                          ),),
                        ),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      // Adjust content padding as needed
                      border: InputBorder.none,
                      // Remove the border
                      hintText: "Employment Status",
                      hintStyle: TextStyle(fontSize: 10,
                          fontWeight: FontWeight.w200,
                          fontFamily: "regulartext"),
                      errorStyle: TextStyle(fontSize: 10,
                          fontWeight: FontWeight.w200,
                          fontFamily: "regulartext"),
                    ), onChanged: (String? value) {
                      if(value=="Restaurants"){
                        NavigationService.push(Restaurants());
                      }else if(value=="Events"){
                        NavigationService.push(Eventsprogrames());
                      }
                  },
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
