package chat.ola.vn.entry.b;

import android.view.View;
import android.widget.ProgressBar;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaSnapPicViewerActivity;

/* JADX INFO: loaded from: classes.dex */
public class e extends f implements View.OnClickListener {
    private View t;
    private TextView u;
    private TextView v;
    private ProgressBar w;

    public e(View view, int i) {
        super(view);
        this.q.setLayoutResource(i);
        this.q.inflate();
        this.q.setVisibility(0);
        this.w = (ProgressBar) view.findViewById(R.id.timeRemainProgress);
        this.t = view.findViewById(R.id.snapPicViewLayout);
        this.t.setOnClickListener(this);
        this.u = (TextView) view.findViewById(R.id.snapPicTimeRemainTextView);
        this.v = (TextView) view.findViewById(R.id.snapPicTipTextView);
        try {
            this.i.setVisibility(8);
            this.e = this.d.getContext().getResources().getDimensionPixelSize(R.dimen.metric_6dp);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entry.b.f, chat.ola.vn.entry.b.b
    public void a(chat.ola.vn.message.d dVar, chat.ola.vn.message.d dVar2, chat.ola.vn.message.d dVar3) {
        TextView textView;
        StringBuilder sb;
        try {
            super.a(dVar, dVar2, dVar3);
            chat.ola.vn.message.t tVar = (chat.ola.vn.message.t) dVar;
            this.t.setTag(tVar);
            this.w.setMax(tVar.z);
            this.w.setProgress(tVar.A);
            if (tVar.A <= 0) {
                this.v.setVisibility(8);
                this.u.setVisibility(0);
                this.u.setText(R.string.string_already_viewed);
                this.w.setVisibility(8);
                return;
            }
            this.v.setVisibility(0);
            this.u.setVisibility(0);
            this.w.setVisibility(0);
            if (tVar.A > 1) {
                textView = this.u;
                sb = new StringBuilder();
                sb.append(chat.ola.vn.util.m.a(tVar.A));
                sb.append(" ");
                sb.append(OlaApplication.a(R.string.string_time_second_plural));
            } else {
                textView = this.u;
                sb = new StringBuilder();
                sb.append(chat.ola.vn.util.m.a(tVar.A));
                sb.append(" ");
                sb.append(OlaApplication.a(R.string.string_time_second));
            }
            textView.setText(sb.toString());
        } catch (Throwable unused) {
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            if (view.getId() != R.id.snapPicViewLayout) {
                return;
            }
            chat.ola.vn.message.t tVar = (chat.ola.vn.message.t) view.getTag();
            tVar.g();
            if (tVar.C() > 0) {
                OlaSnapPicViewerActivity.a(chat.ola.vn.c.c(), tVar);
            }
        } catch (Throwable unused) {
        }
    }
}
