package chat.ola.vn.b;

import android.content.Context;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class v extends h {
    public v(Context context) {
        super(context);
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    @Override // chat.ola.vn.b.h
    protected void a(int i, chat.ola.vn.entry.b.j jVar, chat.ola.vn.entry.b bVar) {
        jVar.a(i == 0 ? R.drawable.bg_shadow_2_edges : i == 1 ? bVar.b.j() ? R.drawable.bg_me_comment_top_hightlight_item : R.drawable.bg_me_comment_top_item : bVar.b.j() ? R.drawable.bg_me_comment_item_highlight : R.drawable.bg_me_comment_item);
    }

    @Override // android.widget.BaseAdapter
    public void notifyDataSetChanged() {
        try {
            this.c = chat.ola.vn.h.u.q();
            super.notifyDataSetChanged();
        } catch (Throwable unused) {
        }
    }
}
