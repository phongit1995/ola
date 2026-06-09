package chat.ola.vn.m;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.activity.BuyVipActivity;
import chat.ola.vn.activity.OlaPhoneVerificationActivity;
import com.facebook.appevents.AppEventsConstants;

/* JADX INFO: loaded from: classes.dex */
public abstract class c extends p<j> {
    protected TextView a;
    protected chat.ola.vn.entity.t b;
    private View d;
    private Button e;
    private TextView f;
    private TextView g;

    protected View a(LayoutInflater layoutInflater) {
        try {
            View viewInflate = layoutInflater.inflate(R.layout.news_title_header_layout, (ViewGroup) null);
            this.a = (TextView) viewInflate.findViewById(R.id.newsTitleTextView);
            this.d = viewInflate.findViewById(R.id.warningLayout);
            this.e = (Button) viewInflate.findViewById(R.id.warningButton);
            this.f = (TextView) viewInflate.findViewById(R.id.warningLine1TextView);
            this.g = (TextView) viewInflate.findViewById(R.id.warningLine2TextView);
            return viewInflate;
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(chat.ola.vn.entity.t tVar) {
        this.b = tVar;
    }

    public void c() {
    }

    public void d() {
    }

    @Override // chat.ola.vn.m.f
    public void d_() {
    }

    public void e() {
        String strE_ = e_();
        if (chat.ola.vn.util.m.a(strE_)) {
            this.a.setVisibility(8);
        } else {
            this.a.setText(strE_);
            this.a.setVisibility(0);
        }
        try {
            try {
                this.d.setVisibility(8);
                if (chat.ola.vn.h.O.u == 0) {
                    this.d.setVisibility(0);
                    this.d.setTag(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                    this.e.setText(R.string.string_buy_vip);
                    this.f.setText(R.string.message_register_vip_account);
                    this.g.setText(R.string.message_register_vip_explaination);
                } else if (chat.ola.vn.h.O.q > 0 && chat.ola.vn.h.O.q < 3) {
                    this.d.setVisibility(0);
                    this.d.setTag("1");
                    this.e.setText(R.string.string_extend_vip);
                    this.f.setText(R.string.message_extend_vip_account);
                    this.g.setText(R.string.message_extend_vip_explaination);
                } else if (!chat.ola.vn.h.O.x) {
                    this.d.setVisibility(0);
                    this.d.setTag("2");
                    this.e.setText(R.string.string_verify);
                    this.f.setText(R.string.message_phone_number_not_validate);
                    this.g.setText(R.string.message_warning_need_verify_phone_to_protect_your_account);
                }
                this.d.setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.m.c.1
                    @Override // android.view.View.OnClickListener
                    public void onClick(View view) {
                        try {
                            String str = (String) view.getTag();
                            if (chat.ola.vn.util.m.c(str, AppEventsConstants.EVENT_PARAM_VALUE_NO)) {
                                BuyVipActivity.a(chat.ola.vn.c.c());
                            } else if (chat.ola.vn.util.m.c(str, "1")) {
                                BuyVipActivity.b(chat.ola.vn.c.c());
                            } else if (chat.ola.vn.util.m.c(str, "2")) {
                                OlaPhoneVerificationActivity.a(chat.ola.vn.c.c());
                            }
                        } catch (Throwable unused) {
                        }
                    }
                });
            } catch (Throwable unused) {
                this.d.setVisibility(8);
            }
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.m.f
    public String e_() {
        return this.b != null ? this.b.p() : "";
    }

    @Override // chat.ola.vn.m.p
    /* JADX INFO: renamed from: f, reason: merged with bridge method [inline-methods] */
    public j g() {
        return super.g() == null ? j.c() : (j) super.g();
    }
}
