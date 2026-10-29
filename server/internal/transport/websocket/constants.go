package websocket

const (
	CacheKeyRoomMembers    = "ROOM:%s:MEMBERS:Z"
	CacheKeyRoomUserConn   = "ROOM:%s:USER:%s:CONN"
	CacheKeyRoomJoinTicket = "ROOM:JOIN_TICKET:%s"

	RoomPresenceTTLSeconds   = 43200
	RoomJoinTicketTTLSeconds = 5

	CacheKeyPresence             = "PRESENCE:%s:ONLINE"
	PresenceTTLSeconds           = 300
	CacheKeyLastActive           = "PRESENCE:%s:LAST_ACTIVE"
	LastActiveTTLSeconds         = 365 * 24 * 60 * 60
	CacheKeyPresenceDevice       = "PRESENCE:%s:DEVICE"
	CacheKeyPresenceBackground   = "PRESENCE:%s:BACKGROUND"
	PresenceBackgroundTTLSeconds = 21600
)
