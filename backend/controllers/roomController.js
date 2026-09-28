const Room = require('../models/Room');

const roomController = {
  getAllRooms: async (req, res) => {
    try {
      const { category, search, page = 1, limit = 20 } = req.query;

      let query = { isPrivate: false };

      if (category) {
        query.category = category;
      }

      if (search) {
        query.name = { $regex: search, $options: 'i' };
      }

      const rooms = await Room.find(query)
        .populate('creator', 'username profileImage')
        .limit(limit * 1)
        .skip((page - 1) * limit)
        .sort({ createdAt: -1 });

      const total = await Room.countDocuments(query);

      res.json({
        rooms,
        total,
        pages: Math.ceil(total / limit),
        currentPage: page
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  getRoomById: async (req, res) => {
    try {
      const room = await Room.findById(req.params.id)
        .populate('creator', 'username profileImage')
        .populate('currentUsers', 'username profileImage vipLevel');

      if (!room) {
        return res.status(404).json({ error: 'Oda bulunamadı' });
      }

      res.json(room);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  createRoom: async (req, res) => {
    try {
      const { name, description, maxUsers, category, isPrivate, password } = req.body;

      if (!name) {
        return res.status(400).json({ error: 'Oda adı gerekli' });
      }

      const room = new Room({
        name,
        description,
        maxUsers: maxUsers || 4,
        category: category || 'talk',
        creator: req.user.id,
        isPrivate: isPrivate || false,
        password: isPrivate ? password : null,
        currentUsers: [req.user.id]
      });

      await room.save();
      await room.populate('creator', 'username profileImage');

      res.status(201).json({
        success: true,
        message: 'Oda başarıyla oluşturuldu',
        room
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  joinRoom: async (req, res) => {
    try {
      const room = await Room.findById(req.params.id);

      if (!room) {
        return res.status(404).json({ error: 'Oda bulunamadı' });
      }

      if (room.currentUsers.includes(req.user.id)) {
        return res.status(400).json({ error: 'Zaten bu odadasınız' });
      }

      if (room.currentUsers.length >= room.maxUsers) {
        return res.status(400).json({ error: 'Oda dolu' });
      }

      room.currentUsers.push(req.user.id);
      room.isLive = true;
      await room.save();

      await room.populate('currentUsers', 'username profileImage vipLevel');

      res.json({
        success: true,
        message: 'Odaya katıldınız',
        room
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  leaveRoom: async (req, res) => {
    try {
      const room = await Room.findById(req.params.id);

      if (!room) {
        return res.status(404).json({ error: 'Oda bulunamadı' });
      }

      room.currentUsers = room.currentUsers.filter(
        userId => userId.toString() !== req.user.id
      );

      if (room.currentUsers.length === 0) {
        room.isLive = false;
      }

      await room.save();

      res.json({
        success: true,
        message: 'Odadan ayrıldınız'
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
};

module.exports = roomController;