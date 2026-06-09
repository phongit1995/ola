package chat.ola.vn.transferken;

import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.EditText;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.q;
import chat.ola.vn.b.q.a;
import chat.ola.vn.c.x;
import chat.ola.vn.entity.ag;
import chat.ola.vn.g;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.p.d;
import chat.ola.vn.util.j;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import chat.ola.vn.view.OlaQuickTypingSuggestedText;

/* JADX INFO: loaded from: classes.dex */
public class b extends a implements View.OnClickListener {
    private TextView a;
    private OlaQuickTypingSuggestedText b;
    private EditText c;
    private Animation d;

    private boolean v() {
        try {
            String string = this.b.getText().toString();
            String string2 = this.c.getText().toString();
            if (m.a(string2)) {
                return false;
            }
            String strReplace = string2.replace(",", "");
            if (m.b(string, h.a())) {
                j.a(e(), R.string.message_cannot_transfer_ken_to_you);
                return false;
            }
            if (m.a(strReplace)) {
                this.c.startAnimation(this.d);
                return false;
            }
            long j = Long.parseLong(strReplace);
            if (j < 1000) {
                j.b(e(), getString(R.string.message_tradding_min_ken_value_format, m.a(1000L)));
                return false;
            }
            if (j > 100000000) {
                j.b(e(), getString(R.string.message_max_vip_price_tradding_format, m.a(100000000L)));
                return false;
            }
            if (!m.a(string)) {
                return true;
            }
            this.b.startAnimation(this.d);
            return false;
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
    }

    @Override // chat.ola.vn.transferken.a
    public a c() {
        try {
            return (c) Fragment.instantiate(getActivity(), c.class.getName());
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.m.f
    public String e_() {
        return OlaApplication.a(R.string.string_enter_ken_transaction_info);
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        int id = view.getId();
        if (id != R.id.nextStepButton) {
            if (id != R.id.olaActionBarBackViewLayout) {
                return;
            }
            j();
        } else if (v()) {
            o.a((Context) e(), (View) this.c, false);
            String string = this.b.getText().toString();
            c.b = Long.parseLong(this.c.getText().toString().replace(",", ""));
            String strJ = m.j(string);
            e().c(true);
            OlaApplication.b.a(strJ, new d() { // from class: chat.ola.vn.transferken.b.3
                @Override // chat.ola.vn.p.d
                public void a(int i) {
                    b.this.e().c(false);
                    i.a(b.this.getActivity(), R.string.dialog_title_fail, R.string.string_buddy_is_not_exist);
                }

                @Override // chat.ola.vn.p.d
                public void a(ag agVar) {
                    c.c = agVar;
                    b.this.e().c(false);
                    b.this.e().B();
                }
            });
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.ola_transfer_ken_step1_fragment_layout, (ViewGroup) null);
        this.b = (OlaQuickTypingSuggestedText) viewInflate.findViewById(R.id.txtKenReceiver);
        this.c = (EditText) viewInflate.findViewById(R.id.txtKenValue);
        this.b.setAllowedSuggestion(x.r);
        q qVar = new q(e());
        qVar.a(g.a());
        qVar.getClass();
        qVar.a(qVar.new a());
        this.b.setAdapter(qVar);
        this.b.setOnSuggestionSelectListener(new OlaQuickTypingSuggestedText.b() { // from class: chat.ola.vn.transferken.b.1
            @Override // chat.ola.vn.view.OlaQuickTypingSuggestedText.b
            public void b_(String str) {
                try {
                    b.this.b.setText(str);
                    b.this.b.setSelection(str.length());
                } catch (Throwable unused) {
                }
            }
        });
        if (h() != null) {
            String stringExtra = h().getStringExtra("_buddy_id");
            if (!m.a(stringExtra)) {
                this.b.setText(stringExtra);
                this.b.setEnabled(false);
                this.c.requestFocus();
            }
        }
        this.d = AnimationUtils.loadAnimation(e(), R.anim.shake);
        this.a = (TextView) viewInflate.findViewById(R.id.txtKenAvaliable);
        this.c.setOnFocusChangeListener(new View.OnFocusChangeListener() { // from class: chat.ola.vn.transferken.b.2
            @Override // android.view.View.OnFocusChangeListener
            public void onFocusChange(View view, boolean z) {
                try {
                    if (z) {
                        b.this.c.setText(b.this.c.getText().toString().replace(",", ""));
                    } else {
                        b.this.c.setText(m.a(Long.valueOf(b.this.c.getText().toString().replace(",", "")).longValue()));
                    }
                } catch (Throwable unused) {
                }
            }
        });
        viewInflate.findViewById(R.id.nextStepButton).setOnClickListener(this);
        if (OlaApplication.b != null) {
            OlaApplication.b.r();
        }
        if (h.o != 0) {
            this.a.setText(m.a(h.o) + " KEN");
        }
        return viewInflate;
    }
}
