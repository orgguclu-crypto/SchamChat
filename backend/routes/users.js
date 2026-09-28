const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const { authenticate } = require('../middleware/auth');

// Kullanıcı profilini getir
router.get('/:id', userController.getUserProfile);

// Profili güncelle
router.put('/:id', authenticate, userController.updateProfile);

// Profil resmini yükle
router.post('/:id/avatar', authenticate, userController.uploadAvatar);

// Kullanıcıyı ara
router.get('/search/:query', userController.searchUsers);

// Kullanıcıyı takip et
router.post('/:id/follow', authenticate, userController.followUser);

// Takibi bırak
router.post('/:id/unfollow', authenticate, userController.unfollowUser);

// Takipçileri getir
router.get('/:id/followers', userController.getFollowers);

// Takip edilenleri getir
router.get('/:id/following', userController.getFollowing);

module.exports = router;