package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.R;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class ad extends j<chat.ola.vn.entity.ah> {
    private LayoutInflater a;
    private View.OnClickListener b;
    private boolean c;
    private List<chat.ola.vn.entity.ah> d;
    private int g;
    private String h;

    class a {
        ImageView a;
        TextView b;
        TextView c;
        View d;
        View e;

        a() {
        }
    }

    public ad(Context context) {
        super(context);
        this.a = LayoutInflater.from(context);
    }

    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        a aVar;
        View view2;
        int i2;
        try {
            if (view == null) {
                aVar = new a();
                View viewInflate = this.a.inflate(R.layout.vip_info_item_layout, (ViewGroup) null);
                try {
                    aVar.a = (ImageView) viewInflate.findViewById(R.id.vipIconImageView);
                    aVar.b = (TextView) viewInflate.findViewById(R.id.vipNameTextView);
                    aVar.c = (TextView) viewInflate.findViewById(R.id.vipStateTextView);
                    aVar.d = viewInflate.findViewById(R.id.listViewBottomDividerView);
                    aVar.e = viewInflate.findViewById(R.id.vipIconViewLayout);
                    viewInflate.setTag(aVar);
                    view = viewInflate;
                } catch (Throwable th) {
                    th = th;
                    view = viewInflate;
                    th.printStackTrace();
                }
            } else {
                aVar = (a) view.getTag();
            }
            final chat.ola.vn.entity.ah item = getItem(i);
            aVar.a.setImageBitmap(chat.ola.vn.j.a().a(item.b()));
            if (this.b != null) {
                aVar.a.setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.b.ad.1
                    @Override // android.view.View.OnClickListener
                    public void onClick(View view3) {
                        view3.setTag(item);
                        ad.this.b.onClick(view3);
                    }
                });
            }
            aVar.b.setText(item.d());
            if (chat.ola.vn.util.m.a(this.h, item.e())) {
                item.b(true);
            } else {
                item.b(false);
            }
            if (!this.c) {
                aVar.c.setVisibility(8);
                view2 = aVar.e;
                i2 = chat.ola.vn.f.d;
            } else if (chat.ola.vn.util.m.a(this.h, item.e())) {
                item.b(true);
                aVar.c.setVisibility(0);
                aVar.c.setText(R.string.string_using);
                aVar.c.setTextColor(chat.ola.vn.f.z);
                view2 = aVar.e;
                i2 = chat.ola.vn.f.I;
            } else if (item.f()) {
                aVar.c.setVisibility(0);
                aVar.c.setText(R.string.string_locked);
                aVar.c.setTextColor(chat.ola.vn.f.L);
                view2 = aVar.e;
                i2 = chat.ola.vn.f.d;
            } else {
                aVar.c.setVisibility(8);
                view2 = aVar.e;
                i2 = chat.ola.vn.f.d;
            }
            view2.setBackgroundColor(i2);
        } catch (Throwable th2) {
            th = th2;
        }
        return view == null ? viewGroup : view;
    }

    public void a(int i) {
        this.g = i;
    }

    public void a(String str) {
        this.h = str;
    }

    public void a(List<chat.ola.vn.entity.ah> list) {
        this.d = list;
    }

    public void a(boolean z) {
        this.c = z;
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entity.ah getItem(int i) {
        return this.d.get(i);
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        if (this.d == null) {
            return 0;
        }
        return this.d.size();
    }
}
