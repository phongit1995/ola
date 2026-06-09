package chat.ola.vn.i;

import android.content.Context;
import android.content.DialogInterface;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class p extends n implements View.OnClickListener {
    protected EditText a;
    private TextView b;
    private Button c;
    private Button d;
    private View e;
    private DialogInterface.OnClickListener f;
    private ImageView g;
    private Animation h;
    private a k;

    public interface a {
        boolean a(String str);
    }

    public p(Context context) {
        super(context);
        setContentView(R.layout.dialog_text_input_layout);
        getWindow().setSoftInputMode(4);
        getWindow().getAttributes().width = context.getResources().getDimensionPixelSize(R.dimen.general_dialog_width_max);
        this.b = (TextView) findViewById(R.id.txtItemTitle);
        this.g = (ImageView) findViewById(R.id.imgDialogIcon);
        this.a = (EditText) findViewById(R.id.txtMeItemContent);
        this.c = (Button) findViewById(R.id.btnButton1);
        this.d = (Button) findViewById(R.id.btnButton2);
        this.e = findViewById(R.id.linearFooter);
        this.e.setVisibility(8);
        this.c.setVisibility(8);
        this.d.setVisibility(8);
        this.c.setOnClickListener(this);
        this.d.setOnClickListener(this);
        this.h = AnimationUtils.loadAnimation(context, R.anim.shake);
    }

    public String a() {
        try {
            String string = this.a.getText().toString();
            if (!chat.ola.vn.util.m.a(string) && (this.k == null || this.k.a(string))) {
                return string;
            }
            this.a.startAnimation(this.h);
        } catch (Throwable unused) {
        }
        return null;
    }

    public void a(int i) {
        this.g.setImageResource(i);
    }

    public void a(DialogInterface.OnClickListener onClickListener) {
        this.f = onClickListener;
    }

    public void a(a aVar) {
        this.k = aVar;
    }

    public void a(String str) {
        this.a.setText(str);
    }

    public void b(int i) {
        this.a.setInputType(i);
    }

    public void b(String str) {
        if (chat.ola.vn.util.m.a(str)) {
            return;
        }
        this.e.setVisibility(0);
        this.c.setVisibility(0);
        this.c.setText(str);
    }

    public String c() {
        try {
            return this.a.getText().toString();
        } catch (Throwable unused) {
            return null;
        }
    }

    public void c(String str) {
        if (chat.ola.vn.util.m.a(str)) {
            return;
        }
        this.a.setHint(str);
    }

    public void d(String str) {
        if (chat.ola.vn.util.m.a(str)) {
            return;
        }
        this.e.setVisibility(0);
        this.d.setVisibility(0);
        this.d.setText(str);
    }

    @Override // chat.ola.vn.i.n, android.app.Dialog, android.content.DialogInterface
    public void dismiss() {
        this.a.clearFocus();
        chat.ola.vn.util.o.a(getContext(), (View) this.a, false);
        super.dismiss();
    }

    public void e(String str) {
        if (chat.ola.vn.util.m.a(str)) {
            str = "";
        }
        this.a.setText(str);
        this.a.setSelection(0, this.a.length());
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        DialogInterface.OnClickListener onClickListener;
        int i;
        if (this.f == null) {
            return;
        }
        switch (view.getId()) {
            case R.id.btnButton1 /* 2131296429 */:
                onClickListener = this.f;
                i = 0;
                break;
            case R.id.btnButton2 /* 2131296430 */:
                onClickListener = this.f;
                i = 1;
                break;
            default:
                return;
        }
        onClickListener.onClick(this, i);
    }

    @Override // android.app.Dialog
    public void setTitle(int i) {
        this.b.setText(i);
    }

    @Override // android.app.Dialog
    public void setTitle(CharSequence charSequence) {
        this.b.setText(charSequence);
    }

    @Override // chat.ola.vn.i.n, android.app.Dialog
    public void show() {
        super.show();
    }
}
