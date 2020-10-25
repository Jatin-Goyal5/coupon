
import 'package:coupon/provider/USER.dart';
import 'package:coupon/provider/couponDetail.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class formUi extends StatefulWidget {
  @override
  _formUiState createState() => _formUiState();
}

class _formUiState extends State<formUi> {
   DateTime selectedDate = DateTime.now();
   final couponName = new TextEditingController();
   var _isLoading = false;
   String _coupon='';
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
       @override
    void initState(){
      super.initState();
      var initializationSettingsAndroid =
      AndroidInitializationSettings('flutter_dev');
      var initializationSettingsIOs = IOSInitializationSettings();
     // var macOsinitialization=MacOSInitializationSettings();
  var initSetttings = InitializationSettings(android: initializationSettingsAndroid,
   iOS:initializationSettingsIOs,
   );

  flutterLocalNotificationsPlugin.initialize(initSetttings,
      onSelectNotification: notificationSelected);
    }
    
 Future notificationSelected(String payload) async {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text("Notification : $payload"),
    ),
  );

  
}

   Future <void> _showNotification() async {
    tz.initializeTimeZones();
    //.setLocalLocation(tz.getLocation(timeZoneName)); 

  var scheduledNotificationDateTime =
      DateTime.now().add(Duration(seconds: 5));
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'channel id',
    'channel name',
    'channel description',
    icon: 'flutter_devs',
    largeIcon: DrawableResourceAndroidBitmap('flutter_devs'),
  );
  //var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  //var platformChannelSpecifics = NotificationDetails(
    //  android:androidPlatformChannelSpecifics, iOS:iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    'scheduled title',
    'scheduled body',
    tz.TZDateTime.now(tz.local).add(const Duration(seconds: 25)),
    const NotificationDetails(
        android: AndroidNotificationDetails('your channel id',
            'your channel name', 'your channel description', icon: 'flutter_dev',
    largeIcon: DrawableResourceAndroidBitmap('flutter_dev'),)),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);

}

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1000, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  @override
  Widget build(BuildContext context) {
    final couponadd = Provider.of<User>(context);
    return new Scaffold(
      appBar:NeumorphicAppBar(
        title: Text('Add coupon',style: TextStyle(
          color:Colors.amberAccent
        ),),
        buttonStyle: NeumorphicStyle(
              color: Colors.amberAccent,
              border: NeumorphicBorder(
                color: Colors.amberAccent,width: 2,
                isEnabled: true
              )
            ),
        actions: [
          
          new Neumorphic(
            child: NeumorphicButton(child:Icon(Icons.add,color:Colors.amberAccent,),
            onPressed: (){
              
              setState(() {
                _isLoading = true;
                _coupon= couponName.text;
              });
              couponadd.addCoupon(new CouponDetail(
                couponName:_coupon,
                dateTime:selectedDate.toString(),
                id:"10101")
                ).catchError((error){
                  return showDialog(context: context,
                  builder:(c)=>AlertDialog(
                      title: Text("error occured"),
                      content: Text("helloo"),
                      actions: [
                        FlatButton(
                          child: Text('okay'),
                          onPressed: (){
                           Navigator.pop(context);
                          },
                        )
                      ],
                    )
                  );
               
                })
                .then((_){
                  setState(() {
                    _isLoading = false;
                  });
                  _showNotification();
                  Navigator.pop(context);
                });
              

            },  
          ),
          )
        ],
      ),
      body:_isLoading == true ?Center(child: CircularProgressIndicator()):new Container(
        padding: EdgeInsets.all( 20),
      child: Neumorphic(
      style: NeumorphicStyle(
      boxShape:NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
      shape: NeumorphicShape.concave,
      depth: 2
   
       ),
       child: new ListView(
      children: <Widget>[
          SizedBox(
          height: 20,
         ),
        
         Container(
          height: 100.0,
          width: 100.0,
          child: Neumorphic(child: new Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ-LgtHvolbp5pahx6vbUkzQR8HxGs5hhgdrA&usqp=CAU',
            fit: BoxFit.contain,),
            style: NeumorphicStyle(
            boxShape:NeumorphicBoxShape.circle(),
            shape: NeumorphicShape.concave,
            depth: 5
            ),
          ),
        ),
        new SizedBox(
          height: 20.0,
        ),
         Padding(
           padding: const EdgeInsets.only(left:50.0,right: 50.0,top: 50.0),
           child: Neumorphic(child: TextFormField(
             controller: couponName,
             keyboardType:TextInputType.text,
             decoration: InputDecoration(
               border:OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular( 20.0)),
              ),
              labelText:'coupon name ' ,
              fillColor: Colors.yellowAccent[400],
              hoverColor: Colors.yellowAccent[400],
              labelStyle: TextStyle(fontSize: 30,
           color: Colors.yellowAccent[400],),),
               
           style: TextStyle(fontSize: 30,
           color: Colors.yellowAccent[400],),textAlign: TextAlign.center),
             style: NeumorphicStyle(
             boxShape:NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
             shape: NeumorphicShape.flat,
             depth: 2
             ),
           ),
         ),
          new SizedBox(
          height: 20.0,
        ),
         Padding(
           padding: const EdgeInsets.only(left:50.0,right: 50.0,top: 50.0),
           child: Neumorphic(child: FlatButton(
              child: new ListTile(
              leading: Text(selectedDate.day.toString()+'/'+selectedDate.month.toString()+'/'+selectedDate.year.toString(),
              style:TextStyle(fontSize: 20,
              color: Colors.yellowAccent[400],),textAlign: TextAlign.center),
              trailing: Icon(Icons.date_range_outlined), 
             ),
             onPressed: (){
               _selectDate(context);
             },
           ),style: NeumorphicStyle(
             boxShape:NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
             shape: NeumorphicShape.flat,
             depth: 2
             ),
           ),
         ),
       
  
  ],
      
        ),
      ),
    )
  );
  }
}
