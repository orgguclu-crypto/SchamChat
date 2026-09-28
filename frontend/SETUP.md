# Frontend Kurulum Kılavuzu

## Flutter Mobile Setup

### Gereksinimler
- Flutter 3.0+
- Android Studio
- Xcode (iOS için)
- Dart SDK

### Kurulum

```bash
# Flutter SDK'yı indir
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Kontrol et
flutter doctor

# Proje oluştur
flutter create --org com.schamchat schamchat_mobile
cd schamchat_mobile

# Bağımlılıkları yükle
flutter pub get
```

### pubspec.yaml

```yaml
name: schamchat_mobile
description: SchamChat - Sosyal Canlı Yayın Platformu
publish_to: 'none'

environment:
  sdk: '>=2.19.0 <3.0.0'

dependencies:
  flutter:
    sdk: flutter
  
  # Networking
  http: ^1.1.0
  web_socket_channel: ^2.4.0
  dio: ^5.0.0
  
  # State Management
  provider: ^6.0.0
  get_it: ^7.5.0
  
  # UI
  flutter_screenutil: ^5.9.0
  google_fonts: ^6.0.0
  cached_network_image: ^3.3.0
  
  # Localization
  easy_localization: ^6.3.0
  intl: ^0.19.0
  
  # Storage
  shared_preferences: ^2.2.0
  hive: ^2.2.3
  
  # WebRTC
  flutter_webrtc: ^0.9.0
  
  # Camera
  camera: ^0.10.0
  
  # Permission
  permission_handler: ^11.4.0
  
  # Utils
  logger: ^2.0.0
  connectivity_plus: ^5.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
  build_runner: ^2.4.0
  hive_generator: ^2.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/animations/
    - assets/icons/
  fonts:
    - family: Poppins
      fonts:
        - asset: assets/fonts/Poppins-Regular.ttf
        - asset: assets/fonts/Poppins-Bold.ttf
          weight: 700
```

## React Web Setup

### Gereksinimler
- Node.js 16+
- npm veya yarn

### Kurulum

```bash
# Proje oluştur
npx create-react-app schamchat-web
cd schamchat-web

# Bağımlılıkları yükle
npm install
```

### package.json Dependencies

```bash
npm install \
  axios \
  react-query \
  react-router-dom \
  zustand \
  tailwindcss \
  react-i18next \
  i18next \
  webrtc \
  simple-peer \
  socket.io-client \
  lodash \
  date-fns \
  recharts \
  react-hook-form \
  zod
```

### Dosya Yapısı

```
schamchat-web/
├── public/
│   ├── index.html
│   ├── favicon.ico
│   └── manifest.json
├── src/
│   ├── components/
│   │   ├── Navigation/
│   │   ├── Rooms/
│   │   ├── Moments/
│   │   ├── Games/
│   │   └── Wallet/
│   ├── pages/
│   │   ├── Home.jsx
│   │   ├── Login.jsx
│   │   ├── Rooms.jsx
│   │   ├── Moments.jsx
│   │   ├── Games.jsx
│   │   └── Profile.jsx
│   ├── hooks/
│   │   ├── useAuth.js
│   │   ├── useWebSocket.js
│   │   └── useLocalStorage.js
│   ├── services/
│   │   ├── api.js
│   │   ├── socket.js
│   │   └── auth.js
│   ├── store/
│   │   ├── authStore.js
│   │   ├── roomStore.js
│   │   └── gameStore.js
│   ├── utils/
│   │   ├── constants.js
│   │   ├── helpers.js
│   │   └── validators.js
│   ├── styles/
│   │   ├── globals.css
│   │   ├── tailwind.css
│   │   └── themes.css
│   ├── locales/
│   │   ├── tr.json
│   │   ├── ar.json
│   │   ├── de.json
│   │   ├── en.json
│   │   └── pt.json
│   ├── App.jsx
│   └── index.js
├── .env.example
├── .gitignore
├── package.json
├── tailwind.config.js
└── webpack.config.js
```

### Environment Variables (.env)

```
REACT_APP_API_URL=http://localhost:8080/api
REACT_APP_WS_URL=ws://localhost:8080
REACT_APP_ENV=development
```

### Başlatma

```bash
# Development
npm start

# Production Build
npm run build

# Test
npm test
```
