package chat.ola.vn.tradingvip;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.entity.ag;
import chat.ola.vn.entry.c.e;
import chat.ola.vn.entry.c.f;
import chat.ola.vn.h;
import chat.ola.vn.message.s;
import chat.ola.vn.view.OlaCachedImageView;

/* JADX INFO: loaded from: classes.dex */
public class d extends a implements View.OnClickListener {
    public static long a;
    public static int b;
    public static ag c;
    private TextView d;
    private TextView e;
    private TextView f;
    private TextView g;
    private TextView h;
    private OlaCachedImageView i;
    private ImageView j;

    /* JADX WARN: Code restructure failed: missing block: B:21:0x00cf, code lost:
    
        if (chat.ola.vn.util.m.a(chat.ola.vn.tradingvip.d.c.k) != false) goto L25;
     */
    /* JADX WARN: Code restructure failed: missing block: B:24:0x00da, code lost:
    
        if (chat.ola.vn.util.m.a(chat.ola.vn.tradingvip.d.c.k) != false) goto L25;
     */
    /* JADX WARN: Code restructure failed: missing block: B:25:0x00dc, code lost:
    
        r5.e.setVisibility(8);
     */
    /* JADX WARN: Code restructure failed: missing block: B:26:0x00e2, code lost:
    
        r5.e.setText(chat.ola.vn.tradingvip.d.c.k);
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void v() {
        /*
            Method dump skipped, instruction units count: 254
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.tradingvip.d.v():void");
    }

    private void x() {
        try {
            OlaApplication.b.a(c.c, OlaTraddingVipActivity.e.e(), b, a, f.a(new e() { // from class: chat.ola.vn.tradingvip.d.1
                @Override // chat.ola.vn.entry.c.e
                public short a() {
                    return (short) 74;
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(Object... objArr) {
                }
            }));
            try {
                chat.ola.vn.message.f fVarD = h.t.d(c.c, (short) 0);
                if (fVarD == null) {
                    fVarD = h.t.b(c.c, (short) 0, true);
                }
                if (fVarD != null) {
                    s sVarA = chat.ola.vn.message.e.a(c.c, a, b, OlaTraddingVipActivity.e);
                    sVarA.a((byte) 2);
                    fVarD.a((chat.ola.vn.message.d) sVarA, true);
                    fVarD.K = Long.valueOf(System.currentTimeMillis());
                }
            } catch (Throwable unused) {
            }
            e().finish();
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
    }

    @Override // chat.ola.vn.tradingvip.a
    public a c() {
        return null;
    }

    @Override // chat.ola.vn.m.f
    public String e_() {
        return OlaApplication.a(R.string.string_confirm);
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        int id = view.getId();
        if (id != R.id.editButton) {
            if (id == R.id.okButton) {
                x();
                return;
            } else if (id != R.id.olaActionBarBackViewLayout) {
                return;
            }
        }
        e().C();
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.ola_tradding_vip_step3_fragment_layout, (ViewGroup) null);
        this.d = (TextView) viewInflate.findViewById(R.id.receiverNickTextView);
        this.e = (TextView) viewInflate.findViewById(R.id.receiverFullnameTextView);
        this.f = (TextView) viewInflate.findViewById(R.id.kenAmountTextView);
        this.g = (TextView) viewInflate.findViewById(R.id.vipDurationTextView);
        this.h = (TextView) viewInflate.findViewById(R.id.vipTitleTextView);
        this.i = (OlaCachedImageView) viewInflate.findViewById(R.id.receiverProfileImageView);
        this.j = (ImageView) viewInflate.findViewById(R.id.vipIconImageView);
        viewInflate.findViewById(R.id.okButton).setOnClickListener(this);
        viewInflate.findViewById(R.id.editButton).setOnClickListener(this);
        return viewInflate;
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onResume() {
        super.onResume();
        v();
    }
}
