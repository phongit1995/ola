package chat.ola.vn.message;

import android.content.Context;
import android.graphics.Typeface;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public class n extends chat.ola.vn.b.j<f> {
    private LayoutInflater a;

    protected class a {
        protected OlaCachedImageView a;
        protected OlaCachedImageView b;
        protected TextView c;
        protected TextView d;
        protected TextView e;
        protected TextView f;
        protected f g;
        protected View h;
        protected View i;

        public a(View view) {
            this.a = (OlaCachedImageView) view.findViewById(R.id.imgItemIcon);
            this.b = (OlaCachedImageView) view.findViewById(R.id.messageStateImageView);
            this.c = (TextView) view.findViewById(R.id.txtItemTitle);
            this.d = (TextView) view.findViewById(R.id.timeAgoTextView);
            this.e = (TextView) view.findViewById(R.id.txtItemSubTitle);
            this.f = (TextView) view.findViewById(R.id.txtUnreadMessgage);
            this.i = view.findViewById(R.id.bottomDividerView);
            this.h = view;
        }

        /* JADX WARN: Removed duplicated region for block: B:12:0x009d  */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        private void a() {
            /*
                r11 = this;
                chat.ola.vn.message.f r0 = r11.g
                int r0 = r0.z()
                r1 = 0
                if (r0 <= 0) goto L30
                android.widget.TextView r0 = r11.c
                android.widget.TextView r2 = r11.c
                android.graphics.Typeface r2 = r2.getTypeface()
                r3 = 1
                android.graphics.Typeface r2 = android.graphics.Typeface.create(r2, r3)
                r0.setTypeface(r2)
                android.widget.TextView r0 = r11.d
                android.widget.TextView r2 = r11.d
                android.graphics.Typeface r2 = r2.getTypeface()
                android.graphics.Typeface r2 = android.graphics.Typeface.create(r2, r3)
                r0.setTypeface(r2)
                android.widget.TextView r0 = r11.d
                int r2 = chat.ola.vn.f.y
            L2c:
                r0.setTextColor(r2)
                goto L53
            L30:
                android.widget.TextView r0 = r11.c
                android.widget.TextView r2 = r11.c
                android.graphics.Typeface r2 = r2.getTypeface()
                android.graphics.Typeface r2 = android.graphics.Typeface.create(r2, r1)
                r0.setTypeface(r2)
                android.widget.TextView r0 = r11.d
                android.widget.TextView r2 = r11.d
                android.graphics.Typeface r2 = r2.getTypeface()
                android.graphics.Typeface r2 = android.graphics.Typeface.create(r2, r1)
                r0.setTypeface(r2)
                android.widget.TextView r0 = r11.d
                int r2 = chat.ola.vn.f.z
                goto L2c
            L53:
                android.widget.TextView r0 = r11.c
                chat.ola.vn.message.f r2 = r11.g
                java.lang.CharSequence r2 = r2.L()
                r0.setText(r2)
                chat.ola.vn.message.f r0 = r11.g
                long r2 = r0.a()
                r4 = 0
                int r0 = (r2 > r4 ? 1 : (r2 == r4 ? 0 : -1))
                r6 = 8
                if (r0 <= 0) goto L9d
                long r7 = java.lang.System.currentTimeMillis()
                long r9 = r7 - r2
                int r0 = (r9 > r4 ? 1 : (r9 == r4 ? 0 : -1))
                if (r0 <= 0) goto L9d
                android.widget.TextView r0 = r11.d
                r0.setVisibility(r1)
                android.widget.TextView r0 = r11.d
                chat.ola.vn.b r1 = chat.ola.vn.b.d()
                java.lang.String[] r1 = r1.c()
                chat.ola.vn.b r2 = chat.ola.vn.b.d()
                java.lang.String[] r2 = r2.a()
                chat.ola.vn.b r3 = chat.ola.vn.b.d()
                java.lang.String[] r3 = r3.b()
                java.lang.String r1 = com.mg.ola.common.d.i.a(r9, r1, r2, r3)
                r0.setText(r1)
                goto La2
            L9d:
                android.widget.TextView r0 = r11.d
                r0.setVisibility(r6)
            La2:
                r11.c()
                r11.d()
                chat.ola.vn.message.f r0 = r11.g
                int r0 = r0.z()
                r11.a(r0)
                r11.e()
                return
            */
            throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.message.n.a.a():void");
        }

        /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
        private void a(int i) {
            View view;
            int i2;
            if (i == 0) {
                this.f.setVisibility(8);
                this.f.clearAnimation();
                view = this.h;
                i2 = chat.ola.vn.f.d;
            } else {
                this.f.setVisibility(0);
                this.f.setText(i + "");
                view = this.h;
                i2 = chat.ola.vn.f.I;
            }
            view.setBackgroundColor(i2);
        }

        private void a(o oVar) {
            this.c.setVisibility(0);
            this.e.setVisibility(0);
            this.d.setVisibility(8);
            this.b.setVisibility(8);
            this.f.setVisibility(8);
            this.a.setImageResource(R.drawable.ic_tab_osimi);
            int iZ = oVar.z();
            if (iZ > 0) {
                this.e.setVisibility(0);
                this.e.setText(chat.ola.vn.util.m.a(iZ) + " " + OlaApplication.a(R.string.string_unread_messages));
            } else {
                this.e.setVisibility(8);
            }
            this.e.setCompoundDrawablesWithIntrinsicBounds(0, 0, 0, 0);
            this.c.setText(OlaApplication.a(R.string.string_other_people));
        }

        private void a(String str) {
            if (!chat.ola.vn.util.m.a(str)) {
                this.f.setVisibility(0);
                this.f.setText(str);
                return;
            }
            this.f.setVisibility(8);
            this.f.clearAnimation();
            if (this.f.getAnimation() != null) {
                this.f.getAnimation().cancel();
            }
        }

        private void b() {
            OlaCachedImageView olaCachedImageView;
            u uVar = (u) this.g;
            this.c.setVisibility(0);
            this.e.setVisibility(0);
            this.d.setVisibility(8);
            this.b.setVisibility(8);
            this.f.setVisibility(8);
            this.c.setTypeface(Typeface.create(this.c.getTypeface(), 1));
            this.c.setText(uVar.Y());
            this.e.setText(uVar.Z());
            this.e.setCompoundDrawablesWithIntrinsicBounds(0, 0, 0, 0);
            this.h.setBackgroundColor(chat.ola.vn.f.I);
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
                d dVar = this.g.S;
                String strW = this.g.w();
                this.e.setVisibility(0);
                this.e.setCompoundDrawablesWithIntrinsicBounds(0, 0, 0, 0);
                if (this.g.s > this.g.a() && System.currentTimeMillis() - this.g.s < 3000) {
                    if (this.g.k() == 2) {
                        this.e.setText(OlaApplication.a(R.string.message_chat_typing, this.g.n));
                        return;
                    } else if (this.g.k() != 4) {
                        this.e.setText(OlaApplication.a(R.string.message_chat_typing_message));
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
                            } else if (dVar.d() == 1 && ((this.g.k() == 2 || this.g.k() == 4) && !chat.ola.vn.util.m.a(dVar.i()))) {
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
                    this.e.setText("");
                    if (dVar.x()) {
                        this.e.setCompoundDrawablesWithIntrinsicBounds(R.drawable.ic_notify_media_receive_photo_gray, 0, 0, 0);
                        return;
                    }
                    if (dVar.e() == 3) {
                        this.e.setCompoundDrawablesWithIntrinsicBounds(R.drawable.ic_notify_media_receive_voice_gray, 0, 0, 0);
                        return;
                    }
                    if (dVar.e() != 6 && dVar.e() != 7) {
                        if (dVar.e() == 14) {
                            strK = OlaApplication.a(R.string.string_sticker);
                        } else if (dVar.e() == 15) {
                            this.e.setCompoundDrawablesWithIntrinsicBounds(R.drawable.ic_ken_gray, 0, 0, 0);
                            return;
                        } else if (dVar.e() == 16 || dVar.e() == 17) {
                            strK = OlaApplication.a(R.string.string_tradding_vip);
                        }
                    }
                    this.e.setCompoundDrawablesWithIntrinsicBounds(R.drawable.ic_notify_media_receive_video_gray, 0, 0, 0);
                    return;
                }
                if (chat.ola.vn.util.m.a(strK)) {
                    this.e.setVisibility(8);
                    textView = this.e;
                    str = "";
                } else {
                    textView = this.e;
                    str = string + strK;
                }
                textView.setText(str);
            } catch (Throwable unused3) {
            }
        }

        private void d() {
            if (this.g == null) {
                return;
            }
            d dVar = this.g.S;
            if (dVar == null || dVar.d() != 2) {
                this.b.setVisibility(8);
                return;
            }
            switch (dVar.q()) {
                case 2:
                    break;
                case 3:
                    if (this.g.k() == 0) {
                        this.b.setVisibility(0);
                        chat.ola.vn.c.t.a().f(this.g.j(), this.b);
                        return;
                    } else if (this.g.k() != 2) {
                        return;
                    }
                default:
                    this.b.setVisibility(8);
                    return;
            }
            this.b.setVisibility(0);
            this.b.setImageResource(R.drawable.ic_checked);
        }

        /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
        private void e() {
            OlaCachedImageView olaCachedImageView;
            int i;
            if (this.g == null) {
                return;
            }
            short sK = this.g.k();
            if (sK != 2) {
                if (sK != 4) {
                    chat.ola.vn.c.t.a().g(this.g.j(), this.a);
                    return;
                } else {
                    olaCachedImageView = this.a;
                    i = R.drawable.ic_broadcast_conv;
                }
            } else if (!chat.ola.vn.util.m.a(this.g.o())) {
                chat.ola.vn.c.t.a().a(this.g.o(), this.a, R.drawable.ic_chatgroup_vip, 96, true);
                return;
            } else {
                olaCachedImageView = this.a;
                i = R.drawable.ic_chatgroup_vip;
            }
            olaCachedImageView.setImageResource(i);
        }

        public void a(f fVar, boolean z) {
            View view;
            int i;
            this.g = fVar;
            if (fVar == null) {
                return;
            }
            if (z) {
                view = this.i;
                i = 4;
            } else {
                view = this.i;
                i = 0;
            }
            view.setVisibility(i);
            if (this.g.k() == 5) {
                b();
            } else if (this.g.k() == 7) {
                a((o) this.g);
            } else {
                a();
            }
        }
    }

    public n(Context context) {
        super(context);
        this.a = LayoutInflater.from(context);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r0v0 */
    /* JADX WARN: Type inference failed for: r0v1, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r0v4 */
    /* JADX WARN: Type inference failed for: r0v5 */
    /* JADX WARN: Type inference failed for: r0v6 */
    /* JADX WARN: Type inference failed for: r0v8, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r0v9 */
    /* JADX WARN: Type inference failed for: r6v0, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r6v1 */
    /* JADX WARN: Type inference failed for: r6v2 */
    /* JADX WARN: Type inference failed for: r6v3, types: [chat.ola.vn.message.n$a] */
    /* JADX WARN: Type inference failed for: r6v5 */
    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        ?? Inflate;
        try {
            if (view == 0) {
                Inflate = this.a.inflate(R.layout.conversation_item_layout, (ViewGroup) null);
                try {
                    a aVar = new a(Inflate);
                    Inflate.setTag(aVar);
                    Inflate = Inflate;
                    view = aVar;
                } catch (Throwable unused) {
                }
            } else {
                Inflate = view;
                view = (a) view.getTag();
            }
            view.a(getItem(i), false);
        } catch (Throwable unused2) {
            Inflate = view;
        }
        return Inflate == 0 ? viewGroup : Inflate;
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public f getItem(int i) {
        return chat.ola.vn.h.t.b(i);
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        return chat.ola.vn.h.t.i();
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getItemViewType(int i) {
        return 0;
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getViewTypeCount() {
        return 1;
    }
}
