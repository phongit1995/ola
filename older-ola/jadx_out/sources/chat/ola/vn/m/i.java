package chat.ola.vn.m;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.j;
import chat.ola.vn.checkin.OlaVenueDetailActivity;
import chat.ola.vn.entity.OlaCheckInActionEntity;
import chat.ola.vn.entity.OlaCheckInItemEntity;
import chat.ola.vn.entity.OlaVenueEntity;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class i extends a implements j.a, chat.ola.vn.p.a {
    private ListView a;
    private View b;
    private chat.ola.vn.b.p c;
    private String d;
    private String e;
    private int f;
    private List<OlaVenueEntity> g;

    private void a(View view) {
        try {
            this.a = (ListView) view.findViewById(R.id.lvCheckInItems);
            this.b = view.findViewById(R.id.progressBar);
            ((ImageView) view.findViewById(R.id.olaActionBarIconImageView)).setImageResource(R.drawable.ic_check_in);
            ((TextView) view.findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.string_check_in_nearby_venues);
            ImageView imageView = (ImageView) view.findViewById(R.id.olaActionBarCloseButtonImageView);
            imageView.setImageResource(R.drawable.ic_action_quit);
            imageView.setVisibility(0);
            imageView.setOnClickListener(this);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void a(String str, String str2, int i) {
        try {
            if (!chat.ola.vn.util.m.c(str) && !chat.ola.vn.util.m.c(str2)) {
                a(true);
                if (OlaApplication.b != null) {
                    OlaApplication.b.a((String) null, str, str2, i, this);
                    return;
                }
                return;
            }
            a(false);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void a(boolean z) {
        try {
            if (z) {
                this.b.setVisibility(0);
            } else {
                this.b.setVisibility(8);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void d() {
        try {
            this.d = chat.ola.vn.n.c.a().b();
            this.e = chat.ola.vn.n.c.a().c();
            a(this.d, this.e, this.f);
            this.c = new chat.ola.vn.b.p(getActivity());
            this.c.a((View.OnClickListener) this);
            this.c.a((j.a) this);
            this.a.setAdapter((ListAdapter) this.c);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.b.j.a
    public boolean B() {
        return this.f > 0;
    }

    @Override // chat.ola.vn.p.a
    public void a(OlaCheckInItemEntity olaCheckInItemEntity) {
    }

    @Override // chat.ola.vn.p.a
    public void a(OlaVenueEntity olaVenueEntity) {
    }

    @Override // chat.ola.vn.p.a
    public void a(chat.ola.vn.entity.o oVar) {
    }

    @Override // chat.ola.vn.p.a
    public void a(chat.ola.vn.entity.y yVar) {
    }

    @Override // chat.ola.vn.p.a
    public void a(List<chat.ola.vn.entity.g> list, long j) {
    }

    @Override // chat.ola.vn.p.a
    public void a(short s, String str) {
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        a(this.d, this.e, this.f);
    }

    @Override // chat.ola.vn.p.a
    public void b(OlaVenueEntity olaVenueEntity) {
    }

    @Override // chat.ola.vn.p.a
    public void b(List<OlaVenueEntity> list, int i) {
        if (list != null) {
            try {
                if (this.f == 0) {
                    this.g = new ArrayList(list);
                } else {
                    if (this.g == null) {
                        this.g = new ArrayList(0);
                    }
                    ArrayList arrayList = new ArrayList(list);
                    for (int i2 = 0; i2 < list.size(); i2++) {
                        this.g.add((OlaVenueEntity) arrayList.get(i2));
                    }
                }
                this.c.a(this.g);
                this.c.notifyDataSetChanged();
                this.f = i;
            } catch (Throwable th) {
                th.printStackTrace();
            }
        }
        a(false);
    }

    public int c() {
        return 13;
    }

    @Override // chat.ola.vn.p.a
    public void c(List<OlaCheckInActionEntity> list) {
    }

    @Override // chat.ola.vn.p.a
    public void c(List<OlaCheckInItemEntity> list, int i) {
    }

    @Override // chat.ola.vn.p.a
    public void f(String str) {
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id != R.id.btnDetail) {
                if (id == R.id.olaActionBarCloseButtonImageView) {
                    a().d(c());
                    return;
                } else if (id != R.id.vLinearCheckInInfo) {
                    return;
                }
            }
            OlaVenueDetailActivity.a(a(), ((OlaVenueEntity) view.getTag()).b());
            a().overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, @Nullable ViewGroup viewGroup, @Nullable Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.check_in_nearby_vernues_activity_layout, (ViewGroup) null);
        try {
            a(viewInflate);
            d();
        } catch (Throwable unused) {
        }
        return viewInflate;
    }
}
