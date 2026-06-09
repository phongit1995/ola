package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import chat.ola.vn.R;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class g extends j<chat.ola.vn.entity.e> {
    protected LayoutInflater a;
    protected List<chat.ola.vn.entity.e> b;
    protected View.OnClickListener c;
    protected View.OnLongClickListener d;
    private int g;

    public g(Context context) {
        super(context);
        this.a = LayoutInflater.from(context);
    }

    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        chat.ola.vn.entity.e item = getItem(i);
        int iE = item.E();
        if (view == null) {
            view = chat.ola.vn.entry.b.h.a(this.a, viewGroup, iE);
        }
        chat.ola.vn.entry.b.h hVar = (chat.ola.vn.entry.b.h) view.getTag();
        hVar.a(this.c);
        hVar.a(this.d);
        hVar.a(item);
        try {
            if (hVar.b != null && (iE == 100 || iE == 102 || iE == 101 || iE == 6)) {
                if (i != 0) {
                    if (i != getCount() - 1) {
                        int iE2 = getItem(i - 1).E();
                        int iE3 = getItem(i + 1).E();
                        if (iE2 != 2 && iE2 != 0 && iE2 != -6 && iE2 != -2) {
                            if (iE3 != 2) {
                                hVar.b.setBackgroundResource(R.drawable.bg_me_comment_item);
                            }
                        }
                    }
                    hVar.b.setBackgroundResource(R.drawable.bg_me_comment_item_footer);
                    return view;
                }
                hVar.b.setBackgroundResource(R.drawable.bg_me_comment_top_item);
                return view;
            }
        } catch (Throwable unused) {
        }
        return view;
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entity.e getItem(int i) {
        return this.b.get(i);
    }

    public void a(View.OnClickListener onClickListener) {
        this.c = onClickListener;
    }

    public void a(View.OnLongClickListener onLongClickListener) {
        this.d = onLongClickListener;
    }

    public void a(List<chat.ola.vn.entity.e> list) {
        this.b = list;
    }

    public void b(int i) {
        this.g = i;
    }

    public void b(List<chat.ola.vn.entity.e> list) {
        if (list == null) {
            return;
        }
        if (this.b == null) {
            this.b = new ArrayList();
        }
        this.b.clear();
        for (chat.ola.vn.entity.e eVar : list) {
            this.b.add(eVar);
            List<chat.ola.vn.entity.e> listW = eVar.w();
            if (listW != null) {
                this.b.addAll(listW);
            }
        }
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        if (this.b == null) {
            return 0;
        }
        return this.b.size();
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getItemViewType(int i) {
        return chat.ola.vn.entry.b.h.a(getItem(i).E()) + this.g;
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getViewTypeCount() {
        return chat.ola.vn.entry.b.h.a();
    }
}
