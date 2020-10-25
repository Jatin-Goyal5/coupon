import 'package:coupon/provider/couponDetail.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User extends ChangeNotifier{
String userName= " hi , there";
List<CouponDetail> couponList=[];
getUser(){
  return userName;
}
Future<void> getList () async{
  const String url = 'https://flutter-location-47366.firebaseio.com/user.json';
  try{
    final response = await http.get(url);
    final data = json.decode(response.body) as Map<String, dynamic>;
    final List<CouponDetail> duplicate = [];
    data.forEach((key, value) {
      duplicate.add(
        new CouponDetail(
          id: key,
          dateTime: value['date'],
          couponName: value['name']
        )
      ) ;   
    });
    couponList = duplicate;
    notifyListeners();
    print(data.values);
  }catch(error){
    print(error);
  }
  
  
  //return couponList;
}
Future<void> addCoupon(CouponDetail couponDetail){
  const String url = 'https://flutter-location-47366.firebaseio.com/user.json';
 return http.post(url, body:json.encode({
   'name': couponDetail.couponName,
   'date': couponDetail.dateTime.toString() 
  }),
  ).then((reply){
    print(json.decode(reply.body));
     couponList.add(new CouponDetail(
    couponName:couponDetail.couponName,
     dateTime:couponDetail.dateTime,
     id:json.decode(reply.body)['name']));
     notifyListeners();
  }).catchError((error){
    print(error);
    throw error;
  });
}

Future<void> removeCoupon(String id ) async{
  final prodid = couponList.indexWhere((element) => element.id == id);
  if(prodid >= 0){
    final  url = 'https://flutter-location-47366.firebaseio.com/user/$id.json';
    var coupon = couponList[prodid];
    couponList.removeAt(prodid);
    notifyListeners();

    http.delete(url).then((_){
      coupon = null;
    }).catchError((){
      couponList.insert(prodid, coupon);
    }      
    );
   
  }
  notifyListeners();
}
}