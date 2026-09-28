# Backend Setup

## Kurulum

```bash
# Proje klasörüne gir
cd backend

# Bağımlılıkları yükle
npm install
```

## Environment Variables

`.env` dosyası oluştur:

```
NODE_ENV=development
PORT=8080
WS_PORT=8080

# Database
MONGO_URI=mongodb://localhost:27017/schamchat
REDIS_URL=redis://localhost:6379

# JWT
JWT_SECRET=your-secret-key-here
JWT_EXPIRY=24h
REFRESH_TOKEN_SECRET=your-refresh-secret
REFRESH_TOKEN_EXPIRY=30d

# CORS
CORS_ORIGIN=http://localhost:3000

# Logging
LOG_LEVEL=info

# Payment
STRIPE_KEY=pk_test_...
PAYPAL_CLIENT_ID=...

# Email
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=your-app-password
```

## Docker Setup

### docker-compose.yml

```yaml
version: '3.8'

services:
  # MongoDB
  mongo:
    image: mongo:6.0
    ports:
      - "27017:27017"
    volumes:
      - mongo_data:/data/db
    environment:
      MONGO_INITDB_ROOT_USERNAME: admin
      MONGO_INITDB_ROOT_PASSWORD: password

  # Redis
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data

  # Node.js Backend
  api:
    build: .
    ports:
      - "8080:8080"
    depends_on:
      - mongo
      - redis
    environment:
      - NODE_ENV=development
      - MONGO_URI=mongodb://admin:password@mongo:27017/schamchat
      - REDIS_URL=redis://redis:6379
    volumes:
      - .:/app
      - /app/node_modules
    command: npm run dev

volumes:
  mongo_data:
  redis_data:
```

### Başlat

```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

## NPM Scripts

```bash
# Development
npm run dev

# Production
npm start

# Test
npm test

# Linting
npm run lint

# Database Migration
npm run migrate
```

## API Testing

### Postman Collection

`/backend/postman/SchamChat.postman_collection.json`

### cURL Examples

```bash
# Kayıt Ol
curl -X POST http://localhost:8080/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "email": "test@example.com",
    "password": "securepass123"
  }'

# Giriş Yap
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "securepass123"
  }'
```
