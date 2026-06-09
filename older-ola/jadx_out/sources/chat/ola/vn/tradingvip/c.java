package chat.ola.vn.tradingvip;

import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.View;
import android.view.animation.Animation;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.entity.ag;
import chat.ola.vn.i.i;
import chat.ola.vn.j;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import chat.ola.vn.view.OlaQuickTypingSuggestedText;

/* JADX INFO: loaded from: classes.dex */
public class c extends a implements View.OnClickListener {
    private Animation a;
    private OlaQuickTypingSuggestedText b;
    private EditText c;
    private EditText d;
    private TextView e;
    private ImageView f;

    private void v() {
        if (OlaTraddingVipActivity.e != null) {
            this.f.setImageBitmap(j.a().a(OlaTraddingVipActivity.e.b()));
            this.e.setText(OlaTraddingVipActivity.e.d());
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void x() {
        try {
            if (y()) {
                long j = 0;
                int i = 0;
                String string = this.b.getText().toString();
                try {
                    j = Long.parseLong(this.c.getText().toString().replace(",", ""));
                } catch (Throwable unused) {
                }
                try {
                    i = Integer.parseInt(this.d.getText().toString());
                } catch (Throwable unused2) {
                }
                d.a = j;
                d.b = i;
                String strJ = m.j(string);
                e().c(true);
                OlaApplication.b.a(strJ, new chat.ola.vn.p.d() { // from class: chat.ola.vn.tradingvip.c.5
                    @Override // chat.ola.vn.p.d
                    public void a(int i2) {
                        c.this.e().c(false);
                        i.a(c.this.getActivity(), R.string.dialog_title_fail, R.string.string_buddy_is_not_exist);
                    }

                    @Override // chat.ola.vn.p.d
                    public void a(ag agVar) {
                        d.c = agVar;
                        c.this.e().c(false);
                        c.this.e().B();
                    }
                });
            }
        } catch (Throwable unused3) {
        }
    }

    private boolean y() {
        try {
            String string = this.b.getText().toString();
            if (m.a(string)) {
                this.b.startAnimation(this.a);
                return false;
            }
            if (!m.a(string)) {
                return true;
            }
            this.b.startAnimation(this.a);
            return false;
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
    }

    @Override // chat.ola.vn.tradingvip.a
    public a c() {
        try {
            return (d) Fragment.instantiate(getActivity(), d.class.getName());
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.m.f
    public String e_() {
        return OlaApplication.a(R.string.string_transaction_info);
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            o.a((Context) getActivity(), this.b.isFocused() ? this.b : this.c, false);
        } catch (Throwable unused) {
        }
        int id = view.getId();
        if (id != R.id.editButton) {
            if (id == R.id.nextStepButton) {
                x();
                return;
            } else if (id != R.id.olaActionBarBackViewLayout) {
                return;
            }
        }
        e().C();
    }

    /* JADX WARN: Removed duplicated region for block: B:7:0x009f  */
    @Override // android.support.v4.app.Fragment
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public android.view.View onCreateView(android.view.LayoutInflater r1, android.view.ViewGroup r2, android.os.Bundle r3) {
        /*
            Method dump skipped, instruction units count: 220
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.tradingvip.c.onCreateView(android.view.LayoutInflater, android.view.ViewGroup, android.os.Bundle):android.view.View");
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onResume() {
        super.onResume();
        v();
    }
}
