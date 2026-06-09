package chat.ola.vn.i;

import android.content.Context;
import android.content.DialogInterface;
import android.graphics.Bitmap;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class g extends n implements View.OnClickListener {
    protected TextView a;
    protected TextView b;
    protected Button c;
    protected Button d;
    protected View e;
    protected DialogInterface.OnClickListener f;
    protected ImageView g;
    protected CheckBox h;

    public g(Context context) {
        super(context);
        setContentView(R.layout.confirm_dialog_layout);
        getWindow().getAttributes().width = context.getResources().getDimensionPixelSize(R.dimen.general_dialog_width_max);
        this.a = (TextView) findViewById(R.id.txtItemTitle);
        this.b = (TextView) findViewById(R.id.txtMeItemContent);
        this.c = (Button) findViewById(R.id.btnButton1);
        this.d = (Button) findViewById(R.id.btnButton2);
        this.g = (ImageView) findViewById(R.id.imgVipIcon);
        this.h = (CheckBox) findViewById(R.id.ckbCheckBox);
        this.e = findViewById(R.id.linearFooter);
        this.e.setVisibility(8);
        this.c.setVisibility(8);
        this.d.setVisibility(8);
        this.c.setOnClickListener(this);
        this.d.setOnClickListener(this);
    }

    public void a(int i) {
        this.e.setVisibility(0);
        this.c.setVisibility(0);
        this.c.setText(i);
    }

    public void a(DialogInterface.OnClickListener onClickListener) {
        this.f = onClickListener;
    }

    public void a(Bitmap bitmap) {
        this.g.setVisibility(0);
        this.g.setImageBitmap(bitmap);
    }

    public void a(CharSequence charSequence) {
        this.b.setText(charSequence);
    }

    public void a(String str) {
        this.e.setVisibility(0);
        this.c.setVisibility(0);
        this.c.setText(str);
    }

    public void b(int i) {
        this.e.setVisibility(0);
        this.d.setVisibility(0);
        this.d.setText(i);
    }

    public void b(String str) {
        this.e.setVisibility(0);
        this.d.setVisibility(0);
        this.d.setText(str);
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
        this.a.setText(i);
    }

    @Override // android.app.Dialog
    public void setTitle(CharSequence charSequence) {
        this.a.setText(charSequence);
    }
}
