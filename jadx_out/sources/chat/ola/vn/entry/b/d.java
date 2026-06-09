package chat.ola.vn.entry.b;

import android.content.Context;
import android.content.DialogInterface;
import android.view.View;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaChatViewActivity;
import chat.ola.vn.me.OlaUserMePageActivity;
import chat.ola.vn.view.OlaCachedImageView;
import chat.ola.vn.view.OlaRatioImageView;
import com.mg.ola.common.widget.OlaTextView;
import it.sephiroth.android.library.widget.HListView;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public class d extends b implements View.OnClickListener {
    protected OlaRatioImageView f;
    protected OlaCachedImageView g;
    protected ImageView h;
    protected ImageView i;
    protected ImageView j;
    protected TextView k;
    protected TextView l;
    protected TextView m;
    protected TextView n;
    protected TextView o;
    protected View p;
    protected View q;
    protected OlaTextView r;
    protected chat.ola.vn.message.v s;
    protected HListView t;
    private chat.ola.vn.b.s u;

    private class a extends chat.ola.vn.entity.n {
        String a;
        short b;

        public a(String str, short s) {
            this.a = str;
            this.b = s;
        }

        @Override // chat.ola.vn.entity.n
        public boolean a(Context context) {
            d.b(context, this.a, this.b);
            return true;
        }
    }

    public d(View view) {
        super(view);
        this.s = null;
        this.f = (OlaRatioImageView) view.findViewById(R.id.coverImageView);
        this.f.setRatio(2.6666666666666665d);
        this.g = (OlaCachedImageView) view.findViewById(R.id.imgMeAvatarThumbnail);
        this.t = (HListView) view.findViewById(R.id.attachedPhotoListView);
        this.u = new chat.ola.vn.b.s(view.getContext());
        this.u.a(false);
        this.t.setAdapter((ListAdapter) this.u);
        this.h = (ImageView) view.findViewById(R.id.vipIconImageView);
        this.i = (ImageView) view.findViewById(R.id.imgDeviceType);
        this.j = (ImageView) view.findViewById(R.id.verificationImageView);
        this.k = (TextView) view.findViewById(R.id.vipTitleTextView);
        this.l = (TextView) view.findViewById(R.id.ageTextView);
        this.m = (TextView) view.findViewById(R.id.joinOlaTextView);
        this.n = (TextView) view.findViewById(R.id.fanTextView);
        this.o = (TextView) view.findViewById(R.id.antiFanTextView);
        this.r = (OlaTextView) view.findViewById(R.id.statusMessageTextView);
        this.r.setOlaSpanClickListener(chat.ola.vn.q.a.a());
        this.p = view.findViewById(R.id.addFriendCommandViewLayout);
        this.q = view.findViewById(R.id.unblockViewLayout);
        view.findViewById(R.id.addFriendButton).setOnClickListener(this);
        TextView textView = (TextView) view.findViewById(R.id.blockTextView);
        textView.setText(OlaApplication.a(R.string.string_block).toUpperCase(Locale.US));
        textView.setOnClickListener(this);
        TextView textView2 = (TextView) view.findViewById(R.id.closeTextView);
        textView2.setText(OlaApplication.a(R.string.string_close).toUpperCase(Locale.US));
        textView2.setOnClickListener(this);
        view.findViewById(R.id.unblockButton).setOnClickListener(this);
        this.f.setOnClickListener(this);
        this.g.setOnClickListener(this);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void b(Context context, String str, short s) {
        try {
            OlaChatViewActivity.a(context, OlaApplication.b, str, s);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void c() {
        try {
            if (!this.s.f().F.booleanValue()) {
                d();
            } else {
                this.q.setVisibility(0);
                this.p.setVisibility(8);
            }
        } catch (Throwable unused) {
            d();
        }
    }

    private void d() {
        try {
            this.q.setVisibility(8);
            if (chat.ola.vn.h.t.d(this.s.i()) == null) {
                this.p.setVisibility(0);
            } else {
                this.p.setVisibility(8);
            }
        } catch (Throwable unused) {
            this.p.setVisibility(8);
        }
    }

    private void e() {
        try {
            if (chat.ola.vn.util.m.a(this.s.i())) {
                return;
            }
            chat.ola.vn.c.t.a().b(this.s.i(), (OlaCachedImageView) this.f, false);
            chat.ola.vn.c.t.a().b(this.s.i(), true, this.g);
        } catch (Throwable unused) {
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:13:0x0060  */
    @Override // chat.ola.vn.entry.b.b
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void a(chat.ola.vn.message.d r10, chat.ola.vn.message.d r11, chat.ola.vn.message.d r12) {
        /*
            Method dump skipped, instruction units count: 642
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.entry.b.d.a(chat.ola.vn.message.d, chat.ola.vn.message.d, chat.ola.vn.message.d):void");
    }

    protected void a(String str) {
        if (this.r == null) {
            return;
        }
        if (chat.ola.vn.util.m.a(str)) {
            this.r.setVisibility(8);
            return;
        }
        this.r.setVisibility(0);
        this.r.setText(chat.ola.vn.util.i.a(this.r, chat.ola.vn.q.a.a(), str));
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            switch (view.getId()) {
                case R.id.addFriendButton /* 2131296305 */:
                    if (OlaApplication.b == null) {
                        return;
                    }
                    chat.ola.vn.message.f fVarF = this.s.f();
                    if (chat.ola.vn.h.t.d(this.s.i()) == null) {
                        OlaApplication.b.a(fVarF);
                    }
                    break;
                    break;
                case R.id.blockTextView /* 2131296399 */:
                    final chat.ola.vn.c cVarC = chat.ola.vn.c.c();
                    chat.ola.vn.i.i.d(cVarC, OlaApplication.a(R.string.message_block_chat_title), OlaApplication.a(R.string.message_block_chat_confirm_format, this.s.i()), OlaApplication.a(R.string.string_block), OlaApplication.a(R.string.string_cancel), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.entry.b.d.1
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i) {
                            dialogInterface.dismiss();
                            if (i != 0 || OlaApplication.b == null) {
                                return;
                            }
                            OlaApplication.b.l(d.this.s.i());
                            chat.ola.vn.h.t.a(d.this.s.i(), (short) 0);
                            cVarC.finish();
                        }
                    });
                    return;
                case R.id.closeTextView /* 2131296636 */:
                    chat.ola.vn.c cVarC2 = chat.ola.vn.c.c();
                    if (OlaApplication.b != null) {
                        chat.ola.vn.h.t.a(this.s.i(), (short) 0);
                        cVarC2.finish();
                        return;
                    }
                    return;
                case R.id.coverImageView /* 2131296724 */:
                    String strI = ((chat.ola.vn.message.v) view.getTag()).i();
                    chat.ola.vn.me.c.a(chat.ola.vn.c.c(), OlaApplication.b, strI, new a(strI, (short) 0));
                    return;
                case R.id.imgMeAvatarThumbnail /* 2131296910 */:
                    String strI2 = ((chat.ola.vn.message.v) view.getTag()).i();
                    chat.ola.vn.c cVarC3 = chat.ola.vn.c.c();
                    if (cVarC3 == null || chat.ola.vn.util.m.a(strI2)) {
                        return;
                    }
                    OlaUserMePageActivity.a(cVarC3, strI2);
                    return;
                case R.id.unblockButton /* 2131297718 */:
                    if (OlaApplication.b == null) {
                        return;
                    }
                    this.s.f().F = Boolean.FALSE;
                    OlaApplication.b.n(this.s.i());
                    break;
                default:
                    return;
            }
            c();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
