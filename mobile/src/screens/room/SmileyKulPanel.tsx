import { useState } from 'react';
import { Image, Pressable, ScrollView, View } from 'react-native';
import { SMILEY_PANEL } from '../../lib/chatSmiley';
import { EMOJI_IMAGES, emojiToken } from '../../lib/emoji';
import { KUL_IMAGES } from '../../lib/kul';
import { imageSizeForHeight } from '../../lib/chatSmiley';

type PanelTab = 'emoji' | 'smiley' | 'kul';

const emojiTabIcon = require('../../assets/icons/chat/ic_tab_emoji.png');
const smileyTabIcon = require('../../assets/icons/chat/ic_tab_smiley.png');
const kulTabIcon = require('../../assets/icons/chat/ic_tab_kul.png');
const backspaceIcon = require('../../assets/icons/chat/ic_backspace_selected.png');

export const SMILEY_PANEL_MIN_CONTENT_HEIGHT = 164;

interface SmileyKulPanelProps {
  hideKul?: boolean;
  contentHeight?: number;
  onPickEmoji: (code: string) => void;
  onBackspace?: () => void;
  onSendKul?: (index: number) => void;
}

const GROUP_TABS: Array<{ key: PanelTab; icon: number }> = [
  { key: 'emoji', icon: emojiTabIcon },
  { key: 'smiley', icon: smileyTabIcon },
  { key: 'kul', icon: kulTabIcon },
];

const COMPOSER_TABS: Array<{ key: PanelTab; icon: number }> = [
  { key: 'smiley', icon: smileyTabIcon },
  { key: 'emoji', icon: emojiTabIcon },
];

function PanelTabBar({
  active,
  tabs,
  onSelect,
}: {
  active: PanelTab;
  tabs: Array<{ key: PanelTab; icon: number }>;
  onSelect: (tab: PanelTab) => void;
}) {
  return (
    <View
      className="flex-row"
      style={{ height: 44, borderBottomWidth: 1, borderBottomColor: 'rgba(0,0,0,0.12)' }}
    >
      {tabs.map((tab) => {
        const isActive = tab.key === active;
        return (
          <Pressable
            key={tab.key}
            onPress={() => onSelect(tab.key)}
            className="flex-1 items-center justify-center"
            style={{ backgroundColor: isActive ? 'rgba(124,179,66,0.1)' : 'transparent' }}
          >
            <Image
              source={tab.icon}
              style={{ width: 24, height: 24, opacity: isActive ? 1 : 0.6 }}
              resizeMode="contain"
            />
            {isActive && (
              <View
                className="absolute bottom-0 left-0 right-0"
                style={{ height: 2, backgroundColor: '#7cb342' }}
              />
            )}
          </Pressable>
        );
      })}
    </View>
  );
}

export function SmileyKulPanel({
  hideKul,
  contentHeight = SMILEY_PANEL_MIN_CONTENT_HEIGHT,
  onPickEmoji,
  onBackspace,
  onSendKul,
}: SmileyKulPanelProps) {
  const visibleTabs = hideKul === true ? COMPOSER_TABS : GROUP_TABS;
  const [active, setActive] = useState<PanelTab>('smiley');

  return (
    <View className="bg-white" style={{ borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.12)' }}>
      <PanelTabBar active={active} tabs={visibleTabs} onSelect={setActive} />
      <View style={{ height: contentHeight }}>
        <ScrollView
          style={{ flex: 1 }}
          contentContainerClassName="flex-row flex-wrap p-2"
          keyboardShouldPersistTaps="handled"
        >
          {active === 'emoji'
            ? EMOJI_IMAGES.map((image, index) => (
                <Pressable
                  key={index}
                  onPress={() => onPickEmoji(emojiToken(index + 1))}
                  className="items-center justify-center"
                  style={{ width: `${100 / 8}%`, height: 36 }}
                >
                  <Image source={image} style={imageSizeForHeight(image, 22)} resizeMode="contain" />
                </Pressable>
              ))
            : active === 'smiley'
            ? SMILEY_PANEL.map((smiley, index) => (
                <Pressable
                  key={index}
                  onPress={() => onPickEmoji(smiley.code)}
                  className="items-center justify-center"
                  style={{ width: `${100 / 8}%`, height: 36 }}
                >
                  <Image
                    source={smiley.image}
                    style={imageSizeForHeight(smiley.image, 24)}
                    resizeMode="contain"
                  />
                </Pressable>
              ))
            : KUL_IMAGES.map((image, index) => (
                <Pressable
                  key={index}
                  onPress={() => onSendKul?.(index + 1)}
                  className="items-center justify-center"
                  style={{ width: `${100 / 6}%`, aspectRatio: 1, padding: 4 }}
                >
                  <Image
                    source={image}
                    style={{ width: '100%', height: '100%' }}
                    resizeMode="contain"
                  />
                </Pressable>
              ))}
        </ScrollView>
        {(active === 'emoji' || active === 'smiley') && onBackspace != null && (
          <View
            className="flex-row items-center justify-end bg-white px-2"
            style={{ height: 32, borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.12)' }}
          >
            <View
              style={{
                width: 1,
                height: 16,
                marginRight: 4,
                backgroundColor: 'rgba(0,0,0,0.12)',
              }}
            />
            <Pressable onPress={onBackspace} className="h-full w-12 items-center justify-center">
              <Image
                source={backspaceIcon}
                style={{ width: 20, height: 20 }}
                resizeMode="contain"
              />
            </Pressable>
          </View>
        )}
      </View>
    </View>
  );
}
