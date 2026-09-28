const WebSocket = require('ws');
const server = new WebSocket.Server({ port: 8080 });

let waitingUser = null;

server.on('connection', (socket) => {
    socket.id = Math.random().toString(36).substring(7);
    console.log(`[Bağlandı] Kullanıcı ID: ${socket.id}`);

    socket.on('message', (message) => {
        try {
            const data = JSON.parse(message);

            switch (data.type) {
                case 'join':
                    if (waitingUser && waitingUser !== socket) {
                        socket.peer = waitingUser;
                        waitingUser.peer = socket;

                        socket.send(JSON.stringify({ type: 'matched', role: 'offerer' }));
                        waitingUser.send(JSON.stringify({ type: 'matched', role: 'answerer' }));

                        waitingUser = null;
                    } else {
                        waitingUser = socket;
                        socket.send(JSON.stringify({ type: 'waiting' }));
                    }
                    break;

                case 'offer':
                case 'answer':
                case 'candidate':
                    if (socket.peer && socket.peer.readyState === WebSocket.OPEN) {
                        socket.peer.send(JSON.stringify(data));
                    }
                    break;

                case 'leave':
                    handleDisconnect(socket);
                    break;
            }
        } catch (e) {
            console.error('Hata:', e);
        }
    });

    socket.on('close', () => {
        console.log(`[Ayrıldı] Kullanıcı ID: ${socket.id}`);
        handleDisconnect(socket);
    });
});

function handleDisconnect(socket) {
    if (waitingUser === socket) {
        waitingUser = null;
    }
    if (socket.peer) {
        if (socket.peer.readyState === WebSocket.OPEN) {
            socket.peer.send(JSON.stringify({ type: 'peer_disconnected' }));
        }
        socket.peer.peer = null;
        socket.peer = null;
    }
}

console.log('SchamChatt Sinyalleşme Sunucusu 8080 portunda çalışıyor...');