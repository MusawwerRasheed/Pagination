import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class Refresher extends StatefulWidget {
  const Refresher({super.key});

  @override
  State<Refresher> createState() => _RefresherState();
}

class _RefresherState extends State<Refresher> {

  List <String> items  = [];
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(seconds:1));
     items.add((items.length+1).toString());

     if(mounted){
       setState(() {

       });
       _refreshController.loadComplete();
     }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Refresher'),),
      body: SmartRefresher(

        enablePullUp: true,
        enablePullDown: true,
         header: WaterDropHeader(),

        footer: CustomFooter(builder: (BuildContext context, LoadStatus? mode) {

          Widget body;

          if(mode == LoadStatus.idle){
            body = Text('Pull up to load');
          }

          else if (mode == LoadStatus.loading){
            body = CircularProgressIndicator();
          }

          else if (mode == LoadStatus.canLoading){
            body = Text('release to load more');
          }
 else{
   body = Text('no more carts');
          }

 return Container(
   height: 50,
   child: Center(child: body,),);

        },

        ),
controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,

        child:  ListView.builder(itemBuilder: (c, i)=> Card(child: Center(child: Text(items[i]),),),
        itemExtent: 100.0,
          itemCount: items.length,


        ),

      ),
    );
  }
}
