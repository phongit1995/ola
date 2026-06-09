package chat.ola.vn.i;

import android.content.Context;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.TextView;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class h extends n implements View.OnClickListener {
    private TextView a;
    private TextView b;
    private Button c;
    private Button d;
    private CheckBox e;
    private a f;

    public interface a {
        void a(boolean z);
    }

    public h(Context context, String str, String str2, a aVar) {
        super(context);
        setContentView(R.layout.delete_conversation_confirm_dialog_layout);
        getWindow().getAttributes().width = context.getResources().getDimensionPixelSize(R.dimen.general_dialog_width_max);
        this.a = (TextView) findViewById(R.id.txtItemTitle);
        this.b = (TextView) findViewById(R.id.txtDeleteConversationMessageHistory);
        this.c = (Button) findViewById(R.id.btnButton1);
        this.d = (Button) findViewById(R.id.btnButton2);
        this.e = (CheckBox) findViewById(R.id.ckbDeleteConversationContentHistory);
        this.a.setText(str);
        this.b.setText(str2);
        this.c.setText(R.string.string_delete);
        this.d.setText(R.string.string_no);
        this.f = aVar;
        this.c.setOnClickListener(this);
        this.d.setOnClickListener(this);
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.btnButton1 /* 2131296429 */:
                if (this.f != null) {
                    this.f.a(this.e.isChecked());
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
