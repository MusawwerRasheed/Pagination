import 'dart:convert';

import 'package:pagination/Domain/Models/Carts.dart';

abstract class PaginationState {}

class PaginationInitialState extends PaginationState {}

class PaginationLoadedState extends PaginationState {
  final  List<Cart> loadedData;
  final List<Cart> fulldata;
  PaginationLoadedState( {required this.loadedData, required this.fulldata,  });
}

class PaginationLoadingState extends PaginationState {}

class PaginationEmptyState extends PaginationState{

}

class PaginationErrorState extends PaginationState {
  final String error;
  PaginationErrorState({required this.error});
}


