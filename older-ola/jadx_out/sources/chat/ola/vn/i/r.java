package chat.ola.vn.i;

import android.content.Context;
import android.view.View;
import android.widget.ArrayAdapter;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaSuggestEditText;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class r extends p {
    protected View b;

    public r(Context context) {
        super(context);
        this.b = findViewById(R.id.btnDropdown);
        this.b.setOnClickListener(this);
    }

    public r a(List<String> list) {
        View view;
        int i;
        if (list != null) {
            Context context = getContext();
            if (list == null) {
                list = new ArrayList<>();
            }
            ((OlaSuggestEditText) this.a).setAdapter(new ArrayAdapter(context, android.R.layout.simple_list_item_1, list));
            view = this.b;
            i = 0;
        } else {
            view = this.b;
            i = 8;
        }
        view.setVisibility(i);
        return this;
    }

    @Override // chat.ola.vn.i.p, android.view.View.OnClickListener
    public void onClick(View view) {
        super.onClick(view);
        if (view.getId() != R.id.btnDropdown) {
            return;
        }
        ((OlaSuggestEditText) this.a).a();
        try {
            chat.ola.vn.util.o.a(getContext(), (View) this.a, true);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override // android.app.Dialog
    public void setContentView(int i) {
        super.setContentView(R.layout.dialog_text_suggest_input_layout);
    }
}
