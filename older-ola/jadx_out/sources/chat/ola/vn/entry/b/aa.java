package chat.ola.vn.entry.b;

import android.annotation.TargetApi;
import android.view.View;
import android.widget.ListAdapter;
import chat.ola.vn.R;
import it.sephiroth.android.library.widget.HListView;

/* JADX INFO: loaded from: classes.dex */
public class aa extends j {
    public static boolean l = true;
    View i;
    HListView j;
    chat.ola.vn.b.w k;

    private void e() {
        try {
            if (this.a != null) {
                this.i.setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.entry.b.aa.1
                    @Override // android.view.View.OnClickListener
                    public void onClick(View view) {
                        view.setTag(aa.this.b);
                        aa.this.a.onClick(view);
                    }
                });
                this.k.a(this.a);
                this.k.a(this.e);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entry.b.j
    @TargetApi(11)
    public void a() {
        try {
            if (this.b == null) {
                return;
            }
            e();
            if (!l || this.b.b.d == null || this.b.b.d.size() <= 0) {
                return;
            }
            this.k.a(this.b.b.d);
            this.j.c(0);
            l = false;
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entry.b.j
    public void a(View view) {
        super.a(view);
        view.setClickable(true);
        l = true;
        this.i = view.findViewById(R.id.viewAllTextView);
        this.j = (HListView) view.findViewById(R.id.suggestedFriendList);
        try {
            this.k = new chat.ola.vn.b.w(view.getContext());
            this.j.setAdapter((ListAdapter) this.k);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entry.b.j
    public void a(boolean z) {
        super.a(z);
    }
}
