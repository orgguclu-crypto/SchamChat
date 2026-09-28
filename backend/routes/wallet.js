const express = require('express');
const router = express.Router();
const walletController = require('../controllers/walletController');
const { authenticate } = require('../middleware/auth');

// Cüzdan bilgisini getir
router.get('/:userId', authenticate, walletController.getWallet);

// Para yatır
router.post('/:userId/deposit', authenticate, walletController.deposit);

// Para çek
router.post('/:userId/withdraw', authenticate, walletController.withdraw);

// İşlem geçmişini getir
router.get('/:userId/transactions', authenticate, walletController.getTransactions);

// VIP yükseltme
router.post('/:userId/upgrade-vip', authenticate, walletController.upgradeVIP);

module.exports = router;