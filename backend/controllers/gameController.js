const Game = require('../models/Game');
const Transaction = require('../models/Transaction');
const Wallet = require('../models/Wallet');

const gameController = {
  getAllGames: async (req, res) => {
    try {
      const { type, page = 1, limit = 20 } = req.query;

      let query = { isActive: true };

      if (type) {
        query.type = type;
      }

      const games = await Game.find(query)
        .limit(limit * 1)
        .skip((page - 1) * limit)
        .sort({ createdAt: -1 });

      const total = await Game.countDocuments(query);

      res.json({
        games,
        total,
        pages: Math.ceil(total / limit),
        currentPage: page
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  playGame: async (req, res) => {
    try {
      const { gameId } = req.params;
      const { bet } = req.body;

      if (!bet || bet <= 0) {
        return res.status(400).json({ error: 'Geçerli bir bahis miktarı girin' });
      }

      const game = await Game.findById(gameId);
      if (!game) {
        return res.status(404).json({ error: 'Oyun bulunamadı' });
      }

      if (bet < game.minBet || bet > game.maxBet) {
        return res.status(400).json({ error: `Bahis ${game.minBet}-${game.maxBet} arasında olmalı` });
      }

      let wallet = await Wallet.findOne({ userId: req.user.id });
      if (!wallet || wallet.balance < bet) {
        return res.status(400).json({ error: 'Yetersiz bakiye' });
      }

      const isWin = Math.random() < (game.rtp / 100);
      const prize = isWin ? bet * 2 : 0;

      const transaction = new Transaction({
        userId: req.user.id,
        type: 'game',
        amount: isWin ? prize - bet : -bet,
        status: 'completed',
        gameId,
        description: isWin ? `${game.name} kazandı: ${prize}` : `${game.name} kaybetti: ${bet}`
      });

      await transaction.save();

      wallet.balance = wallet.balance - bet + prize;
      wallet.transactions.push(transaction._id);
      await wallet.save();

      res.json({
        success: true,
        result: isWin ? 'win' : 'lose',
        prize,
        newBalance: wallet.balance,
        transaction
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
};

module.exports = gameController;