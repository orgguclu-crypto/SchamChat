const express = require('express');
const router = express.Router();
const gameController = require('../controllers/gameController');
const { authenticate } = require('../middleware/auth');

// Tüm oyunları listele
router.get('/', gameController.getAllGames);

// Oyun detaylarını getir
router.get('/:id', gameController.getGameById);

// Oyun oyna
router.post('/:gameId/play', authenticate, gameController.playGame);

// Oyun sonuçlarını getir
router.get('/:gameId/results', authenticate, gameController.getGameResults);

// Leaderboard
router.get('/:gameId/leaderboard', gameController.getLeaderboard);

module.exports = router;