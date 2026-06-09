package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class h extends j<chat.ola.vn.entry.b> {
    protected LayoutInflater a;
    protected View.OnClickListener b;
    protected List<chat.ola.vn.entry.b> c;
    protected View.OnLongClickListener d;

    public h(Context context) {
        super(context);
        this.a = LayoutInflater.from(context);
    }

    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        chat.ola.vn.entry.b.j jVarA;
        try {
            if (view == null) {
                int itemViewType = getItemViewType(i);
                if (itemViewType == -1) {
                    return new View(b());
                }
                jVarA = chat.ola.vn.entry.b.i.a(itemViewType, view, this.a);
                view = jVarA.c();
            } else {
                jVarA = (chat.ola.vn.entry.b.j) view.getTag();
            }
            chat.ola.vn.entry.b item = getItem(i);
            jVarA.a(this.b);
            jVarA.a(this.d);
            jVarA.a(item);
            jVarA.b();
            jVarA.a();
            jVarA.a(false);
            a(i, jVarA, item);
        } catch (Throwable unused) {
        }
        return view == null ? viewGroup : view;
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entry.b getItem(int i) {
        try {
            return this.c.get(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    protected void a(int i, chat.ola.vn.entry.b.j jVar, chat.ola.vn.entry.b bVar) {
    }

    public void a(View.OnClickListener onClickListener) {
        this.b = onClickListener;
    }

    public void a(View.OnLongClickListener onLongClickListener) {
        this.d = onLongClickListener;
    }

    public void a(List<chat.ola.vn.entry.b> list) {
        this.c = list;
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            return this.c.size();
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public long getItemId(int i) {
        return i;
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getItemViewType(int i) {
        try {
            return getItem(i).d();
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getViewTypeCount() {
        return 10;
    }
}
