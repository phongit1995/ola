package chat.ola.vn.entry.b;

import android.annotation.SuppressLint;
import android.view.View;
import android.view.ViewStub;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.LinearLayout;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;
import com.facebook.appevents.AppEventsConstants;
import com.mg.ola.common.widget.OlaTextView;
import java.util.Calendar;

/* JADX INFO: loaded from: classes.dex */
public class f extends b {
    public static f s;
    protected OlaCachedImageView f;
    protected OlaCachedImageView g;
    protected TextView h;
    protected OlaTextView i;
    protected View j;
    protected View k;
    protected View l;
    protected View m;
    protected TextView n;
    protected LinearLayout o;
    protected View p;
    protected ViewStub q;
    protected TextView r;
    private chat.ola.vn.message.d t;
    private boolean u;
    private boolean v;
    private Animation w;

    public f(View view) {
        super(view);
        this.t = null;
        this.u = false;
        this.v = false;
        this.o = (LinearLayout) view.findViewById(R.id.chatMessageBubbleView);
        this.q = (ViewStub) view.findViewById(R.id.chatAttachmentViewStub);
        this.k = view.findViewById(R.id.chatMessageTextContentView);
        this.k.setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.entry.b.f.1
            @Override // android.view.View.OnClickListener
            public void onClick(View view2) {
                if (view2.getId() != R.id.chatMessageTextContentView) {
                    return;
                }
                if (f.s != null && f.s != f.this) {
                    f.s.c();
                }
                f.s = f.this;
                f.this.d();
            }
        });
        this.p = view.findViewById(R.id.messageSeparatorView);
        this.r = (TextView) view.findViewById(R.id.messageSenderTextview);
        this.f = (OlaCachedImageView) view.findViewById(R.id.senderAvatarImageView);
        this.g = (OlaCachedImageView) view.findViewById(R.id.readPeopleImageView);
        this.j = view.findViewById(R.id.resendImageView);
        if (this.j != null) {
            this.j.setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.entry.b.f.2
                @Override // android.view.View.OnClickListener
                public void onClick(View view2) {
                    try {
                        f.this.t.z().run();
                    } catch (Throwable unused) {
                    }
                }
            });
        }
        this.l = view.findViewById(R.id.sendingProgressBar);
        this.n = (TextView) view.findViewById(R.id.failReasonTextView);
        this.i = (OlaTextView) view.findViewById(R.id.messageTextContentTextview);
        this.i.setOlaSpanClickListener(chat.ola.vn.q.a.a());
        if (this.f != null) {
            this.f.setOnClickListener(chat.ola.vn.q.a.a());
        }
        if (this.r != null) {
            this.r.setOnClickListener(chat.ola.vn.q.a.a());
        }
        this.h = (TextView) view.findViewById(R.id.chatMessageTimeTextView);
        this.m = view.findViewById(R.id.bookmarkImageButton);
        try {
            this.w = AnimationUtils.loadAnimation(view.getContext(), R.anim.fade_in);
            this.w.setDuration(300L);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void a(boolean z) {
        if (this.u) {
            this.h.setVisibility(z ? 0 : 8);
        } else if (this.u) {
            this.h.setVisibility(8);
        } else {
            this.h.setVisibility(0);
        }
        if (this.r != null) {
            if (this.u || chat.ola.vn.util.m.a(this.r.getText().toString())) {
                this.r.setVisibility(8);
            } else {
                this.r.setVisibility(0);
            }
        }
        if (this.t.d() != 1) {
            if (this.f != null) {
                this.f.setVisibility(8);
            }
        } else if (this.u) {
            if (this.f != null) {
                this.f.setVisibility(4);
            }
        } else if (this.f != null) {
            this.f.setVisibility(0);
        }
        if (this.t.d() == 2) {
            if (!this.v) {
                switch (this.t.q()) {
                    case 1:
                    case 2:
                    case 3:
                        if (this.g.getVisibility() != 0) {
                            this.g.setVisibility(0);
                            try {
                                this.w.cancel();
                                this.g.startAnimation(this.w);
                                return;
                            } catch (Throwable unused) {
                                return;
                            }
                        }
                        return;
                    default:
                        if (this.g.getVisibility() == 8) {
                            return;
                        }
                        break;
                }
            } else if (this.g.getVisibility() == 8) {
                return;
            }
        } else if (this.t.d() == 1) {
            if (this.g.getVisibility() == 8) {
                return;
            }
        } else if (this.g.getVisibility() == 8) {
            return;
        }
        this.g.setVisibility(8);
    }

    private void g() {
        OlaCachedImageView olaCachedImageView;
        byte bQ = this.t.q();
        int i = R.drawable.ic_checked;
        switch (bQ) {
            case 1:
                olaCachedImageView = this.g;
                i = R.drawable.ic_message_sent;
                olaCachedImageView.setImageResource(i);
                break;
            case 3:
                String strA = this.t.a(0);
                if (!chat.ola.vn.util.m.a(strA)) {
                    a(strA, this.g);
                    break;
                }
            case 2:
                olaCachedImageView = this.g;
                olaCachedImageView.setImageResource(i);
                break;
            default:
                this.g.a(null, null);
                break;
        }
        try {
            if (this.t.d() != 2) {
                if (this.l != null) {
                    this.l.setVisibility(8);
                }
                if (this.j != null) {
                    this.j.setVisibility(8);
                }
                if (this.n == null) {
                    return;
                }
            } else if (this.t.q() == 4) {
                if (this.l != null) {
                    this.l.setVisibility(0);
                }
                if (this.j != null) {
                    this.j.setVisibility(8);
                }
                if (this.n == null) {
                    return;
                }
            } else {
                if (this.t.q() == 5) {
                    if (this.l != null) {
                        this.l.setVisibility(8);
                    }
                    if (this.j != null) {
                        this.j.setVisibility(0);
                    }
                    if (this.n != null) {
                        if (chat.ola.vn.util.m.a(this.t.A())) {
                            this.n.setText(R.string.message_fail_send_message);
                        } else {
                            this.n.setText(this.t.A());
                        }
                        this.n.setVisibility(0);
                        return;
                    }
                    return;
                }
                if (this.l != null) {
                    this.l.setVisibility(8);
                }
                if (this.j != null) {
                    this.j.setVisibility(8);
                }
                if (this.n == null) {
                    return;
                }
            }
            this.n.setVisibility(8);
        } catch (Throwable unused) {
        }
    }

    private void h() {
        try {
            this.h.setText("");
            Calendar calendar = Calendar.getInstance();
            calendar.setTimeInMillis(this.t.m());
            int i = calendar.get(11);
            int i2 = calendar.get(12);
            String str = "" + i;
            String str2 = "" + i2;
            if (i < 10) {
                str = AppEventsConstants.EVENT_PARAM_VALUE_NO + i;
            }
            if (i2 < 10) {
                str2 = AppEventsConstants.EVENT_PARAM_VALUE_NO + i2;
            }
            this.h.setText(str + ":" + str2);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entry.b.b
    @SuppressLint({"NewApi"})
    public void a() {
        this.t = null;
        this.u = false;
        this.v = false;
    }

    /* JADX WARN: Removed duplicated region for block: B:19:0x0037  */
    /* JADX WARN: Removed duplicated region for block: B:20:0x003d  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    protected void a(chat.ola.vn.message.d r5) {
        /*
            r4 = this;
            com.mg.ola.common.widget.OlaTextView r0 = r4.i
            if (r0 != 0) goto L5
            return
        L5:
            byte r0 = r5.d()
            r1 = 1
            r2 = 4
            r3 = 0
            if (r0 != r1) goto L43
            boolean r0 = r5.w
            if (r0 == 0) goto L1a
            com.mg.ola.common.widget.OlaTextView r0 = r4.i
            int r1 = chat.ola.vn.f.A
        L16:
            r0.setTextColor(r1)
            goto L1f
        L1a:
            com.mg.ola.common.widget.OlaTextView r0 = r4.i
            int r1 = chat.ola.vn.f.y
            goto L16
        L1f:
            android.view.View r0 = r4.m
            if (r0 == 0) goto L6d
            android.view.View r0 = r4.m
            r0.setTag(r5)
            android.view.View r0 = r4.m
            if (r0 == 0) goto L33
            android.view.View r0 = r4.m
            android.view.View$OnClickListener r1 = r4.a
            r0.setOnClickListener(r1)
        L33:
            boolean r0 = r5.x
            if (r0 == 0) goto L3d
        L37:
            android.view.View r0 = r4.m
            r0.setVisibility(r3)
            goto L6d
        L3d:
            android.view.View r0 = r4.m
            r0.setVisibility(r2)
            goto L6d
        L43:
            boolean r0 = r5.w
            if (r0 == 0) goto L4f
            com.mg.ola.common.widget.OlaTextView r0 = r4.i
            int r1 = chat.ola.vn.f.E
        L4b:
            r0.setTextColor(r1)
            goto L54
        L4f:
            com.mg.ola.common.widget.OlaTextView r0 = r4.i
            int r1 = chat.ola.vn.f.C
            goto L4b
        L54:
            android.view.View r0 = r4.m
            if (r0 == 0) goto L6d
            android.view.View r0 = r4.m
            r0.setTag(r5)
            android.view.View r0 = r4.m
            if (r0 == 0) goto L68
            android.view.View r0 = r4.m
            android.view.View$OnClickListener r1 = r4.a
            r0.setOnClickListener(r1)
        L68:
            boolean r0 = r5.x
            if (r0 == 0) goto L3d
            goto L37
        L6d:
            com.mg.ola.common.widget.OlaTextView r0 = r4.i
            java.lang.CharSequence r5 = r5.l()
            r0.setText(r5)
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.entry.b.f.a(chat.ola.vn.message.d):void");
    }

    @Override // chat.ola.vn.entry.b.b
    public void a(chat.ola.vn.message.d dVar, chat.ola.vn.message.d dVar2, chat.ola.vn.message.d dVar3) {
        try {
            this.t = dVar;
            this.k.setTag(this.t);
            this.k.setOnLongClickListener(this.b);
            try {
                this.u = false;
                if (dVar2.d() == this.t.d() && chat.ola.vn.util.m.b(dVar2.i(), this.t.i()) && Math.abs(this.t.m() - dVar2.m()) < 300000) {
                    this.u = true;
                }
            } catch (Throwable unused) {
            }
            try {
                this.v = false;
                if (dVar3.d() == this.t.d() && chat.ola.vn.util.m.b(dVar3.i(), this.t.i()) && Math.abs(dVar3.m() - this.t.m()) < 180000) {
                    this.v = true;
                }
            } catch (Throwable unused2) {
            }
            a(this.t);
            e();
            h();
            f();
            g();
            a(false);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    void a(String str, OlaCachedImageView olaCachedImageView) {
        if (str == null) {
            return;
        }
        chat.ola.vn.c.t.a().f(str, olaCachedImageView);
    }

    @Override // chat.ola.vn.entry.b.b
    public View b() {
        return this.k != null ? this.k : super.b();
    }

    public void c() {
        if (this.u) {
            this.h.setVisibility(8);
        }
        if (!this.v || this.g.getVisibility() == 8) {
            return;
        }
        this.g.setVisibility(8);
    }

    @SuppressLint({"NewApi"})
    public void d() {
        try {
            if (this.u) {
                a(this.h.getVisibility() != 0);
            }
        } catch (Throwable unused) {
        }
    }

    protected void e() {
        View view;
        int i;
        this.p.setVisibility(8);
        try {
            switch (this.t.d()) {
                case 0:
                    this.k.setBackgroundResource(R.drawable.bg_system_bubble_item);
                    break;
                case 1:
                    if (!this.u && !this.v) {
                        this.p.setVisibility(0);
                        view = this.k;
                        i = R.drawable.chat_incoming;
                    } else if (!this.v) {
                        view = this.k;
                        i = R.drawable.chat_incoming_bottom;
                    } else if (this.u) {
                        view = this.k;
                        i = R.drawable.chat_incoming_mid;
                    } else {
                        this.p.setVisibility(0);
                        view = this.k;
                        i = R.drawable.chat_incoming_top;
                    }
                    view.setBackgroundResource(i);
                    break;
                case 2:
                    if (!this.u && !this.v) {
                        this.p.setVisibility(0);
                        if (this.t.q() == 5) {
                            view = this.k;
                            i = R.drawable.chat_outgoing_fail;
                        } else {
                            view = this.k;
                            i = R.drawable.chat_outgoing;
                        }
                    } else if (this.v) {
                        if (!this.u) {
                            this.p.setVisibility(0);
                            if (this.t.q() == 5) {
                                view = this.k;
                                i = R.drawable.chat_outgoing_fail_top;
                            } else {
                                view = this.k;
                                i = R.drawable.chat_outgoing_top;
                            }
                        } else if (this.t.q() == 5) {
                            view = this.k;
                            i = R.drawable.chat_outgoing_fail_mid;
                        } else {
                            view = this.k;
                            i = R.drawable.chat_outgoing_mid;
                        }
                    } else if (this.t.q() == 5) {
                        view = this.k;
                        i = R.drawable.chat_outgoing_fail_bottom;
                    } else {
                        view = this.k;
                        i = R.drawable.chat_outgoing_bottom;
                    }
                    view.setBackgroundResource(i);
                    break;
            }
        } catch (Throwable unused) {
        }
        if (this.e >= 0) {
            this.k.setPadding(this.e, this.e, this.e, this.e);
        }
    }

    protected void f() {
        if (this.r != null && this.t.d() == 1) {
            this.r.setText("");
            String strI = this.t.i();
            if (chat.ola.vn.util.m.a(strI)) {
                return;
            }
            if (this.r != null) {
                this.r.setTag(strI);
            }
            if (this.f != null) {
                this.f.setTag(strI);
                if (this.u) {
                    this.f.a(null, null);
                } else {
                    a(strI, this.f);
                }
            }
            chat.ola.vn.message.f fVarF = this.t.f();
            if (fVarF != null) {
                short sK = fVarF.k();
                if (sK == 2 || sK == 4) {
                    try {
                        if (this.u) {
                            return;
                        }
                        chat.ola.vn.message.f fVarF2 = chat.ola.vn.h.t.f(strI, (short) 0);
                        if (fVarF2 != null) {
                            this.r.setText(fVarF2.L().toString());
                        } else {
                            this.r.setText(strI);
                        }
                    } catch (Throwable unused) {
                    }
                }
            }
        }
    }
}
