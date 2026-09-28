# SchamChat API Referansı

## Temel URL
```
http://localhost:8080
```

## WebSocket Endpoints

### Bağlantı
```
ws://localhost:8080
```

## REST API Endpoints

### Kullanıcı Yönetimi

#### Kayıt Ol
```
POST /api/auth/register
Content-Type: application/json

{
  "username": "string",
  "email": "string",
  "password": "string",
  "language": "tr" | "ar" | "de" | "en" | "pt"
}

Response: 200
{
  "token": "string",
  "user": {
    "id": "string",
    "username": "string",
    "email": "string",
    "profileImage": "string",
    "language": "string"
  }
}
```

#### Giriş Yap
```
POST /api/auth/login
Content-Type: application/json

{
  "email": "string",
  "password": "string"
}

Response: 200
{
  "token": "string",
  "user": { ... }
}
```

#### Profili Güncelle
```
PUT /api/users/:userId
Authorization: Bearer <token>
Content-Type: application/json

{
  "username": "string",
  "profileImage": "string",
  "bio": "string",
  "language": "string"
}

Response: 200
{
  "id": "string",
  "username": "string",
  "profileImage": "string",
  "bio": "string"
}
```

### Sesli Sohbet Odaları (Rooms)

#### Odaları Listele
```
GET /api/rooms

Response: 200
[
  {
    "id": "string",
    "name": "string",
    "description": "string",
    "currentUsers": "number",
    "maxUsers": "number",
    "thumbnail": "string"
  }
]
```

#### Oda Oluştur
```
POST /api/rooms
Authorization: Bearer <token>
Content-Type: application/json

{
  "name": "string",
  "description": "string",
  "maxUsers": "number"
}

Response: 201
{
  "id": "string",
  "name": "string",
  "creator": "string",
  "createdAt": "timestamp"
}
```

#### Odaya Katıl
```
POST /api/rooms/:roomId/join
Authorization: Bearer <token>

Response: 200
{
  "roomId": "string",
  "userId": "string",
  "users": []
}
```

### Sosyal Gönderiler (Moments)

#### Gönderileri Getir
```
GET /api/moments?page=1&limit=20

Response: 200
{
  "posts": [
    {
      "id": "string",
      "author": "string",
      "content": "string",
      "image": "string",
      "likes": "number",
      "comments": "number",
      "createdAt": "timestamp"
    }
  ],
  "total": "number",
  "page": "number"
}
```

#### Gönderi Oluştur
```
POST /api/moments
Authorization: Bearer <token>
Content-Type: application/json

{
  "content": "string",
  "image": "string (optional)",
  "tags": ["string"]
}

Response: 201
{
  "id": "string",
  "author": "string",
  "content": "string",
  "createdAt": "timestamp"
}
```

#### Gönderiyi Beğen
```
POST /api/moments/:postId/like
Authorization: Bearer <token>

Response: 200
{
  "liked": "boolean",
  "likes": "number"
}
```

### Cüzdan Yönetimi (Mine)

#### Cüzdan Bilgisi
```
GET /api/wallet/:userId
Authorization: Bearer <token>

Response: 200
{
  "userId": "string",
  "balance": "number",
  "currency": "string",
  "vipLevel": "string",
  "transactions": [
    {
      "id": "string",
      "type": "deposit" | "withdraw" | "game",
      "amount": "number",
      "date": "timestamp"
    }
  ]
}
```

#### Para Yatır
```
POST /api/wallet/:userId/deposit
Authorization: Bearer <token>
Content-Type: application/json

{
  "amount": "number",
  "method": "credit_card" | "paypal" | "crypto"
}

Response: 201
{
  "transactionId": "string",
  "status": "pending" | "completed",
  "amount": "number"
}
```

### Mini Oyunlar (Games)

#### Oyunları Listele
```
GET /api/games

Response: 200
[
  {
    "id": "string",
    "name": "string",
    "type": "slot" | "wheel" | "fishing",
    "description": "string",
    "thumbnail": "string"
  }
]
```

#### Oyun Oyna
```
POST /api/games/:gameId/play
Authorization: Bearer <token>
Content-Type: application/json

{
  "bet": "number",
  "data": {}
}

Response: 200
{
  "result": "win" | "lose",
  "prize": "number",
  "newBalance": "number"
}
```

## WebSocket Olayları

### Bağlantı
```javascript
socket.on('connected', (data) => {
  // { userId: string, sessionId: string }
});
```

### Oda Olayları
```javascript
socket.on('room:user-joined', (data) => {
  // { roomId: string, userId: string, username: string }
});

socket.on('room:user-left', (data) => {
  // { roomId: string, userId: string }
});

socket.on('room:message', (data) => {
  // { roomId: string, userId: string, message: string }
});
```

### Oyun Olayları
```javascript
socket.on('game:result', (data) => {
  // { gameId: string, result: string, prize: number }
});
```

## Hata Kodları

| Kod | Açıklama |
|-----|----------|
| 400 | Geçersiz İstek |
| 401 | Yetkisiz |
| 403 | Yasak |
| 404 | Bulunamadı |
| 500 | Sunucu Hatası |

## Rate Limiting

- 100 istek / dakika (Anonymous)
- 1000 istek / dakika (Authenticated)
- 5000 istek / dakika (VIP)
