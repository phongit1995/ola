import { useId } from 'react';
import { GO_SALARY, JAIL_FINE, LEVEL_NAMES, MAX_HOUSES, MAX_ROUNDS, START_CASH, TURN_SECONDS } from '../logic/constants';
import { ModalHeading } from './ModalHeading';
import { TyIcon, type TyIconName } from './TyIcon';
import { useDialogFocus } from './useDialogFocus';
import { useTycoon } from '../store/useTycoon';

const RULES: Array<[TyIconName, string, string]> = [
  ['dice', 'Gieo xúc xắc', `Mỗi lượt gieo 2 xúc xắc và đi theo tổng. Gieo đôi được gieo tiếp; đôi 3 lần liên tiếp thì vào tù. Mỗi hành động có ${TURN_SECONDS} giây.`],
  ['deed', 'Mua đất', `Mỗi người bắt đầu với ${START_CASH} tr. Đáp vào ô thành phố chưa có chủ thì được mua theo giá ghi trên ô. Qua Xuất phát nhận ${GO_SALARY} tr.`],
  ['coins', 'Tiền thuê', 'Đáp vào đất của người khác thì trả tiền thuê (số trong viên tròn trên ô). Sở hữu trọn nhóm màu thì thuê đất trống gấp đôi. Bến tính theo số bến sở hữu, tiện ích tính theo xúc xắc.'],
  ['house', 'Nâng cấp', `Sở hữu trọn nhóm màu (2 thành phố) mới được nâng cấp, tối đa ${MAX_HOUSES} cấp: ${LEVEL_NAMES.slice(1).join(' → ')}. Phải nâng đều giữa các ô. Hạ cấp được hoàn nửa giá.`],
  ['jail-bars', 'Nhà tù', `Vào tù thì mỗi lượt được gieo: ra đôi thì ra tù. Có thể nộp ${JAIL_FINE} tr hoặc dùng thẻ ra tù. Đến lượt thứ 3 bắt buộc nộp phạt.`],
  ['warning', 'Nợ và phá sản', 'Không đủ tiền trả thì phải hạ cấp nhà. Hạ hết vẫn không đủ là phá sản: tài sản chuyển cho chủ nợ hoặc về ngân hàng.'],
  ['flag', 'Kết thúc', `Ván kết thúc khi chỉ còn một người hoặc hết ${MAX_ROUNDS} vòng. Xếp hạng theo tổng tài sản: tiền mặt + giá đất + tiền nâng cấp.`],
];

export function RulesModal() {
  const setRulesOpen = useTycoon((s) => s.setRulesOpen);
  const titleId = useId();
  const close = () => setRulesOpen(false);
  const modalRef = useDialogFocus<HTMLDivElement>({ onEscape: close });
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
        <ModalHeading eyebrow="Cách chơi" title="Luật Cờ Tỷ Phú" icon="deed" titleId={titleId} />
        <div className="ty-rules-list">
          {RULES.map(([icon, title, body]) => (
            <section key={title} className="ty-rules-item">
              <span className="ty-rules-icon">
                <TyIcon name={icon} size={18} />
              </span>
              <div>
                <h3>{title}</h3>
                <p>{body}</p>
              </div>
            </section>
          ))}
        </div>
        <div className="ty-modal-actions">
          <button type="button" className="ty-btn ty-btn-gold" onClick={close} data-dialog-initial-focus>
            Đã hiểu
          </button>
        </div>
      </div>
    </div>
  );
}
