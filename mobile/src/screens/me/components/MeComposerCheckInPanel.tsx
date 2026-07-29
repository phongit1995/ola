import { useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, ScrollView, Text, View } from 'react-native';
import Geolocation from '@react-native-community/geolocation';
import { GeoService } from '@ola/shared/services';
import type { CheckInAction, GeoVenue } from '@ola/shared/types';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { CHECK_IN_ACTIONS } from '@lib/checkInActions';

const checkInIcon = require('@assets/icons/me/ic_check_in.png');

export type ComposedCheckIn = GeoVenue & { action?: string; actionIcon?: string };

interface MeComposerCheckInPanelProps {
  onSelect: (checkIn: ComposedCheckIn) => void;
}

export function MeComposerCheckInPanel({ onSelect }: MeComposerCheckInPanelProps) {
  const { t } = useTranslation();
  const pushToast = useToastStore((s) => s.push);
  const [action, setAction] = useState<CheckInAction | null>(null);
  const [nearby, setNearby] = useState<GeoVenue[]>([]);
  const [current, setCurrent] = useState<GeoVenue | null>(null);
  const [locating, setLocating] = useState(false);
  const [locateError, setLocateError] = useState(false);
  const hasLocated = useRef(false);

  function locate() {
    if (!GeoService.enabled) {
      setLocateError(true);
      pushToast('error', t('me.checkInError'));
      return;
    }
    setLocating(true);
    setLocateError(false);
    Geolocation.requestAuthorization();
    Geolocation.getCurrentPosition(
      (position) => {
        const { latitude, longitude } = position.coords;
        void (async () => {
          try {
            const [venues, here] = await Promise.all([
              GeoService.nearby(latitude, longitude),
              GeoService.reverse(latitude, longitude).catch(() => null),
            ]);
            setNearby(venues);
            setCurrent(here ?? { name: '', address: '', lat: latitude, lng: longitude });
          } catch {
            setLocateError(true);
            pushToast('error', t('me.checkInError'));
          } finally {
            setLocating(false);
          }
        })();
      },
      () => {
        setLocating(false);
        setLocateError(true);
        pushToast('error', t('me.checkInError'));
      },
      { enableHighAccuracy: true, timeout: 10000 }
    );
  }

  function chooseAction(item: CheckInAction) {
    setAction(item);
    if (!hasLocated.current) {
      hasLocated.current = true;
      locate();
    }
  }

  function pick(venue: GeoVenue) {
    if (action == null) return;
    onSelect({ ...venue, action: action.text, actionIcon: action.icon });
  }

  return (
    <View style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)', borderRadius: 6, overflow: 'hidden' }}>
      <View className="p-2" style={{ borderBottomWidth: 1, borderBottomColor: 'rgba(0,0,0,0.12)' }}>
        <Text className="text-sm font-medium text-ola-ink">
          {t('me.checkInWhat')}
        </Text>
        <View className="mt-2 flex-row flex-wrap gap-1">
          {CHECK_IN_ACTIONS.map((item) => {
            const active = action?.text === item.text;
            return (
              <Pressable
                key={item.text}
                onPress={() => chooseAction(item)}
                className="flex-row items-center gap-1 rounded-full px-2 py-1"
                style={{
                  borderWidth: 1,
                  borderColor: active ? '#7cb342' : 'rgba(0,0,0,0.12)',
                  backgroundColor: active ? '#f1f8e9' : 'transparent',
                }}
              >
                <Text style={{ fontSize: 12 }}>{item.icon}</Text>
                <Text className="text-xs" style={{ color: active ? '#7cb342' : 'rgba(0,0,0,0.54)' }}>
                  {item.text}
                </Text>
              </Pressable>
            );
          })}
        </View>
        {action == null && (
          <Text className="mt-2 text-xs" style={{ color: 'rgba(0,0,0,0.4)' }}>
            {t('me.checkInPickActionFirst')}
          </Text>
        )}
      </View>

      {action != null && (
        <>
          <Pressable
            onPress={locate}
            disabled={locating}
            className="flex-row items-center gap-2 px-3 py-2"
            style={{ borderBottomWidth: 1, borderBottomColor: 'rgba(0,0,0,0.12)', opacity: locating ? 0.5 : 1 }}
          >
            <Text style={{ fontSize: 14 }}>📡</Text>
            <Text className="text-sm" style={{ color: '#7cb342' }}>
              {locating ? t('me.checkInLocating') : t('me.checkInLocate')}
            </Text>
          </Pressable>

          {current != null && (
            <Pressable
              onPress={() => pick(current)}
              className="flex-row items-center gap-2 px-3 py-2 active:bg-black/5"
              style={{ borderBottomWidth: 1, borderBottomColor: 'rgba(0,0,0,0.12)' }}
            >
              <Image source={checkInIcon} style={{ width: 24, height: 24 }} resizeMode="contain" />
              <View className="min-w-0 flex-1">
                <Text numberOfLines={1} className="text-sm" style={{ color: '#7cb342' }}>
                  {t('me.checkInCurrent')}
                </Text>
                {(current.name !== '' || current.address !== '') && (
                  <Text numberOfLines={1} className="text-xs" style={{ color: 'rgba(0,0,0,0.4)' }}>
                    {current.name !== '' ? current.name : current.address}
                  </Text>
                )}
              </View>
            </Pressable>
          )}

          {locateError && (
            <Text className="px-3 py-2 text-xs" style={{ color: '#e34545' }}>
              {t('me.checkInError')}
            </Text>
          )}
          {!locating && !locateError && nearby.length === 0 && (
            <Text className="px-3 py-2 text-xs" style={{ color: 'rgba(0,0,0,0.4)' }}>
              {t('me.checkInNoVenues')}
            </Text>
          )}

          <ScrollView style={{ maxHeight: 176 }} keyboardShouldPersistTaps="handled">
            {nearby.map((venue) => (
              <Pressable
                key={`${venue.name}-${venue.lat}-${venue.lng}`}
                onPress={() => pick(venue)}
                className="flex-row items-center gap-2 px-3 py-2 active:bg-black/5"
              >
                <Text style={{ fontSize: 14 }}>📍</Text>
                <View className="min-w-0 flex-1">
                  <Text numberOfLines={1} className="text-sm text-ola-ink">
                    {venue.name}
                  </Text>
                  {venue.address !== '' && (
                    <Text numberOfLines={1} className="text-xs" style={{ color: 'rgba(0,0,0,0.4)' }}>
                      {venue.address}
                    </Text>
                  )}
                </View>
              </Pressable>
            ))}
          </ScrollView>
        </>
      )}
    </View>
  );
}
