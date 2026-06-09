package chat.ola.vn.i;

import android.content.Context;
import android.graphics.Bitmap;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class b extends n implements View.OnClickListener {
    private TextView a;
    private TextView b;
    private ImageView c;
    private EditText d;
    private Button e;

    public b(Context context, String str, String str2, Bitmap bitmap) {
        super(context);
        setContentView(R.layout.captcha_required_dialog_layout);
        getWindow().setSoftInputMode(4);
        getWindow().getAttributes().width = context.getResources().getDimensionPixelSize(R.dimen.general_dialog_width_max);
        setCancelable(false);
        this.a = (TextView) findViewById(R.id.txtItemTitle);
        this.b = (TextView) findViewById(R.id.txtDeleteConversationMessageHistory);
        this.c = (ImageView) findViewById(R.id.imgCapcharImage);
        this.c.setImageBitmap(bitmap);
        this.d = (EditText) findViewById(R.id.txtCaptchaInput);
        this.e = (Button) findViewById(R.id.btnButton1);
        this.a.setText(str);
        this.b.setText(str2);
        this.e.setOnClickListener(this);
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        if (view.getId() != R.id.btnButton1) {
            return;
        }
        try {
            String string = this.d.getText().toString();
            if (chat.ola.vn.util.m.a(string)) {
                return;
            }
            try {
                chat.ola.vn.util.o.a(getContext(), (View) this.d, false);
            } catch (Throwable unused) {
            }
            OlaApplication.b.y(string);
            dismiss();
        } catch (Throwable unused2) {
        }
    }
}
