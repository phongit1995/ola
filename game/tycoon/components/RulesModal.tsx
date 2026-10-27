import { useId, useRef, useState, type KeyboardEvent } from 'react';
import bookUrl from '../assets/lobby/ill-rules.webp';
import closeUrl from '../assets/bot-setup/close-navy.svg';
import actionTimerUrl from '../assets/rules/ill-action-timer.webp';
import buyRentUrl from '../assets/rules/ill-buy-rent.webp';
import debtWarningUrl from '../assets/rules/ill-debt-warning.webp';
import doubleDiceUrl from '../assets/rules/ill-double-dice.webp';
import festivalUrl from '../assets/rules/ill-festival.webp';
import finishClockUrl from '../assets/rules/ill-finish-clock.webp';
import jailUrl from '../assets/rules/ill-jail.webp';
import rollDiceUrl from '../assets/rules/ill-roll-dice.webp';
import startCoinsUrl from '../assets/rules/ill-start-coins.webp';
import takeoverUrl from '../assets/rules/ill-takeover.webp';
import taxCardsUrl from '../assets/rules/ill-tax-cards.webp';
import totalAssetsUrl from '../assets/rules/ill-total-assets.webp';
import travelUrl from '../assets/rules/ill-travel.webp';
import upgradeUrl from '../assets/rules/ill-upgrade.webp';
import winAirportsUrl from '../assets/rules/ill-win-airports.webp';
import winGroupsUrl from '../assets/rules/ill-win-groups.webp';
import winLineUrl from '../assets/rules/ill-win-line.webp';
import winTrophyUrl from '../assets/rules/ill-win-trophy.webp';
import { formatMoney } from '../helpers/format';
import {
  FESTIVAL_MULTIPLIER,
  GO_SALARY,
  JAIL_FINE,
  JAIL_MAX_TURNS,
  LEVEL_NAMES,
  MAX_DOUBLES,
  MAX_HOUSES,
  MAX_ROUNDS,
  START_CASH,
  STATION_RENT,
  TAKEOVER_MULTIPLIER,
  TAX_RATE,
  TIME_LIMIT_MS,
  TURN_SECONDS,
  WIN_GROUPS,
} from '../logic/constants';
import { useTycoon } from '../store/useTycoon';
import { useDialogFocus } from './useDialogFocus';

type Tone = 'gold' | 'sky' | 'mint' | 'coral';

interface RuleCard {
  icon: string;
  tone: Tone;
  title: string;
  lines: string[];
  wide?: boolean;
}

interface RuleTab {
  id: string;
  label: string;
  cards: RuleCard[];
}

const money = (value: number) => formatMoney(value).replace(' ', ' ');
const AIRPORTS = STATION_RENT.length - 1;

const TABS: RuleTab[] = [
  {
    id: 'basic',
    label: 'Cơ bản',
    cards: [
      {
        icon: startCoinsUrl,
        tone: 'gold',
        title: 'Chuẩn bị',
        lines: [`Mỗi người có ${money(START_CASH)} để bắt đầu.`, '“tr” là tiền triệu trong ván, không phải KEN.'],
      },
      {
        icon: rollDiceUrl,
        tone: 'sky',
        title: 'Gieo & di chuyển',
        lines: ['Gieo 2 xúc xắc, đi theo tổng số.', `Qua hoặc đáp Xuất phát nhận ${money(GO_SALARY)}; đi thẳng vào tù thì không nhận.`],
      },
      {
        icon: doubleDiceUrl,
        tone: 'mint',
        title: 'Gieo đôi',
        lines: [
          'Gieo đôi được thêm lượt gieo.',
          `Đôi ${MAX_DOUBLES}\u00a0lần liên tiếp trong cùng lượt: vào tù ngay.`,
          'Gieo đôi để ra tù: xem tab Ô đặc biệt.',
        ],
      },
    ],
  },
  {
    id: 'assets',
    label: 'Tài sản',
    cards: [
      {
        icon: buyRentUrl,
        tone: 'gold',
        title: 'Mua & thuê đất',
        lines: [
          'Ô chưa có chủ: mua theo giá trên ô nếu đủ tiền.',
          'Đất người khác: trả tiền thuê, số thuê nằm trong viên tròn trên ô.',
          'Trọn nhóm màu: thuê đất trống ×2.',
          'Sân bay: thuê theo số sân bay sở hữu.',
        ],
      },
      {
        icon: takeoverUrl,
        tone: 'sky',
        title: 'Mua lại đất',
        lines: [
          `Trả thuê xong và không nợ: trả ×${TAKEOVER_MULTIPLIER} (giá đất + tiền nâng cấp) để mua lại thành phố đó.`,
          'Tiền trả cho chủ cũ, giữ nguyên cấp nhà; phải đủ tiền.',
          `Không mua lại sân bay hoặc ô đã lên ${LEVEL_NAMES[MAX_HOUSES]}.`,
        ],
      },
      {
        icon: upgradeUrl,
        tone: 'mint',
        title: 'Nâng cấp',
        lines: [
          'Cần đủ 2 thành phố cùng nhóm màu.',
          `${LEVEL_NAMES.slice(1).join(' → ')}, tối đa ${MAX_HOUSES} cấp; nâng đều trong lượt của mình.`,
          'Hạ cấp hoàn 50% giá nâng cấp, hạ đều giữa các ô cùng nhóm còn giữ.',
        ],
      },
      {
        icon: debtWarningUrl,
        tone: 'coral',
        title: 'Nợ & phá sản',
        lines: [
          'Thiếu tiền: hạ cấp nhà để trả nợ.',
          'Hạ hết vẫn không đủ: phá sản. Tài sản chuyển cho chủ nợ là người chơi; nợ ngân hàng thì đất về ngân hàng.',
        ],
      },
    ],
  },
  {
    id: 'special',
    label: 'Ô đặc biệt',
    cards: [
      {
        icon: festivalUrl,
        tone: 'gold',
        title: 'Lễ hội',
        lines: [
          `Chọn một thành phố của mình: tiền thuê ô đó ×${FESTIVAL_MULTIPLIER}.`,
          'Cả bàn chỉ có một Lễ hội; người sau tổ chức thì Lễ hội chuyển sang ô mới.',
        ],
      },
      {
        icon: travelUrl,
        tone: 'sky',
        title: 'Du lịch',
        lines: [
          'Lượt sau bay tới ô bất kỳ trừ ô đang đứng, hoặc gieo bình thường.',
          `Qua Xuất phát vẫn nhận ${money(GO_SALARY)}; ô đáp xử lý như thường.`,
        ],
      },
      {
        icon: taxCardsUrl,
        tone: 'mint',
        title: 'Thuế & thẻ bài',
        lines: [`Thuế: ${TAX_RATE * 100}% tổng tài sản.`, 'Cơ hội, Khí vận: rút thẻ và làm theo.'],
      },
      {
        icon: jailUrl,
        tone: 'coral',
        title: 'Nhà tù',
        lines: [
          `Vào tù do thẻ hoặc gieo đôi ${MAX_DOUBLES}\u00a0lần.`,
          `Ra tù: nộp ${money(JAIL_FINE)}, dùng thẻ ra tù hoặc gieo đôi.`,
          'Ra tù bằng đôi: đi theo số vừa gieo, không gieo tiếp.',
          `Lượt thứ ${JAIL_MAX_TURNS} chưa đôi: nộp ${money(JAIL_FINE)} rồi đi theo kết quả gieo.`,
        ],
      },
    ],
  },
  {
    id: 'ending',
    label: 'Kết thúc',
    cards: [
      {
        icon: finishClockUrl,
        tone: 'sky',
        title: 'Khi nào kết thúc?',
        lines: [
          'Nếu chưa ai thắng ngay:',
          `Còn 1 người, đủ ${MAX_ROUNDS} vòng hoặc hết ${TIME_LIMIT_MS / 60000} phút.`,
          'Điều kiện nào đến trước thì kết thúc.',
        ],
      },
      {
        icon: totalAssetsUrl,
        tone: 'sky',
        title: 'Cách xếp hạng',
        lines: ['Tổng tài sản = tiền mặt + giá đất + tiền nâng cấp.', 'Không tính theo KEN hay chỉ tiền mặt.'],
        wide: true,
      },
    ],
  },
];

const WIN_CONDITIONS: Array<[string, string]> = [
  [winGroupsUrl, `Trọn ${WIN_GROUPS} nhóm màu`],
  [winLineUrl, 'Toàn bộ thành phố trên một cạnh bàn'],
  [winAirportsUrl, `Cả ${AIRPORTS} sân bay`],
];

function Card({ card }: { card: RuleCard }) {
  return (
    <section className={card.wide ? 'ty-rules-card ty-rules-card-sky' : 'ty-rules-card'}>
      <span className={`ty-rules-art ty-rules-art-${card.tone}`}>
        <img src={card.icon} alt="" aria-hidden="true" draggable={false} />
      </span>
      <div className="ty-rules-copy">
        <h3>{card.title}</h3>
        {card.lines.map((line) => (
          <p key={line}>{line}</p>
        ))}
      </div>
    </section>
  );
}

function WinCard() {
  return (
    <section className="ty-rules-win">
      <div className="ty-rules-win-head">
        <img src={winTrophyUrl} alt="" aria-hidden="true" draggable={false} />
        <div className="ty-rules-copy">
          <h3>Thắng ngay</h3>
          <p>Chỉ cần đạt 1 trong 3 điều kiện:</p>
        </div>
      </div>
      <ul className="ty-rules-win-list">
        {WIN_CONDITIONS.map(([icon, label]) => (
          <li key={label}>
            <span className="ty-rules-win-art">
              <img src={icon} alt="" aria-hidden="true" draggable={false} />
            </span>
            <span>{label}</span>
          </li>
        ))}
      </ul>
    </section>
  );
}

export function RulesModal() {
  const setRulesOpen = useTycoon((s) => s.setRulesOpen);
  const [tabId, setTabId] = useState(TABS[0].id);
  const bodyRef = useRef<HTMLDivElement>(null);
  const baseId = useId();
  const titleId = `${baseId}-title`;
  const close = () => setRulesOpen(false);
  const modalRef = useDialogFocus<HTMLDivElement>({ onEscape: close });
  const tab = TABS.find((item) => item.id === tabId) ?? TABS[0];

  const select = (id: string) => {
    setTabId(id);
    bodyRef.current?.querySelector<HTMLElement>(`[data-panel="${id}"]`)?.scrollTo({ top: 0 });
  };

  const onTabKeyDown = (event: KeyboardEvent<HTMLDivElement>) => {
    const index = TABS.findIndex((item) => item.id === tab.id);
    const next =
      event.key === 'ArrowRight'
        ? (index + 1) % TABS.length
        : event.key === 'ArrowLeft'
          ? (index - 1 + TABS.length) % TABS.length
          : event.key === 'Home'
            ? 0
            : event.key === 'End'
              ? TABS.length - 1
              : -1;
    if (next < 0) return;
    event.preventDefault();
    select(TABS[next].id);
    event.currentTarget.querySelector<HTMLButtonElement>(`[data-tab="${TABS[next].id}"]`)?.focus();
  };

  return (
    <div className="ty-backdrop" onClick={close}>
      <div
        ref={modalRef}
        className="ty-modal ty-rules-modal"
        role="dialog"
        aria-modal="true"
        aria-labelledby={titleId}
        tabIndex={-1}
        onClick={(event) => event.stopPropagation()}
      >
        <div className="ty-rules-head">
          <img src={bookUrl} alt="" aria-hidden="true" draggable={false} />
          <h2 className="ty-modal-title" id={titleId}>
            Hướng dẫn chơi
          </h2>
          <button type="button" className="ty-rules-close" aria-label="Đóng" onClick={close}>
            <img src={closeUrl} alt="" aria-hidden="true" draggable={false} />
          </button>
        </div>

        <div className="ty-rules-tabs" role="tablist" aria-label="Nhóm luật" onKeyDown={onTabKeyDown}>
          {TABS.map((item) => {
            const selected = item.id === tab.id;
            return (
              <button
                key={item.id}
                type="button"
                role="tab"
                id={`${baseId}-tab-${item.id}`}
                data-tab={item.id}
                aria-selected={selected}
                aria-controls={`${baseId}-panel-${item.id}`}
                tabIndex={selected ? 0 : -1}
                data-dialog-initial-focus={item.id === TABS[0].id ? '' : undefined}
                className={selected ? 'ty-rules-tab ty-rules-tab-on' : 'ty-rules-tab'}
                onClick={() => select(item.id)}
              >
                {item.label}
              </button>
            );
          })}
        </div>

        <div ref={bodyRef} className="ty-rules-body">
          {TABS.map((item) => {
            const selected = item.id === tab.id;
            return (
              <div
                key={item.id}
                className={selected ? 'ty-rules-panel ty-rules-panel-on' : 'ty-rules-panel'}
                role="tabpanel"
                id={`${baseId}-panel-${item.id}`}
                data-panel={item.id}
                aria-labelledby={`${baseId}-tab-${item.id}`}
                tabIndex={selected ? 0 : -1}
                inert={!selected}
              >
                {item.id === 'ending' ? <WinCard /> : null}
                {item.cards.map((card) => (
                  <Card key={card.title} card={card} />
                ))}
                {item.id === 'basic' ? (
                  <p className="ty-rules-note">
                    <img src={actionTimerUrl} alt="" aria-hidden="true" draggable={false} />
                    <span>Mỗi hành động có {TURN_SECONDS}&nbsp;giây.</span>
                  </p>
                ) : null}
              </div>
            );
          })}
        </div>

        <div className="ty-rules-actions">
          <button type="button" className="ty-rules-done" onClick={close}>
            Đã hiểu
          </button>
        </div>
      </div>
    </div>
  );
}
