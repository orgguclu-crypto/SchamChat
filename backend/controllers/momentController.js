const Moment = require('../models/Moment');

const momentController = {
  getAllMoments: async (req, res) => {
    try {
      const { page = 1, limit = 20 } = req.query;

      const moments = await Moment.find({ isPublic: true })
        .populate('author', 'username profileImage vipLevel')
        .populate('comments.author', 'username profileImage')
        .limit(limit * 1)
        .skip((page - 1) * limit)
        .sort({ createdAt: -1 });

      const total = await Moment.countDocuments({ isPublic: true });

      res.json({
        moments,
        total,
        pages: Math.ceil(total / limit),
        currentPage: page
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  createMoment: async (req, res) => {
    try {
      const { content, image, video, tags, isPublic } = req.body;

      if (!content) {
        return res.status(400).json({ error: 'Gönderi içeriği gerekli' });
      }

      const moment = new Moment({
        author: req.user.id,
        content,
        image,
        video,
        tags: tags || [],
        isPublic: isPublic !== undefined ? isPublic : true
      });

      await moment.save();
      await moment.populate('author', 'username profileImage vipLevel');

      res.status(201).json({
        success: true,
        message: 'Gönderi oluşturuldu',
        moment
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  likeMoment: async (req, res) => {
    try {
      const moment = await Moment.findById(req.params.id);

      if (!moment) {
        return res.status(404).json({ error: 'Gönderi bulunamadı' });
      }

      if (!moment.likes.includes(req.user.id)) {
        moment.likes.push(req.user.id);
        await moment.save();
      }

      res.json({
        success: true,
        message: 'Gönderi beğenildi',
        likes: moment.likes.length
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
};

module.exports = momentController;