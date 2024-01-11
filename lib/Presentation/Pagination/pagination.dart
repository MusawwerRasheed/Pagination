import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination/Domain/Models/Carts.dart';
import 'package:pagination/Presentation/Pagination/Controller/pagination_cubit.dart';
import 'package:pagination/Presentation/Pagination/State/pagination_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class Pagination extends StatefulWidget {
  const Pagination({Key? key}) : super(key: key);

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  List<Cart> loadedList = [];
  List<Cart> cachecarts = [];
  int pageNo=1;

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    context.read<PaginationCubit>().getCarts(pageNo: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pagination')),
      body: BlocConsumer<PaginationCubit, PaginationState>(
        listener: (context, state) {},
        builder: (context, state) {
           if (state is PaginationLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PaginationLoadedState) {
            return buildListView(state.fulldata);
          }
           else if (state is PaginationEmptyState){
             return Center (child: Text('NO more products '));
           }
           else if (state is PaginationErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          }
         else {
            return Container(
              child: Text('Not working'),
            );
          }
        },
      ),
    );
  }

  Widget buildListView(List<Cart> data) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;

          if (mode == LoadStatus.idle) {
            body = SizedBox();
          }
          else if(mode == LoadStatus.noMore){
           body =  SizedBox(child: Text('No more products -----'),);
          }
          else if (mode == LoadStatus.loading) {
            body = SizedBox(height: 200,);
          } else if (mode == LoadStatus.failed) {
            body = Text('Failed to load carts');
          } else if (mode == LoadStatus.canLoading) {
            body = SizedBox();
          } else {
            body = Text('No more Carts');
          }
          return Container(
            child: body,
            height: 55,
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child:
      ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
            Cart cart = data[index];
            print('>> Cart titile is ${cart.title}');
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title:
            cart.title =='' ? Text('No more Products' , style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold),) : Text(cart.title!),
                ),
              ],
            );
          }
      ),
    );
  }


  void _onLoading() async {
    pageNo=pageNo+1;
    print('Page Number>>>>: $pageNo');
    if(pageNo<=20){
      context.read<PaginationCubit>().getCarts(load: true,pageNo: pageNo, );
    }
    // else if(pageNo == 21) {
    //   context.read<PaginationCubit>().getCarts(load: false, pageNo: pageNo);
    // }
    else{
        _refreshController.loadNoData();

    }
    await Future.delayed(const Duration(seconds: 1));
    _refreshController.loadComplete();
  }

  void _onRefresh() async {
    context.read<PaginationCubit>().getCarts(pageNo: 1);
    await Future.delayed(Duration(milliseconds: 333));
    _refreshController.refreshCompleted();
  }

}




//
//
// class Pagination extends StatefulWidget {
//   const Pagination({Key? key}) : super(key: key);
//
//   @override
//   State<Pagination> createState() => _PaginationState();
// }
//
// class _PaginationState extends State<Pagination> {
//   List<Cart> loadedList = [];
//   List<Cart> cachecarts = [];
//
//   // List<Map<String, dynamic>> metadata = [];
//
//   // static Future<Map<String, dynamic>> fetchMetaData() async {
//   //   print('api services fetchData gets executed');
//   //   try {
//   //     final apiUrl = Uri.parse('https://dummyjson.com/carts');
//   //     print('URI PARSING: $apiUrl');
//   //     final headers = {'Content-Type': 'application/json', 'Host': '<calculated when request is sent>'};
//   //     print(headers);
//   //     final response = await http.get(apiUrl);
//   //
//   //     if (response.statusCode == 200) {
//   //       print('success');
//   //       final data = json.decode(response.body);
//   //       return data;
//   //     } else {
//   //       throw Exception('Failed to load data. Status code: ${response.statusCode}');
//   //     }
//   //   } catch (e) {
//   //     throw Exception('Error: $e');
//   //   }
//   // }
//
//   // void assignvalue() async {
//   //   try {
//   //     metadata = await fetchMetaData();
//   //     print('Metadata is assigned  $metadata');
//   //   } catch (e) {
//   //     print(e);
//   //   }
//   // }
//
//   void _onLoading() async {
//     context.read<PaginationCubit>().getCarts();
//     // assignvalue();
//     // for(Map<String, dynamic> data in metadata){
//     //
//     //   print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $data');
//     //
//     // }
//     await Future.delayed(Duration(seconds: 2));
//     cachecarts.addAll(loadedList);
//     if (mounted) setState(() {});
//     _refreshController.loadComplete();
//   }
//
//   RefreshController _refreshController =
//   RefreshController(initialRefresh: false);
//
//   @override
//   void _onRefresh(BuildContext context) async {
//     context.read<PaginationCubit>().getCarts();
//     await Future.delayed(Duration(milliseconds: 333));
//     _refreshController.refreshCompleted();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<PaginationCubit>().getCarts();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Pagination')),
//       body: BlocConsumer<PaginationCubit, PaginationState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           if (state is PaginationInitialState) {
//             return Center(child: SizedBox());
//           } else if (state is PaginationLoading) {
//             return Center(child: SizedBox());
//           } else if (state is PaginationLoadedState) {
//             loadedList = state.loadedData;
//
//             return buildListView(cachecarts);
//           } else if (state is PaginationErrorState) {
//             return Center(child: Text('Error: ${state.error}'));
//           } else {
//             return Container(
//               child: Text('Not working'),
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   Widget buildListView(List<Cart> data) {
//     return SmartRefresher(
//       enablePullDown: true,
//       enablePullUp: true,
//       header: WaterDropHeader(),
//       footer: CustomFooter(
//         builder: (BuildContext context, LoadStatus? mode) {
//           Widget body;
//
//           if (mode == LoadStatus.idle) {
//             body = Text('Pull up load');
//           } else if (mode == LoadStatus.loading) {
//             body = SizedBox();
//           } else if (mode == LoadStatus.failed) {
//             body = Text('Failed to load carts');
//           } else if (mode == LoadStatus.canLoading) {
//             body = Text('release to load more');
//           } else {
//             body = Text('No more Carts');
//           }
//           return Container(
//             child: body,
//             height: 55,
//           );
//         },
//       ),
//       controller: _refreshController,
//       onRefresh: () => _onRefresh(context),
//       onLoading: _onLoading,
//       child: ListView.builder(
//         itemCount: data.length,
//         itemBuilder: (context, index) {
//           if (index < data.length) {
//             Cart cart = data[index];
//             for (Product prod in cart.products!)
//               return Column(
//                 children: [
//                   Text('Description: ${prod.discountPercentage}'),
//                   Text('Price: ${prod.quantity}'),
//                   Image.network(prod.thumbnail ?? ""),
//                   Divider(),
//                 ],
//               );
//           } else {
//             // Loading indicator
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }




//
//
// class Pagination extends StatefulWidget {
//   const Pagination({Key? key}) : super(key: key);
//
//   @override
//   State<Pagination> createState() => _PaginationState();
// }
//
// class _PaginationState extends State<Pagination> {
//   @override
//   void initState() {
//     context.read<PaginationCubit>().getCarts();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Pagination')),
//       body: BlocConsumer<PaginationCubit, PaginationState>(
//         listener: (context, state) {
//
//         },
//         builder: (context, state) {
//           if (state is PaginationInitialState) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is PaginationLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is PaginationLoadedState) {
//             var loadedList = state.loadedData;
//             print(loadedList);
//             return buildListView(loadedList);
//           } else if (state is PaginationErrorState) {
//             return Center(child: Text('Error: ${state.error}'));
//           } else {
//             return Container(child: Text('Not working'),);
//           }
//         },
//       ),
//     );
//   }
//
//
//   Widget buildListView(List<dynamic> data) {
//     return Column(
//       children: [
//         Expanded(
//           child: ListView.builder(
//             itemCount: data.length,
//             itemBuilder: (context, index) {
//               Cart cart = data[index];
//               return Column(
//                 children: [
//                   Text(cart.id.toString(),style: TextStyle(fontSize: 45),),
//                   for(Product prod in cart.products!)
//                     ColoredBox(color:Colors.yellow,
//                       child: Column(crossAxisAlignment
//                       :CrossAxisAlignment.start,
//                         children: [
//
//                         Text(prod.title.toString()),
//                         Text('Description: ${prod.discountPercentage}'),
//                         Text('Price: ${prod.quantity}'),
//                         Image.network(prod.thumbnail??""
//                         ),
//                         Divider(),
//                       ],),
//                     )
//
//                 ],
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//
// }

