part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitEvent extends HomeEvent {}

class HomeProductWishlistButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;

  HomeProductWishlistButtonClickedEvent(this.clickedProduct);
}

class HomeProductCartButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;

  HomeProductCartButtonClickedEvent(this.clickedProduct);
}

class HomeWishlistButtonNavigateEvent extends HomeEvent {}

class HomeCartButtonNavigateEvent extends HomeEvent {}
