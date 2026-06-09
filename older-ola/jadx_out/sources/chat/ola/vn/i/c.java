package chat.ola.vn.i;

import android.content.Context;
import android.content.DialogInterface;
import android.graphics.Color;
import android.os.CountDownTimer;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import chat.ola.vn.R;
import com.mg.ola.common.widget.ProgressCircleView;

/* JADX INFO: loaded from: classes.dex */
public class c extends n implements View.OnClickListener {
    private ProgressCircleView a;
    private TextView b;
    private Button c;
    private Button d;
    private long e;
    private DialogInterface.OnClickListener f;
    private View g;
    private CountDownTimer h;

    public c(Context context) {
        super(context);
        this.e = 100L;
        try {
            requestWindowFeature(1);
            setCanceledOnTouchOutside(false);
            setContentView(R.layout.dialog_circle_progress_layout);
            getWindow().getAttributes().height = -2;
            getWindow().getAttributes().width = context.getResources().getDimensionPixelSize(R.dimen.general_dialog_width_max);
            this.a = (ProgressCircleView) findViewById(R.id.progressBar);
            this.a.setRadius(50);
            this.a.setStrokeWidth(8.0f);
            this.a.a(Color.parseColor("#379cf1"), Color.parseColor("#40379cf1"));
            this.g = findViewById(R.id.linearFooter);
            this.b = (TextView) findViewById(R.id.txtMessage);
            this.c = (Button) findViewById(R.id.button1);
            this.d = (Button) findViewById(R.id.button2);
            this.g.setVisibility(8);
            this.c.setVisibility(8);
            this.d.setVisibility(8);
            this.c.setOnClickListener(this);
            this.d.setOnClickListener(this);
        } catch (Throwable unused) {
        }
    }

    public void a() {
        try {
            if (this.h != null) {
                this.h.cancel();
            }
            dismiss();
        } catch (Throwable unused) {
        }
    }

    public void a(int i) {
        try {
            this.b.setText(i);
        } catch (Throwable unused) {
        }
    }

    public void a(final long j, final Runnable runnable) {
        try {
            this.a.setProgress(0L);
            this.h = new CountDownTimer(j, j / 100 == 0 ? j : j / 100) { // from class: chat.ola.vn.i.c.1
                @Override // android.os.CountDownTimer
                public void onFinish() {
                    try {
                        if (c.this.a != null) {
                            c.this.a.setProgress(100L);
                        }
                        c.this.dismiss();
                        if (runnable != null) {
                            runnable.run();
                        }
                    } catch (Throwable unused) {
                    }
                }

                @Override // android.os.CountDownTimer
                public void onTick(long j2) {
                    try {
                        c.this.a.setProgress((int) (((j - j2) * 100) / j));
                    } catch (Throwable unused) {
                    }
                }
            };
            this.h.start();
            show();
        } catch (Throwable unused) {
            if (!isShowing() || this.h == null) {
                return;
            }
            dismiss();
        }
    }

    public void a(String str) {
        try {
            this.b.setText(str);
        } catch (Throwable unused) {
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        DialogInterface.OnClickListener onClickListener;
        int i;
        if (this.f == null) {
            return;
        }
        switch (view.getId()) {
            case R.id.button1 /* 2131296567 */:
                onClickListener = this.f;
                i = 0;
                break;
            case R.id.button2 /* 2131296568 */:
                onClickListener = this.f;
                i = 1;
                break;
            default:
                dismiss();
        }
        onClickListener.onClick(this, i);
        dismiss();
    }
}
