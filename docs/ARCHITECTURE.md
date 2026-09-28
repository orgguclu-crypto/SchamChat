# SchamChat Mimari Tasarımı

## Genel Mimarı

```
┌─────────────────────────────────────┐
│         Frontend (Client)            │
│  ┌──────────────┐  ┌─────────────┐  │
│  │   Flutter    │  │   React Web │  │
│  │   (Mobile)   │  │   (Browser) │  │
│  └──────────────┘  └─────────────┘  │
└────────────────┬────────────────────┘
                 │ (WebSocket/REST)
┌────────────────▼────────────────────┐
│    API Gateway & Load Balancer      │
├─────────────────────────────────────┤
│      Backend (Node.js + Express)    │
│  ┌──────────┐  ┌──────────┐        │
│  │ Auth Svc │  │ Room Svc │        │
│  └──────────┘  └──────────┘        │
│  ┌──────────┐  ┌──────────┐        │
│  │Moments Svc│ │ Game Svc │        │
│  └──────────┘  └──────────┘        │
│  ┌──────────┐  ┌──────────┐        │
│  │Wallet Svc│  │WebSocket │        │
│  └──────────┘  └──────────┘        │
└────────────┬───────┬────────────────┘
             │       │
      ┌──────▼──┐   ┌▼─────────┐
      │ MongoDB │   │  Redis   │
      │(Primary)│   │ (Cache)  │
      └─────────┘   └──────────┘
```

## Servisler

### 1. Authentication Service
- JWT Token Yönetimi
- Kullanıcı Kaydı ve Girişi
- Şifre Sıfırlama
- OAuth2 Entegrasyonu (Opsiyonel)

### 2. Room Service
- Oda Yönetimi
- Kullanıcı Matching
- WebRTC Sinyalleşme
- Ses Akışı İşleme

### 3. Moments Service
- Sosyal Gönderi Yönetimi
- Beğeni ve Yorum Sistemi
- Feed Algoritması
- Medya İşleme

### 4. Game Service
- Oyun Motor Yönetimi
- Bahis İşlemleri
- Sonuç Hesaplaması
- Ödül Dağıtımı

### 5. Wallet Service
- Bakiye Yönetimi
- Para Girişi/Çıkışı
- İşlem Geçmişi
- VIP Seviye Yönetimi

### 6. WebSocket Service
- Real-time İletişim
- Event Yönetimi
- Oda Yayını
- Bildirim Gönderimi

## Veri Modeli

### User (Kullanıcı)
```javascript
{
  _id: ObjectId,
  username: String,
  email: String,
  password: String (hashed),
  profileImage: String,
  bio: String,
  language: String,
  vipLevel: Number,
  createdAt: Date,
  updatedAt: Date
}
```

### Room (Oda)
```javascript
{
  _id: ObjectId,
  name: String,
  description: String,
  creator: ObjectId (User),
  currentUsers: [ObjectId],
  maxUsers: Number,
  thumbnail: String,
  isPrivate: Boolean,
  createdAt: Date
}
```

### Moment (Gönderi)
```javascript
{
  _id: ObjectId,
  author: ObjectId (User),
  content: String,
  image: String,
  likes: [ObjectId],
  comments: [Object],
  tags: [String],
  createdAt: Date,
  updatedAt: Date
}
```

### Wallet (Cüzdan)
```javascript
{
  _id: ObjectId,
  userId: ObjectId (User),
  balance: Number,
  currency: String,
  vipLevel: Number,
  transactions: [Object],
  createdAt: Date
}
```

### Game (Oyun)
```javascript
{
  _id: ObjectId,
  name: String,
  type: String,
  description: String,
  thumbnail: String,
  rules: Object,
  createdAt: Date
}
```

## Güvenlik Slotları

### Authentication
- JWT Token Tabanlı
- Token Expiry: 24 Saatlik
- Refresh Token: 30 Günlük
- Bcrypt Şifre Hashing

### Authorization
- Role-Based Access Control (RBAC)
- Roller: User, Moderator, Admin

### API Güvenliği
- Rate Limiting
- CORS Yapılandırması
- HTTPS Enforced
- Input Validation
- SQL Injection Koruması

### Data Encryption
- SSL/TLS Transport
- Hassas Veri Şifreleme
- Secure Token Storage

## Ölçeklendirebilirlik

### Yatay Ölçekleme
- Multiple Server Instances
- Load Balancer (Nginx/HAProxy)
- Session Sharing (Redis)

### Dikey Ölçekleme
- Database Indexing
- Query Optimization
- Caching Strategy (Redis)
- CDN Kullanımı

## Deployment Stratejisi

### Development
```bash
docker-compose -f docker-compose.dev.yml up
```

### Production
```bash
docker-compose -f docker-compose.prod.yml up -d
```

### Kubernetes (Opsiyonel)
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: schamchat-api
spec:
  replicas: 3
  selector:
    matchLabels:
      app: schamchat-api
  template:
    metadata:
      labels:
        app: schamchat-api
    spec:
      containers:
      - name: api
        image: schamchat-api:latest
        ports:
        - containerPort: 8080
```
