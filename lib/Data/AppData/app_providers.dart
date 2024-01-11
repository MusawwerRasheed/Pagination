
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination/Presentation/Pagination/Controller/pagination_cubit.dart';
 

List<BlocProvider> appProviders = [
BlocProvider<PaginationCubit>(create: (context) => PaginationCubit()),

];


