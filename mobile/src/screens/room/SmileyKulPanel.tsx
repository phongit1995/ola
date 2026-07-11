import { useState } from 'react';
import { Image, Pressable, ScrollView, Text, View } from 'react-native';
import { SMILEY_PANEL } from '../../lib/chatSmiley';
import { EMOJI_IMAGES, emojiToken } from '../../lib/emoji';
import { KUL_IMAGES } from '../../lib/kul';

type PanelTab = 'emoji' | 'smiley' | 'kul';

const emojiTabIcon = require('../../assets/icons/chat/ic_tab_emoji.png');
const smileyTabIcon = require('../../assets/icons/chat/ic_tab_smiley.png');
const kulTabIcon = require('../../assets/icons/chat/ic_tab_kul.png');

interface SmileyKulPanelProps {
  hideKul?: boolean;
  onPickEmoji: (code: string) => void;
  onBackspace?: () => void;
  onSendKul?: (index: number) => void;
}

const TABS: Array<{ key: PanelTab; icon: number }> = [
  { key: 'emoji', icon: emojiTabIcon },
  { key: 'smiley', icon: smileyTabIcon },
  { key: 'kul', icon: kulTabIcon },
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

export function SmileyKulPanel({ hideKul, onPickEmoji, onBackspace, onSendKul }: SmileyKulPanelProps) {
  const visibleTabs = hideKul === true ? TABS.filter((item) => item.key !== 'kul') : TABS;
  const [active, setActive] = useState<PanelTab>(hideKul === true ? 'emoji' : 'smiley');

  return (
    <View className="bg-white" style={{ borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.12)' }}>
      <PanelTabBar active={active} tabs={visibleTabs} onSelect={setActive} />
      <View style={{ height: 220 }}>
        <ScrollView contentContainerClassName="flex-row flex-wrap p-2">
          {active === 'emoji'
            ? EMOJI_IMAGES.map((image, index) => (
                <Pressable
                  key={index}
                  onPress={() => onPickEmoji(`${emojiToken(index + 1)} `)}
                  className="items-center justify-center"
                  style={{ width: `${100 / 8}%`, height: 40 }}
                >
                  <Image source={image} style={{ width: 24, height: 24 }} resizeMode="contain" />
                </Pressable>
              ))
            : active === 'smiley'
            ? SMILEY_PANEL.map((smiley, index) => (
                <Pressable
                  key={index}
                  onPress={() => onPickEmoji(`${smiley.code} `)}
                  className="items-center justify-center"
                  style={{ width: `${100 / 8}%`, height: 40 }}
                >
                  <Image source={smiley.image} style={{ width: 26, height: 26 }} resizeMode="contain" />
                </Pressable>
              ))
            : KUL_IMAGES.map((image, index) => (
                <Pressable
                  key={index}
                  onPress={() => onSendKul?.(index + 1)}
                  className="items-center justify-center p-1"
                  style={{ width: `${100 / 6}%`, height: 64 }}
                >
                  <Image source={image} style={{ width: 52, height: 52 }} resizeMode="contain" />
                </Pressable>
              ))}
        </ScrollView>
        {(active === 'emoji' || active === 'smiley') && onBackspace != null && (
          <Pressable
            onPress={onBackspace}
            className="absolute bottom-2 right-2 h-9 w-11 items-center justify-center rounded-full"
            style={{ backgroundColor: 'rgba(0,0,0,0.06)' }}
          >
            <Text className="text-base" style={{ color: 'rgba(0,0,0,0.54)' }}>
              ⌫
            </Text>
          </Pressable>
        )}
      </View>
    </View>
  );
}
