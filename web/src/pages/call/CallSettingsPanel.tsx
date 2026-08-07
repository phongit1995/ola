import { useTranslation } from 'react-i18next';
import { PERM_NAME, PERM_STATE } from './constants';
import type { PermState } from './interfaces';
import { CloseIcon } from './icons';
import { useDeviceSync } from './hooks/useDeviceSync';
import { usePermissionStatus } from './hooks/usePermissionStatus';

interface CallSettingsPanelProps {
  onClose: () => void;
}

interface DeviceSectionProps {
  title: string;
  devices: MediaDeviceInfo[];
  selectedId: string | null;
  perm?: PermState;
  emptyLabel: string;
  onSelect: (id: string) => void;
}

function permLabelKey(perm: PermState) {
  if (perm === PERM_STATE.granted) return 'call.permAllowed' as const;
  if (perm === PERM_STATE.denied) return 'call.permBlocked' as const;
  if (perm === PERM_STATE.unsupported) return 'call.permUnsupported' as const;
  return 'call.permNotAsked' as const;
}

function permToneClass(perm: PermState) {
  if (perm === PERM_STATE.granted) return 'bg-ola-button';
  if (perm === PERM_STATE.denied) return 'bg-ola-error';
  return 'bg-amber-400';
}

function DeviceSection({
  title,
  devices,
  selectedId,
  perm,
  emptyLabel,
  onSelect,
}: DeviceSectionProps) {
  const { t } = useTranslation();

  return (
    <section className="flex flex-col gap-2">
      <header className="flex items-center gap-2">
        <h3 className="text-sm font-semibold text-white">{title}</h3>
        {perm != null && (
          <span className="flex items-center gap-1 text-[11px] text-white/60">
            <span className={`h-2 w-2 rounded-full ${permToneClass(perm)}`} />
            {t(permLabelKey(perm))}
          </span>
        )}
      </header>
      {devices.length === 0 ? (
        <p className="text-xs text-white/50">{emptyLabel}</p>
      ) : (
        <ul className="flex flex-col gap-1">
          {devices.map((device, index) => {
            const checked =
              selectedId === device.deviceId ||
              (selectedId == null && index === 0);
            return (
              <li key={device.deviceId}>
                <button
                  type="button"
                  onClick={() => onSelect(device.deviceId)}
                  className={`w-full truncate rounded-lg px-3 py-2 text-left text-sm ${
                    checked
                      ? 'bg-white/90 text-ola-primary-darker'
                      : 'bg-white/10 text-white hover:bg-white/20'
                  }`}
                >
                  {device.label !== '' ? device.label : device.deviceId}
                </button>
              </li>
            );
          })}
        </ul>
      )}
    </section>
  );
}

export function CallSettingsPanel({ onClose }: CallSettingsPanelProps) {
  const { t } = useTranslation();
  const micPerm = usePermissionStatus(PERM_NAME.mic);
  const camPerm = usePermissionStatus(PERM_NAME.cam);
  const {
    devices,
    selectedMicId,
    selectedCamId,
    selectedSpeakerId,
    setSelectedMicId,
    setSelectedCamId,
    setSelectedSpeakerId,
  } = useDeviceSync();

  const needPermission = t('call.devicesNeedPermission');

  return (
    <div className="absolute inset-0 z-30 flex flex-col justify-end bg-black/50">
      <button
        type="button"
        aria-label={t('call.close')}
        onClick={onClose}
        className="flex-1"
      />
      <div className="max-h-[70%] overflow-y-auto rounded-t-3xl bg-[#1f2a24] px-5 pb-8 pt-5">
        <div className="mb-4 flex items-center justify-between">
          <h2 className="text-base font-semibold text-white">
            {t('call.settingsTitle')}
          </h2>
          <button
            type="button"
            aria-label={t('call.close')}
            onClick={onClose}
            className="flex h-8 w-8 items-center justify-center rounded-full bg-white/10 text-white hover:bg-white/20"
          >
            <CloseIcon className="h-4 w-4" />
          </button>
        </div>

        <div className="flex flex-col gap-5">
          <DeviceSection
            title={t('call.microphone')}
            devices={devices.audioinput}
            selectedId={selectedMicId}
            perm={micPerm}
            emptyLabel={needPermission}
            onSelect={setSelectedMicId}
          />
          <DeviceSection
            title={t('call.camera')}
            devices={devices.videoinput}
            selectedId={selectedCamId}
            perm={camPerm}
            emptyLabel={needPermission}
            onSelect={setSelectedCamId}
          />
          <DeviceSection
            title={t('call.speaker')}
            devices={devices.audiooutput}
            selectedId={selectedSpeakerId}
            emptyLabel={t('call.noDevices')}
            onSelect={setSelectedSpeakerId}
          />
        </div>
      </div>
    </div>
  );
}
