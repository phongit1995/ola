import { memo, useCallback, useEffect, useMemo, useState } from 'react';
import { findNodeHandle, Image, NativeModules, View } from 'react-native';
import type { RefObject } from 'react';
import type { LayoutRectangle, TextInput, TextInputScrollEvent } from 'react-native';
import {
  PLACEHOLDER_SLOT_WIDTH,
  PLACEHOLDER_WIDTH_TOLERANCE,
  SMILEY_PLACEHOLDER,
  composerSmileyHeight,
  imageSizeForHeight,
  smileyImageForCode,
} from '../lib/chatSmiley';

const { TextRangeRects } = NativeModules as {
  TextRangeRects?: { measure(tag: number, starts: number[]): Promise<LayoutRectangle[]> };
};

const COMPOSER_LINE_HEIGHT = 24;
const LINE_Y_TOLERANCE = 2;

export function composerSingleLineHeight(verticalPadding: number): number {
  return COMPOSER_LINE_HEIGHT + verticalPadding * 2;
}

export function useComposerScrollSync(draft: string) {
  const [scrollY, setScrollY] = useState(0);
  if (draft === '' && scrollY !== 0) setScrollY(0);
  const handleScroll = useCallback(
    (event: TextInputScrollEvent) => setScrollY(event.nativeEvent.contentOffset.y),
    []
  );
  return { scrollY, handleScroll };
}

function placeholderIndices(display: string): number[] {
  const indices: number[] = [];
  for (let index = 0; index < display.length; index++) {
    if (display[index] === SMILEY_PLACEHOLDER) indices.push(index);
  }
  return indices;
}

interface PlaceholderGroup {
  code: string;
  members: number[];
}

function placeholderGroups(indices: number[], codes: string[]): PlaceholderGroup[] {
  const groups: PlaceholderGroup[] = [];
  let buffer: number[] = [];
  indices.forEach((position, order) => {
    if (order > 0 && position !== indices[order - 1] + 1) buffer = [];
    const code = codes[order] ?? '';
    if (code === '') {
      buffer.push(order);
      return;
    }
    groups.push({ code, members: [...buffer, order] });
    buffer = [];
  });
  return groups;
}

function groupRect(group: PlaceholderGroup, rects: LayoutRectangle[]): LayoutRectangle | null {
  const main = rects[group.members[group.members.length - 1]];
  if (main == null || main.width < PLACEHOLDER_SLOT_WIDTH - 1) return null;
  const first = rects[group.members[0]];
  if (first == null || Math.abs(first.y - main.y) > LINE_Y_TOLERANCE) return main;
  return {
    x: first.x,
    y: main.y,
    width: main.x + main.width - first.x,
    height: main.height,
  };
}

function sameRects(previous: LayoutRectangle[], next: LayoutRectangle[]): boolean {
  if (previous.length !== next.length) return false;
  return previous.every((rect, index) => {
    const other = next[index];
    return (
      rect.x === other.x &&
      rect.y === other.y &&
      rect.width === other.width &&
      rect.height === other.height
    );
  });
}

interface DraftOverlayProps {
  display: string;
  codes: string[];
  inputRef: RefObject<TextInput | null>;
}

const DraftImages = memo(function DraftImages({ display, codes, inputRef }: DraftOverlayProps) {
  const measureKey = display.slice(0, display.lastIndexOf(SMILEY_PLACEHOLDER) + 1);
  const indices = useMemo(() => placeholderIndices(measureKey), [measureKey]);
  const groups = useMemo(() => placeholderGroups(indices, codes), [indices, codes]);
  const [rects, setRects] = useState<LayoutRectangle[]>([]);

  useEffect(() => {
    if (indices.length === 0) {
      setRects((previous) => (previous.length === 0 ? previous : []));
      return;
    }
    let cancelled = false;
    const frame = requestAnimationFrame(() => {
      const tag = findNodeHandle(inputRef.current);
      if (tag == null || TextRangeRects == null) return;
      TextRangeRects.measure(tag, indices)
        .then((measured) => {
          if (!cancelled) setRects((previous) => (sameRects(previous, measured) ? previous : measured));
        })
        .catch(() => undefined);
    });
    return () => {
      cancelled = true;
      cancelAnimationFrame(frame);
    };
  }, [indices, inputRef]);

  return (
    <>
      {groups.map((group, index) => {
        const rect = groupRect(group, rects);
        const src = rect == null ? null : smileyImageForCode(group.code);
        if (rect == null || src == null) return null;
        const height = composerSmileyHeight(group.code);
        const width = Math.min(
          imageSizeForHeight(src, height).width,
          rect.width + PLACEHOLDER_WIDTH_TOLERANCE
        );
        return (
          <Image
            key={index}
            source={src}
            resizeMode="contain"
            style={{
              position: 'absolute',
              left: rect.x + (rect.width - width) / 2,
              top: rect.y + (rect.height - height) / 2,
              width,
              height,
            }}
          />
        );
      })}
    </>
  );
});

export function ComposerDraftOverlay({
  display,
  codes,
  inputRef,
  scrollY = 0,
}: DraftOverlayProps & { scrollY?: number }) {
  return (
    <View pointerEvents="none" className="absolute inset-0 overflow-hidden">
      <View style={{ transform: [{ translateY: -scrollY }] }}>
        <DraftImages display={display} codes={codes} inputRef={inputRef} />
      </View>
    </View>
  );
}
