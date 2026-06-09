package chat.ola.vn.entry.b;

import android.graphics.Bitmap;
import android.location.Address;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.n.b;
import chat.ola.vn.view.OlaCachedImageView;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class u extends f {
    private OlaCachedImageView t;
    private TextView u;
    private View v;
    private String w;
    private final int x;
    private chat.ola.vn.message.k y;

    public u(View view, int i) {
        super(view);
        this.x = 16;
        this.q.setLayoutResource(i);
        this.q.inflate();
        this.q.setVisibility(0);
        this.t = (OlaCachedImageView) view.findViewById(R.id.messageLocationThumbnail);
        this.t.setOnClickListener(this.a);
        this.u = (TextView) view.findViewById(R.id.addressTextView);
        this.v = view.findViewById(R.id.loadingProgressBar);
        try {
            this.i.setVisibility(8);
            this.e = this.d.getContext().getResources().getDimensionPixelSize(R.dimen.metric_6dp);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void g() {
        TextView textView;
        int i;
        try {
            this.t.setTag(this.y);
            String strA = this.y.a();
            String strC = this.y.C();
            final chat.ola.vn.c.f fVarA = chat.ola.vn.c.f.a(strC, strA, this.t.getWidth(), this.t.getHeight(), 16);
            this.w = fVarA.e();
            List<Address> listD = this.y.D();
            if (listD == null) {
                this.y.b(new ArrayList());
                final chat.ola.vn.message.k kVar = this.y;
                chat.ola.vn.n.b.a(OlaApplication.a(), Double.parseDouble(strA), Double.parseDouble(strC), new b.a() { // from class: chat.ola.vn.entry.b.u.1
                    @Override // chat.ola.vn.n.b.a
                    public void a() {
                    }

                    @Override // chat.ola.vn.n.b.a
                    public void a(List<Address> list) {
                        try {
                            kVar.b(list);
                            u.this.g();
                        } catch (Throwable unused) {
                        }
                    }
                });
            } else {
                try {
                    String strA2 = chat.ola.vn.n.b.a(listD.get(0));
                    if (strA2 != null) {
                        if (this.y.d() == 2) {
                            textView = this.u;
                            i = chat.ola.vn.f.D;
                        } else {
                            textView = this.u;
                            i = chat.ola.vn.f.z;
                        }
                        textView.setTextColor(i);
                        this.u.setText(strA2);
                        this.u.setVisibility(0);
                    }
                } catch (Throwable unused) {
                    this.u.setVisibility(8);
                }
            }
            if (this.t.a(this.w)) {
                return;
            }
            this.v.setVisibility(0);
            this.t.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
            this.t.setImageResource(R.drawable.ic_media_map);
            chat.ola.vn.c.t.a().a(this.w, new chat.ola.vn.c.i() { // from class: chat.ola.vn.entry.b.u.2
                @Override // chat.ola.vn.c.w
                public void c(String str) {
                    try {
                        if (chat.ola.vn.util.m.b(str, u.this.w)) {
                            fVarA.a(new chat.ola.vn.c.g() { // from class: chat.ola.vn.entry.b.u.2.1
                                @Override // chat.ola.vn.c.g
                                public void a(chat.ola.vn.c.f fVar) {
                                    try {
                                        if (chat.ola.vn.util.m.b(u.this.w, fVar.e())) {
                                            u.this.v.setVisibility(8);
                                            u.this.t.setScaleType(ImageView.ScaleType.CENTER_CROP);
                                            u.this.t.a(fVar.c(), u.this.w);
                                        }
                                    } catch (Throwable unused2) {
                                    }
                                }

                                @Override // chat.ola.vn.c.g
                                public void b(chat.ola.vn.c.f fVar) {
                                }
                            });
                            new chat.ola.vn.c.e().a(fVarA);
                        }
                    } catch (Throwable unused2) {
                    }
                }

                @Override // chat.ola.vn.c.w
                public void c(String str, Bitmap bitmap) {
                    try {
                        if (chat.ola.vn.util.m.b(u.this.w, str)) {
                            u.this.v.setVisibility(8);
                            u.this.t.setScaleType(ImageView.ScaleType.CENTER_CROP);
                            u.this.t.a(bitmap, str);
                        }
                    } catch (Throwable unused2) {
                    }
                }
            });
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.entry.b.f, chat.ola.vn.entry.b.b
    public void a(chat.ola.vn.message.d dVar, chat.ola.vn.message.d dVar2, chat.ola.vn.message.d dVar3) {
        try {
            super.a(dVar, dVar2, dVar3);
            this.y = (chat.ola.vn.message.k) dVar;
            g();
        } catch (Throwable unused) {
        }
    }
}
