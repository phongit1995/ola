package chat.ola.vn.cloud;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.AdapterView;
import android.widget.GridView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.j;
import chat.ola.vn.entity.i;
import chat.ola.vn.entity.l;
import chat.ola.vn.h;
import chat.ola.vn.util.m;
import chat.ola.vn.view.g;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaCloudPhotoChooserActivity extends chat.ola.vn.c implements View.OnClickListener, j.a, d {
    private static g.e e;
    private GridView f = null;
    private b g = null;
    private View h = null;
    private View i = null;
    private TextView j = null;
    private String k = null;
    private String l = null;
    private List<l> m = null;
    private l n = null;
    private ListView o;
    private chat.ola.vn.b.a p;
    private Runnable q;

    private void E() {
        this.f = (GridView) findViewById(R.id.albumGridView);
        this.f.setFadingEdgeLength(0);
        findViewById(R.id.cameraImageView).setVisibility(4);
        this.j = (TextView) findViewById(R.id.olaActionBarTitleTextView);
        findViewById(R.id.olaActionBarTitleViewLayout).setOnClickListener(this);
        findViewById(R.id.olaActionBarButtonTextView).setOnClickListener(this);
        this.h = findViewById(R.id.wattingProgressBar);
        this.i = findViewById(R.id.darkLayerLayout);
        this.i.setOnClickListener(this);
        this.o = (ListView) findViewById(R.id.albumChooserListView);
        this.p = new chat.ola.vn.b.a(this);
        this.o.setAdapter((ListAdapter) this.p);
        this.o.setOnItemClickListener(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.cloud.OlaCloudPhotoChooserActivity.1
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                try {
                    l item = OlaCloudPhotoChooserActivity.this.p.getItem(i);
                    if (item.k) {
                        return;
                    }
                    OlaCloudPhotoChooserActivity.this.n.k = false;
                    OlaCloudPhotoChooserActivity.this.n = item;
                    OlaCloudPhotoChooserActivity.this.n.k = true;
                    OlaCloudPhotoChooserActivity.this.g.a();
                    OlaCloudPhotoChooserActivity.this.g.notifyDataSetChanged();
                    OlaCloudPhotoChooserActivity.this.k = null;
                    OlaCloudPhotoChooserActivity.this.j.setText(OlaCloudPhotoChooserActivity.this.n.a);
                    OlaCloudPhotoChooserActivity.this.p.notifyDataSetChanged();
                    OlaCloudPhotoChooserActivity.this.a_(0);
                    OlaCloudPhotoChooserActivity.this.c(false);
                } catch (Throwable unused) {
                }
            }
        });
    }

    private void F() {
        try {
            if (this.g == null) {
                this.g = new b(this);
                this.g.e();
                this.g.a((d) this);
                this.g.a((j.a) this);
                this.f.setAdapter((ListAdapter) this.g);
            }
            if (this.g.g() != null && this.g.g().size() != 0) {
                this.g.notifyDataSetChanged();
                return;
            }
            d(true);
            OlaApplication.b.e((String) null, (short) 0);
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, g.e eVar) {
        e = eVar;
        context.startActivity(new Intent(context, (Class<?>) OlaCloudPhotoChooserActivity.class));
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_bottom_in, R.anim.push_top_out);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(boolean z) {
        if (z) {
            if (this.o.getVisibility() != 0) {
                this.o.setVisibility(0);
                this.i.setVisibility(0);
                Animation animationLoadAnimation = AnimationUtils.loadAnimation(this, R.anim.expand_animation);
                this.o.setVisibility(0);
                this.o.startAnimation(animationLoadAnimation);
                return;
            }
            return;
        }
        if (this.o.getVisibility() == 0) {
            Animation animationLoadAnimation2 = AnimationUtils.loadAnimation(this, R.anim.collapse_animation);
            this.o.setVisibility(8);
            this.o.startAnimation(animationLoadAnimation2);
            if (this.h.getVisibility() != 0) {
                this.i.setVisibility(8);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void d(boolean z) {
        if (this.q == null) {
            this.q = new Runnable() { // from class: chat.ola.vn.cloud.OlaCloudPhotoChooserActivity.2
                @Override // java.lang.Runnable
                public void run() {
                    OlaCloudPhotoChooserActivity.this.d(false);
                }
            };
        }
        try {
            OlaApplication.c(this.q);
        } catch (Throwable unused) {
        }
        if (z) {
            this.h.setVisibility(0);
            this.i.setVisibility(0);
            OlaApplication.a(this.q, 30000L);
        } else {
            this.h.setVisibility(8);
            if (this.o.getVisibility() != 0) {
                this.i.setVisibility(8);
            }
        }
    }

    @Override // chat.ola.vn.b.j.a
    public boolean B() {
        return !m.b(this.k, "null");
    }

    @Override // chat.ola.vn.cloud.d
    public void C() {
    }

    @Override // chat.ola.vn.cloud.d
    public void D() {
    }

    @Override // chat.ola.vn.c
    protected void a() {
        F();
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(int i, String str, byte[] bArr, chat.ola.vn.entity.d[] dVarArr, short s) {
        d(false);
        this.k = "null";
        this.l = "null";
    }

    @Override // chat.ola.vn.cloud.d
    public void a(View view, i iVar) {
    }

    @Override // chat.ola.vn.cloud.d
    public void a(l lVar) {
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(String str, List<i> list, String str2, short s) {
        try {
            d(false);
            this.k = str2;
            if (m.a(str2) || list == null || list.size() == 0) {
                this.k = "null";
                this.l = "null";
            }
            this.g.a(list);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(List<l> list, String str, short s) {
        try {
            this.m = list;
            this.n = this.m.get(0);
            Iterator<l> it2 = list.iterator();
            while (true) {
                if (!it2.hasNext()) {
                    break;
                }
                l next = it2.next();
                if (m.b(next.b, "upload:" + h.a())) {
                    this.n = next;
                    this.n.k = true;
                    break;
                }
            }
            this.j.setText(this.n.a);
            this.p.a(list);
            this.p.notifyDataSetChanged();
            a_(0);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        if (this.k != null && m.b(this.k, this.l)) {
            d(false);
            return;
        }
        if (this.n == null) {
            d(false);
            return;
        }
        if (i == 0) {
            d(true);
        } else {
            d(false);
        }
        this.l = this.k;
        if (m.b(this.k, "null")) {
            return;
        }
        OlaApplication.b.a(this.n.b, (byte) 50, this.k, (short) 0);
    }

    @Override // chat.ola.vn.cloud.d
    public void d(int i) {
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        super.finish();
        try {
            overridePendingTransition(R.anim.push_top_in, R.anim.push_bottom_out);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        if (this.o.getVisibility() == 0) {
            c(false);
        } else {
            super.onBackPressed();
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id != R.id.cameraImageView) {
                if (id != R.id.darkLayerLayout) {
                    if (id == R.id.olaActionBarButtonTextView) {
                        List<i> listC = this.g.c();
                        if (listC != null && listC.size() > 0) {
                            ArrayList arrayList = new ArrayList(listC.size());
                            ArrayList arrayList2 = new ArrayList(listC.size());
                            int size = listC.size();
                            for (int i = 0; i < size; i++) {
                                i iVar = listC.get(i);
                                if (iVar.f() == 1) {
                                    arrayList.add(iVar.d());
                                } else if (iVar.f() == 2) {
                                    arrayList2.add(iVar.d());
                                }
                            }
                            if (arrayList.size() > 0) {
                                e.d(arrayList);
                            }
                            if (arrayList2.size() > 0) {
                                e.e(arrayList2);
                            }
                        }
                        finish();
                        return;
                    }
                    if (id != R.id.olaActionBarTitleViewLayout) {
                        return;
                    }
                    if (this.o.getVisibility() != 0) {
                        if (this.m == null || this.m.size() <= 0) {
                            return;
                        }
                        c(true);
                        return;
                    }
                }
                c(false);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_cloud_photo_chooser_layout);
        E();
    }
}
