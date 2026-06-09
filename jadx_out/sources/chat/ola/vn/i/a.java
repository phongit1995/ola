package chat.ola.vn.i;

import android.content.Context;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.EditText;
import chat.ola.vn.R;
import chat.ola.vn.entity.t;

/* JADX INFO: loaded from: classes.dex */
public class a extends n implements View.OnClickListener {
    private EditText a;
    private EditText b;
    private t c;
    private Animation d;

    public a(Context context, t tVar) {
        super(context);
        getWindow().getAttributes().width = context.getResources().getDimensionPixelSize(R.dimen.general_dialog_width_max);
        this.c = tVar;
        setContentView(R.layout.bookmark_edit_input_layout);
        this.a = (EditText) findViewById(R.id.txtBookmarkTitle);
        this.b = (EditText) findViewById(R.id.txtBookmarkUrl);
        this.a.setText(tVar.l());
        this.b.setText(tVar.o());
        findViewById(R.id.btnButton1).setOnClickListener(this);
        findViewById(R.id.btnButton2).setOnClickListener(this);
        this.d = AnimationUtils.loadAnimation(context, R.anim.shake);
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        EditText editText;
        switch (view.getId()) {
            case R.id.btnButton1 /* 2131296429 */:
                if (this.a.length() != 0) {
                    if (this.b.length() != 0) {
                        String string = this.a.getText().toString();
                        String string2 = this.b.getText().toString();
                        this.c.b(string);
                        this.c.e(string2);
                        chat.ola.vn.h.s.h();
                        chat.ola.vn.h.s.g();
                    } else {
                        editText = this.b;
                    }
                    break;
                } else {
                    editText = this.a;
                }
                editText.startAnimation(this.d);
                return;
            case R.id.btnButton2 /* 2131296430 */:
                break;
            default:
                return;
        }
        dismiss();
    }
}
