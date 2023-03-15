part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeEventAdd extends HomeEvent {}

class HomeEventRemove extends HomeEvent {}

// Fetch Product Event
class HomeEventFetch extends HomeEvent {}

class HomeEventToggleDisplay extends HomeEvent {}
