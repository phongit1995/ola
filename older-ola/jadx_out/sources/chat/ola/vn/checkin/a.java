package chat.ola.vn.checkin;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Filter;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.b.j;
import chat.ola.vn.c;
import chat.ola.vn.c.f;
import chat.ola.vn.entity.OlaCheckInItemEntity;
import chat.ola.vn.util.m;
import chat.ola.vn.view.OlaCachedImageView;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class a extends j<OlaCheckInItemEntity> {
    private List<OlaCheckInItemEntity> a;
    private List<OlaCheckInItemEntity> b;
    private C0025a c;

    /* JADX INFO: renamed from: chat.ola.vn.checkin.a$a, reason: collision with other inner class name */
    private class C0025a extends Filter {
        private C0025a() {
        }

        @Override // android.widget.Filter
        protected Filter.FilterResults performFiltering(CharSequence charSequence) {
            ArrayList arrayList = new ArrayList(0);
            for (int i = 0; i < a.this.a.size(); i++) {
                try {
                    if (m.h(((OlaCheckInItemEntity) a.this.a.get(i)).b()).toLowerCase().contains(m.h(charSequence.toString()).toLowerCase())) {
                        OlaCheckInItemEntity olaCheckInItemEntity = new OlaCheckInItemEntity();
                        olaCheckInItemEntity.a((OlaCheckInItemEntity) a.this.a.get(i));
                        arrayList.add(olaCheckInItemEntity);
                    }
                } catch (Throwable unused) {
                }
            }
            Filter.FilterResults filterResults = new Filter.FilterResults();
            filterResults.count = arrayList.size();
            filterResults.values = arrayList;
            return filterResults;
        }

        @Override // android.widget.Filter
        protected void publishResults(CharSequence charSequence, Filter.FilterResults filterResults) {
            if (filterResults != null) {
                a.this.b = new ArrayList((List) filterResults.values);
                a.this.notifyDataSetChanged();
            }
        }
    }

    private class b {
        public OlaCheckInItemEntity a;
        private OlaCachedImageView c;
        private TextView d;
        private View e;

        public b(View view) {
            try {
                this.e = view;
                this.c = (OlaCachedImageView) view.findViewById(R.id.imgCheckInItemPhoto);
                this.d = (TextView) view.findViewById(R.id.txtItemName);
                this.e.setTag(this);
            } catch (Throwable th) {
                th.printStackTrace();
            }
        }

        public void a(OlaCheckInItemEntity olaCheckInItemEntity) {
            try {
                this.a = new OlaCheckInItemEntity();
                this.a.a(olaCheckInItemEntity);
                this.d.setText(this.a.b());
                f.a((Context) c.c(), this.c, this.a.d(), R.drawable.ic_check_in_item_default, false);
            } catch (Throwable th) {
                th.printStackTrace();
            }
        }
    }

    public a(Context context) {
        super(context);
        this.c = new C0025a();
    }

    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        b bVar;
        try {
            OlaCheckInItemEntity olaCheckInItemEntity = this.b.get(i);
            if (view == null) {
                view = LayoutInflater.from(b()).inflate(R.layout.check_in_what_suggest_item, viewGroup, false);
                bVar = new b(view);
            } else {
                bVar = (b) view.getTag();
            }
            bVar.a(olaCheckInItemEntity);
            return view;
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public OlaCheckInItemEntity getItem(int i) {
        try {
            return this.b.get(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(List<OlaCheckInItemEntity> list) {
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
