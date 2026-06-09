package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.animation.Animation;
import android.widget.BaseAdapter;

/* JADX INFO: loaded from: classes.dex */
public class o extends BaseAdapter {
    private LayoutInflater a;
    private View.OnClickListener b;
    private View.OnLongClickListener c;
    private Context d;
    private chat.ola.vn.message.f e;
    private Animation f;
    private Animation g;
    private Animation h;

    public o(Context context, chat.ola.vn.message.f fVar) {
        this.a = (LayoutInflater) context.getSystemService("layout_inflater");
        this.d = context;
        this.e = fVar;
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.message.d getItem(int i) {
        try {
            if (this.e == null) {
                return null;
            }
            return this.e.b(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(View.OnClickListener onClickListener) {
        this.b = onClickListener;
    }

    public void a(View.OnLongClickListener onLongClickListener) {
        this.c = onLongClickListener;
    }

    public void a(chat.ola.vn.message.f fVar) {
        this.e = fVar;
    }

    @Override // android.widget.Adapter
    public int getCount() {
        try {
            return this.e.K();
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // android.widget.Adapter
    public long getItemId(int i) {
        return i;
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getItemViewType(int i) {
        chat.ola.vn.message.d item = getItem(i);
        return item.e() + (item.d() * 19);
    }

    /* JADX WARN: Removed duplicated region for block: B:46:0x00bb A[Catch: Throwable -> 0x0102, TryCatch #2 {Throwable -> 0x0102, blocks: (B:30:0x0066, B:32:0x0071, B:34:0x0075, B:35:0x007b, B:37:0x0080, B:39:0x0084, B:40:0x0094, B:41:0x009b, B:42:0x009f, B:44:0x00a3, B:45:0x00b3, B:46:0x00bb, B:47:0x00c1, B:49:0x00cc, B:51:0x00d0, B:53:0x00d6, B:54:0x00e6, B:55:0x00ea, B:57:0x00ee), top: B:75:0x0061 }] */
    @Override // android.widget.Adapter
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public android.view.View getView(int r18, android.view.View r19, android.view.ViewGroup r20) {
        /*
            Method dump skipped, instruction units count: 288
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.b.o.getView(int, android.view.View, android.view.ViewGroup):android.view.View");
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getViewTypeCount() {
        return 57;
    }
}
