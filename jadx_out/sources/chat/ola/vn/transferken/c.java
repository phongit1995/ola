package chat.ola.vn.transferken;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.EditText;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.entity.ag;
import chat.ola.vn.view.OlaCachedImageView;

/* JADX INFO: loaded from: classes.dex */
public class c extends a implements View.OnClickListener {
    public static long a;
    public static long b;
    public static ag c;
    private Animation d;
    private EditText e;
    private View f;
    private TextView g;
    private TextView h;
    private TextView i;
    private OlaCachedImageView j;

    /* JADX WARN: Code restructure failed: missing block: B:19:0x009a, code lost:
    
        if (chat.ola.vn.util.m.a(chat.ola.vn.transferken.c.c.k) != false) goto L23;
     */
    /* JADX WARN: Code restructure failed: missing block: B:22:0x00a5, code lost:
    
        if (chat.ola.vn.util.m.a(chat.ola.vn.transferken.c.c.k) != false) goto L23;
     */
    /* JADX WARN: Code restructure failed: missing block: B:23:0x00a7, code lost:
    
        r9.h.setVisibility(8);
     */
    /* JADX WARN: Code restructure failed: missing block: B:24:0x00ad, code lost:
    
        r9.h.setText(chat.ola.vn.transferken.c.c.k);
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void v() {
        /*
            Method dump skipped, instruction units count: 201
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.transferken.c.v():void");
    }

    private void x() {
        try {
            String string = this.e.getText().toString();
            if (OlaApplication.b != null) {
                e().c(true);
                OlaApplication.b.a(c.c, string, b, (short) 0);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
    }

    @Override // chat.ola.vn.transferken.a
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
        if (id == R.id.editButton || id == R.id.olaActionBarBackViewLayout) {
            e().C();
        } else {
            if (id != R.id.transferButton) {
                return;
            }
            x();
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.ola_transfer_ken_step2_fragment_layout, (ViewGroup) null);
        this.e = (EditText) viewInflate.findViewById(R.id.transferKenPasswordEditText);
        this.f = viewInflate.findViewById(R.id.txtTransferPasswordViewLayout);
        this.g = (TextView) viewInflate.findViewById(R.id.receiverNickTextView);
        this.h = (TextView) viewInflate.findViewById(R.id.receiverFullnameTextView);
        this.i = (TextView) viewInflate.findViewById(R.id.kenAmountTextView);
        this.j = (OlaCachedImageView) viewInflate.findViewById(R.id.receiverProfileImageView);
        viewInflate.findViewById(R.id.transferButton).setOnClickListener(this);
        viewInflate.findViewById(R.id.editButton).setOnClickListener(this);
        this.d = AnimationUtils.loadAnimation(e(), R.anim.shake);
        return viewInflate;
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onResume() {
        super.onResume();
        v();
    }
}
