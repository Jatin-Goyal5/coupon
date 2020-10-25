import 'package:coupon/provider/USER.dart';
import 'package:coupon/provider/couponDetail.dart';
import 'package:coupon/ui/authentication.dart';
import 'package:coupon/ui/couponTile.dart';
import 'package:coupon/ui/formui.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';


class AllCard extends StatefulWidget {
  @override
  _AllCardState createState() => _AllCardState();
}

class _AllCardState extends State<AllCard> {
  var _checkState= true;
  var _isLoading = false;

  
   Widget floatButton(){
      return new FloatingActionButton(onPressed: (){
          Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, 
          child: formUi(),
          duration: Duration(milliseconds: 1500),
          curve: Curves.bounceOut)
          );

          },
          child:new Icon(Icons.add,) ,
          hoverColor: Colors.deepOrange,
          
            
          
          );

    }
    @override
    void initState(){
      super.initState();
     
    }
    

    @override
    void didChangeDependencies() {
      if(_checkState){
        setState(() {
          _isLoading = true;
        });
        Provider.of<User>(context).getList().then((_) {
          setState(() {
            _isLoading = false;
           _checkState = false; 
          });
          
        });
      }
      
         _checkState = false;
     
      
     
      
      super.didChangeDependencies();
      
    }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    List<CouponDetail>userCouponList = user.couponList;
    return Scaffold(
     
      
      appBar: NeumorphicAppBar(
        title: Text(
           "Coupons",
           
          style: TextStyle(
            color: Colors.yellowAccent[400],
            fontWeight: FontWeight.bold,
            fontSize:40.0,  
          ),
        ),
      ),
          body: _isLoading ? new Center(child: new CircularProgressIndicator(),)
          :Container(
            height: MediaQuery.of(context).size.height-200,
            width: MediaQuery.of(context).size.width,                     
            child: userCouponList.length== 0? Center(
              child: Text("No, Coupon To Show",style: TextStyle(
              color: Colors.yellowAccent[400],
              // fontWeight: FontWeight.bold, 
          ),
        ),
            ):ListView.builder(
               
                shrinkWrap: true,
                itemCount: userCouponList.length,
                
                itemBuilder: (context, int index)=> ChangeNotifierProvider.value(
                value: userCouponList[index],
                child:Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Slidable(child: CouponTile(),  
                    secondaryActions: [
                      NeumorphicButton(child: Icon(Icons.delete),
                      onPressed: (){

                      user.removeCoupon(userCouponList[index].id);
                      },
                      ),],
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                  
                  )
                ),
                )
              ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton:floatButton(),
          bottomNavigationBar: BottomAppBar(
           notchMargin: 8,
           
           elevation: 80,
            color: Colors.amberAccent[800],
            shape: CircularNotchedRectangle(),
            child: new Row(children:<Widget>[new FlatButton(child:Text(''),onPressed:(){})]),
          ),
    );
   
  }
}