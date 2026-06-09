package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.view.OlaCachedImageView;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class ai extends k<chat.ola.vn.entity.t> {
    protected LayoutInflater b;

    private class a {
        OlaCachedImageView a;
        TextView b;

        public a(View view) {
            this.a = (OlaCachedImageView) view.findViewById(R.id.imgMenuIcon);
            this.b = (TextView) view.findViewById(R.id.txtMenuTitle);
            this.a.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
            this.a.setImageResource(R.drawable.ic_tab_news);
            view.setTag(this);
        }

        public void a(chat.ola.vn.entity.t tVar) {
            this.b.setText(tVar.l());
        }
    }

    public ai(Context context) {
        super(context);
        this.b = LayoutInflater.from(context);
        a((List) chat.ola.vn.h.s.d());
    }

    @Override // java.util.Comparator
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public int compare(chat.ola.vn.entity.t tVar, chat.ola.vn.entity.t tVar2) {
        if (tVar2.A() > tVar.A()) {
            return 1;
        }
        return tVar2.A() < tVar.A() ? -1 : 0;
    }

    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        a aVar;
        try {
            if (view == null) {
                view = this.b.inflate(R.layout.slider_menu_item, (ViewGroup) null);
                aVar = new a(view);
            } else {
                aVar = (a) view.getTag();
            }
            aVar.a(getItem(i));
            return view;
        } catch (Throwable th) {
            th.printStackTrace();
            return new View(b());
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // chat.ola.vn.b.k
    public String a(chat.ola.vn.entity.t tVar) {
        return chat.ola.vn.util.m.h(tVar.l());
    }
}
