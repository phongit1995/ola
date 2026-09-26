export const FACTORY_LAYOUT = {
  splitMinWidth: 560,
  splitMaxHeight: 500,
  width: 560,
  splitWidth: 620,
  height: 480,
  splitHeight: 340,
  screenMargin: 24,
  padding: 18,
  footerBottom: 30,
} as const;

/** Queue slots in CSS pixels; the row scrolls sideways when they do not all fit. */
export const QUEUE_SLOT_SIZE = 64,
  /** Largest slot when the whole queue fits, e.g. on a desktop window. */
  QUEUE_SLOT_MAX = 88,
  QUEUE_SLOT_GAP = 8,
  /** Diamond price button under each queued job. */
  QUEUE_BOOST_HEIGHT = 26,
  QUEUE_BOOST_GAP = 4,
  /** CSS pixels from the dialog's top edge to the queue row, just under the title ear. */
  QUEUE_ROW_TOP = 60;
