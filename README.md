# SchamChat - Sosyal Canlı Yayın ve Eğlence Platformu

## 🎬 Proje Açıklaması

SchamChat, modern sosyal ağ ve eğlence deneyimini birleştiren bir platformdur.

### 🌟 Ana Özellikler

#### 1. **Rooms** (Sesli Sohbet Odaları)
- P2P sesli sohbet odaları
- Gerçek zamanlı WebRTC bağlantısı
- Çoklu kullanıcı desteği
- Oda kontrolü ve yönetimi

#### 2. **Moments** (Canlı Yayın & Sosyal Gönderiler)
- Canlı yayın akışları
- Sosyal gönderiler paylaşımı
- Yorum ve beğeni sistemi
- Etkileşimli içerik

#### 3. **Mine** (Profil & Cüzdan Yönetimi)
- Kullanıcı profili düzenleme
- Dijital cüzdan yönetimi
- İstatistikler ve başarılar
- Ödeme işlemleri

#### 4. **Games** (Mini Oyunlar)
- **Azal Farm / Ferris Wheel** - Şans çarkı mini oyunu
- **Jackpot** - Meyve simgeli slot makinesi
- **Money Pot / Fortune Pot** - Doğu/Çin temalı altın ve şans slot oyunu
- **Starshine Princess, Captain Fishing, Gold of Olympus** - Popüler slot ve çark oyunları

### 🎨 Tasarım Teması

- **Ana Stil**: Golden 777 / VIP / Asil teması
- **Arka Plan**: Altın kanatlı, taçlı ve elmas işlemeli çerçeveler
- **Logo**: Aslan tasarımı
- **Renk Şeması**: Altın, premium siyah ve kırmızı tonları

### 🌐 Dil Desteği

- 🇹🇷 Türkçe
- 🇸🇦 Arapça
- 🇩🇪 Almanca
- 🇬🇧 İngilizce
- 🇵🇷 Portekizce

## 🚀 Başlangıç

### Gereksinimler
- Node.js 14+
- npm veya yarn

### Kurulum

```bash
# Depoyu klonla
git clone https://github.com/orgguclu-crypto/SchamChat.git
cd SchamChat

# Bağımlılıkları yükle
npm install

# Sunucuyu başlat
npm start
```

### Geliştirme Modu

```bash
npm run dev
```

Sunucu `http://localhost:8080` adresinde çalışacaktır.

## 📁 Proje Yapısı

```
SchamChat/
├── server.js                 # WebSocket sinyalleşme sunucusu
├── package.json              # Proje bağımlılıkları
├── README.md                 # Bu dosya
├── docs/                     # Dokumentasyon
│   ├── API.md              # API referansı
│   ├── ARCHITECTURE.md      # Mimarı tasarımı
│   └── LOCALIZATION.md      # Dil desteği konfigürasyonu
├── backend/                  # Backend uygulaması
│   ├── routes/             # API rotaları
│   ├── models/             # Veri modelleri
│   ├── controllers/        # İş mantığı
│   └── middleware/         # Middleware
├── frontend/                 # Frontend uygulaması (Flutter/React)
│   ├── lib/                # Flutter kütüphaneleri
│   ├── src/                # React kaynakları
│   └── assets/             # Görseller ve kaynaklar
└── tests/                    # Test dosyaları
```

## 🔧 WebSocket API

### Bağlantı Kurma

```javascript
const socket = new WebSocket('ws://localhost:8080');
```

### Mesaj Türleri

#### 1. Odaya Katıl
```json
{
  "type": "join"
}
```

#### 2. Eş Bulundu
```json
{
  "type": "matched",
  "role": "offerer"
}
```

#### 3. WebRTC Offer
```json
{
  "type": "offer",
  "data": {}
}
```

#### 4. WebRTC Answer
```json
{
  "type": "answer",
  "data": {}
}
```

#### 5. ICE Candidate
```json
{
  "type": "candidate",
  "data": {}
}
```

#### 6. Odadan Ayrıl
```json
{
  "type": "leave"
}
```

## 🔐 Güvenlik

- WSS (WebSocket Secure) desteği
- JWT tabanlı kimlik doğrulama
- Rate limiting
- CORS yapılandırması
- Veri şifreleme

## 📊 Teknoloji Stack

### Backend
- Node.js + Express.js
- WebSocket (ws kütüphanesi)
- MongoDB / PostgreSQL
- JWT Authentication

### Frontend
- Flutter (Mobil)
- React.js (Web)
- WebRTC
- Redux (State Management)

### DevOps
- Docker
- Docker Compose
- GitHub Actions
- AWS/GCP Deployment

## 📝 Lisans

MIT License - Detaylar için LICENSE dosyasına bakınız.

## 👥 Katkı Sağlama

1. Fork yapın
2. Feature branch oluşturun (`git checkout -b feature/AmazingFeature`)
3. Değişiklikleri commit edin (`git commit -m 'Add some AmazingFeature'`)
4. Branch'e push yapın (`git push origin feature/AmazingFeature`)
5. Pull Request oluşturun

## 📧 İletişim

Sorular veya öneriler için lütfen ilişkiye geçin: orgguclu-crypto@example.com

---

**SchamChat** - Premium Sosyal Eğlence Platformu 🎭✨