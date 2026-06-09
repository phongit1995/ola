package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Filter;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.entity.OlaCheckInActionEntity;
import chat.ola.vn.view.OlaCachedImageView;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class c extends j<OlaCheckInActionEntity> {
    private List<OlaCheckInActionEntity> a;
    private List<OlaCheckInActionEntity> b;
    private a c;

    private class a extends Filter {
        private a() {
        }

        @Override // android.widget.Filter
        protected Filter.FilterResults performFiltering(CharSequence charSequence) {
            ArrayList arrayList = new ArrayList(0);
            try {
                String lowerCase = chat.ola.vn.util.m.h(charSequence.toString()).toLowerCase();
                for (int i = 0; i < c.this.a.size(); i++) {
                    if (chat.ola.vn.util.m.h(((OlaCheckInActionEntity) c.this.a.get(i)).b()).toLowerCase().startsWith(lowerCase)) {
                        OlaCheckInActionEntity olaCheckInActionEntity = new OlaCheckInActionEntity();
                        olaCheckInActionEntity.a((OlaCheckInActionEntity) c.this.a.get(i));
                        arrayList.add(olaCheckInActionEntity);
                    }
                }
                for (int i2 = 0; i2 < c.this.a.size(); i2++) {
                    String lowerCase2 = chat.ola.vn.util.m.h(((OlaCheckInActionEntity) c.this.a.get(i2)).b()).toLowerCase();
                    if (lowerCase2.contains(lowerCase) && !lowerCase2.startsWith(lowerCase)) {
                        OlaCheckInActionEntity olaCheckInActionEntity2 = new OlaCheckInActionEntity();
                        olaCheckInActionEntity2.a((OlaCheckInActionEntity) c.this.a.get(i2));
                        arrayList.add(olaCheckInActionEntity2);
                    }
                }
            } catch (Throwable unused) {
            }
            Filter.FilterResults filterResults = new Filter.FilterResults();
            filterResults.count = arrayList.size();
            filterResults.values = arrayList;
            return filterResults;
        }

        @Override // android.widget.Filter
        protected void publishResults(CharSequence charSequence, Filter.FilterResults filterResults) {
            if (charSequence != null) {
                try {
                    if (!chat.ola.vn.util.m.a(charSequence.toString())) {
                        if (filterResults != null) {
                            c.this.b = new ArrayList((List) filterResults.values);
                            c.this.notifyDataSetChanged();
                            return;
                        }
                        return;
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                    return;
                }
            }
            c.this.b = new ArrayList(c.this.a);
            c.this.notifyDataSetChanged();
        }
    }

    private class b {
        private TextView b;
        private OlaCachedImageView c;
        private OlaCheckInActionEntity d;

        public b(View view) {
            try {
                this.b = (TextView) view.findViewById(R.id.txtCheckInActionSuggest);
                this.c = (OlaCachedImageView) view.findViewById(R.id.imgCheckAction);
                view.setTag(this);
            } catch (Throwable unused) {
            }
        }

        public void a(OlaCheckInActionEntity olaCheckInActionEntity) {
            try {
                this.d = olaCheckInActionEntity;
                this.b.setText(olaCheckInActionEntity.b());
                chat.ola.vn.c.f.a((Context) chat.ola.vn.c.c(), this.c, this.d.c(), R.drawable.ic_check_in_item_default, false);
            } catch (Throwable unused) {
            }
        }
    }

    public c(Context context) {
        super(context);
        this.c = new a();
    }

    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        b bVar;
        try {
            if (view == null) {
                view = LayoutInflater.from(b()).inflate(R.layout.check_in_action_suggest_item, viewGroup, false);
                bVar = new b(view);
            } else {
                bVar = (b) view.getTag();
            }
            bVar.a(this.b.get(i));
            return view;
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public OlaCheckInActionEntity getItem(int i) {
        try {
            return this.b.get(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(List<OlaCheckInActionEntity> list) {
        this.a = new ArrayList(list);
        this.b = new ArrayList(list);
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            return this.b.size();
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // chat.ola.vn.b.j, android.widget.Filterable
    public Filter getFilter() {
        return this.c;
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public long getItemId(int i) {
        return 0L;
    }
}
