package chat.ola.vn.entry.b;

import android.view.View;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;
import chat.ola.vn.view.OlaRatioImageView;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class ad extends f {
    protected int t;
    protected int u;
    protected int v;
    private TextView w;
    private View x;
    private OlaCachedImageView[] y;

    public ad(View view, int i) {
        super(view);
        this.t = chat.ola.vn.e.c / 3;
        this.u = (chat.ola.vn.e.c * 2) / 3;
        this.v = chat.ola.vn.e.c;
        this.q.setLayoutResource(i);
        this.q.inflate();
        this.q.setVisibility(0);
        this.y = new OlaCachedImageView[5];
        try {
            this.y[0] = (OlaCachedImageView) view.findViewById(R.id.mediaImageView1);
            this.y[1] = (OlaCachedImageView) view.findViewById(R.id.mediaImageView2);
            this.y[2] = (OlaCachedImageView) view.findViewById(R.id.mediaImageView3);
            this.y[3] = (OlaCachedImageView) view.findViewById(R.id.mediaImageView4);
            this.y[4] = (OlaCachedImageView) view.findViewById(R.id.mediaImageView5);
            this.w = (TextView) view.findViewById(R.id.moreMediaTextView);
            this.x = view.findViewById(R.id.theTenViewLayout);
        } catch (Throwable unused) {
        }
        try {
            this.e = this.d.getContext().getResources().getDimensionPixelSize(R.dimen.metric_6dp);
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.entry.b.f, chat.ola.vn.entry.b.b
    public void a(chat.ola.vn.message.d dVar, chat.ola.vn.message.d dVar2, chat.ola.vn.message.d dVar3) {
        try {
            super.a(dVar, dVar2, dVar3);
            a((chat.ola.vn.message.p) dVar);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void a(chat.ola.vn.message.p pVar) {
        OlaRatioImageView olaRatioImageView;
        if (pVar == null) {
            return;
        }
        for (int i = 0; i < this.y.length; i++) {
            try {
                if (this.y[i] != null) {
                    this.y[i].setVisibility(8);
                    this.y[i].setTag(pVar);
                    this.y[i].setOnClickListener(chat.ola.vn.q.a.a());
                    if (this.b != null) {
                        this.y[i].setOnLongClickListener(this.b);
                    }
                }
            } catch (Throwable th) {
                th.printStackTrace();
                try {
                    if (this.y != null) {
                        for (int i2 = 0; i2 < this.y.length; i2++) {
                            if (this.y[i2] != null) {
                                this.y[i2].setVisibility(8);
                            }
                        }
                        return;
                    }
                    return;
                } catch (Throwable th2) {
                    th2.printStackTrace();
                    return;
                }
            }
        }
        this.x.setVisibility(8);
        this.w.setVisibility(8);
        List<chat.ola.vn.entity.ab> listA = pVar.a();
        if (listA == null || listA.size() <= 0) {
            return;
        }
        int size = listA.size();
        if (size > 5) {
            if (this.x != null) {
                this.x.setVisibility(0);
            }
            this.w.setVisibility(0);
            TextView textView = this.w;
            StringBuilder sb = new StringBuilder();
            sb.append("+");
            sb.append(size - 5);
            textView.setText(sb.toString());
        } else if (size != 5) {
            this.w.setVisibility(8);
        } else if (this.x != null) {
            this.x.setVisibility(0);
        }
        for (int i3 = 0; i3 < this.y.length && i3 < size; i3++) {
            chat.ola.vn.entity.ab abVar = listA.get(i3);
            String str = abVar.c;
            if (this.y[i3] != null) {
                this.y[i3].setVisibility(0);
                if (abVar.b == 0) {
                    chat.ola.vn.c.t.a().b(str, this.y[i3], this.u);
                    if (size != 5) {
                        switch (size) {
                            case 1:
                                break;
                            case 2:
                                if (i3 == 0) {
                                    ((OlaRatioImageView) this.y[0]).setRatio(0.5625d);
                                }
                                if (i3 == 1) {
                                    ((OlaRatioImageView) this.y[1]).setRatio(0.5625d);
                                } else {
                                    continue;
                                }
                                break;
                            case 3:
                                if (i3 == 0) {
                                    ((OlaRatioImageView) this.y[0]).setRatio(1.0d);
                                }
                                if (i3 == 1) {
                                    ((OlaRatioImageView) this.y[1]).setRatio(1.0d);
                                }
                                if (i3 == 2) {
                                    ((OlaRatioImageView) this.y[2]).setRatio(1.7777777777777777d);
                                } else {
                                    continue;
                                }
                                break;
                            default:
                                if (i3 == 0) {
                                    ((OlaRatioImageView) this.y[0]).setRatio(1.0d);
                                }
                                if (i3 == 1) {
                                    ((OlaRatioImageView) this.y[1]).setRatio(1.0d);
                                }
                                if (i3 == 2) {
                                    olaRatioImageView = (OlaRatioImageView) this.y[2];
                                }
                                break;
                        }
                        olaRatioImageView.setRatio(1.0d);
                    } else {
                        if (i3 == 0) {
                            ((OlaRatioImageView) this.y[0]).setRatio(1.0d);
                        }
                        if (i3 == 1) {
                            ((OlaRatioImageView) this.y[1]).setRatio(1.0d);
                        }
                        if (i3 == 2) {
                            olaRatioImageView = (OlaRatioImageView) this.y[2];
                            olaRatioImageView.setRatio(1.0d);
                        }
                    }
                } else {
                    ((OlaRatioImageView) this.y[0]).setRatio(1.0d);
                    ((OlaRatioImageView) this.y[1]).setRatio(1.0d);
                    ((OlaRatioImageView) this.y[2]).setRatio(1.0d);
                    chat.ola.vn.c.t.a().e(str, this.y[i3]);
                }
            }
        }
    }
}
