const jwt = require('jsonwebtoken');
const User = require('../models/User');

const authController = {
  register: async (req, res) => {
    try {
      const { username, email, password, language } = req.body;

      if (!username || !email || !password) {
        return res.status(400).json({ error: 'Tüm alanlar zorunlu' });
      }

      const existingUser = await User.findOne({ $or: [{ email }, { username }] });
      if (existingUser) {
        return res.status(400).json({ error: 'Email veya kullanıcı adı zaten kayıtlı' });
      }

      const user = new User({
        username,
        email,
        password,
        language: language || 'tr'
      });

      await user.save();

      const token = jwt.sign(
        { id: user._id, username: user.username },
        process.env.JWT_SECRET,
        { expiresIn: process.env.JWT_EXPIRY || '24h' }
      );

      res.status(201).json({
        success: true,
        token,
        user: {
          id: user._id,
          username: user.username,
          email: user.email,
          language: user.language
        }
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  login: async (req, res) => {
    try {
      const { email, password } = req.body;

      if (!email || !password) {
        return res.status(400).json({ error: 'Email ve şifre gerekli' });
      }

      const user = await User.findOne({ email }).select('+password');
      if (!user) {
        return res.status(401).json({ error: 'Email veya şifre yanlış' });
      }

      const isPasswordValid = await user.comparePassword(password);
      if (!isPasswordValid) {
        return res.status(401).json({ error: 'Email veya şifre yanlış' });
      }

      const token = jwt.sign(
        { id: user._id, username: user.username },
        process.env.JWT_SECRET,
        { expiresIn: process.env.JWT_EXPIRY || '24h' }
      );

      const refreshToken = jwt.sign(
        { id: user._id },
        process.env.REFRESH_TOKEN_SECRET,
        { expiresIn: process.env.REFRESH_TOKEN_EXPIRY || '30d' }
      );

      res.json({
        success: true,
        token,
        refreshToken,
        user: {
          id: user._id,
          username: user.username,
          email: user.email,
          profileImage: user.profileImage,
          vipLevel: user.vipLevel,
          language: user.language
        }
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  refreshToken: async (req, res) => {
    try {
      const { refreshToken } = req.body;

      if (!refreshToken) {
        return res.status(400).json({ error: 'Refresh token gerekli' });
      }

      const decoded = jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET);
      const user = await User.findById(decoded.id);

      if (!user) {
        return res.status(401).json({ error: 'Kullanıcı bulunamadı' });
      }

      const newToken = jwt.sign(
        { id: user._id, username: user.username },
        process.env.JWT_SECRET,
        { expiresIn: process.env.JWT_EXPIRY || '24h' }
      );

      res.json({
        success: true,
        token: newToken
      });
    } catch (error) {
      res.status(401).json({ error: 'Geçersiz token' });
    }
  },

  logout: async (req, res) => {
    try {
      res.json({ success: true, message: 'Çıkış yapıldı' });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
};

module.exports = authController;