import 'package:flutter/material.dart';
import '../../models/wallet_model.dart';

class WalletProvider extends ChangeNotifier {
  WalletModel? _wallet;
  bool _isLoading = false;
  String? _error;

  WalletModel? get wallet => _wallet;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchWallet() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: API call
      await Future.delayed(const Duration(seconds: 1));
      _wallet = WalletModel(
        id: '1',
        balance: 1500.50,
        currency: 'USD',
        vipLevel: 2,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deposit(double amount) async {
    try {
      if (_wallet != null) {
        _wallet = _wallet!.copyWith(
          balance: _wallet!.balance + amount,
        );
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> withdraw(double amount) async {
    try {
      if (_wallet != null && _wallet!.balance >= amount) {
        _wallet = _wallet!.copyWith(
          balance: _wallet!.balance - amount,
        );
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
