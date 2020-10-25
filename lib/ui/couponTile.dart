
import 'package:coupon/provider/couponDetail.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';


class CouponTile extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final couponDetail = Provider.of<CouponDetail>(context);
    return new Padding(

      padding: const EdgeInsets.only(bottom:20.0),

         // f Neumorphic (may be convex, flat & emboss)

        child: Neumorphic(
          style: NeumorphicStyle(
            border: NeumorphicBorder(
              color: Color(0x33000000),
              width: 0.8,
            )
    ),
          child: new ListTile(
            onTap: (){
              
            },
           // contentPadding:const EdgeInsets.all(10.0),
            leading: Neumorphic(child: new Image.network(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ-LgtHvolbp5pahx6vbUkzQR8HxGs5hhgdrA&usqp=CAU',
          fit: BoxFit.contain,),
          style: NeumorphicStyle(
          boxShape:NeumorphicBoxShape.circle(),
          shape: NeumorphicShape.concave,
          depth: 5
          ),
        ),
            title: NeumorphicText(couponDetail.couponName,
              style: NeumorphicStyle(
                depth: 1,
                color: Colors.white, //customize color here
              ),
              textStyle: NeumorphicTextStyle(
                fontSize: 20,
              ),
            ),
            subtitle: NeumorphicText(couponDetail.dateTime.toString(),
              style: NeumorphicStyle(
                depth: 4,
                color: Colors.white, //customize color here
              ),
              textStyle: NeumorphicTextStyle(
                fontSize: 10,
              ),
            ),


      ),
        ),
    );
  }
}