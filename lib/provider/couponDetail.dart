import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CouponDetail extends ChangeNotifier{
  String couponName;
  String dateTime;
  String id ="";
  CouponDetail({this.couponName,this.dateTime,this.id});
  String getCouponName()=> couponName;
}