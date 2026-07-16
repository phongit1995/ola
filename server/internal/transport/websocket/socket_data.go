package websocket

import "sync"

type SocketData struct {
	UserID   string
	Platform string

	mu          sync.Mutex
	joinedRooms map[string]bool
}

func NewSocketData(userID, platform string) *SocketData {
	return &SocketData{UserID: userID, Platform: platform, joinedRooms: make(map[string]bool)}
}

func (d *SocketData) JoinRoom(roomID string) {
	d.mu.Lock()
	defer d.mu.Unlock()
	d.joinedRooms[roomID] = true
}

func (d *SocketData) LeaveRoom(roomID string) bool {
	d.mu.Lock()
	defer d.mu.Unlock()
	if !d.joinedRooms[roomID] {
		return false
	}
	delete(d.joinedRooms, roomID)
	return true
}

func (d *SocketData) HasRoom(roomID string) bool {
	d.mu.Lock()
	defer d.mu.Unlock()
	return d.joinedRooms[roomID]
}

func (d *SocketData) RoomIDs() []string {
	d.mu.Lock()
	defer d.mu.Unlock()
	ids := make([]string, 0, len(d.joinedRooms))
	for roomID := range d.joinedRooms {
		ids = append(ids, roomID)
	}
	return ids
}
