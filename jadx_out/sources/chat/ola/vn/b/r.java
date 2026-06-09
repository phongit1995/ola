package chat.ola.vn.b;

import android.content.Context;
import android.graphics.Typeface;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;
import java.util.ArrayList;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public class r extends j<chat.ola.vn.message.f> {
    private LayoutInflater a;
    private ArrayList<chat.ola.vn.message.f> b;

    protected class a {
        protected OlaCachedImageView a;
        public ImageView b;
        protected OlaCachedImageView c;
        protected TextView d;
        protected TextView e;
        protected TextView f;
        protected TextView g;
        protected chat.ola.vn.message.f h;
        protected View i;
        protected View j;

        public a(View view) {
            this.a = (OlaCachedImageView) view.findViewById(R.id.imgItemIcon);
            this.b = (ImageView) view.findViewById(R.id.imgDeviceType);
            this.c = (OlaCachedImageView) view.findViewById(R.id.messageStateImageView);
            this.d = (TextView) view.findViewById(R.id.txtItemTitle);
            this.e = (TextView) view.findViewById(R.id.timeAgoTextView);
            this.f = (TextView) view.findViewById(R.id.txtItemSubTitle);
            this.g = (TextView) view.findViewById(R.id.txtUnreadMessgage);
            this.j = view.findViewById(R.id.bottomDividerView);
            this.i = view;
        }

        /* JADX WARN: Removed duplicated region for block: B:12:0x009d  */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        private void a() {
            /*
                Method dump skipped, instruction units count: 268
                To view this dump add '--comments-level debug' option
            */
            throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.b.r.a.a():void");
        }

        /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
        private void a(int i) {
            View view;
            int i2;
            if (i == 0) {
                this.g.setVisibility(8);
                this.g.clearAnimation();
                view = this.i;
                i2 = chat.ola.vn.f.d;
            } else {
                this.g.setVisibility(0);
                this.g.setText(i + "");
                view = this.i;
                i2 = chat.ola.vn.f.I;
            }
            view.setBackgroundColor(i2);
        }

        /* JADX WARN: Removed duplicated region for block: B:7:0x005e  */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        private void a(chat.ola.vn.message.o r12) {
            /*
                Method dump skipped, instruction units count: 261
                To view this dump add '--comments-level debug' option
            */
            throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.b.r.a.a(chat.ola.vn.message.o):void");
        }

        private void a(String str) {
            if (!chat.ola.vn.util.m.a(str)) {
                this.g.setVisibility(0);
                this.g.setText(str);
                return;
            }
            this.g.setVisibility(8);
            this.g.clearAnimation();
            if (this.g.getAnimation() != null) {
                this.g.getAnimation().cancel();
            }
        }

        private void b() {
            OlaCachedImageView olaCachedImageView;
            chat.ola.vn.message.u uVar = (chat.ola.vn.message.u) this.h;
            this.d.setVisibility(0);
            this.f.setVisibility(0);
            this.e.setVisibility(8);
            this.c.setVisibility(8);
            this.g.setVisibility(8);
            this.d.setTypeface(Typeface.create(this.d.getTypeface(), 1));
            this.d.setText(uVar.Y());
            this.f.setText(uVar.Z());
            this.f.setCompoundDrawablesWithIntrinsicBounds(0, 0, 0, 0);
            this.i.setBackgroundColor(chat.ola.vn.f.d);
            boolean zA = chat.ola.vn.util.m.a(uVar.aa());
            int iAc = R.drawable.ic_tab_appstore;
            if (zA) {
                if (uVar.ac() != 0) {
                    olaCachedImageView = this.a;
                    iAc = uVar.ac();
                } else {
                    olaCachedImageView = this.a;
                }
                olaCachedImageView.setImageResource(iAc);
            } else if (uVar.aa().toLowerCase(Locale.US).startsWith("http")) {
                chat.ola.vn.c.t.a().a(uVar.aa(), this.a, R.drawable.ic_tab_appstore, true);
            } else {
                chat.ola.vn.c.t.a().a(uVar.aa(), this.a, R.drawable.ic_tab_appstore, 96, true);
            }
            a(uVar.ab());
        }

        private void c() {
            String strK;
            StringBuilder sb;
            TextView textView;
            String str;
            try {
                chat.ola.vn.message.d dVar = this.h.S;
                String strW = this.h.w();
                this.f.setVisibility(0);
                this.f.setCompoundDrawablesWithIntrinsicBounds(0, 0, 0, 0);
                if (this.h.s > this.h.a() && System.currentTimeMillis() - this.h.s < 3000) {
                    if (this.h.k() == 2) {
                        this.f.setText(OlaApplication.a(R.string.message_chat_typing, this.h.n));
                        return;
                    } else if (this.h.k() != 4) {
                        this.f.setText(OlaApplication.a(R.string.message_chat_typing_message));
                        return;
                    }
                }
                String string = "";
                if (dVar != null) {
                    try {
                        strK = dVar.k();
                        try {
                            if (dVar.d() == 2) {
                                sb = new StringBuilder();
                                sb.append(OlaApplication.a(R.string.string_you));
                                sb.append(": ");
                            } else if (dVar.d() == 1 && ((this.h.k() == 2 || this.h.k() == 4) && !chat.ola.vn.util.m.a(dVar.i()))) {
                                sb = new StringBuilder();
                                sb.append(dVar.i());
                                sb.append(": ");
                            }
                            string = sb.toString();
                        } catch (Throwable unused) {
                        }
                    } catch (Throwable unused2) {
                        strK = strW;
                    }
                } else {
                    strK = strW;
                }
                if (dVar != null) {
                    this.f.setText("");
                    if (dVar.x()) {
                        this.f.setCompoundDrawablesWithIntrinsicBounds(R.drawable.ic_notify_media_receive_photo_gray, 0, 0, 0);
                        return;
                    }
                    if (dVar.e() == 3) {
                        this.f.setCompoundDrawablesWithIntrinsicBounds(R.drawable.ic_notify_media_receive_voice_gray, 0, 0, 0);
                        return;
                    }
                    if (dVar.e() != 6 && dVar.e() != 7) {
                        if (dVar.e() == 14) {
                            strK = OlaApplication.a(R.string.string_sticker);
                        } else if (dVar.e() == 15) {
                            this.f.setCompoundDrawablesWithIntrinsicBounds(R.drawable.ic_ken_gray, 0, 0, 0);
                            return;
                        } else if (dVar.e() == 16 || dVar.e() == 17) {
                            strK = OlaApplication.a(R.string.string_tradding_vip);
                        }
                    }
                    this.f.setCompoundDrawablesWithIntrinsicBounds(R.drawable.ic_notify_media_receive_video_gray, 0, 0, 0);
                    return;
                }
                if (chat.ola.vn.util.m.a(strK)) {
                    this.f.setVisibility(8);
                    textView = this.f;
                    str = "";
                } else {
                    textView = this.f;
                    str = string + strK;
                }
                textView.setText(str);
            } catch (Throwable unused3) {
            }
        }

        private void d() {
            if (this.h == null) {
                return;
            }
            chat.ola.vn.message.d dVar = this.h.S;
            if (dVar == null || dVar.d() != 2) {
                this.c.setVisibility(8);
                return;
            }
            switch (dVar.q()) {
                case 2:
                    break;
                case 3:
                    if (this.h.k() == 0) {
                        this.c.setVisibility(0);
                        chat.ola.vn.c.t.a().f(this.h.j(), this.c);
                        return;
                    } else if (this.h.k() != 2) {
                        return;
                    }
                default:
                    this.c.setVisibility(8);
                    return;
            }
            this.c.setVisibility(0);
            this.c.setImageResource(R.drawable.ic_checked);
        }

        /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
        private void e() {
            OlaCachedImageView olaCachedImageView;
            int i;
            if (this.h == null) {
                this.a.a(null, null);
                return;
            }
            short sK = this.h.k();
            if (sK != 2) {
                if (sK != 4) {
                    chat.ola.vn.c.t.a().g(this.h.j(), this.a);
                    return;
                } else {
                    olaCachedImageView = this.a;
                    i = R.drawable.ic_broadcast_conv;
                }
            } else if (!chat.ola.vn.util.m.a(this.h.o())) {
                chat.ola.vn.c.t.a().a(this.h.o(), this.a, R.drawable.ic_chatgroup_vip, 96, true);
                return;
            } else {
                olaCachedImageView = this.a;
                i = R.drawable.ic_chatgroup_vip;
            }
            olaCachedImageView.setImageResource(i);
        }

        public void a(chat.ola.vn.message.f fVar, boolean z) {
            View view;
            int i;
            this.h = fVar;
            if (fVar == null) {
                return;
            }
            if (z) {
                view = this.j;
                i = 4;
            } else {
                view = this.j;
                i = 0;
            }
            view.setVisibility(i);
            if (this.h.k() == 5) {
                b();
            } else if (this.h.k() == 7) {
                a((chat.ola.vn.message.o) this.h);
            } else {
                a();
            }
        }
    }

    public r(Context context) {
        super(context);
        this.a = LayoutInflater.from(context);
        this.b = new ArrayList<>();
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Removed duplicated region for block: B:21:0x0076 A[RETURN] */
    /* JADX WARN: Removed duplicated region for block: B:22:0x0077 A[RETURN] */
    /* JADX WARN: Type inference failed for: r0v0, types: [short] */
    /* JADX WARN: Type inference failed for: r0v1 */
    /* JADX WARN: Type inference failed for: r0v14 */
    /* JADX WARN: Type inference failed for: r0v4 */
    /* JADX WARN: Type inference failed for: r0v5 */
    /* JADX WARN: Type inference failed for: r9v0, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r9v1, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r9v10 */
    /* JADX WARN: Type inference failed for: r9v2 */
    /* JADX WARN: Type inference failed for: r9v6, types: [android.view.View] */
    @Override // chat.ola.vn.b.j
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public android.view.View a(int r8, android.view.View r9, android.view.ViewGroup r10) {
        /*
            r7 = this;
            chat.ola.vn.message.f r8 = r7.getItem(r8)     // Catch: java.lang.Throwable -> L74
            short r0 = r8.k()     // Catch: java.lang.Throwable -> L74
            r1 = 6
            r2 = 0
            if (r0 != r1) goto L52
            if (r9 != 0) goto L24
            android.view.LayoutInflater r0 = r7.a     // Catch: java.lang.Throwable -> L74
            r1 = 2131427453(0x7f0b007d, float:1.8476523E38)
            android.view.View r0 = r0.inflate(r1, r2)     // Catch: java.lang.Throwable -> L74
            android.view.LayoutInflater r9 = r7.a     // Catch: java.lang.Throwable -> L73
            chat.ola.vn.util.a.a(r0, r9)     // Catch: java.lang.Throwable -> L73
            r9 = r8
            chat.ola.vn.message.a r9 = (chat.ola.vn.message.a) r9     // Catch: java.lang.Throwable -> L73
            r1 = 0
            r9.a = r1     // Catch: java.lang.Throwable -> L73
            r9 = r0
        L24:
            long r0 = java.lang.System.currentTimeMillis()     // Catch: java.lang.Throwable -> L74
            r2 = r8
            chat.ola.vn.message.a r2 = (chat.ola.vn.message.a) r2     // Catch: java.lang.Throwable -> L74
            long r2 = r2.a     // Catch: java.lang.Throwable -> L74
            r4 = 0
            long r4 = r0 - r2
            r0 = 180000(0x2bf20, double:8.8932E-319)
            int r2 = (r4 > r0 ? 1 : (r4 == r0 ? 0 : -1))
            if (r2 < 0) goto L74
            java.lang.Object r0 = r9.getTag()     // Catch: java.lang.Throwable -> L74
            com.google.android.gms.ads.AdView r0 = (com.google.android.gms.ads.AdView) r0     // Catch: java.lang.Throwable -> L74
            chat.ola.vn.message.a r8 = (chat.ola.vn.message.a) r8     // Catch: java.lang.Throwable -> L74
            long r1 = java.lang.System.currentTimeMillis()     // Catch: java.lang.Throwable -> L74
            r8.a = r1     // Catch: java.lang.Throwable -> L74
            com.google.android.gms.ads.AdRequest$Builder r8 = new com.google.android.gms.ads.AdRequest$Builder     // Catch: java.lang.Throwable -> L74
            r8.<init>()     // Catch: java.lang.Throwable -> L74
            com.google.android.gms.ads.AdRequest r8 = r8.build()     // Catch: java.lang.Throwable -> L74
            r0.loadAd(r8)     // Catch: java.lang.Throwable -> L74
            goto L74
        L52:
            if (r9 != 0) goto L66
            android.view.LayoutInflater r0 = r7.a     // Catch: java.lang.Throwable -> L74
            r1 = 2131427456(0x7f0b0080, float:1.8476529E38)
            android.view.View r0 = r0.inflate(r1, r2)     // Catch: java.lang.Throwable -> L74
            chat.ola.vn.b.r$a r9 = new chat.ola.vn.b.r$a     // Catch: java.lang.Throwable -> L73
            r9.<init>(r0)     // Catch: java.lang.Throwable -> L73
            r0.setTag(r9)     // Catch: java.lang.Throwable -> L73
            goto L6f
        L66:
            java.lang.Object r0 = r9.getTag()     // Catch: java.lang.Throwable -> L74
            chat.ola.vn.b.r$a r0 = (chat.ola.vn.b.r.a) r0     // Catch: java.lang.Throwable -> L74
            r6 = r0
            r0 = r9
            r9 = r6
        L6f:
            r1 = 0
            r9.a(r8, r1)     // Catch: java.lang.Throwable -> L73
        L73:
            r9 = r0
        L74:
            if (r9 != 0) goto L77
            return r10
        L77:
            return r9
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.b.r.a(int, android.view.View, android.view.ViewGroup):android.view.View");
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.message.f getItem(int i) {
        return chat.ola.vn.h.t.c(i);
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        return chat.ola.vn.h.t.j();
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getItemViewType(int i) {
        try {
            return getItem(i).k() == 6 ? 1 : 0;
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getViewTypeCount() {
        return 2;
    }

    @Override // android.widget.BaseAdapter
    public void notifyDataSetChanged() {
        super.notifyDataSetChanged();
    }
}
