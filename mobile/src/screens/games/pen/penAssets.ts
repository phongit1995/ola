export const penAssets = {
  scene: require('@assets/games/pen/background-empty.webp'),
  ball: require('@assets/games/pen/ball.webp'),
  ballTrail: require('@assets/games/pen/ball-trail.webp'),
  shootBtn: require('@assets/games/pen/button-shoot.webp'),
  selectBtn: require('@assets/games/pen/button-select.webp'),
  refreshBtn: require('@assets/games/pen/button-refresh.webp'),
  historyBtn: require('@assets/games/pen/button-history.webp'),
  plusBtn: require('@assets/games/pen/button-plus.webp'),
  helpBtn: require('@assets/games/pen/button-help.webp'),
  backBtn: require('@assets/games/pen/button-back.webp'),
  backIcon: require('@assets/games/pen/back.webp'),
  helpIcon: require('@assets/games/pen/help.webp'),
  plusIcon: require('@assets/games/pen/plus.webp'),
  historyIcon: require('@assets/games/pen/history.webp'),
  refreshIcon: require('@assets/games/pen/refresh.webp'),
  gloveIcon: require('@assets/games/pen/glove.webp'),
  shotListIcon: require('@assets/games/pen/shot-list.webp'),
  kenIcon: require('@assets/icons/apps/ken.png'),
};

export const penShootAssets = {
  ball: require('@assets/games/pen/shoot-modal/ball-trail.webp'),
  panelBall: require('@assets/games/pen/shoot-modal/selected/ball.webp'),
  confirmBtn: require('@assets/games/pen/shoot-modal/button-confirm.webp'),
  cancelBtn: require('@assets/games/pen/shoot-modal/button-cancel.webp'),
  closeBtn: require('@assets/games/pen/shoot-modal/button-close.webp'),
  closeIcon: require('@assets/games/pen/shoot-modal/close.webp'),
  dir: {
    selected: {
      bg: require('@assets/games/pen/shoot-modal/selected/background-empty.webp'),
      tab: require('@assets/games/pen/shoot-modal/selected/label-tab.webp'),
      arrowLeft: require('@assets/games/pen/shoot-modal/selected/arrow-left.webp'),
      arrowRight: require('@assets/games/pen/shoot-modal/selected/arrow-right.webp'),
      mark: require('@assets/games/pen/shoot-modal/selected/circle-check.webp'),
    },
    unselected: {
      bg: require('@assets/games/pen/shoot-modal/unselected/background-empty.webp'),
      tab: require('@assets/games/pen/shoot-modal/unselected/label-tab.webp'),
      arrowLeft: require('@assets/games/pen/shoot-modal/unselected/arrow-left.webp'),
      arrowRight: require('@assets/games/pen/shoot-modal/unselected/arrow-right.webp'),
      mark: require('@assets/games/pen/shoot-modal/unselected/circle.webp'),
    },
  },
};

export const penHistoryAssets = {
  tab: require('@assets/games/pen/history-modal/tab.webp'),
  pageCurrent: require('@assets/games/pen/history-modal/button-page-current.webp'),
  pageNext: require('@assets/games/pen/history-modal/button-page-next.webp'),
  clock: require('@assets/games/pen/history-modal/clock.webp'),
  clockYellow: require('@assets/games/pen/history-modal/clock-yellow.webp'),
};

export const penLeaderboardAssets = {
  frame: require('@assets/games/pen/leaderboard/frame.webp'),
  cup: require('@assets/games/pen/leaderboard/cup.webp'),
  tab: require('@assets/games/pen/leaderboard/tab.webp'),
  medals: [
    require('@assets/games/pen/leaderboard/medal-1.webp'),
    require('@assets/games/pen/leaderboard/medal-2.webp'),
    require('@assets/games/pen/leaderboard/medal-3.webp'),
  ] as const,
};

export const penCatchAssets = {
  gloveLeft: require('@assets/games/pen/catch-modal/glove-left.webp'),
  gloveRight: require('@assets/games/pen/catch-modal/glove-right.webp'),
  gloveEffect: require('@assets/games/pen/catch-modal/glove-effect.webp'),
  confirmBtn: require('@assets/games/pen/shoot-modal/button-confirm.webp'),
  cancelBtn: require('@assets/games/pen/shoot-modal/button-cancel.webp'),
  closeBtn: require('@assets/games/pen/shoot-modal/button-close.webp'),
  closeIcon: require('@assets/games/pen/shoot-modal/close.webp'),
  dir: {
    selected: {
      bg: require('@assets/games/pen/catch-modal/selected/background-empty.webp'),
      tab: require('@assets/games/pen/catch-modal/selected/label-tab.webp'),
      arrowLeft: require('@assets/games/pen/catch-modal/selected/arrow-left.webp'),
      arrowRight: require('@assets/games/pen/catch-modal/selected/arrow-right.webp'),
      mark: require('@assets/games/pen/catch-modal/selected/circle-check.webp'),
    },
    unselected: {
      bg: require('@assets/games/pen/shoot-modal/unselected/background-empty.webp'),
      tab: require('@assets/games/pen/catch-modal/unselected/label-tab.webp'),
      arrowLeft: require('@assets/games/pen/catch-modal/unselected/arrow-left.webp'),
      arrowRight: require('@assets/games/pen/catch-modal/unselected/arrow-right.webp'),
    },
  },
};
