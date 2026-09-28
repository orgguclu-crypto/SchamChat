const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');
const { authenticate } = require('../middleware/auth');

// Kayıt Ol
router.post('/register', authController.register);

// Giriş Yap
router.post('/login', authController.login);

// Token Yenile
router.post('/refresh', authController.refreshToken);

// Çıkış Yap
router.post('/logout', authenticate, authController.logout);

// Şifre Sıfırla
router.post('/forgot-password', authController.forgotPassword);
router.put('/reset-password/:token', authController.resetPassword);

module.exports = router;