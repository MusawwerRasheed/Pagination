import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination/Data/Repository/pagination_repository.dart';
import 'package:pagination/Domain/Models/Carts.dart';
import 'package:pagination/Domain/Models/outer_data_model.dart';
import '../State/pagination_state.dart';

class PaginationCubit extends Cubit<PaginationState> {
  List<Cart> paginatedDto = [];
  List<Cart> empty = [];

  PaginationCubit() : super(PaginationInitialState());

  Future<void> getCarts({bool? load, int? pageNo}) async {
    if (load == null) {
      emit(PaginationLoadingState());
    }
    if (load == false) {
      try {
        paginatedDto.add(Cart(title: "No more products >>>"));
        emit(PaginationLoadedState(loadedData: empty, fulldata: paginatedDto));
      } catch (e) {
        emit(PaginationErrorState(error: e.toString()));
        rethrow;
      }
    }
    else {
      try {
        Map<String, dynamic> value = await PaginationRepository.getCarts(
            pageNo);
        List<Cart> carts = List<Cart>.from(
            value['products'].map((x) => Cart.fromJson(x)));
        paginatedDto.addAll(carts);
        emit(PaginationLoadedState(loadedData: carts, fulldata: paginatedDto));
      } catch (e) {
        emit(PaginationErrorState(error: e.toString()));
        rethrow;
      }
    }
  }

}






  // Future<void> loadMoreCarts() async {
  //   if (!_isLoading) {
  //     try {
  //       emit(PaginationLoadingState());
  //       _isLoading = true;
  //
  //       Map<String, dynamic> moreData = await PaginationRepository.getCarts(_currentPage);
  //
  //       List<Cart> moreCarts = List<Cart>.from(moreData['carts'].map((x) => Cart.fromJson(x)));
  //
  //       _currentPage++;
  //
  //       emit(PaginationLoadedState(loadedData: moreCarts, fulldata: paginatedDto ));
  //
  //     } catch (e) {
  //       emit(PaginationErrorState(error: e.toString()));
  //       rethrow;
  //     } finally {
  //       _isLoading = false;
  //     }
  //   }
  // }
  //
  //





















// class PaginationCubit extends Cubit<PaginationState> {
//   PaginationCubit() : super(PaginationInitialState());
//
//   Future<void> getCarts() async {
//     emit(PaginationLoading());
//     try {
//      Map<String, dynamic> value = await PaginationRepository.getCarts();
//
//        List <Cart> carts = List<Cart>.from(value['carts'].map((x) => Cart.fromJson(x)));
//
//       emit(PaginationLoadedState(loadedData: carts));
//     } catch (e ) {
//       emit(PaginationErrorState(error: e.toString()));
//       rethrow;
//     }
//   }
// }
