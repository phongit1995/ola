package chat.ola.vn.cloud;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.b.j;
import chat.ola.vn.c.t;
import chat.ola.vn.e;
import chat.ola.vn.entity.i;
import chat.ola.vn.entity.l;
import chat.ola.vn.util.m;
import chat.ola.vn.view.OlaCachedImageView;
import chat.ola.vn.view.OlaRatioImageView;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class c extends j<i> {
    protected LayoutInflater a;
    protected d b;
    private List<i> c;

    public class a {
        protected View a;
        protected TextView b;
        protected OlaRatioImageView c;
        private i e;

        protected a(View view) {
            try {
                this.a = view.findViewById(R.id.cloudAlbumViewLayout);
                this.b = (TextView) view.findViewById(R.id.cloudAlbumCheckImageView);
                this.c = (OlaRatioImageView) view.findViewById(R.id.cloudAlbumCoverImageView);
            } catch (Throwable unused) {
            }
        }

        /* JADX WARN: Failed to find 'out' block for switch in B:13:0x008c. Please report as an issue. */
        private void a() {
            OlaRatioImageView olaRatioImageView;
            int i;
            if (this.e.b()) {
                this.a.setSelected(true);
                this.b.setVisibility(0);
                this.b.setText("" + (this.e.a() + 1));
            } else {
                this.a.setSelected(false);
                this.b.setVisibility(8);
            }
            this.a.setOnClickListener(new View.OnClickListener() { // from class: chat.ola.vn.cloud.c.a.1
                @Override // android.view.View.OnClickListener
                public void onClick(View view) {
                    if (c.this.b != null) {
                        c.this.b.a(view, a.this.e);
                    }
                }
            });
            this.a.setOnLongClickListener(new View.OnLongClickListener() { // from class: chat.ola.vn.cloud.c.a.2
                @Override // android.view.View.OnLongClickListener
                public boolean onLongClick(View view) {
                    return true;
                }
            });
            if (m.a(this.e.h())) {
                if (!m.a(this.e.d())) {
                    switch (this.e.f()) {
                        case 1:
                            t.a().a(this.e.d(), this.c, 0, e.c / 3);
                            break;
                        case 2:
                            this.c.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                            olaRatioImageView = this.c;
                            i = R.drawable.ic_media_video;
                            olaRatioImageView.setImageResource(i);
                            break;
                        case 3:
                            this.c.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                            olaRatioImageView = this.c;
                            i = R.drawable.ic_media_sound;
                            olaRatioImageView.setImageResource(i);
                            break;
                    }
                } else {
                    this.c.a(null, null);
                }
                this.c.setRatio(1.0d);
            }
            t.a().a(l.a(this.e.h(), e.c / 3, e.c / 3), (OlaCachedImageView) this.c, true);
            this.c.setRatio(1.0d);
        }

        protected void a(i iVar) {
            try {
                this.e = iVar;
                a();
            } catch (Throwable unused) {
            }
        }
    }

    public c(Context context) {
        super(context);
        this.a = LayoutInflater.from(context);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r5v0, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r5v1 */
    /* JADX WARN: Type inference failed for: r5v2 */
    /* JADX WARN: Type inference failed for: r5v3 */
    /* JADX WARN: Type inference failed for: r5v4, types: [chat.ola.vn.cloud.c$a] */
    /* JADX WARN: Type inference failed for: r5v6 */
    /* JADX WARN: Type inference failed for: r6v1 */
    /* JADX WARN: Type inference failed for: r6v11, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r6v12 */
    /* JADX WARN: Type inference failed for: r6v2, types: [android.view.View] */
    /* JADX WARN: Type inference failed for: r6v5 */
    /* JADX WARN: Type inference failed for: r6v7 */
    /* JADX WARN: Type inference failed for: r6v8 */
    /* JADX WARN: Type inference failed for: r6v9, types: [android.view.View] */
    @Override // chat.ola.vn.b.j
    public View a(int i, View view, ViewGroup viewGroup) {
        ?? Inflate;
        try {
            if (view == 0) {
                Inflate = this.a.inflate(R.layout.ola_cloud_media_layout, (ViewGroup) null);
                try {
                    a aVar = new a(Inflate);
                    Inflate.setTag(aVar);
                    view = aVar;
                    Inflate = Inflate;
                } catch (Throwable th) {
                    th = th;
                    th.printStackTrace();
                    return Inflate;
                }
            } else {
                try {
                    Inflate = view;
                    view = (a) view.getTag();
                } catch (Throwable th2) {
                    a aVar2 = new a(view);
                    view.setTag(aVar2);
                    th2.printStackTrace();
                    Inflate = view;
                    view = aVar2;
                }
            }
            view.a(this.c.get(i));
            return Inflate;
        } catch (Throwable th3) {
            th = th3;
            Inflate = view;
            th.printStackTrace();
            return Inflate;
        }
    }

    @Override // android.widget.Adapter
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public i getItem(int i) {
        try {
            return this.c.get(i);
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    public List<i> a() {
        try {
            return this.c;
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    public void a(d dVar) {
        this.b = dVar;
    }

    public void a(List<i> list) {
        if (this.c == null) {
            this.c = new ArrayList(list);
        } else {
            this.c.addAll(list);
        }
        notifyDataSetChanged();
    }

    @Override // chat.ola.vn.b.j, android.widget.Adapter
    public int getCount() {
        try {
            return this.c.size();
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getItemViewType(int i) {
        return 0;
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getViewTypeCount() {
        return 1;
    }
}
