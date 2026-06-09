package chat.ola.vn.entry.b;

import android.annotation.TargetApi;
import android.support.v4.view.ViewCompat;
import android.view.View;
import android.view.ViewStub;
import android.widget.ProgressBar;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;

/* JADX INFO: loaded from: classes.dex */
public class y extends ab {
    private View A;
    private TextView B;
    private TextView C;
    private View D;
    private ProgressBar E;
    private View F;
    private int G;
    private String H;
    private ViewStub I;
    private OlaCachedImageView z;

    public y(View view, int i) {
        super(view, i);
        this.G = 10;
        this.H = null;
        this.I = null;
    }

    private void h() {
        if (this.b.m == null) {
            this.z.setVisibility(8);
            return;
        }
        try {
            chat.ola.vn.c.t.a().a(this.b.p, this.z);
            this.A.setVisibility(0);
            if (this.b.n != null) {
                this.F.setVisibility(0);
                this.B.setText(this.b.n);
                this.C.setText(this.b.o);
            } else {
                this.F.setVisibility(8);
                this.B.setText("");
                this.C.setText("");
                OlaApplication.b.a(this.b.m, new chat.ola.vn.p.b() { // from class: chat.ola.vn.entry.b.y.1
                    @Override // chat.ola.vn.p.b
                    public void a(String str, String str2) {
                        try {
                            y.this.b.n = "";
                            y.this.b.o = "";
                        } catch (Throwable unused) {
                        }
                    }

                    @Override // chat.ola.vn.p.b
                    public void a(String str, String str2, chat.ola.vn.entity.e eVar) {
                        chat.ola.vn.entry.b bVar;
                        String strS;
                        chat.ola.vn.entry.b bVar2;
                        String strZ;
                        chat.ola.vn.entry.b bVar3;
                        String strA;
                        TextView textView;
                        String str3;
                        try {
                            if (y.this.z.getWidth() > 400 || chat.ola.vn.h.I) {
                                y.this.b.p = eVar.q();
                                if (chat.ola.vn.util.m.a(y.this.b.p)) {
                                    y.this.b.p = eVar.r();
                                }
                                if (chat.ola.vn.util.m.a(y.this.b.p)) {
                                    bVar = y.this.b;
                                    strS = eVar.s();
                                    bVar.p = strS;
                                }
                            } else {
                                y.this.b.p = eVar.r();
                                if (chat.ola.vn.util.m.a(y.this.b.p)) {
                                    y.this.b.p = eVar.s();
                                }
                                if (chat.ola.vn.util.m.a(y.this.b.p)) {
                                    bVar = y.this.b;
                                    strS = eVar.q();
                                    bVar.p = strS;
                                }
                            }
                            y.this.b.q = eVar.A();
                            if (chat.ola.vn.util.m.a(eVar.z())) {
                                bVar2 = y.this.b;
                                strZ = "";
                            } else {
                                bVar2 = y.this.b;
                                strZ = eVar.z();
                            }
                            bVar2.n = strZ;
                            if (eVar.C() >= 0) {
                                bVar3 = y.this.b;
                                strA = com.mg.ola.common.d.i.a(eVar.C(), ":", ":");
                            } else {
                                bVar3 = y.this.b;
                                strA = "";
                            }
                            bVar3.o = strA;
                            if (chat.ola.vn.util.m.a(y.this.b.n)) {
                                y.this.F.setVisibility(8);
                                y.this.B.setText("");
                                textView = y.this.C;
                                str3 = "";
                            } else {
                                y.this.F.setVisibility(0);
                                y.this.B.setText(y.this.b.n);
                                textView = y.this.C;
                                str3 = y.this.b.o;
                            }
                            textView.setText(str3);
                        } catch (Throwable unused) {
                        }
                    }
                });
            }
        } catch (Throwable unused) {
        }
    }

    @TargetApi(11)
    private void i() {
        if (this.b.m == null) {
            this.z.setVisibility(8);
            return;
        }
        try {
            String str = "http://img.youtube.com/vi/" + this.b.m + "/mqdefault.jpg";
            if (this.z.getWidth() > 400 || chat.ola.vn.h.I) {
                str = "http://img.youtube.com/vi/" + this.b.m + "/hqdefault.jpg";
            }
            chat.ola.vn.c.t.a().a(str, this.z);
            this.A.setVisibility(0);
            if (this.b.n != null) {
                this.F.setVisibility(0);
                this.B.setText(this.b.n);
                this.C.setText(this.b.o);
            } else {
                this.F.setVisibility(8);
                this.B.setText("");
                this.C.setText("");
                OlaApplication.b.a(this.b.m, new chat.ola.vn.p.o() { // from class: chat.ola.vn.entry.b.y.2
                    @Override // chat.ola.vn.p.o
                    public void a() {
                        y.this.b.n = "";
                    }

                    @Override // chat.ola.vn.p.o
                    public void a(chat.ola.vn.entity.ai aiVar) {
                        chat.ola.vn.entry.b bVar;
                        String str2;
                        TextView textView;
                        String str3;
                        try {
                            if (chat.ola.vn.util.m.b(y.this.b.m, aiVar.c)) {
                                if (chat.ola.vn.util.m.a(aiVar.a)) {
                                    bVar = y.this.b;
                                    str2 = "";
                                } else {
                                    bVar = y.this.b;
                                    str2 = aiVar.a;
                                }
                                bVar.n = str2;
                                if (!chat.ola.vn.util.m.a(aiVar.d)) {
                                    y.this.b.o = aiVar.d;
                                }
                                if (chat.ola.vn.util.m.a(y.this.b.n)) {
                                    y.this.F.setVisibility(8);
                                    y.this.B.setText("");
                                    textView = y.this.C;
                                    str3 = "";
                                } else {
                                    y.this.F.setVisibility(0);
                                    y.this.B.setText(y.this.b.n);
                                    textView = y.this.C;
                                    str3 = y.this.b.o;
                                }
                                textView.setText(str3);
                            }
                        } catch (Throwable th) {
                            th.printStackTrace();
                        }
                    }
                });
            }
        } catch (Throwable unused) {
        }
    }

    @TargetApi(11)
    private void j() {
        if (this.b.m == null) {
            this.z.setVisibility(8);
            return;
        }
        try {
            this.A.setVisibility(0);
            this.z.setBackgroundColor(ViewCompat.MEASURED_STATE_MASK);
            this.z.a(null, null);
            this.F.setVisibility(0);
            this.B.setText(R.string.string_touch_to_view_video);
            this.C.setText("--:--");
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entry.b.ab, chat.ola.vn.entry.b.j
    @TargetApi(11)
    public void a() {
        if (this.b == null) {
        }
        super.a();
        if (this.a != null) {
            this.D.setTag(this.b);
            this.D.setOnClickListener(this.a);
        }
        if (this.e != null) {
            this.D.setTag(this.b);
            this.D.setOnLongClickListener(this.e);
        }
        switch (this.b.l) {
            case 1:
                h();
                break;
            case 2:
                j();
                break;
            default:
                i();
                break;
        }
    }

    @Override // chat.ola.vn.entry.b.ab, chat.ola.vn.entry.b.j
    public void a(View view) {
        super.a(view);
        this.D = view.findViewById(R.id.linearYoutubeSpan);
        try {
            this.E = (ProgressBar) view.findViewById(R.id.autoPlayVideoViewLoading);
            this.E.setVisibility(8);
        } catch (Throwable unused) {
        }
        this.A = view.findViewById(R.id.imgMeYoutubeThumbnailPlayIcon);
        this.z = (OlaCachedImageView) view.findViewById(R.id.imgMeYoutubeThumbnail1);
        this.F = view.findViewById(R.id.meYouTubeInfo);
        this.B = (TextView) view.findViewById(R.id.meYouTubeTitle);
        this.C = (TextView) view.findViewById(R.id.meYouTubeDuration);
        try {
            this.G = view.getContext().getResources().getDimensionPixelSize(R.dimen.metric_8dp);
        } catch (Throwable unused2) {
        }
        this.z.a(null, null);
        this.I = (ViewStub) view.findViewById(R.id.meCheckInViewStub);
    }
}
