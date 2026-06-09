package chat.ola.vn.cloud;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.view.View;
import android.widget.GridView;
import android.widget.ListAdapter;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaImageViewerActivity;
import chat.ola.vn.b.j;
import chat.ola.vn.e;
import chat.ola.vn.entity.l;
import chat.ola.vn.i.i;
import chat.ola.vn.mediastore.OlaMediaEntity;
import chat.ola.vn.p.n;
import chat.ola.vn.util.m;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaGalleryPhotoListActivity extends chat.ola.vn.c implements View.OnClickListener, j.a, d, n {
    private static l e;
    private GridView f = null;
    private c g = null;
    private View h = null;
    private String i = null;
    private String j = null;
    private Runnable k;

    private void E() {
        this.f = (GridView) findViewById(R.id.albumGridView);
        this.f.setFadingEdgeLength(0);
        findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
        findViewById(R.id.olaActionBarTitleViewLayout).setOnClickListener(this);
        if (e == null || m.a(e.a)) {
            ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.general_tab_mediastore);
        } else {
            ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(e.a);
        }
        this.h = findViewById(R.id.wattingProgressBar);
    }

    private void F() {
        try {
            if (this.g == null) {
                this.g = new c(this);
                this.g.a((d) this);
                this.g.a((j.a) this);
                this.f.setAdapter((ListAdapter) this.g);
            }
            if (this.g.a() != null && this.g.a().size() != 0) {
                this.g.notifyDataSetChanged();
                return;
            }
            if (e != null) {
                this.i = e.b;
            }
            a_(0);
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, l lVar) {
        e = lVar;
        context.startActivity(new Intent(context, (Class<?>) OlaGalleryPhotoListActivity.class));
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(boolean z) {
        if (this.k == null) {
            this.k = new Runnable() { // from class: chat.ola.vn.cloud.OlaGalleryPhotoListActivity.1
                @Override // java.lang.Runnable
                public void run() {
                    OlaGalleryPhotoListActivity.this.c(false);
                    i.a(OlaGalleryPhotoListActivity.this, R.string.dialog_title_inform, R.string.message_process_timeout);
                }
            };
        }
        try {
            OlaApplication.c(this.k);
        } catch (Throwable unused) {
        }
        if (!z) {
            this.h.setVisibility(8);
        } else {
            this.h.setVisibility(0);
            OlaApplication.a(this.k, 30000L);
        }
    }

    @Override // chat.ola.vn.b.j.a
    public boolean B() {
        return !m.b(this.i, "null");
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

    @Override // chat.ola.vn.cloud.d
    public void a(View view, chat.ola.vn.entity.i iVar) {
        ArrayList arrayList = new ArrayList();
        List<chat.ola.vn.entity.i> listA = this.g.a();
        if (listA != null) {
            Iterator<chat.ola.vn.entity.i> it2 = listA.iterator();
            while (it2.hasNext()) {
                arrayList.add(new OlaMediaEntity(l.a(it2.next().h(), Math.max(e.c, e.d), Math.max(e.c, e.d)), 3, (short) 1));
            }
            OlaImageViewerActivity.a(this, view, (Bitmap) null, listA.indexOf(iVar), (ArrayList<OlaMediaEntity>) arrayList);
        }
    }

    @Override // chat.ola.vn.cloud.d
    public void a(l lVar) {
        if (lVar.i == 5) {
            OlaGalleryAlbumListActivity.a(this, lVar);
        }
    }

    @Override // chat.ola.vn.p.n
    public void a(String str, List<l> list, String str2) {
    }

    @Override // chat.ola.vn.p.n
    public void a(List<l> list, String str) {
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        if (this.i == null || !m.b(this.i, this.j)) {
            c(i == 0);
            this.j = this.i;
            OlaApplication.b.a(this.i, this);
        }
    }

    @Override // chat.ola.vn.p.n
    public void b(String str, List<chat.ola.vn.entity.i> list, String str2) {
        c(false);
        this.i = str2;
        this.g.a(list);
    }

    @Override // chat.ola.vn.cloud.d
    public void d(int i) {
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        super.finish();
        try {
            overridePendingTransition(R.anim.push_right_in, R.anim.push_right_out);
        } catch (Throwable unused) {
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            if (view.getId() != R.id.olaActionBarBackViewLayout) {
                return;
            }
            finish();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_cloud_album_list_layout);
        E();
    }
}
