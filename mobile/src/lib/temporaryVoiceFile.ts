import { InteractionManager } from 'react-native';
import ReactNativeBlobUtil from 'react-native-blob-util';
import { recordAppError } from './telemetry';

interface TemporaryVoiceFileLease {
  consumers: number;
  deleteRequested: boolean;
}

const temporaryVoiceFileLeases = new Map<string, TemporaryVoiceFileLease>();

function localPath(uri: string): string | null {
  if (uri.startsWith('file://')) return uri.slice('file://'.length);
  if (uri.startsWith('/')) return uri;
  return null;
}

async function unlinkTemporaryVoiceFile(uri: string): Promise<void> {
  const path = localPath(uri);
  if (path == null || path === '') return;
  try {
    if (await ReactNativeBlobUtil.fs.exists(path)) {
      await ReactNativeBlobUtil.fs.unlink(path);
    }
  } catch (error) {
    recordAppError(error, 'voice_temporary_file_delete_failed');
  }
}

function scheduleTemporaryVoiceFileDeletion(uri: string): void {
  requestAnimationFrame(() => {
    InteractionManager.runAfterInteractions(() => {
      void deleteTemporaryVoiceFile(uri);
    });
  });
}

export function retainTemporaryVoiceFile(uri: string): void {
  if (localPath(uri) == null) return;
  const lease = temporaryVoiceFileLeases.get(uri) ?? {
    consumers: 0,
    deleteRequested: false,
  };
  lease.consumers += 1;
  temporaryVoiceFileLeases.set(uri, lease);
}

export function releaseTemporaryVoiceFile(uri: string): void {
  const lease = temporaryVoiceFileLeases.get(uri);
  if (lease == null) return;
  lease.consumers = Math.max(0, lease.consumers - 1);
  if (lease.consumers > 0) return;
  temporaryVoiceFileLeases.delete(uri);
  if (lease.deleteRequested) scheduleTemporaryVoiceFileDeletion(uri);
}

export async function deleteTemporaryVoiceFile(uri: string): Promise<void> {
  const lease = temporaryVoiceFileLeases.get(uri);
  if (lease != null && lease.consumers > 0) {
    lease.deleteRequested = true;
    return;
  }
  temporaryVoiceFileLeases.delete(uri);
  await unlinkTemporaryVoiceFile(uri);
}

export function deleteTemporaryVoiceFileAfterUiUpdate(uri: string): void {
  scheduleTemporaryVoiceFileDeletion(uri);
}
