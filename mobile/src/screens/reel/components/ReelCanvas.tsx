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
import { REEL_TYPE } from '@ola/shared/constants';
import { reelBackgroundColors, resolveReelBackground } from '@ola/shared/lib';
import type { ReelMediaDraft, ReelOverlay } from '@ola/shared/types';
import { REEL_BACKDROP_BLUR, REEL_GRADIENT_ANGLE_DEG } from '../constants';
import { gradientPoints, overlayBubbleStyle, overlayTextStyle } from '../utils';

export type ReelVideoMode = 'still' | 'loop' | 'controlled';

export type ReelMediaFit = 'contain' | 'cover';

export interface ReelCanvasSize {
  width: number;
  height: number;
}

const GRADIENT = gradientPoints(REEL_GRADIENT_ANGLE_DEG);

const FILL_IMAGE = StyleSheet.absoluteFill as FastImageProps['style'];

export function ReelOverlayFrame({
  overlay,
  canvas,
  children,
}: {
  overlay: ReelOverlay;
  canvas: ReelCanvasSize;
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

export function ReelOverlayBubble({
  overlay,
  canvasWidth,
}: {
  overlay: ReelOverlay;
  canvasWidth: number;
}) {
  return (
    <View style={overlayBubbleStyle(overlay, canvasWidth)}>
      <Text style={overlayTextStyle(overlay, canvasWidth)}>{overlay.text}</Text>
    </View>
  );
}

function ReelOverlayText({ overlay, canvas }: { overlay: ReelOverlay; canvas: ReelCanvasSize }) {
  return (
    <ReelOverlayFrame overlay={overlay} canvas={canvas}>
      <View pointerEvents="none" style={{ transform: [{ rotate: `${overlay.rotation}deg` }] }}>
        <ReelOverlayBubble overlay={overlay} canvasWidth={canvas.width} />
      </View>
    </ReelOverlayFrame>
  );
}

export function ReelBackgroundFill({ background }: { background?: string }) {
  const fill = resolveReelBackground(background);
  if (fill.kind === 'solid') {
    return <View style={[StyleSheet.absoluteFill, { backgroundColor: fill.color }]} />;
  }
  return (
    <LinearGradient
      colors={reelBackgroundColors(fill)}
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
        blurRadius={REEL_BACKDROP_BLUR}
        resizeMode="cover"
        style={[StyleSheet.absoluteFill, { opacity: 0.7, transform: [{ scale: 1.1 }] }]}
      />
      <View style={[StyleSheet.absoluteFill, { backgroundColor: 'rgba(0,0,0,0.25)' }]} />
    </>
  );
}

interface ReelVideoEvents {
  playId?: number;
  paused?: boolean;
  muted?: boolean;
  onVideoProgress?: (progress: number) => void;
  onVideoEnd?: () => void;
}

interface ReelMediaEvents {
  onMediaReady?: () => void;
  onMediaError?: () => void;
}

function ReelVideo({
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
}: ReelVideoEvents &
  ReelMediaEvents & { media: ReelMediaDraft; mode: ReelVideoMode; fit: ReelMediaFit }) {
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

interface ReelCanvasProps extends ReelVideoEvents, ReelMediaEvents {
  background?: string;
  media?: ReelMediaDraft | null;
  overlays: readonly ReelOverlay[];
  videoMode?: ReelVideoMode;
  fit?: ReelMediaFit;
  renderOverlays?: (canvas: ReelCanvasSize) => ReactNode;
  style?: StyleProp<ViewStyle>;
  children?: ReactNode;
}

export function ReelCanvas({
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
}: ReelCanvasProps) {
  const [canvas, setCanvas] = useState<ReelCanvasSize | null>(null);
  const [failedUrl, setFailedUrl] = useState<string | null>(null);
  const [shownUrl, setShownUrl] = useState(media?.url);
  const backdropUrl =
    fit === 'cover' ? undefined : media?.type === REEL_TYPE.image ? media.url : media?.posterUrl;

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
      {media == null && <ReelBackgroundFill background={background} />}
      {backdropUrl ? <BlurredBackdrop url={backdropUrl} /> : null}
      {media?.type === REEL_TYPE.image && failedUrl !== media.url && (
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
      {media?.type === REEL_TYPE.video && (
        <ReelVideo
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
              <ReelOverlayText key={overlay.id} overlay={overlay} canvas={canvas} />
            )))}
      {children}
    </View>
  );
}
