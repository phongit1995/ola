package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import chat.ola.vn.R;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class u extends j<chat.ola.vn.entry.b> {
    private LayoutInflater a;
    private View.OnClickListener b;
    private List<chat.ola.vn.entry.b> c;
    private chat.ola.vn.entry.b d;
    private chat.ola.vn.r.a.e g;
    private View.OnLongClickListener h;

    public u(Context context) {
        this(context, null);
    }

    public u(Context context, chat.ola.vn.r.a.e eVar) {
        super(context);
        this.a = LayoutInflater.from(context);
        this.g = eVar;
    }

    private View a(View view, int i) {
        View viewInflate;
        Exception e;
        if (view != null) {
            return view;
        }
        try {
            viewInflate = this.a.inflate(R.layout.chat_item_time_line, (ViewGroup) null);
        } catch (Exception e2) {
            viewInflate = view;
            e = e2;
        }
        try {
            ((TextView) viewInflate.findViewById(R.id.messageTimeText)).setText(R.string.string_readed);
            return viewInflate;
        } catch (Exception e3) {
            e = e3;
            e.printStackTrace();
            return viewInflate;
        }
    }

    /* JADX WARN: Can't wrap try/catch for region: R(8:(1:20)(10:49|23|26|46|27|(1:32)(1:31)|45|33|SW:34|(1:40)(1:41))|21|22|26|46|27|(5:29|32|45|33|SW:34)(0)|(0)(0)) */
    /* JADX WARN: Removed duplicated region for block: B:32:0x00a6 A[Catch: Throwable -> 0x00ac, TRY_LEAVE, TryCatch #1 {Throwable -> 0x00ac, blocks: (B:27:0x0081, B:29:0x0085, B:31:0x008a, B:32:0x00a6), top: B:46:0x0081 }] */
    /* JADX WARN: Removed duplicated region for block: B:35:0x00bc A[Catch: Throwable -> 0x00c4, TRY_LEAVE, TryCatch #2 {Throwable -> 0x00c4, blocks: (B:2:0x0000, B:4:0x0007, B:8:0x000f, B:10:0x0015, B:15:0x0031, B:17:0x0045, B:20:0x0063, B:21:0x0069, B:26:0x007d, B:33:0x00ac, B:34:0x00b9, B:35:0x00bc, B:25:0x0076, B:23:0x006f), top: B:48:0x0000, inners: #3 }] */
    /* JADX WARN: Removed duplicated region for block: B:40:0x00ca A[RETURN] */
    /* JADX WARN: Removed duplicated region for block: B:41:0x00cb A[RETURN] */
    @Override // chat.ola.vn.b.j
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public android.view.View a(int r7, android.view.View r8, android.view.ViewGroup r9) {
        /*
            Method dump skipped, instruction units count: 220
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.b.u.a(int, android.view.View, android.view.ViewGroup):android.view.View");
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entry.b getItem(int i) {
        int i2;
        if (this.d != null) {
            i2 = 1;
            if (i == 0) {
                return this.d;
            }
        } else {
            i2 = 0;
        }
        try {
            return this.c.get(i - i2);
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    public void a(View.OnClickListener onClickListener) {
        this.b = onClickListener;
    }

    public void a(View.OnLongClickListener onLongClickListener) {
        this.h = onLongClickListener;
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        int i = this.d != null ? 1 : 0;
        try {
            return this.c == null ? i : this.c.size() + i;
        } catch (Throwable unused) {
            return i;
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

    @Override // android.widget.BaseAdapter
    public void notifyDataSetChanged() {
        chat.ola.vn.r.a.e eVar = this.g;
        if (eVar == null) {
            eVar = chat.ola.vn.h.u;
        }
        this.d = eVar.f();
        if (this.c == null) {
            this.c = new ArrayList();
        }
        this.c.clear();
        if (eVar.i() != null) {
            this.c.addAll(eVar.i());
        }
        super.notifyDataSetChanged();
    }
}
