import 'package:bay_flutter1/src/models/product.dart';
import 'package:bay_flutter1/src/services/network_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    // Fetch products
    on<HomeEventFetch>((event, emit) async {
      try {
        emit(state.copyWith(products: [], status: FetchStatus.fetching));
        await Future.delayed(Duration(seconds: 1));
        final result = await NetworkService().getProduct();
        emit(state.copyWith(products: result, status: FetchStatus.success));
      } catch (e) {
        emit(state.copyWith(products: [], status: FetchStatus.failed));
      }
    });

    // toggle display mode between grid and list view
    on<HomeEventToggleDisplay>((event, emit) async {
      emit(state.copyWith(isGrid: !state.isGrid));
    });
  }
}
