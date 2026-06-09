package chat.ola.vn.entry.a;

import android.content.Context;
import android.content.res.Resources;
import android.view.View;
import android.widget.AdapterView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.i.m;
import java.util.ArrayList;
import java.util.Collections;

/* JADX INFO: loaded from: classes.dex */
public class d extends c<String> {
    private String[] f;
    private String[] g;

    public d(short s, String str, String str2, int i, int i2, String str3) {
        super(s, (short) 1, str, str2, str3);
        try {
            this.g = OlaApplication.b().getStringArray(i2);
            this.f = OlaApplication.b().getStringArray(i);
        } catch (Resources.NotFoundException e) {
            e.printStackTrace();
        }
    }

    private boolean b(Context context) {
        if (this.f == null || this.g == null || this.f.length != this.g.length) {
            return false;
        }
        ArrayList arrayList = new ArrayList();
        Collections.addAll(arrayList, this.f);
        final m mVar = new m(context);
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.entry.a.d.1
            /* JADX WARN: Multi-variable type inference failed */
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                d.this.d = d.this.g[i];
                if (d.this.e != null) {
                    d.this.e.a(d.this, d.this.d);
                }
                mVar.dismiss();
            }
        });
        mVar.show();
        return true;
    }

    @Override // chat.ola.vn.entry.a.c
    public boolean a(Context context) {
        return b(context);
    }

    /* JADX WARN: Multi-variable type inference failed */
    public String f() {
        int length = this.g.length;
        for (int i = 0; i < length; i++) {
            if (chat.ola.vn.util.m.b(this.g[i], (String) this.d)) {
                return this.f[i];
            }
        }
        return (String) this.d;
    }
}
