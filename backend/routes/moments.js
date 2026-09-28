const express = require('express');
const router = express.Router();
const momentController = require('../controllers/momentController');
const { authenticate } = require('../middleware/auth');

// Tüm gönderileri getir
router.get('/', momentController.getAllMoments);

// Kullanıcı gönderilerini getir
router.get('/user/:userId', momentController.getUserMoments);

// Gönderi detaylarını getir
router.get('/:id', momentController.getMomentById);

// Yeni gönderi oluştur
router.post('/', authenticate, momentController.createMoment);

// Gönderiyi güncelle
router.put('/:id', authenticate, momentController.updateMoment);

// Gönderiyi sil
router.delete('/:id', authenticate, momentController.deleteMoment);

// Gönderiyi beğen
router.post('/:id/like', authenticate, momentController.likeMoment);

// Beğeniyi kaldır
router.post('/:id/unlike', authenticate, momentController.unlikeMoment);

// Yorum ekle
router.post('/:id/comments', authenticate, momentController.addComment);

// Yorumu sil
router.delete('/:id/comments/:commentId', authenticate, momentController.deleteComment);

module.exports = router;