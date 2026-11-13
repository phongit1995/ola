# Tính năng đang tạm ẩn

Các mục dưới đây từng nằm trong code dưới dạng comment. Code đã gỡ khỏi file nguồn (quy ước không comment), nội dung khôi phục giữ ở đây. Bật lại thì dán đoạn code vào đúng chỗ, thêm lại import/prop được ghi kèm.

## Web — Danh sách phòng chat (`web/src/pages/room/components/RoomList.tsx`)

### Banner mua VIP

Ẩn theo yêu cầu. Bật lại: thêm prop `onBuyVip: () => void` vào `RoomListProps` + destructure, truyền handler mua VIP từ `RoomPanel.tsx`, rồi đặt khối này ngay sau `<ul>`, trước dòng `{showQuickJoin && (`.

```tsx
<li className="flex items-center justify-between gap-3 border-b border-black/12 bg-[#fff8e1] px-4 py-3">
  <span className="min-w-0">
    <span className="block text-sm font-medium text-black/87">
      {t('room.warningVipTitle')}
    </span>
    <span className="block text-xs text-black/54">
      {t('room.warningVipBody')}
    </span>
  </span>
  <button
    type="button"
    onClick={onBuyVip}
    className="shrink-0 rounded-sm bg-amber-400 px-3 py-1.5 text-sm font-medium text-white"
  >
    {t('room.buyVip')}
  </button>
</li>
```

### "Xung quanh bạn"

Ẩn theo yêu cầu. Prop `onAroundYou` vẫn còn trong `RoomListProps` và `RoomPanel.tsx` vẫn truyền vào; bật lại chỉ cần thêm `onAroundYou` vào destructure và đặt khối này ngay sau banner VIP (nếu có), trước dòng `{showQuickJoin && (`.

```tsx
<SpecialRow
  icon="📍"
  title={t('room.aroundYou')}
  subtitle={t('room.aroundYouDesc')}
  onClick={onAroundYou}
/>
```

## Danh bạ — "Có thể bạn muốn làm quen"

Chờ API gợi ý kết bạn thật: `SuggestedFriendsScreen` đang chạy trên `SUGGESTED_FRIENDS` hardcode, nút Kết bạn chỉ hiện toast.

### Web (`web/src/pages/chat/components/ContactList.tsx`)

Bật lại: `import { PeopleIcon } from './Icons';`, `import { SUGGESTED_FRIENDS } from '../constants';`; prop `onOpenSuggested` vẫn còn trong `ContactListProps`, chỉ cần thêm vào destructure. Đặt khối ngay sau khối lời mời kết bạn (`requests`), trước `{enabledBots.length > 0 && (`.

```tsx
<button
  type="button"
  onClick={onOpenSuggested}
  className="flex w-full items-center gap-3 border-b border-black/12 bg-white/80 px-4 py-2 text-left"
>
  <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-[#e0e0e0]">
    <PeopleIcon />
  </span>
  <span className="min-w-0 flex-1">
    <span className="block text-base text-black/87">
      {t('chat.suggestFriends')}
    </span>
    <span className="mt-1 flex items-center gap-2">
      {SUGGESTED_FRIENDS.slice(0, 3).map((friend) => (
        <span key={friend.name} className="block overflow-hidden rounded">
          <Avatar
            name={friend.name}
            color={friend.color}
            size={28}
            rounded={false}
          />
        </span>
      ))}
    </span>
  </span>
  <span className="flex h-5 min-w-5 items-center justify-center rounded-full bg-ola-accent px-1 text-[10px] font-bold text-white">
    {SUGGESTED_FRIENDS.length}
  </span>
  <span className="shrink-0 text-xl text-black/26">›</span>
</button>
```

### Mobile (`mobile/src/screens/chat/components/ContactsPane.tsx`)

Bật lại: `import { SUGGESTED_FRIENDS } from '@screens/friends/constants';` và `const peopleIcon = require('@assets/icons/chat/ic_people_gray.png');`. Đặt khối ngay sau khối lời mời kết bạn, trước phần danh sách bot.

```tsx
<Pressable
  onPress={() => navigation.navigate(ROOT_ROUTES.SuggestedFriends)}
  className="flex-row items-center gap-3 bg-white px-4 py-2"
  style={{ borderBottomWidth: 1, borderBottomColor: DIVIDER }}
>
  <View className="h-10 w-10 items-center justify-center rounded-full" style={{ backgroundColor: '#e0e0e0' }}>
    <Image source={peopleIcon} style={{ width: 24, height: 24 }} resizeMode="contain" />
  </View>
  <View className="min-w-0 flex-1">
    <Text className="text-base text-ola-ink">{t('chat.suggestFriends')}</Text>
    <View className="mt-1 flex-row items-center gap-2">
      {SUGGESTED_FRIENDS.slice(0, 3).map((friend) => (
        <View
          key={friend.name}
          className="h-7 w-7 items-center justify-center rounded"
          style={{ backgroundColor: friend.color }}
        >
          <Text className="text-xs font-semibold text-white">{friend.name.charAt(0).toUpperCase()}</Text>
        </View>
      ))}
    </View>
  </View>
  <View className="h-5 min-w-5 items-center justify-center rounded-full bg-ola-accent px-1">
    <Text className="text-[10px] font-bold text-white">{SUGGESTED_FRIENDS.length}</Text>
  </View>
  <Text className="text-xl text-ola-ink-hint">›</Text>
</Pressable>
```

## Web — Danh bạ: "Mời thêm bạn bè" và "Chat nhóm" (`ContactList.tsx`)

Chưa có chức năng mời bạn qua Facebook và chưa có chat nhóm. Đặt sau khối "Có thể bạn muốn làm quen". "Chat nhóm" cần `import groupIcon from '@/assets/icons/room/ic_notify_new_chat_group_message.png';`.

```tsx
<ActionRow
  badge={
    <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded bg-[#1877f2] text-xl font-bold text-white">
      f
    </span>
  }
  title={t('chat.inviteFriends')}
  subtitle={t('chat.inviteFriendsSub')}
  onClick={onComingSoon}
/>

<ActionRow
  badge={
    <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded bg-ola-primary">
      <img src={groupIcon} alt="" className="h-6 w-6 object-contain" />
    </span>
  }
  title={t('chat.chatGroup')}
  subtitle={t('chat.chatGroupSub')}
  showChevron
  onClick={onComingSoon}
/>
```

## Web — Ứng dụng: Kho game, Đăng quảng cáo, OlaMall, Lân cận (`web/src/pages/apps/constants.ts`)

Chưa có tính năng thật. Lân cận chờ `NearbyPlacesPage` bỏ dữ liệu mock `MOCK_VENUES`.

Import icon:

```ts
import iconGame from '@/assets/icons/apps/game.png';
import iconAdme from '@/assets/icons/apps/adme.png';
import iconMall from '@/assets/icons/apps/mall.png';
import iconNearby from '@/assets/icons/apps/nearby.png';
```

Thêm vào cuối `GAME_ITEMS`:

```ts
{ icon: iconGame, titleKey: 'home.apps.gameStore', subtitleKey: 'home.appGameSubtitle' },
{ icon: iconAdme, titleKey: 'home.apps.advertise' },
{ icon: iconMall, titleKey: 'home.apps.mall', subtitleKey: 'home.appMallSubtitle' },
{ icon: iconNearby, titleKey: 'home.apps.nearby', app: 'nearby' },
```

## Me — các mục drawer trái chưa có action (`MeLeftDrawer.tsx`)

Ẩn cả web lẫn mobile cho đến khi có action.

Web (`web/src/pages/me/components/MeLeftDrawer.tsx`), import:

```ts
import eggIcon from '@/assets/icons/me/ic_indicate_broken_egg.png';
import androidIcon from '@/assets/icons/me/ic_indicate_android.png';
import olaIcon from '@/assets/icons/me/ic_indicate_me.png';
import funnyIcon from '@/assets/icons/me/ic_indicate_funny.png';
import publicIcon from '@/assets/icons/me/ic_indicate_public.png';
```

Mobile (`mobile/src/screens/me/components/MeLeftDrawer.tsx`), import:

```ts
const eggIcon = require('@assets/icons/me/ic_indicate_broken_egg.png');
const androidIcon = require('@assets/icons/me/ic_indicate_android.png');
const olaIcon = require('@assets/icons/me/ic_indicate_me.png');
const funnyIcon = require('@assets/icons/me/ic_indicate_funny.png');
const publicIcon = require('@assets/icons/me/ic_indicate_public.png');
```

Mục thêm vào mảng item của drawer (cả hai nền tảng):

```ts
{ key: 'egg', icon: eggIcon, label: t('me.drawerEgg') },
{ key: 'android', icon: androidIcon, label: '#Android' },
{ key: 'ola', icon: olaIcon, label: '#Ola' },
{ key: 'funny', icon: funnyIcon, label: t('me.drawerFunny') },
{ key: 'public', icon: publicIcon, label: t('me.drawerPublic') },
```

## Mobile — Foreground service cho cuộc gọi Android (`mobile/src/screens/call/CallOverlay.tsx`)

Tắt vì foreground service đã gỡ khỏi `AndroidManifest` để khỏi phải khai báo với Play Console. Hệ quả: Android 14+ có thể cắt mic/camera khi app xuống nền giữa cuộc gọi (xem `docs/code-notes.md`). Bật lại cần khai báo lại service trong manifest + Play Console, rồi sửa 3 chỗ:

1. Import:

```ts
import {
  startCallForegroundService,
  stopCallForegroundService,
} from './lib/callForegroundService';
```

2. Trong `useCallSession`, ngay sau `await enterCallAudioSession(withVideo); if (cancelled) return;`:

```ts
await startCallForegroundService(withVideo);
if (cancelled) {
  await stopCallForegroundService().catch(() => {});
  return;
}
```

3. Trong cleanup của effect đó, trước `void leaveCallAudioSession();`:

```ts
void stopCallForegroundService().catch(() => {});
```
