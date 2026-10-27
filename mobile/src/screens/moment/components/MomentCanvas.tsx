import { useEffect, useRef, useState, type ReactNode } from 'react';
import {
  Image,
  StyleSheet,
  Text,
  View,
  type LayoutChangeEvent,
  type StyleProp,
  type ViewStyle,
} from 'react-native';
import FastImage, { type FastImageProps } from '@d11/react-native-fast-image';
import LinearGradient from 'react-native-linear-gradient';
import Video, { type OnLoadData, type OnProgressData, type VideoRef } from 'react-native-video';
import { MOMENT_TYPE } from '@ola/shared/constants';
import { momentBackgroundColors, resolveMomentBackground } from '@ola/shared/lib';
import type { MomentMediaDraft, MomentOverlay } from '@ola/shared/types';
import { MOMENT_BACKDROP_BLUR, MOMENT_GRADIENT_ANGLE_DEG } from '../constants';
import { gradientPoints, overlayBubbleStyle, overlayTextStyle } from '../utils';

export type MomentVideoMode = 'still' | 'loop' | 'controlled';

export type MomentMediaFit = 'contain' | 'cover';

export interface MomentCanvasSize {
  width: number;
  height: number;
}

const GRADIENT = gradientPoints(MOMENT_GRADIENT_ANGLE_DEG);

const FILL_IMAGE = StyleSheet.absoluteFill as FastImageProps['style'];

export function MomentOverlayFrame({
  overlay,
  canvas,
  children,
}: {
  overlay: MomentOverlay;
  canvas: MomentCanvasSize;
  children: ReactNode;
}) {
  return (
    <View
      pointerEvents="box-none"
      style={{
        position: 'absolute',
        left: (overlay.x - overlay.w / 2) * canvas.width,
        width: overlay.w * canvas.width,
        top: overlay.y * canvas.height - canvas.height,
        height: canvas.height * 2,
        alignItems: 'center',
        justifyContent: 'center',
      }}
    >
      {children}
    </View>
  );
}

export function MomentOverlayBubble({
  overlay,
  canvasWidth,
}: {
  overlay: MomentOverlay;
  canvasWidth: number;
}) {
  return (
    <View style={overlayBubbleStyle(overlay, canvasWidth)}>
      <Text style={overlayTextStyle(overlay, canvasWidth)}>{overlay.text}</Text>
    </View>
  );
}

function MomentOverlayText({ overlay, canvas }: { overlay: MomentOverlay; canvas: MomentCanvasSize }) {
  return (
    <MomentOverlayFrame overlay={overlay} canvas={canvas}>
      <View pointerEvents="none" style={{ transform: [{ rotate: `${overlay.rotation}deg` }] }}>
        <MomentOverlayBubble overlay={overlay} canvasWidth={canvas.width} />
      </View>
    </MomentOverlayFrame>
  );
}

export function MomentBackgroundFill({ background }: { background?: string }) {
  const fill = resolveMomentBackground(background);
  if (fill.kind === 'solid') {
    return <View style={[StyleSheet.absoluteFill, { backgroundColor: fill.color }]} />;
  }
  return (
    <LinearGradient
      colors={momentBackgroundColors(fill)}
      start={GRADIENT.start}
      end={GRADIENT.end}
      style={StyleSheet.absoluteFill}
    />
  );
}

function BlurredBackdrop({ url }: { url: string }) {
  return (
    <>
      <Image
        source={{ uri: url }}
        blurRadius={MOMENT_BACKDROP_BLUR}
        resizeMode="cover"
        style={[StyleSheet.absoluteFill, { opacity: 0.7, transform: [{ scale: 1.1 }] }]}
      />
      <View style={[StyleSheet.absoluteFill, { backgroundColor: 'rgba(0,0,0,0.25)' }]} />
    </>
  );
}

interface MomentVideoEvents {
  playId?: number;
  paused?: boolean;
  muted?: boolean;
  onVideoProgress?: (progress: number) => void;
  onVideoEnd?: () => void;
}

interface MomentMediaEvents {
  onMediaReady?: () => void;
  onMediaError?: () => void;
}

function MomentVideo({
  media,
  mode,
  fit,
  playId,
  paused,
  muted,
  onVideoProgress,
  onVideoEnd,
  onMediaReady,
  onMediaError,
}: MomentVideoEvents &
  MomentMediaEvents & { media: MomentMediaDraft; mode: MomentVideoMode; fit: MomentMediaFit }) {
  const [duration, setDuration] = useState(0);
  const videoRef = useRef<VideoRef>(null);

  useEffect(() => {
    if (playId != null) videoRef.current?.seek(0);
  }, [playId]);

  if (mode === 'still') {
    if (!media.posterUrl) return null;
    return (
      <FastImage
        source={{ uri: media.posterUrl }}
        resizeMode={FastImage.resizeMode[fit]}
        style={FILL_IMAGE}
      />
    );
  }
  if (mode === 'loop') {
    return (
      <Video
        source={{ uri: media.url }}
        repeat
        muted
        resizeMode="contain"
        onReadyForDisplay={onMediaReady}
        onError={onMediaError}
        style={StyleSheet.absoluteFill}
      />
    );
  }
  return (
    <Video
      ref={videoRef}
      source={{ uri: media.url }}
      paused={paused}
      muted={muted}
      resizeMode="contain"
      progressUpdateInterval={100}
      onLoad={(data: OnLoadData) => setDuration(data.duration)}
      onProgress={(data: OnProgressData) => {
        const total = duration || data.seekableDuration;
        if (total > 0) onVideoProgress?.(data.currentTime / total);
      }}
      onEnd={onVideoEnd}
      onReadyForDisplay={onMediaReady}
      onError={onMediaError}
      style={StyleSheet.absoluteFill}
    />
  );
}

interface MomentCanvasProps extends MomentVideoEvents, MomentMediaEvents {
  background?: string;
  media?: MomentMediaDraft | null;
  overlays: readonly MomentOverlay[];
  videoMode?: MomentVideoMode;
  fit?: MomentMediaFit;
  renderOverlays?: (canvas: MomentCanvasSize) => ReactNode;
  style?: StyleProp<ViewStyle>;
  children?: ReactNode;
}

export function MomentCanvas({
  background,
  media,
  overlays,
  videoMode = 'still',
  fit = 'contain',
  renderOverlays,
  style,
  children,
  onMediaReady,
  onMediaError,
  ...videoEvents
}: MomentCanvasProps) {
  const [canvas, setCanvas] = useState<MomentCanvasSize | null>(null);
  const [failedUrl, setFailedUrl] = useState<string | null>(null);
  const [shownUrl, setShownUrl] = useState(media?.url);
  const backdropUrl =
    fit === 'cover' ? undefined : media?.type === MOMENT_TYPE.image ? media.url : media?.posterUrl;

  if (shownUrl !== media?.url) {
    setShownUrl(media?.url);
    setFailedUrl(null);
  }

  function handleLayout(event: LayoutChangeEvent) {
    const { width, height } = event.nativeEvent.layout;
    if (canvas == null || canvas.width !== width || canvas.height !== height) {
      setCanvas({ width, height });
    }
  }

  return (
    <View
      onLayout={handleLayout}
      style={[{ overflow: 'hidden', backgroundColor: '#000000' }, style]}
    >
      {media == null && <MomentBackgroundFill background={background} />}
      {backdropUrl ? <BlurredBackdrop url={backdropUrl} /> : null}
      {media?.type === MOMENT_TYPE.image && failedUrl !== media.url && (
        <FastImage
          key={media.url}
          source={{ uri: media.url }}
          resizeMode={FastImage.resizeMode[fit]}
          onLoad={onMediaReady}
          onError={() => {
            setFailedUrl(media.url);
            onMediaError?.();
          }}
          style={FILL_IMAGE}
        />
      )}
      {media?.type === MOMENT_TYPE.video && (
        <MomentVideo
          key={media.url}
          media={media}
          mode={videoMode}
          fit={fit}
          onMediaReady={onMediaReady}
          onMediaError={onMediaError}
          {...videoEvents}
        />
      )}
      {canvas != null &&
        (renderOverlays
          ? renderOverlays(canvas)
          : overlays.map((overlay) => (
              <MomentOverlayText key={overlay.id} overlay={overlay} canvas={canvas} />
            )))}
      {children}
    </View>
  );
}
