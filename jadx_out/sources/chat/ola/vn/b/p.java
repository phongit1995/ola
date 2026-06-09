package chat.ola.vn.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Filter;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.entity.OlaVenueEntity;
import chat.ola.vn.view.OlaCachedImageView;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class p extends j<OlaVenueEntity> {
    private List<OlaVenueEntity> a;
    private List<OlaVenueEntity> b;
    private c c;
    private a<OlaVenueEntity> d;
    private View.OnLongClickListener g;
    private View.OnClickListener h;

    public interface a<T> {
        void a(List<T> list);
    }

    private class b {
        private OlaVenueEntity b;
        private OlaCachedImageView c;
        private View d;
        private View e;
        private TextView f;
        private TextView g;
        private TextView h;
        private TextView i;
        private View j;
        private View k;
        private View l;
        private View.OnClickListener m;
        private View.OnLongClickListener n;

        public b(View view) {
            try {
                this.e = view.findViewById(R.id.vLinearCheckInInfo);
                this.e.setClickable(true);
                this.d = view.findViewById(R.id.vLinearCheckInItem);
                this.c = (OlaCachedImageView) view.findViewById(R.id.imgCheckInAvatar);
                this.f = (TextView) view.findViewById(R.id.txtPlaceName);
                this.g = (TextView) view.findViewById(R.id.txtPlaceDistanceInfo);
                this.h = (TextView) view.findViewById(R.id.txtAmountPepleCheckedInfo);
                this.i = (TextView) view.findViewById(R.id.txtPlaceAddress);
                this.k = view.findViewById(R.id.btnDetail);
                this.l = view.findViewById(R.id.txtDistanceHint);
                this.j = view;
                this.j.setTag(this);
            } catch (Throwable unused) {
            }
        }

        private void a() {
            this.k.setOnClickListener(this.m);
            this.k.setTag(this.b);
            this.e.setOnClickListener(this.m);
            this.e.setTag(this.b);
        }

        public void a(View.OnClickListener onClickListener) {
            this.m = onClickListener;
        }

        public void a(View.OnLongClickListener onLongClickListener) {
            this.n = onLongClickListener;
        }

        public void a(OlaVenueEntity olaVenueEntity) {
            TextView textView;
            String str;
            try {
                this.b = olaVenueEntity;
                chat.ola.vn.c.f.a((Context) chat.ola.vn.c.c(), this.c, this.b.f(), R.drawable.ic_check_in_gray, false);
                this.f.setText(this.b.c());
                this.g.setText(this.b.h());
                if (chat.ola.vn.util.m.c(this.b.h())) {
                    this.l.setVisibility(8);
                } else {
                    this.l.setVisibility(0);
                }
                if (this.b.i() > 0) {
                    textView = this.h;
                    str = "(" + this.b.i() + " " + chat.ola.vn.c.c().getResources().getString(R.string.string_checkins) + ")";
                } else {
                    textView = this.h;
                    str = "";
                }
                textView.setText(str);
                this.i.setText(this.b.e());
            } catch (Throwable unused) {
            }
            a();
        }
    }

    private class c extends Filter {
        private c() {
        }

        @Override // android.widget.Filter
        protected Filter.FilterResults performFiltering(CharSequence charSequence) {
            ArrayList arrayList = new ArrayList(0);
            try {
                if (!chat.ola.vn.util.m.c(charSequence)) {
                    String lowerCase = chat.ola.vn.util.m.h(charSequence.toString()).toLowerCase();
                    ArrayList arrayList2 = arrayList;
                    for (int i = 0; i < p.this.a.size(); i++) {
                        try {
                            String strC = ((OlaVenueEntity) p.this.a.get(i)).c();
                            if (!chat.ola.vn.util.m.c(strC) && chat.ola.vn.util.m.h(strC).toLowerCase().contains(lowerCase)) {
                                if (arrayList2 == null) {
                                    arrayList2 = new ArrayList(0);
                                }
                                arrayList2.add(((OlaVenueEntity) p.this.a.get(i)).g());
                            }
                        } catch (Throwable unused) {
                        }
                    }
                    arrayList = arrayList2;
                }
            } catch (Throwable unused2) {
            }
            Filter.FilterResults filterResults = new Filter.FilterResults();
            filterResults.count = arrayList.size();
            filterResults.values = arrayList;
            return filterResults;
        }

        @Override // android.widget.Filter
        protected void publishResults(CharSequence charSequence, Filter.FilterResults filterResults) {
            if (filterResults != null) {
                p.this.b = (List) filterResults.values;
                if (p.this.d != null) {
                    p.this.d.a(new ArrayList(p.this.b));
                }
                p.this.notifyDataSetChanged();
            }
        }
    }

    public p(Context context) {
        super(context);
        this.c = new c();
    }

    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        b bVar;
        try {
            OlaVenueEntity olaVenueEntity = this.b.get(i);
            if (view == null) {
                view = LayoutInflater.from(b()).inflate(R.layout.check_in_item_layout, viewGroup, false);
                bVar = new b(view);
            } else {
                bVar = (b) view.getTag();
            }
            bVar.a(this.h);
            bVar.a(this.g);
            bVar.a(olaVenueEntity);
            return view;
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public OlaVenueEntity getItem(int i) {
        try {
            if (this.b != null) {
                return this.b.get(i);
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(View.OnClickListener onClickListener) {
        this.h = onClickListener;
    }

    public void a(a<OlaVenueEntity> aVar) {
        this.d = aVar;
    }

    public void a(List<OlaVenueEntity> list) {
        this.a = new ArrayList(list);
        this.b = new ArrayList(list);
        notifyDataSetChanged();
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            if (this.b != null) {
                return this.b.size();
            }
            return 0;
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // chat.ola.vn.b.j, android.widget.Filterable
    public Filter getFilter() {
        return this.c;
    }
}
