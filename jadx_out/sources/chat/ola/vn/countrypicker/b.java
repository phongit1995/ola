package chat.ola.vn.countrypicker;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.i;
import chat.ola.vn.util.m;
import java.util.List;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public class b extends BaseAdapter {
    List<chat.ola.vn.countrypicker.a> a;
    LayoutInflater b;
    private Context c;

    static class a {
        public TextView a;
        public TextView b;
        public ImageView c;

        a() {
        }
    }

    public b(Context context, List<chat.ola.vn.countrypicker.a> list) {
        this.c = context;
        this.a = list;
        this.b = (LayoutInflater) this.c.getSystemService("layout_inflater");
    }

    private int a(String str) {
        try {
            return i.a.class.getField(str).getInt(null);
        } catch (Exception e) {
            Log.e("COUNTRYPICKER", "Failure to get drawable id.", e);
            return -1;
        }
    }

    @Override // android.widget.Adapter
    public int getCount() {
        return this.a.size();
    }

    @Override // android.widget.Adapter
    public Object getItem(int i) {
        return null;
    }

    @Override // android.widget.Adapter
    public long getItemId(int i) {
        return 0L;
    }

    @Override // android.widget.Adapter
    public View getView(int i, View view, ViewGroup viewGroup) {
        View viewInflate;
        a aVar;
        chat.ola.vn.countrypicker.a aVar2 = this.a.get(i);
        if (view == null) {
            aVar = new a();
            viewInflate = this.b.inflate(R.layout.row, (ViewGroup) null);
            aVar.a = (TextView) viewInflate.findViewById(R.id.row_title);
            aVar.b = (TextView) viewInflate.findViewById(R.id.row_code);
            aVar.c = (ImageView) viewInflate.findViewById(R.id.row_icon);
            viewInflate.setTag(aVar);
        } else {
            viewInflate = view;
            aVar = (a) view.getTag();
        }
        aVar.a.setText(aVar2.b());
        String strC = aVar2.c();
        if (m.a(strC)) {
            aVar.b.setText("");
        } else {
            aVar.b.setText("+" + strC);
        }
        aVar.c.setImageResource(a("flag_" + aVar2.a().toLowerCase(Locale.ENGLISH)));
        return viewInflate;
    }
}
