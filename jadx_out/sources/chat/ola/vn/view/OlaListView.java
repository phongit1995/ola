package chat.ola.vn.view;

import android.content.Context;
import android.util.AttributeSet;
import android.widget.BaseAdapter;
import android.widget.ListAdapter;
import android.widget.ListView;

/* JADX INFO: loaded from: classes.dex */
public class OlaListView extends ListView {
    boolean a;
    protected ListAdapter b;

    public OlaListView(Context context) {
        super(context);
        this.a = false;
        this.b = null;
    }

    public OlaListView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.a = false;
        this.b = null;
    }

    public OlaListView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.a = false;
        this.b = null;
    }

    @Override // android.widget.ListView, android.widget.AbsListView
    protected void layoutChildren() {
        try {
            super.layoutChildren();
            this.a = false;
        } catch (IllegalStateException unused) {
            if (this.a) {
                return;
            }
            try {
                this.a = true;
                ((BaseAdapter) this.b).notifyDataSetChanged();
            } catch (Throwable unused2) {
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // android.widget.AdapterView
    public void setAdapter(ListAdapter listAdapter) {
        super.setAdapter(listAdapter);
        this.b = listAdapter;
    }
}
