package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ProgressBar;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;

/* JADX INFO: loaded from: classes.dex */
public class i extends j<chat.ola.vn.entry.e> {
    private LayoutInflater a;
    private int b;

    class a {
        OlaCachedImageView a;
        ProgressBar b;
        TextView c;
        TextView d;
        TextView e;
        TextView f;
        View g;
        View h;

        a() {
        }

        /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
        private void a(chat.ola.vn.entry.e eVar) {
            TextView textView;
            TextView textView2;
            String strP;
            if (eVar.c()) {
                if (chat.ola.vn.util.m.a(eVar.h())) {
                    this.e.setVisibility(8);
                    textView = this.e;
                    textView.setText("");
                } else {
                    this.e.setVisibility(0);
                    textView2 = this.e;
                    strP = eVar.h();
                    textView2.setText(strP);
                }
            }
            this.e.setVisibility(8);
            if (chat.ola.vn.util.m.a(eVar.p())) {
                this.f.setVisibility(8);
                textView = this.f;
                textView.setText("");
            } else {
                this.f.setVisibility(0);
                textView2 = this.f;
                strP = eVar.p();
                textView2.setText(strP);
            }
        }

        private void a(OlaCachedImageView olaCachedImageView, View view, String str) {
            chat.ola.vn.c.t.a().a(str, olaCachedImageView, view);
        }

        private void b(chat.ola.vn.entry.e eVar) {
            if (this.a != null) {
                if (!chat.ola.vn.util.m.a(eVar.b())) {
                    a(this.a, this.b, i.this.a(eVar.b(), i.this.b));
                } else if (eVar.i() > 0) {
                    this.a.setLoadingUrl(null);
                    this.a.setImageResource(eVar.i());
                } else {
                    this.a.setLoadingUrl(null);
                    this.a.setImageResource(R.drawable.ola_logo_trans);
                }
            }
        }

        void a(chat.ola.vn.entry.e eVar, chat.ola.vn.entry.e eVar2, chat.ola.vn.entry.e eVar3) {
            try {
                if (eVar.o() != 0) {
                    if (this.f != null) {
                        this.f.setVisibility(8);
                    }
                    this.d.setText(eVar.f());
                    return;
                }
                if (eVar3 == null || eVar3.o() != 1) {
                    this.h.setVisibility(0);
                } else {
                    this.h.setVisibility(8);
                }
                this.d.setText(eVar.f());
                String strN = eVar.n();
                if (chat.ola.vn.util.m.a(strN)) {
                    if (this.c != null) {
                        this.c.setVisibility(8);
                    }
                } else if (this.c != null) {
                    this.c.setVisibility(0);
                    this.c.setText(strN);
                }
                b(eVar);
                a(eVar);
            } catch (Throwable unused) {
            }
        }
    }

    public i(Context context) {
        super(context);
        this.a = (LayoutInflater) context.getSystemService("layout_inflater");
        this.b = context.getResources().getDimensionPixelSize(R.dimen.home_grid_icon_size);
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    public String a(String str, int i) {
        StringBuilder sb;
        String str2;
        if (str.contains("?")) {
            sb = new StringBuilder();
            sb.append(str);
            str2 = "&w=";
        } else {
            sb = new StringBuilder();
            sb.append(str);
            str2 = "?w=";
        }
        sb.append(str2);
        sb.append(i);
        return sb.toString();
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r7v10 */
    /* JADX WARN: Type inference failed for: r7v2, types: [int] */
    /* JADX WARN: Type inference failed for: r7v3 */
    /* JADX WARN: Type inference failed for: r7v6 */
    /* JADX WARN: Type inference failed for: r7v9 */
    /* JADX WARN: Type inference failed for: r8v0, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r8v1 */
    /* JADX WARN: Type inference failed for: r8v2, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r8v3 */
    /* JADX WARN: Type inference failed for: r8v31 */
    /* JADX WARN: Type inference failed for: r8v32 */
    /* JADX WARN: Type inference failed for: r8v4 */
    /* JADX WARN: Type inference failed for: r8v8, types: [android.view.View] */
    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        chat.ola.vn.entry.e item;
        chat.ola.vn.entry.e item2;
        a aVar;
        try {
            chat.ola.vn.entry.e item3 = getItem(i);
            try {
                item = getItem(i - 1);
            } catch (Throwable unused) {
                item = null;
            }
            try {
                item2 = getItem(i + 1);
            } catch (Throwable unused2) {
                item2 = null;
            }
            if (view == 0) {
                aVar = new a();
                ?? itemViewType = getItemViewType(i);
                try {
                    if (itemViewType == 0) {
                        View viewInflate = this.a.inflate(R.layout.home_icon_item, (ViewGroup) null);
                        aVar.h = viewInflate.findViewById(R.id.bottomDividerView);
                        aVar.g = viewInflate.findViewById(R.id.notificationViewLayout);
                        aVar.a = (OlaCachedImageView) viewInflate.findViewById(R.id.notificationIconImageView);
                        aVar.d = (TextView) viewInflate.findViewById(R.id.notificationTitleTextView);
                        aVar.c = (TextView) viewInflate.findViewById(R.id.notificationSubtitleTextView);
                        aVar.e = (TextView) viewInflate.findViewById(R.id.notificationNumberTextView);
                        aVar.f = (TextView) viewInflate.findViewById(R.id.notificationCaptionTextView);
                        aVar.b = (ProgressBar) viewInflate.findViewById(R.id.notificationIconProgressBar);
                        itemViewType = viewInflate;
                    } else {
                        View viewInflate2 = this.a.inflate(R.layout.list_view_section_item_layout, (ViewGroup) null);
                        aVar.d = (TextView) viewInflate2.findViewById(R.id.labelTextView);
                        itemViewType = viewInflate2;
                    }
                    ?? r8 = itemViewType;
                    r8.setTag(aVar);
                    view = r8;
                } catch (Throwable unused3) {
                    view = itemViewType;
                }
            } else {
                aVar = (a) view.getTag();
                view = view;
            }
            aVar.a(item3, item, item2);
        } catch (Throwable unused4) {
        }
        return view == 0 ? viewGroup : view;
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entry.e getItem(int i) {
        try {
            return chat.ola.vn.h.v.a(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            return chat.ola.vn.h.v.j();
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getItemViewType(int i) {
        return getItem(i).o();
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getViewTypeCount() {
        return 2;
    }
}
