import 'package:flutter/material.dart';
import '../models/models.dart';
import 'sample_data.dart';

/// Very small in-memory store for the prototype. No backend required.
class AppState extends ChangeNotifier {
  AppState._();
  static final AppState instance = AppState._();

  final List<CartItem> _cart = [];
  final Set<String> _enrolledCourseIds = {};
  final List<Order> _orders = List.of(SampleData.orders);
  bool _ownsWorkbook = false;
  List<CartItem> _lastOrderItems = [];
  double _lastOrderTotal = 0;

  List<CartItem> get cart => List.unmodifiable(_cart);
  List<Order> get orders => List.unmodifiable(_orders);
  bool get ownsWorkbook => _ownsWorkbook;
  Set<String> get enrolledCourseIds => Set.unmodifiable(_enrolledCourseIds);
  List<CartItem> get lastOrderItems => List.unmodifiable(_lastOrderItems);
  double get lastOrderTotal => _lastOrderTotal;

  int get cartCount => _cart.fold(0, (sum, item) => sum + item.quantity);

  double get cartSubtotal =>
      _cart.fold(0.0, (sum, item) => sum + item.lineTotal);

  double get cartTotal => _cart.isEmpty ? 0 : cartSubtotal + 10;

  void addToCart(Product product) {
    final existing = _cart.where((i) => i.product.id == product.id);
    if (existing.isNotEmpty) {
      existing.first.quantity++;
    } else {
      _cart.add(CartItem(product, 1));
    }
    notifyListeners();
  }

  void increment(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  void decrement(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _cart.remove(item);
    }
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _cart.remove(item);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  void completeOrder() {
    _ownsWorkbook = true;
    _lastOrderTotal = cartTotal == 0 ? 118 : cartTotal;
    _lastOrderItems = _cart
        .map((i) => CartItem(i.product, i.quantity))
        .toList();
    _orders.insert(
      0,
      Order(
          id: 'MA1003',
          amount: _lastOrderTotal,
          status: 'Paid',
          items: _lastOrderItems.map((i) => i.product).toList()),
    );
    _cart.clear();
    notifyListeners();
  }

  void enrol(Course course) {
    _enrolledCourseIds.add(course.id);
    notifyListeners();
  }
}