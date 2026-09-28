const mongoose = require('mongoose');

const gameSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    unique: true
  },
  type: {
    type: String,
    enum: ['slot', 'wheel', 'fishing', 'card', 'board'],
    required: true
  },
  description: {
    type: String,
    default: ''
  },
  thumbnail: {
    type: String,
    default: null
  },
  rules: {
    type: mongoose.Schema.Types.Mixed,
    default: {}
  },
  minBet: {
    type: Number,
    default: 1
  },
  maxBet: {
    type: Number,
    default: 1000
  },
  rtp: {
    type: Number,
    default: 96.5 // Return to Player (RTP) %
  },
  isActive: {
    type: Boolean,
    default: true
  },
  createdAt: {
    type: Date,
    default: Date.now
  }
});

module.exports = mongoose.model('Game', gameSchema);