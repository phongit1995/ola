package chat.ola.vn.i;

import android.content.Context;
import android.view.View;
import android.widget.TextView;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class j extends n implements View.OnClickListener {
    private a a;

    public interface a {
        void a();
    }

    public j(Context context, boolean z, a aVar) {
        TextView textView;
        int i;
        super(context);
        setContentView(R.layout.logout_confirm_dialog_layout);
        try {
            if (z) {
                textView = (TextView) findViewById(R.id.txtMeItemContent);
                i = R.string.message_logout_all_confirm;
            } else {
                textView = (TextView) findViewById(R.id.txtMeItemContent);
                i = R.string.message_logout_confirm;
            }
            textView.setText(i);
        } catch (Throwable unused) {
        }
        getWindow().getAttributes().width = context.getResources().getDimensionPixelSize(R.dimen.general_dialog_width_max);
        findViewById(R.id.btnButton1).setOnClickListener(this);
        findViewById(R.id.btnButton2).setOnClickListener(this);
        this.a = aVar;
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.btnButton1 /* 2131296429 */:
                if (this.a != null) {
                    this.a.a();
                }
                break;
            case R.id.btnButton2 /* 2131296430 */:
                break;
            default:
                return;
        }
        dismiss();
    }
}
