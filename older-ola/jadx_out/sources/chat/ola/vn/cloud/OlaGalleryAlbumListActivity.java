package chat.ola.vn.cloud;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.GridView;
import android.widget.ListAdapter;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.j;
import chat.ola.vn.entity.l;
import chat.ola.vn.i.i;
import chat.ola.vn.p.n;
import chat.ola.vn.util.m;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaGalleryAlbumListActivity extends chat.ola.vn.c implements View.OnClickListener, j.a, d, n {
    private static l e;
    private static String f;
    private GridView g = null;
    private a h = null;
    private View i = null;
    private TextView j = null;
    private String k = null;
    private Runnable l;

    private void E() {
        this.g = (GridView) findViewById(R.id.albumGridView);
        this.g.setFadingEdgeLength(0);
        findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
        findViewById(R.id.olaActionBarTitleViewLayout).setOnClickListener(this);
        this.j = (TextView) findViewById(R.id.olaActionBarButtonTextView);
        this.j.setVisibility(8);
        this.j.setText(R.string.string_delete);
        this.j.setOnClickListener(this);
        if (e != null) {
            f = e.b;
        }
        if (e == null || m.a(e.a)) {
            ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.general_tab_mediastore);
        } else {
            ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(e.a);
        }
        this.i = findViewById(R.id.wattingProgressBar);
    }

    private void F() {
        try {
            if (this.h == null) {
                this.h = new a(this);
                this.h.a((d) this);
                this.h.a((j.a) this);
                this.g.setAdapter((ListAdapter) this.h);
            }
            if (this.h.f() != null && this.h.f().size() != 0) {
                this.h.notifyDataSetChanged();
                return;
            }
            a_(0);
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, l lVar) {
        e = lVar;
        context.startActivity(new Intent(context, (Class<?>) OlaGalleryAlbumListActivity.class));
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(boolean z) {
        if (this.l == null) {
            this.l = new Runnable() { // from class: chat.ola.vn.cloud.OlaGalleryAlbumListActivity.2
                @Override // java.lang.Runnable
                public void run() {
                    OlaGalleryAlbumListActivity.this.c(false);
                    i.a(OlaGalleryAlbumListActivity.this, R.string.dialog_title_inform, R.string.message_process_timeout);
                }
            };
        }
        try {
            OlaApplication.c(this.l);
        } catch (Throwable unused) {
        }
        if (!z) {
            this.i.setVisibility(8);
        } else {
            this.i.setVisibility(0);
            OlaApplication.a(this.l, 30000L);
        }
    }

    @Override // chat.ola.vn.b.j.a
    public boolean B() {
        return !m.b(f, "null");
    }

    @Override // chat.ola.vn.cloud.d
    public void C() {
        this.j.setVisibility(0);
    }

    @Override // chat.ola.vn.cloud.d
    public void D() {
        this.j.setVisibility(8);
    }

    @Override // chat.ola.vn.c
    protected void a() {
        F();
    }

    @Override // chat.ola.vn.cloud.d
    public void a(View view, chat.ola.vn.entity.i iVar) {
    }

    @Override // chat.ola.vn.cloud.d
    public void a(l lVar) {
        if (m.b(lVar.e, "folders")) {
            OlaGalleryPhotoListActivity.a(this, lVar);
        } else {
            a(this, lVar);
        }
    }

    @Override // chat.ola.vn.p.n
    public void a(String str, List<l> list, String str2) {
        c(false);
        f = str2;
        if (m.a(f)) {
            f = "null";
            this.k = "null";
        }
        this.h.a(list);
    }

    @Override // chat.ola.vn.p.n
    public void a(List<l> list, String str) {
        c(false);
        f = str;
        if (m.a(f)) {
            f = "null";
            this.k = "null";
        }
        this.h.a(list);
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        if (f == null || !m.b(f, this.k)) {
            c(i == 0);
            this.k = f;
            OlaApplication.b.a(f, this);
        }
    }

    @Override // chat.ola.vn.p.n
    public void b(String str, List<chat.ola.vn.entity.i> list, String str2) {
    }

    @Override // chat.ola.vn.cloud.d
    public void d(int i) {
        if (i == 0) {
            this.h.e();
            this.j.setVisibility(8);
            return;
        }
        this.j.setVisibility(0);
        this.j.setText(getString(R.string.string_delete) + " (" + i + ")");
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        super.finish();
        try {
            overridePendingTransition(R.anim.push_right_in, R.anim.push_right_out);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        if (this.h.c()) {
            this.h.e();
        } else {
            super.onBackPressed();
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        final List<l> listA;
        try {
            int id = view.getId();
            if (id == R.id.olaActionBarBackViewLayout) {
                finish();
                return;
            }
            if (id == R.id.olaActionBarButtonTextView && (listA = this.h.a()) != null && listA.size() > 0) {
                i.d(this, getString(R.string.string_delete_album), getString(R.string.message_delete_albums_confirm_format, new Object[]{listA.size() + ""}), getString(R.string.string_delete), getString(R.string.string_no), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.cloud.OlaGalleryAlbumListActivity.1
                    @Override // android.content.DialogInterface.OnClickListener
                    public void onClick(DialogInterface dialogInterface, int i) {
                        if (i == 0) {
                            try {
                                List<l> listF = OlaGalleryAlbumListActivity.this.h.f();
                                for (l lVar : listA) {
                                    listF.remove(lVar);
                                    OlaApplication.b.q(lVar.b, (short) 0);
                                }
                                OlaGalleryAlbumListActivity.this.h.e();
                                OlaGalleryAlbumListActivity.this.h.notifyDataSetChanged();
                            } catch (Throwable unused) {
                                return;
                            }
                        }
                        dialogInterface.dismiss();
                    }
                });
            }
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
