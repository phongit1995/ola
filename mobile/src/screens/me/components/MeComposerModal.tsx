import { useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, ScrollView, View } from 'react-native';
import { ChatKeyboardArea } from '@components/ChatKeyboardArea';
import { OlaModal } from '@components/ui/OlaModal';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeUploadFile } from '@ola/shared/types';
import type {
  CreatePostRequest,
  Post,
  PostVisibility,
} from '@ola/shared/types';
import {
  ChatComposer,
  type ChatComposerHandle,
} from '@components/ChatComposer';
import { DIVIDER } from '@constants';
import { useThemeColors } from '@hooks/useThemeColors';
import { useBottomBarInset } from '@hooks/useBottomBarInset';
import { useLastKeyboardHeight } from '@hooks/useKeyboardHeight';
import {
  SmileyKulPanel,
  SMILEY_PANEL_MIN_CONTENT_HEIGHT,
} from '@screens/room/components/SmileyKulPanel';
import { MeComposerTagPanel } from './MeComposerTagPanel';
import { MeComposerCheckInPanel } from './MeComposerCheckInPanel';
import {
  AttachBar,
  CheckInPreview,
  ComposerHeader,
  PhotoStrip,
  PrivacyRow,
  StickerPanel,
  StickerPreview,
} from './MeComposerParts';
import { COMPOSER_PRIVACY_OPTIONS } from '../constants';
import { useMeComposer } from '../useMeComposer';

interface MeComposerModalProps {
  visible: boolean;
  onClose: () => void;
  onSaved?: (post: Post) => void;
  editPost?: Post | null;
  title?: string;
  privacyOptions?: PostVisibility[];
  submitPost?: (
    payload: CreatePostRequest,
    files: NativeUploadFile[],
    imageUrls: string[],
  ) => Promise<Post | null>;
}

export function MeComposerModal(props: MeComposerModalProps) {
  const postingRef = useRef(false);
  return (
    <OlaModal
      visible={props.visible}
      statusBarTranslucent
      navigationBarTranslucent
      animationType="slide"
      onRequestClose={() => {
        if (!postingRef.current) props.onClose();
      }}
    >
      <MeComposerBody {...props} postingRef={postingRef} />
    </OlaModal>
  );
}

function MeComposerBody({
  visible,
  onClose,
  onSaved,
  editPost,
  title,
  privacyOptions,
  submitPost,
  postingRef,
}: MeComposerModalProps & { postingRef: { current: boolean } }) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const insets = useSafeAreaInsets();
  const bottomBarInset = useBottomBarInset();
  const lastKeyboardHeight = useLastKeyboardHeight();
  const panelContentHeight = Math.max(
    SMILEY_PANEL_MIN_CONTENT_HEIGHT,
    lastKeyboardHeight - 44,
  );
  const [inputFocused, setInputFocused] = useState(false);
  const composerRef = useRef<ChatComposerHandle>(null);

  const vm = useMeComposer({
    visible,
    onClose,
    onSaved,
    editPost,
    privacyOptions,
    submitPost,
    composerRef,
  });
  postingRef.current = vm.posting;

  return (
    <ChatKeyboardArea>
      <View className="flex-1 bg-white">
        <ComposerHeader
          paddingTop={insets.top + 8}
          titleText={
            vm.isEdit ? t('me.editTitle') : title ?? t('me.composerTitle')
          }
          actionText={vm.isEdit ? t('me.saveEdit') : t('me.post')}
          canPost={vm.canPost}
          posting={vm.posting}
          onClose={vm.close}
          onSubmit={() => void vm.submit()}
        />

        <PrivacyRow
          options={privacyOptions ?? COMPOSER_PRIVACY_OPTIONS}
          privacy={vm.privacy}
          onChange={vm.setPrivacy}
        />

        <View className="flex-1">
          <View
            className="flex-1"
            onStartShouldSetResponderCapture={() => {
              if (vm.panel != null) vm.setPanel(null);
              return false;
            }}
          >
            <View
              className="mx-4 mt-3 flex-1"
              style={{
                minHeight: 96,
                borderWidth: 1,
                borderColor: inputFocused ? colors.primary : DIVIDER,
                borderRadius: 6,
              }}
            >
              <ScrollView
                keyboardShouldPersistTaps="handled"
                contentContainerStyle={{ flexGrow: 1 }}
              >
                <ChatComposer
                  ref={composerRef}
                  value={vm.content}
                  onChange={vm.setContent}
                  placeholder={t('me.composerHint')}
                  alignTop
                  minHeight={94}
                  maxHeight={100000}
                  paddingH={12}
                  paddingV={8}
                  onFocus={() => {
                    setInputFocused(true);
                    vm.setPanel(null);
                  }}
                  onBlur={() => setInputFocused(false)}
                />
                <Pressable
                  className="flex-1"
                  onPress={() => composerRef.current?.focus()}
                />
              </ScrollView>
            </View>

            {vm.sticker != null && (
              <StickerPreview
                sticker={vm.sticker}
                onRemove={() => vm.setSticker(null)}
              />
            )}

            {vm.checkIn != null && (
              <CheckInPreview
                checkIn={vm.checkIn}
                onRemove={() => vm.setCheckIn(null)}
              />
            )}

            <PhotoStrip photos={vm.photos} onRemove={vm.removePhoto} />
          </View>

          {vm.panel === 'sticker' && (
            <StickerPanel
              onPick={code => {
                vm.setSticker(code);
                vm.setPanel(null);
              }}
            />
          )}

          {vm.panel === 'tag' && (
            <View className="mx-4 mt-2">
              <MeComposerTagPanel
                onMention={nick =>
                  composerRef.current?.insertText(` @${nick} `)
                }
              />
            </View>
          )}

          {vm.panel === 'checkin' && (
            <View className="mx-4 mt-2">
              <MeComposerCheckInPanel
                onSelect={value => {
                  vm.setCheckIn(value);
                  vm.setPanel(null);
                }}
              />
            </View>
          )}
          <View className="h-2" />
        </View>

        <AttachBar
          panel={vm.panel}
          paddingBottom={vm.panel === 'smiley' ? 0 : bottomBarInset}
          onPress={vm.handleAttach}
        />

        {vm.panel === 'smiley' && (
          <View style={{ paddingBottom: bottomBarInset }}>
            <SmileyKulPanel
              hideKul
              contentHeight={panelContentHeight}
              onPickEmoji={code => composerRef.current?.insertCode(code, true)}
            />
          </View>
        )}
      </View>
    </ChatKeyboardArea>
  );
}
