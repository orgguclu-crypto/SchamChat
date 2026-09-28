const Wallet = require('../models/Wallet');
const Transaction = require('../models/Transaction');

const walletController = {
  getWallet: async (req, res) => {
    try {
      const { userId } = req.params;

      if (userId !== req.user.id && req.user.role !== 'admin') {
        return res.status(403).json({ error: 'Yetkisiz' });
      }

      let wallet = await Wallet.findOne({ userId })
        .populate('transactions');

      if (!wallet) {
        wallet = new Wallet({ userId });
        await wallet.save();
      }

      res.json(wallet);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  deposit: async (req, res) => {
    try {
      const { userId } = req.params;
      const { amount, method } = req.body;

      if (userId !== req.user.id) {
        return res.status(403).json({ error: 'Yetkisiz' });
      }

      if (!amount || amount <= 0) {
        return res.status(400).json({ error: 'Geçerli bir tutar girin' });
      }

      let wallet = await Wallet.findOne({ userId });
      if (!wallet) {
        wallet = new Wallet({ userId });
      }

      const transaction = new Transaction({
        userId,
        type: 'deposit',
        amount,
        method: method || 'credit_card',
        status: 'completed'
      });

      await transaction.save();

      wallet.balance += amount;
      wallet.totalDeposited += amount;
      wallet.transactions.push(transaction._id);
      await wallet.save();

      res.status(201).json({
        success: true,
        message: 'Para başarıyla yatırıldı',
        wallet,
        transaction
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
};

module.exports = walletController;