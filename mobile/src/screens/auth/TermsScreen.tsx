import { useTranslation } from 'react-i18next';
import { Image, Pressable, ScrollView, Text, View } from 'react-native';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import type { AuthStackParamList } from '../../navigation/types';

type TermsBlock = { type: 'p'; text: string } | { type: 'ul'; items: string[] };

interface TermsSection {
  title: string;
  blocks: TermsBlock[];
}

type Props = NativeStackScreenProps<AuthStackParamList, 'Terms'>;

export function TermsScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const sections = t('terms.sections', { returnObjects: true }) as unknown as TermsSection[];

  return (
    <ScrollView className="flex-1 bg-[#f0f7f0]">
      <View className="bg-ola-primary-dark px-4 pb-6 pt-4">
        <Pressable className="self-start py-1" onPress={() => navigation.goBack()}>
          <Text className="text-sm text-white/90">{t('terms.back')}</Text>
        </Pressable>
        <View className="mt-3 items-center">
          <Image
            source={require('../../assets/ola-logo.png')}
            className="mb-3 h-16 w-16 rounded-2xl"
            resizeMode="contain"
          />
          <Text className="text-xl font-bold tracking-wide text-white">{t('terms.title')}</Text>
          <Text className="mt-1.5 text-[13px] text-white/85">{t('terms.subtitle')}</Text>
        </View>
      </View>

      <View className="px-4 pb-14 pt-6">
        <Text className="mb-4 text-center text-xs text-[#5a7a5d]">{t('terms.updated')}</Text>

        <View className="mb-4 rounded-xl border border-[#ffd54f] bg-[#fff8e1] px-4 py-3.5">
          <Text className="text-[13px] text-[#6d4c00]">
            <Text className="font-bold">{t('terms.noticeLabel')}</Text> {t('terms.notice')}
          </Text>
        </View>

        {sections.map((section) => (
          <View key={section.title} className="mb-4 rounded-xl bg-white px-4 py-5 shadow">
            <Text className="mb-2.5 text-base font-extrabold tracking-wide text-ola-primary-dark">
              {section.title}
            </Text>
            {section.blocks.map((block, index) =>
              block.type === 'ul' ? (
                <View key={index} className="pl-1">
                  {block.items.map((item, itemIndex) => (
                    <View key={itemIndex} className="mb-2 flex-row">
                      <Text className="mr-2 text-sm text-gray-800">•</Text>
                      <Text className="flex-1 text-sm text-gray-800">{item}</Text>
                    </View>
                  ))}
                </View>
              ) : (
                <Text key={index} className="mb-2 text-sm text-gray-800">
                  {block.text}
                </Text>
              )
            )}
          </View>
        ))}

        <Text className="text-center text-xs text-[#7a9a7d]">{t('terms.footer')}</Text>
      </View>
    </ScrollView>
  );
}
