package chat.ola.vn.entry.b;

import android.content.DialogInterface;
import android.view.View;
import android.widget.AdapterView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import com.mg.ola.common.widget.OlaTextView;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class k extends l implements View.OnLongClickListener {
    public OlaTextView a;

    public k(View view) {
        super(view);
        this.a = (OlaTextView) view;
        this.a.setOlaSpanClickListener(chat.ola.vn.q.a.a());
        this.a.setOnLongClickListener(this);
    }

    @Override // chat.ola.vn.entry.b.l
    public void a(chat.ola.vn.entry.c cVar, int i) {
        this.a.setText(cVar.d());
        this.a.setTextSize(2, this.d);
        try {
            this.a.setBackgroundColor(chat.ola.vn.f.g);
        } catch (Throwable unused) {
        }
    }

    @Override // android.view.View.OnLongClickListener
    public boolean onLongClick(View view) {
        try {
            final String string = this.a.getText().toString();
            if (chat.ola.vn.util.m.a(string)) {
                return false;
            }
            this.a.setBackgroundColor(chat.ola.vn.f.G);
            final ArrayList arrayList = new ArrayList();
            arrayList.add(OlaApplication.a(R.string.string_copy));
            arrayList.add(OlaApplication.a(R.string.string_copy_plus));
            chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(chat.ola.vn.c.c());
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.entry.b.k.1
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view2, int i, long j) {
                    String str;
                    try {
                        String str2 = (String) arrayList.get(i);
                        if (chat.ola.vn.util.m.b(str2, OlaApplication.a(R.string.string_copy))) {
                            chat.ola.vn.util.o.a(chat.ola.vn.c.c(), string);
                            return;
                        }
                        if (!chat.ola.vn.util.m.b(str2, OlaApplication.a(R.string.string_copy_plus))) {
                            if (chat.ola.vn.util.m.b(str2, OlaApplication.a(R.string.general_tab_translater))) {
                                chat.ola.vn.m.z.a(chat.ola.vn.c.c(), string);
                                return;
                            }
                            return;
                        }
                        String strA = chat.ola.vn.util.o.a(chat.ola.vn.c.c());
                        if (chat.ola.vn.util.m.a(strA)) {
                            str = string;
                        } else {
                            str = strA + " " + string;
                        }
                        chat.ola.vn.util.o.a(chat.ola.vn.c.c(), str);
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.setOnDismissListener(new DialogInterface.OnDismissListener() { // from class: chat.ola.vn.entry.b.k.2
                @Override // android.content.DialogInterface.OnDismissListener
                public void onDismiss(DialogInterface dialogInterface) {
                    try {
                        k.this.a.setBackgroundColor(chat.ola.vn.f.g);
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }
}
