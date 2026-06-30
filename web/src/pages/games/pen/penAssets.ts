import sceneUrl from '@/assets/games/pen/background-empty.webp';
import ballUrl from '@/assets/games/pen/ball.webp';
import ballTrailUrl from '@/assets/games/pen/ball-trail.webp';
import shootBtnUrl from '@/assets/games/pen/button-shoot.webp';
import selectBtnUrl from '@/assets/games/pen/button-select.webp';
import refreshBtnUrl from '@/assets/games/pen/button-refresh.webp';
import historyBtnUrl from '@/assets/games/pen/button-history.webp';
import plusBtnUrl from '@/assets/games/pen/button-plus.webp';
import helpBtnUrl from '@/assets/games/pen/button-help.webp';
import backBtnUrl from '@/assets/games/pen/button-back.webp';
import backIconUrl from '@/assets/games/pen/back.webp';
import helpIconUrl from '@/assets/games/pen/help.webp';
import plusIconUrl from '@/assets/games/pen/plus.webp';
import historyIconUrl from '@/assets/games/pen/history.webp';
import refreshIconUrl from '@/assets/games/pen/refresh.webp';
import gloveIconUrl from '@/assets/games/pen/glove.webp';
import kenIconUrl from '@/assets/icons/apps/ken.png';
import shootBallUrl from '@/assets/games/pen/shoot-modal/ball-trail.webp';
import confirmBtnUrl from '@/assets/games/pen/shoot-modal/button-confirm.webp';
import cancelBtnUrl from '@/assets/games/pen/shoot-modal/button-cancel.webp';
import closeBtnUrl from '@/assets/games/pen/shoot-modal/button-close.webp';
import closeIconUrl from '@/assets/games/pen/shoot-modal/close.webp';
import dirSelBgUrl from '@/assets/games/pen/shoot-modal/selected/background-empty.webp';
import dirSelTabUrl from '@/assets/games/pen/shoot-modal/selected/label-tab.webp';
import dirSelArrowLeftUrl from '@/assets/games/pen/shoot-modal/selected/arrow-left.webp';
import dirSelArrowRightUrl from '@/assets/games/pen/shoot-modal/selected/arrow-right.webp';
import dirSelBallUrl from '@/assets/games/pen/shoot-modal/selected/ball.webp';
import dirSelMarkUrl from '@/assets/games/pen/shoot-modal/selected/circle-check.webp';
import dirUnselBgUrl from '@/assets/games/pen/shoot-modal/unselected/background-empty.webp';
import dirUnselTabUrl from '@/assets/games/pen/shoot-modal/unselected/label-tab.webp';
import dirUnselArrowLeftUrl from '@/assets/games/pen/shoot-modal/unselected/arrow-left.webp';
import dirUnselArrowRightUrl from '@/assets/games/pen/shoot-modal/unselected/arrow-right.webp';
import dirUnselMarkUrl from '@/assets/games/pen/shoot-modal/unselected/circle.webp';
import catchGloveLeftUrl from '@/assets/games/pen/catch-modal/glove-left.webp';
import catchGloveRightUrl from '@/assets/games/pen/catch-modal/glove-right.webp';
import catchGloveEffectUrl from '@/assets/games/pen/catch-modal/glove-effect.webp';
import catchSelBgUrl from '@/assets/games/pen/catch-modal/selected/background-empty.webp';
import catchSelTabUrl from '@/assets/games/pen/catch-modal/selected/label-tab.webp';
import catchSelArrowLeftUrl from '@/assets/games/pen/catch-modal/selected/arrow-left.webp';
import catchSelArrowRightUrl from '@/assets/games/pen/catch-modal/selected/arrow-right.webp';
import catchSelMarkUrl from '@/assets/games/pen/catch-modal/selected/circle-check.webp';
import catchUnselTabUrl from '@/assets/games/pen/catch-modal/unselected/label-tab.webp';
import catchUnselArrowLeftUrl from '@/assets/games/pen/catch-modal/unselected/arrow-left.webp';
import catchUnselArrowRightUrl from '@/assets/games/pen/catch-modal/unselected/arrow-right.webp';

export const penAssets = {
  scene: sceneUrl,
  ball: ballUrl,
  ballTrail: ballTrailUrl,
  shootBtn: shootBtnUrl,
  selectBtn: selectBtnUrl,
  refreshBtn: refreshBtnUrl,
  historyBtn: historyBtnUrl,
  plusBtn: plusBtnUrl,
  helpBtn: helpBtnUrl,
  backBtn: backBtnUrl,
  backIcon: backIconUrl,
  helpIcon: helpIconUrl,
  plusIcon: plusIconUrl,
  historyIcon: historyIconUrl,
  refreshIcon: refreshIconUrl,
  gloveIcon: gloveIconUrl,
  kenIcon: kenIconUrl,
};

export const penShootAssets = {
  ball: shootBallUrl,
  panelBall: dirSelBallUrl,
  confirmBtn: confirmBtnUrl,
  cancelBtn: cancelBtnUrl,
  closeBtn: closeBtnUrl,
  closeIcon: closeIconUrl,
  dir: {
    selected: {
      bg: dirSelBgUrl,
      tab: dirSelTabUrl,
      arrowLeft: dirSelArrowLeftUrl,
      arrowRight: dirSelArrowRightUrl,
      mark: dirSelMarkUrl,
    },
    unselected: {
      bg: dirUnselBgUrl,
      tab: dirUnselTabUrl,
      arrowLeft: dirUnselArrowLeftUrl,
      arrowRight: dirUnselArrowRightUrl,
      mark: dirUnselMarkUrl,
    },
  },
};

export const penCatchAssets = {
  gloveLeft: catchGloveLeftUrl,
  gloveRight: catchGloveRightUrl,
  gloveEffect: catchGloveEffectUrl,
  confirmBtn: confirmBtnUrl,
  cancelBtn: cancelBtnUrl,
  closeBtn: closeBtnUrl,
  closeIcon: closeIconUrl,
  dir: {
    selected: {
      bg: catchSelBgUrl,
      tab: catchSelTabUrl,
      arrowLeft: catchSelArrowLeftUrl,
      arrowRight: catchSelArrowRightUrl,
      mark: catchSelMarkUrl,
    },
    unselected: {
      bg: dirUnselBgUrl,
      tab: catchUnselTabUrl,
      arrowLeft: catchUnselArrowLeftUrl,
      arrowRight: catchUnselArrowRightUrl,
    },
  },
};
