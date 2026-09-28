const express = require('express');
const router = express.Router();
const roomController = require('../controllers/roomController');
const { authenticate } = require('../middleware/auth');

// Tüm odaları listele
router.get('/', roomController.getAllRooms);

// Oda detaylarını getir
router.get('/:id', roomController.getRoomById);

// Yeni oda oluştur
router.post('/', authenticate, roomController.createRoom);

// Odayı güncelle
router.put('/:id', authenticate, roomController.updateRoom);

// Odayı sil
router.delete('/:id', authenticate, roomController.deleteRoom);

// Odaya katıl
router.post('/:id/join', authenticate, roomController.joinRoom);

// Odadan ayrıl
router.post('/:id/leave', authenticate, roomController.leaveRoom);

// Oda kullanıcılarını getir
router.get('/:id/users', roomController.getRoomUsers);

module.exports = router;