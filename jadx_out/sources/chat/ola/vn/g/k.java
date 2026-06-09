package chat.ola.vn.g;

import android.graphics.Bitmap;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaImageViewerActivity;
import chat.ola.vn.c.t;
import chat.ola.vn.mediastore.OlaMediaEntity;
import chat.ola.vn.view.OlaCachedImageView;

/* JADX INFO: loaded from: classes.dex */
public class k extends h {
    public OlaCachedImageView e;
    public OlaCachedImageView f;
    public TextView g;
    public TextView h;
    public TextView i;
    public ImageView j;
    public boolean k;
    public boolean l;
    private View m;
    private int n;
    private chat.ola.vn.message.f o;
    private ImageView p;
    private OlaCachedImageView q;
    private boolean r;

    public k(chat.ola.vn.message.f fVar, View view) {
        super(view);
        this.k = false;
        this.l = false;
        this.r = false;
        this.m = view;
        this.o = fVar;
        this.e = (OlaCachedImageView) view.findViewById(R.id.imgItemIcon);
        this.j = (ImageView) view.findViewById(R.id.imgDeviceType);
        this.f = (OlaCachedImageView) view.findViewById(R.id.imgMediaThumbnail);
        this.g = (TextView) view.findViewById(R.id.txtItemTitle);
        this.h = (TextView) view.findViewById(R.id.timeOfflineTextView);
        this.i = (TextView) view.findViewById(R.id.txtItemSubTitle);
        this.p = (ImageView) view.findViewById(R.id.imgGenderIcon);
        try {
            this.q = (OlaCachedImageView) view.findViewById(R.id.vipImageHolder);
            this.n = OlaApplication.a().getResources().getDimensionPixelSize(R.dimen.metric_40dp);
        } catch (Throwable unused) {
        }
    }

    private void a(View.OnClickListener onClickListener) {
        OlaCachedImageView olaCachedImageView;
        boolean z;
        if (this.o == null || onClickListener == null) {
            return;
        }
        this.f.setOnClickListener(onClickListener);
        if (this.o.m()) {
            this.e.setOnClickListener(onClickListener);
            olaCachedImageView = this.e;
            z = true;
        } else {
            this.e.setOnClickListener(null);
            olaCachedImageView = this.e;
            z = false;
        }
        olaCachedImageView.setClickable(z);
    }

    private void c() {
        int i;
        ImageView imageView;
        ImageView imageView2;
        int i2;
        if (this.o == null) {
            return;
        }
        if (this.l) {
            short sK = this.o.k();
            i = 4;
            if (sK != 4) {
                switch (sK) {
                    case 1:
                    case 2:
                        break;
                    default:
                        this.p.setVisibility(0);
                        if (this.o.r() == 1) {
                            imageView2 = this.p;
                            i2 = R.drawable.ic_indicate_male;
                        } else if (this.o.r() == 0) {
                            imageView2 = this.p;
                            i2 = R.drawable.ic_indicate_female;
                        } else if (this.o.r() != 2) {
                            this.p.setVisibility(4);
                            return;
                        } else {
                            imageView2 = this.p;
                            i2 = R.drawable.ic_indicate_dynamic_gender;
                        }
                        imageView2.setImageResource(i2);
                        return;
                }
            }
            imageView = this.p;
        } else {
            imageView = this.p;
            i = 8;
        }
        imageView.setVisibility(i);
    }

    private void d() {
        if (this.o == null) {
            return;
        }
        this.e.setVisibility(0);
        if (this.o.k() == 2) {
            this.j.setVisibility(4);
            if (this.q != null) {
                this.q.setVisibility(8);
            }
            e();
            return;
        }
        f();
        if (this.k) {
            k();
        } else {
            j();
        }
    }

    private void e() {
        if (this.o.o() != null) {
            t.a().a(this.o.o(), this.e, R.drawable.ic_chatgroup_vip, 96, true);
        } else {
            this.e.setImageResource(R.drawable.ic_chatgroup_vip);
        }
    }

    private void f() {
        if (this.o == null) {
            return;
        }
        l();
        t.a().g(this.o.j(), this.e);
    }

    private void g() {
        if (this.o == null) {
            return;
        }
        this.g.setText(this.o.L());
        if (this.h != null) {
            try {
                if (this.o.N <= 0 || this.o.g() == 2) {
                    this.h.setVisibility(8);
                } else {
                    this.h.setVisibility(0);
                    this.h.setText(com.mg.ola.common.d.i.a(System.currentTimeMillis() - this.o.N, chat.ola.vn.b.d().c(), chat.ola.vn.b.d().a(), chat.ola.vn.b.d().b()));
                }
            } catch (Throwable unused) {
                this.h.setVisibility(8);
            }
        }
    }

    private void h() {
        if (this.o == null) {
            return;
        }
        if (this.o.M() == null || this.o.M().length() == 0) {
            this.i.setVisibility(8);
        } else {
            this.i.setVisibility(0);
            this.i.setText(this.o.M());
        }
    }

    private void i() {
        if (this.o == null) {
            return;
        }
        this.f.setBackgroundResource(R.drawable.bg_shadown_border);
        if (chat.ola.vn.util.m.a(this.o.d())) {
            this.f.setVisibility(8);
            return;
        }
        this.f.setScaleType(ImageView.ScaleType.CENTER_CROP);
        if (this.o.R == null || this.o.R.charAt(1) != 'P') {
            this.f.setVisibility(8);
        } else {
            this.f.setVisibility(0);
            t.a().a(this.o.R, this.f, R.drawable.ic_media_photo, this.n);
        }
    }

    private void j() {
        ImageView imageView;
        int i;
        if (this.o == null) {
            return;
        }
        if (this.o.k() == 1) {
            this.j.setVisibility(4);
            return;
        }
        if (this.o.f() != 0) {
            this.j.setVisibility(0);
            imageView = this.j;
            i = R.drawable.ic_buddy_birthday;
        } else if (this.o.g() != 2) {
            this.j.setVisibility(4);
            return;
        } else {
            this.j.setVisibility(0);
            imageView = this.j;
            i = R.drawable.ic_checked;
        }
        imageView.setImageResource(i);
    }

    private void k() {
        ImageView imageView;
        int i;
        if (this.o == null) {
            return;
        }
        if (this.o.k() == 1) {
            this.j.setVisibility(4);
            return;
        }
        if (this.o.f() == 0) {
            if (this.o.g() == 2) {
                this.j.setVisibility(0);
                switch (this.o.h()) {
                    case 0:
                        imageView = this.j;
                        i = R.drawable.ic_device_type_phone;
                        break;
                    case 1:
                    case 2:
                        imageView = this.j;
                        i = R.drawable.ic_device_type_pc;
                        break;
                    case 3:
                        imageView = this.j;
                        i = R.drawable.ic_device_type_apple;
                        break;
                    case 4:
                        imageView = this.j;
                        i = R.drawable.ic_device_type_android;
                        break;
                    case 5:
                        imageView = this.j;
                        i = R.drawable.ic_device_type_winphone;
                        break;
                }
            }
            this.j.setVisibility(4);
            return;
        }
        this.j.setVisibility(0);
        imageView = this.j;
        i = R.drawable.ic_buddy_birthday;
        imageView.setImageResource(i);
    }

    /* JADX WARN: Removed duplicated region for block: B:21:0x007f A[Catch: Throwable -> 0x0084, TRY_LEAVE, TryCatch #0 {Throwable -> 0x0084, blocks: (B:2:0x0000, B:5:0x0005, B:8:0x000a, B:10:0x0015, B:11:0x0018, B:13:0x0021, B:15:0x0029, B:17:0x004e, B:19:0x0079, B:21:0x007f), top: B:26:0x0000 }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void l() {
        /*
            r4 = this;
            chat.ola.vn.view.OlaCachedImageView r0 = r4.q     // Catch: java.lang.Throwable -> L84
            if (r0 != 0) goto L5
            return
        L5:
            chat.ola.vn.message.f r0 = r4.o     // Catch: java.lang.Throwable -> L84
            if (r0 != 0) goto La
            return
        La:
            chat.ola.vn.message.f r0 = r4.o     // Catch: java.lang.Throwable -> L84
            short r0 = r0.k()     // Catch: java.lang.Throwable -> L84
            r1 = 4
            r2 = 8
            if (r0 == r1) goto L7f
            switch(r0) {
                case 1: goto L7f;
                case 2: goto L7f;
                default: goto L18;
            }     // Catch: java.lang.Throwable -> L84
        L18:
            chat.ola.vn.message.f r0 = r4.o     // Catch: java.lang.Throwable -> L84
            short r0 = r0.g()     // Catch: java.lang.Throwable -> L84
            r1 = 2
            if (r0 != r1) goto L79
            chat.ola.vn.message.f r0 = r4.o     // Catch: java.lang.Throwable -> L84
            short r0 = r0.i()     // Catch: java.lang.Throwable -> L84
            if (r0 == 0) goto L79
            chat.ola.vn.view.OlaCachedImageView r0 = r4.q     // Catch: java.lang.Throwable -> L84
            r1 = 0
            r0.setVisibility(r1)     // Catch: java.lang.Throwable -> L84
            chat.ola.vn.view.OlaCachedImageView r0 = r4.q     // Catch: java.lang.Throwable -> L84
            java.lang.StringBuilder r1 = new java.lang.StringBuilder     // Catch: java.lang.Throwable -> L84
            r1.<init>()     // Catch: java.lang.Throwable -> L84
            chat.ola.vn.message.f r2 = r4.o     // Catch: java.lang.Throwable -> L84
            short r2 = r2.i()     // Catch: java.lang.Throwable -> L84
            r1.append(r2)     // Catch: java.lang.Throwable -> L84
            java.lang.String r2 = ""
            r1.append(r2)     // Catch: java.lang.Throwable -> L84
            java.lang.String r1 = r1.toString()     // Catch: java.lang.Throwable -> L84
            boolean r0 = r0.a(r1)     // Catch: java.lang.Throwable -> L84
            if (r0 != 0) goto L84
            chat.ola.vn.j r0 = chat.ola.vn.j.a()     // Catch: java.lang.Throwable -> L84
            chat.ola.vn.message.f r1 = r4.o     // Catch: java.lang.Throwable -> L84
            short r1 = r1.i()     // Catch: java.lang.Throwable -> L84
            android.graphics.Bitmap r0 = r0.a(r1)     // Catch: java.lang.Throwable -> L84
            chat.ola.vn.view.OlaCachedImageView r1 = r4.q     // Catch: java.lang.Throwable -> L84
            java.lang.StringBuilder r2 = new java.lang.StringBuilder     // Catch: java.lang.Throwable -> L84
            r2.<init>()     // Catch: java.lang.Throwable -> L84
            chat.ola.vn.message.f r3 = r4.o     // Catch: java.lang.Throwable -> L84
            short r3 = r3.i()     // Catch: java.lang.Throwable -> L84
            r2.append(r3)     // Catch: java.lang.Throwable -> L84
            java.lang.String r3 = ""
            r2.append(r3)     // Catch: java.lang.Throwable -> L84
            java.lang.String r2 = r2.toString()     // Catch: java.lang.Throwable -> L84
            r1.a(r0, r2)     // Catch: java.lang.Throwable -> L84
            return
        L79:
            chat.ola.vn.view.OlaCachedImageView r0 = r4.q     // Catch: java.lang.Throwable -> L84
            r0.setVisibility(r2)     // Catch: java.lang.Throwable -> L84
            return
        L7f:
            chat.ola.vn.view.OlaCachedImageView r0 = r4.q     // Catch: java.lang.Throwable -> L84
            if (r0 == 0) goto L84
            goto L79
        L84:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.g.k.l():void");
    }

    public void a(chat.ola.vn.message.f fVar) {
        this.o = fVar;
    }

    @Override // chat.ola.vn.g.h
    public void b(int i) {
        View view;
        int i2;
        try {
            if (this.r) {
                view = this.m;
                i2 = chat.ola.vn.f.I;
            } else {
                view = this.m;
                i2 = chat.ola.vn.f.d;
            }
            view.setBackgroundColor(i2);
            g();
            h();
            d();
            c();
            i();
            a(new View.OnClickListener() { // from class: chat.ola.vn.g.k.1
                @Override // android.view.View.OnClickListener
                public void onClick(View view2) {
                    try {
                        int id = view2.getId();
                        if (id == R.id.imgItemIcon) {
                            if (k.this.o.m()) {
                                chat.ola.vn.me.c.a(chat.ola.vn.c.c(), OlaApplication.b, k.this.o.j());
                            }
                        } else if (id == R.id.imgMediaThumbnail && !chat.ola.vn.util.m.a(k.this.o.d())) {
                            OlaImageViewerActivity.a(chat.ola.vn.c.c(), view2, (Bitmap) null, 0, OlaMediaEntity.a(chat.ola.vn.util.i.b((CharSequence) k.this.o.d())));
                        }
                    } catch (Throwable th) {
                        th.printStackTrace();
                    }
                }
            });
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void c(boolean z) {
        this.r = z;
    }
}
