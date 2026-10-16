# Ola Mobile

App React Native (bare CLI) dùng chung store / service / type / i18n với web qua `@ola/shared` (`packages/shared`).

## Scripts

| Lệnh | Tác dụng |
|------|----------|
| `pnpm start` | Metro |
| `pnpm ios` / `pnpm android` | Build và chạy app |
| `pnpm typecheck` | Type-check (`tsc --noEmit`) |
| `pnpm lint` | ESLint |
| `pnpm test` | Jest |

## Cấu trúc

```
mobile/src/
├── App.tsx / bootstrap.ts   # entry, provider gốc
├── navigation/              # RootNavigator, routes, type param
├── screens/                 # mỗi màn / nghiệp vụ một thư mục (xem "Quy ước trong màn")
├── components/              # component dùng chung nhiều màn (ui/, form/, chat/, user/…)
├── hooks/                   # hook dùng chung nhiều màn
├── lib/                     # tiện ích dùng chung nhiều màn (asset require(), richText, sound…)
├── constants/               # theme, màu, typography
├── store/                   # zustand store chỉ của mobile (store chung nằm ở @ola/shared/stores)
├── services/                # dịch vụ riêng mobile (OTA…)
├── platform/                # storage, env
├── i18n/                    # cấu hình i18next (locale nằm ở @ola/shared)
└── assets/                  # ảnh, icon
```

Import qua alias `@components/…`, `@screens/…`, `@hooks/…`, `@lib/…`, `@store/…`, `@constants`, `@assets/…` (khai báo ở `tsconfig.json` và `babel.config.js`).

## Quy ước trong màn

Giống quy ước của admin (`admin/README.md`) và web (`web/README.md`). Mỗi thư mục `screens/<màn>/` gồm:

| File | Chứa gì | Ví dụ |
|------|---------|-------|
| `XxxScreen.tsx`, `components/` | Component: state, xử lý sự kiện, JSX | `chat/ChatListScreen.tsx` |
| `useXxx.ts` | Hook của màn: state, gọi store/service | `chat/useChatDetail.ts`, `story/useStoryAccess.ts` |
| `constants.ts` | Hằng số `UPPER_CASE`: page size, màu riêng của màn, dữ liệu tĩnh | `room/constants.ts` (`ROOM_BROWSE_LIMIT`) |
| `utils.ts` | Hàm thuần không có JSX: đổi dữ liệu API → dữ liệu hiển thị, format, tính toán layout | `chat/utils.ts` (`mapFriendsToContacts`), `room/utils.ts` (`roomBubbleTextMaxWidth`) |
| `types.ts` | Type / interface dùng cho nhiều file trong màn. Không tách riêng `interface.ts` | `me/types.ts` (`PickedPhoto`, `MeTab`) |
| `xxxAssets.ts` | Bảng `require()` ảnh / âm thanh của màn, đổi asset chỉ sửa ở đây | `games/pen/penAssets.ts` |

Chỉ tạo `constants.ts` / `utils.ts` / `types.ts` khi màn có nội dung cho file đó. Test của màn đặt trong `__tests__/` cạnh file được test (`games/egg/__tests__/utils.test.ts`).

Module có tác dụng phụ (phát âm thanh, quyền thiết bị, PiP, foreground service) không đưa vào `utils.ts`. Giữ file riêng, đặt tên theo việc nó làm (`spin-wheel/spinWheelSound.ts`), màn lớn thì gom vào `lib/` của màn (`call/lib/`). Style object dùng chung cho nhiều component của một màn để ở `xxxStyles.ts` (`spin-wheel/spinWheelStyles.ts`).

**Đặt code ở đâu**

- Chỉ một màn dùng → để trong thư mục của màn đó, kể cả hook (`chat/usePresence.ts`, `me/useHorizontalSwipe.ts`).
- Nhiều màn con cùng một nhóm dùng → để ở thư mục cha của nhóm (`screens/games/`).
- Nhiều nhóm màn dùng → đưa lên `src/hooks`, `src/lib` hoặc `src/components`.
- Logic thuần dùng được cho cả web lẫn mobile → `packages/shared` (`@ola/shared`).
- Thứ đã có ở `@ola/shared` thì import thẳng (`@ola/shared/lib`, `@ola/shared/types`, `@ola/shared/stores/...`). Không tạo file trung gian chỉ để re-export.
- Import trong cùng màn dùng đường dẫn tương đối (`./utils`, `../types`); import từ ngoài màn dùng alias (`@lib/…`, `@screens/…`).

**Đặt tên**

- Hook đặt tên `useXxx.ts`. Hậu tố `Store` để dành cho zustand.
- Tên trong `constants.ts` / `utils.ts` dùng chung cho cả thư mục, nên phải rõ nghĩa ngoài file gốc (`ROOM_BROWSE_LIMIT`, `roomMessageAbilities`).

**Giữ lại trong component**

- `XxxProps` không export, hằng số có JSX, style object chỉ một component dùng.

---

This is a new [**React Native**](https://reactnative.dev) project, bootstrapped using [`@react-native-community/cli`](https://github.com/react-native-community/cli).

# Getting Started

> **Note**: Make sure you have completed the [Set Up Your Environment](https://reactnative.dev/docs/set-up-your-environment) guide before proceeding.

## Step 1: Start Metro

First, you will need to run **Metro**, the JavaScript build tool for React Native.

To start the Metro dev server, run the following command from the root of your React Native project:

```sh
# Using npm
npm start

# OR using Yarn
yarn start
```

## Step 2: Build and run your app

With Metro running, open a new terminal window/pane from the root of your React Native project, and use one of the following commands to build and run your Android or iOS app:

### Android

```sh
# Using npm
npm run android

# OR using Yarn
yarn android
```

### iOS

For iOS, remember to install CocoaPods dependencies (this only needs to be run on first clone or after updating native deps).

The first time you create a new project, run the Ruby bundler to install CocoaPods itself:

```sh
bundle install
```

Then, and every time you update your native dependencies, run:

```sh
bundle exec pod install
```

For more information, please visit [CocoaPods Getting Started guide](https://guides.cocoapods.org/using/getting-started.html).

```sh
# Using npm
npm run ios

# OR using Yarn
yarn ios
```

If everything is set up correctly, you should see your new app running in the Android Emulator, iOS Simulator, or your connected device.

This is one way to run your app — you can also build it directly from Android Studio or Xcode.

## Step 3: Modify your app

Now that you have successfully run the app, let's make changes!

Open `App.tsx` in your text editor of choice and make some changes. When you save, your app will automatically update and reflect these changes — this is powered by [Fast Refresh](https://reactnative.dev/docs/fast-refresh).

When you want to forcefully reload, for example to reset the state of your app, you can perform a full reload:

- **Android**: Press the <kbd>R</kbd> key twice or select **"Reload"** from the **Dev Menu**, accessed via <kbd>Ctrl</kbd> + <kbd>M</kbd> (Windows/Linux) or <kbd>Cmd ⌘</kbd> + <kbd>M</kbd> (macOS).
- **iOS**: Press <kbd>R</kbd> in iOS Simulator.

## Congratulations! :tada:

You've successfully run and modified your React Native App. :partying_face:

### Now what?

- If you want to add this new React Native code to an existing application, check out the [Integration guide](https://reactnative.dev/docs/integration-with-existing-apps).
- If you're curious to learn more about React Native, check out the [docs](https://reactnative.dev/docs/getting-started).

# Troubleshooting

If you're having issues getting the above steps to work, see the [Troubleshooting](https://reactnative.dev/docs/troubleshooting) page.

# Learn More

To learn more about React Native, take a look at the following resources:

- [React Native Website](https://reactnative.dev) - learn more about React Native.
- [Getting Started](https://reactnative.dev/docs/environment-setup) - an **overview** of React Native and how setup your environment.
- [Learn the Basics](https://reactnative.dev/docs/getting-started) - a **guided tour** of the React Native **basics**.
- [Blog](https://reactnative.dev/blog) - read the latest official React Native **Blog** posts.
- [`@facebook/react-native`](https://github.com/facebook/react-native) - the Open Source; GitHub **repository** for React Native.
