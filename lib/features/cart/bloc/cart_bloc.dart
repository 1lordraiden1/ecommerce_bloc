import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grocery/data/cart_items.dart';
import 'package:grocery/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    double totalPrice = 0.0;
    for (var element in cartItems) {
      totalPrice += element.price;
    }
    emit(CartSuccessState(cartItems, totalPrice));
  }

  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.productDataModel);
    double totalPrice = 0.0;
    for (var element in cartItems) {
      totalPrice += element.price;
    }
    emit(CartRemovedActionState());
    emit(CartSuccessState(cartItems, totalPrice));
  }
}
