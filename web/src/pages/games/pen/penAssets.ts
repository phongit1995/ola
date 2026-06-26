import sceneUrl from '@/assets/games/pen/background-empty.png';
import ballUrl from '@/assets/games/pen/ball.png';
import ballTrailUrl from '@/assets/games/pen/ball-trail.png';
import shootBtnUrl from '@/assets/games/pen/button-shoot.png';
import selectBtnUrl from '@/assets/games/pen/button-select.png';
import refreshBtnUrl from '@/assets/games/pen/button-refresh.png';
import historyBtnUrl from '@/assets/games/pen/button-history.png';
import plusBtnUrl from '@/assets/games/pen/button-plus.png';
import helpBtnUrl from '@/assets/games/pen/button-help.png';
import backBtnUrl from '@/assets/games/pen/button-back.png';
import backIconUrl from '@/assets/games/pen/back.png';
import helpIconUrl from '@/assets/games/pen/help.png';
import plusIconUrl from '@/assets/games/pen/plus.png';
import historyIconUrl from '@/assets/games/pen/history.png';
import refreshIconUrl from '@/assets/games/pen/refresh.png';
import gloveIconUrl from '@/assets/games/pen/glove.png';
import kenIconUrl from '@/assets/icons/apps/ken.png';
import shootBgUrl from '@/assets/games/pen/shoot-modal/background-empty.png';
import shootBallUrl from '@/assets/games/pen/shoot-modal/ball-trail.png';
import confirmBtnUrl from '@/assets/games/pen/shoot-modal/button-confirm.png';
import cancelBtnUrl from '@/assets/games/pen/shoot-modal/button-cancel.png';
import closeBtnUrl from '@/assets/games/pen/shoot-modal/button-close.png';
import closeIconUrl from '@/assets/games/pen/shoot-modal/close.png';
import dirSelBgUrl from '@/assets/games/pen/shoot-modal/selected/background-empty.png';
import dirSelTabUrl from '@/assets/games/pen/shoot-modal/selected/label-tab.png';
import dirSelArrowLeftUrl from '@/assets/games/pen/shoot-modal/selected/arrow-left.png';
import dirSelArrowRightUrl from '@/assets/games/pen/shoot-modal/selected/arrow-right.png';
import dirSelBallUrl from '@/assets/games/pen/shoot-modal/selected/ball.png';
import dirSelMarkUrl from '@/assets/games/pen/shoot-modal/selected/circle-check.png';
import dirUnselBgUrl from '@/assets/games/pen/shoot-modal/unselected/background-empty.png';
import dirUnselTabUrl from '@/assets/games/pen/shoot-modal/unselected/label-tab.png';
import dirUnselArrowLeftUrl from '@/assets/games/pen/shoot-modal/unselected/arrow-left.png';
import dirUnselArrowRightUrl from '@/assets/games/pen/shoot-modal/unselected/arrow-right.png';
import dirUnselMarkUrl from '@/assets/games/pen/shoot-modal/unselected/circle.png';

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
  bg: shootBgUrl,
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
