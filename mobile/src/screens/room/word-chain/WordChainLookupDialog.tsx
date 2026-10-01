import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Pressable,
  ScrollView,
  Text,
  TextInput,
  View,
  useWindowDimensions,
} from 'react-native';
import { WORD_CHAIN_LOOKUP_MAX_LENGTH } from '@ola/shared/constants';
import type { WordChainLookup, WordChainLookupResult } from '@ola/shared/types';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';
import { Dialog } from '@components/ui/Dialog';
import { useThemeColors } from '@hooks/useThemeColors';

const RESULT_MAX_HEIGHT_RATIO = 0.55;

function LookupResultBlock({ result }: { result: WordChainLookupResult }) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  return (
    <View style={{ gap: 8 }}>
      <Text
        className="text-xs font-semibold uppercase"
        style={{ color: 'rgba(0,0,0,0.45)', letterSpacing: 0.5 }}
      >
        {result.langName}
      </Text>
      {result.meanings.length > 0 && (
        <View style={{ gap: 6 }}>
          {result.meanings.map((meaning, index) => (
            <View key={`${meaning.definition}-${index}`} className="flex-row" style={{ gap: 4 }}>
              <Text className="text-sm" style={{ width: 20, color: 'rgba(0,0,0,0.8)' }}>
                {index + 1}.
              </Text>
              <View className="flex-1">
                <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.8)' }}>
                  {meaning.pos != null && meaning.pos !== '' && (
                    <Text className="text-xs font-medium" style={{ color: colors.primaryInk }}>
                      {meaning.subPos != null && meaning.subPos !== ''
                        ? `${meaning.pos} · ${meaning.subPos}`
                        : meaning.pos}{' '}
                    </Text>
                  )}
                  {meaning.definition}
                </Text>
                {meaning.example != null && meaning.example !== '' && (
                  <Text
                    className="mt-0.5 text-xs italic"
                    style={{ color: 'rgba(0,0,0,0.45)' }}
                  >
                    {meaning.example}
                  </Text>
                )}
              </View>
            </View>
          ))}
        </View>
      )}
      {result.translations.length > 0 && (
        <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.7)' }}>
          <Text className="font-medium" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {t('wordChain.lookupTranslations')}{' '}
          </Text>
          {result.translations.map((item) => `${item.translation} (${item.langName})`).join(', ')}
        </Text>
      )}
      {result.relations.length > 0 && (
        <View style={{ gap: 4 }}>
          <Text className="text-sm font-medium" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {t('wordChain.lookupRelations')}
          </Text>
          <View className="flex-row flex-wrap" style={{ gap: 4 }}>
            {result.relations.map((relation) => (
              <View
                key={`${relation.type}-${relation.word}`}
                accessibilityLabel={`${relation.word} (${relation.type})`}
                className="rounded-full px-2 py-0.5"
                style={{ backgroundColor: colors.primaryLight }}
              >
                <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.7)' }}>
                  {relation.word}
                </Text>
              </View>
            ))}
          </View>
        </View>
      )}
    </View>
  );
}

function LookupResultView({
  result,
  showWord,
}: {
  result: WordChainLookup;
  showWord: boolean;
}) {
  const { t } = useTranslation();
  const { height } = useWindowDimensions();
  return (
    <ScrollView style={{ maxHeight: height * RESULT_MAX_HEIGHT_RATIO }}>
      <View style={{ gap: 12 }}>
        {showWord && (
          <Text className="text-base font-semibold" style={{ color: 'rgba(0,0,0,0.87)' }}>
            {result.word}
          </Text>
        )}
        {result.found ? (
          result.results.map((item, index) => (
            <LookupResultBlock key={`${item.langCode}-${index}`} result={item} />
          ))
        ) : (
          <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {t('wordChain.lookupNotFound', { word: result.word })}
          </Text>
        )}
        <Text className="text-right text-xs" style={{ color: 'rgba(0,0,0,0.35)' }}>
          {t('wordChain.lookupSource', { source: result.source })}
        </Text>
      </View>
    </ScrollView>
  );
}

function LookupSearchForm() {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const lookup = useWordChainStore((state) => state.lookup);
  const loading = useWordChainStore((state) => state.lookupLoading);
  const [word, setWord] = useState('');
  const query = word.trim();
  const disabled = query === '' || loading;

  function submit() {
    if (disabled) return;
    void lookup(query);
  }

  return (
    <View className="flex-row items-center gap-2">
      <TextInput
        value={word}
        onChangeText={setWord}
        accessibilityLabel={t('wordChain.lookupTitle')}
        maxLength={WORD_CHAIN_LOOKUP_MAX_LENGTH}
        placeholder={t('wordChain.lookupHint')}
        placeholderTextColor="rgba(0,0,0,0.35)"
        autoCapitalize="none"
        autoCorrect={false}
        autoFocus
        returnKeyType="search"
        onSubmitEditing={submit}
        className="min-w-0 flex-1 rounded px-3 text-base"
        style={{
          height: 40,
          paddingVertical: 0,
          color: 'rgba(0,0,0,0.87)',
          borderWidth: 1,
          borderColor: 'rgba(0,0,0,0.15)',
        }}
      />
      <Pressable
        accessibilityRole="button"
        onPress={submit}
        disabled={disabled}
        className="items-center justify-center rounded px-3 active:opacity-90"
        style={{ height: 40, minWidth: 64, backgroundColor: colors.primary, opacity: disabled ? 0.5 : 1 }}
      >
        {loading ? (
          <ActivityIndicator color={colors.onPrimary} size="small" />
        ) : (
          <Text className="text-sm font-medium" style={{ color: colors.onPrimary }}>
            {t('wordChain.lookupAction')}
          </Text>
        )}
      </Pressable>
    </View>
  );
}

export function WordChainLookupDialog({
  initialWord,
  onClose,
}: {
  initialWord: string;
  onClose: () => void;
}) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const result = useWordChainStore((state) => state.lookupResult);
  const loading = useWordChainStore((state) => state.lookupLoading);
  const searchable = initialWord === '';

  return (
    <Dialog
      visible
      onClose={onClose}
      title={searchable ? t('wordChain.lookupTitle') : initialWord}
      showClose
      avoidKeyboard={searchable}
    >
      <View style={{ gap: 12 }}>
        {searchable && <LookupSearchForm />}
        {result != null ? (
          <LookupResultView result={result} showWord={searchable} />
        ) : searchable ? null : loading ? (
          <View className="items-center py-6">
            <ActivityIndicator color={colors.primary} size="large" />
          </View>
        ) : (
          <Text className="py-4 text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {t('wordChain.lookupError')}
          </Text>
        )}
      </View>
    </Dialog>
  );
}
