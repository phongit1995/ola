package chat.ola.vn.i;

import android.content.Context;
import android.content.DialogInterface;
import android.os.Handler;
import android.text.format.Formatter;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.c.t;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class s extends n implements DialogInterface.OnDismissListener, View.OnClickListener {
    private ImageView a;
    private ProgressBar b;
    private TextView c;
    private TextView d;
    private TextView e;
    private Button f;
    private a g;
    private int h;
    private List<String> k;
    private List<chat.ola.vn.u.p> l;
    private Handler m;

    public interface a {
        void f(String str);
    }

    public s(Context context, a aVar) {
        super(context);
        a(context);
        this.g = aVar;
        this.m = new Handler();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(long j, long j2) {
        if (j2 != 0) {
            try {
                int i = (int) ((100 * j) / j2);
                this.c.setText(i + "%");
                this.b.setMax(100);
                this.b.setProgress(i);
            } catch (Throwable th) {
                th.printStackTrace();
                return;
            }
        }
        this.e.setText(Formatter.formatShortFileSize(getContext(), j) + "/" + Formatter.formatShortFileSize(getContext(), j2));
        this.d.setText(getContext().getString(R.string.message_remain_format, Integer.valueOf(this.k.size())));
    }

    private void a(Context context) {
        super.setOnDismissListener(this);
        setContentView(R.layout.upload_progress_dialog);
        getWindow().getAttributes().width = context.getResources().getDimensionPixelSize(R.dimen.general_dialog_width_max);
        this.a = (ImageView) findViewById(R.id.imgUploadThumbnail);
        this.b = (ProgressBar) findViewById(R.id.progressBar);
        this.e = (TextView) findViewById(R.id.txtSizeProgress);
        this.c = (TextView) findViewById(R.id.txtPercentProgress);
        this.d = (TextView) findViewById(R.id.txtProgress);
        this.f = (Button) findViewById(R.id.btnButton1);
        this.f.setOnClickListener(this);
        this.h = context.getResources().getDimensionPixelSize(R.dimen.metric_96dp);
    }

    public static void a(Context context, a aVar, List<String> list, short s) {
        try {
            s sVar = new s(context, aVar);
            sVar.setCancelable(false);
            sVar.a(list, s);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void a(List<String> list, short s) {
        if (list != null && list.size() > 0) {
            this.k = list;
            this.l = new ArrayList();
            for (final String str : list) {
                if (s == 0) {
                    s = chat.ola.vn.util.o.d(str);
                }
                this.l.add(chat.ola.vn.u.b.a().a(str, null, new chat.ola.vn.u.o() { // from class: chat.ola.vn.i.s.1
                    @Override // chat.ola.vn.u.o
                    public void a(final int i, final int i2) {
                        s.this.m.post(new Runnable() { // from class: chat.ola.vn.i.s.1.1
                            @Override // java.lang.Runnable
                            public void run() {
                                s.this.a(i, i2);
                            }
                        });
                    }

                    @Override // chat.ola.vn.u.o
                    public void a(final chat.ola.vn.entity.i iVar) {
                        s.this.m.post(new Runnable() { // from class: chat.ola.vn.i.s.1.2
                            @Override // java.lang.Runnable
                            public void run() {
                                if (iVar != null) {
                                    if (s.this.g != null) {
                                        s.this.g.f(iVar.d());
                                    }
                                    t.a().a(str, iVar.d());
                                }
                                if (s.this.k != null) {
                                    s.this.k.remove(str);
                                    if (s.this.k.isEmpty()) {
                                        s.this.dismiss();
                                    }
                                }
                            }
                        });
                    }

                    @Override // chat.ola.vn.u.o
                    public void a(final String str2) {
                        s.this.m.post(new Runnable() { // from class: chat.ola.vn.i.s.1.3
                            @Override // java.lang.Runnable
                            public void run() {
                                if (s.this.k != null) {
                                    s.this.k.remove(str2);
                                    if (s.this.k.isEmpty()) {
                                        s.this.dismiss();
                                    }
                                }
                            }
                        });
                    }

                    @Override // chat.ola.vn.u.o
                    public void a(String str2, int i) {
                    }

                    @Override // chat.ola.vn.u.o
                    public void a(final String str2, int i, String str3) {
                        s.this.m.post(new Runnable() { // from class: chat.ola.vn.i.s.1.6
                            @Override // java.lang.Runnable
                            public void run() {
                                if (s.this.k != null) {
                                    s.this.k.remove(str2);
                                    if (s.this.k.isEmpty()) {
                                        s.this.dismiss();
                                    }
                                }
                            }
                        });
                    }

                    @Override // chat.ola.vn.u.o
                    public void a(final String str2, String str3) {
                        s.this.m.post(new Runnable() { // from class: chat.ola.vn.i.s.1.5
                            @Override // java.lang.Runnable
                            public void run() {
                                if (s.this.k != null) {
                                    s.this.k.remove(str2);
                                    if (s.this.k.isEmpty()) {
                                        s.this.dismiss();
                                    }
                                }
                            }
                        });
                    }

                    @Override // chat.ola.vn.u.o
                    public void b(final String str2, String str3) {
                        s.this.m.post(new Runnable() { // from class: chat.ola.vn.i.s.1.4
                            @Override // java.lang.Runnable
                            public void run() {
                                if (s.this.k != null) {
                                    s.this.k.remove(str2);
                                    if (s.this.k.isEmpty()) {
                                        s.this.dismiss();
                                    }
                                }
                            }
                        });
                    }
                }));
            }
        }
        show();
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        if (view.getId() != R.id.btnButton1) {
            return;
        }
        if (this.l != null) {
            chat.ola.vn.u.b.a().a(this.l);
            this.l.clear();
        }
        dismiss();
    }

    @Override // android.content.DialogInterface.OnDismissListener
    public void onDismiss(DialogInterface dialogInterface) {
        if (this.l != null) {
            chat.ola.vn.u.b.a().a(this.l);
            this.l.clear();
        }
    }

    @Override // android.app.Dialog
    public void setOnDismissListener(DialogInterface.OnDismissListener onDismissListener) {
    }
}
