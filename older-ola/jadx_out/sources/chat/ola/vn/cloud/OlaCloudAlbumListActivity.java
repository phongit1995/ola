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
import chat.ola.vn.entry.c.e;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.message.f;
import chat.ola.vn.p.n;
import chat.ola.vn.util.m;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaCloudAlbumListActivity extends chat.ola.vn.c implements View.OnClickListener, j.a, d, n {
    private static String e;
    private GridView f = null;
    private a g = null;
    private View h = null;
    private TextView i = null;
    private String j = null;
    private String k = null;
    private Runnable l;

    private void F() {
        this.f = (GridView) findViewById(R.id.albumGridView);
        this.f.setFadingEdgeLength(0);
        findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
        findViewById(R.id.olaActionBarTitleViewLayout).setOnClickListener(this);
        this.i = (TextView) findViewById(R.id.olaActionBarButtonTextView);
        this.i.setVisibility(8);
        this.i.setText(R.string.string_delete);
        this.i.setOnClickListener(this);
        if (m.a(e)) {
            ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.general_tab_mediastore);
        } else {
            f fVarD = h.t.d(e);
            if (fVarD != null) {
                ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(fVarD.L().toString());
            } else {
                ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(e);
            }
        }
        this.h = findViewById(R.id.wattingProgressBar);
    }

    private void G() {
        try {
            if (this.g == null) {
                this.g = new a(this);
                if (H()) {
                    this.g.a(true);
                } else {
                    this.g.a(false);
                }
                this.g.a((d) this);
                this.g.a((j.a) this);
                this.f.setAdapter((ListAdapter) this.g);
            }
            if (this.g.f() != null && this.g.f().size() != 0) {
                this.g.notifyDataSetChanged();
                return;
            }
            a_(0);
        } catch (Throwable unused) {
        }
    }

    private boolean H() {
        try {
            if (m.a(e)) {
                return true;
            }
            return m.b(e, h.a());
        } catch (Throwable unused) {
            return false;
        }
    }

    public static void a(Context context) {
        a(context, (String) null);
    }

    public static void a(Context context, String str) {
        e = str;
        context.startActivity(new Intent(context, (Class<?>) OlaCloudAlbumListActivity.class));
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(boolean z) {
        if (this.l == null) {
            this.l = new Runnable() { // from class: chat.ola.vn.cloud.OlaCloudAlbumListActivity.2
                @Override // java.lang.Runnable
                public void run() {
                    OlaCloudAlbumListActivity.this.c(false);
                    i.a(OlaCloudAlbumListActivity.this, R.string.dialog_title_inform, R.string.message_process_timeout);
                }
            };
        }
        try {
            OlaApplication.c(this.l);
        } catch (Throwable unused) {
        }
        if (!z) {
            this.h.setVisibility(8);
        } else {
            this.h.setVisibility(0);
            OlaApplication.a(this.l, 30000L);
        }
    }

    @Override // chat.ola.vn.b.j.a
    public boolean B() {
        return !m.b(this.j, "null");
    }

    @Override // chat.ola.vn.cloud.d
    public void C() {
        this.i.setVisibility(0);
    }

    @Override // chat.ola.vn.cloud.d
    public void D() {
        this.i.setVisibility(8);
    }

    @Override // chat.ola.vn.c
    protected void a() {
        G();
    }

    @Override // chat.ola.vn.cloud.d
    public void a(View view, chat.ola.vn.entity.i iVar) {
    }

    @Override // chat.ola.vn.cloud.d
    public void a(l lVar) {
        if (lVar.i == 5) {
            OlaGalleryAlbumListActivity.a(this, lVar);
        } else {
            OlaCloudPhotoListActivity.a(this, lVar);
        }
    }

    @Override // chat.ola.vn.p.n
    public void a(String str, List<l> list, String str2) {
    }

    @Override // chat.ola.vn.p.n
    public void a(List<l> list, String str) {
        this.g.a(list);
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        if (this.j == null || !m.b(this.j, this.k)) {
            c(i == 0);
            this.k = this.j;
            if (m.b(this.j, "null")) {
                return;
            }
            if (H()) {
                OlaApplication.b.e(this.j, chat.ola.vn.entry.c.f.a(new e() { // from class: chat.ola.vn.cloud.OlaCloudAlbumListActivity.3
                    @Override // chat.ola.vn.entry.c.e
                    public short a() {
                        return (short) 16;
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(int i2, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                        OlaCloudAlbumListActivity.this.c(false);
                        OlaCloudAlbumListActivity.this.j = "null";
                        OlaCloudAlbumListActivity.this.k = "null";
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(Object... objArr) {
                        OlaCloudAlbumListActivity.this.c(false);
                        try {
                            if (m.a(OlaCloudAlbumListActivity.e) && m.a(OlaCloudAlbumListActivity.this.j)) {
                                OlaApplication.b.a((n) OlaCloudAlbumListActivity.this);
                            }
                            List<l> list = (List) objArr[0];
                            if (m.a(OlaCloudAlbumListActivity.this.j)) {
                                OlaCloudAlbumListActivity.this.g.b(list);
                            } else {
                                OlaCloudAlbumListActivity.this.g.a(list);
                            }
                            if (objArr[1] != null) {
                                OlaCloudAlbumListActivity.this.j = (String) objArr[1];
                            } else {
                                OlaCloudAlbumListActivity.this.j = "null";
                                OlaCloudAlbumListActivity.this.k = "null";
                            }
                            OlaCloudAlbumListActivity.this.g.notifyDataSetChanged();
                        } catch (Throwable unused) {
                            OlaCloudAlbumListActivity.this.j = "null";
                            OlaCloudAlbumListActivity.this.k = "null";
                        }
                    }
                }));
            } else {
                OlaApplication.b.f(e, this.j, chat.ola.vn.entry.c.f.a(new e() { // from class: chat.ola.vn.cloud.OlaCloudAlbumListActivity.4
                    @Override // chat.ola.vn.entry.c.e
                    public short a() {
                        return (short) 16;
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(int i2, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                        OlaCloudAlbumListActivity.this.c(false);
                        OlaCloudAlbumListActivity.this.j = "null";
                        OlaCloudAlbumListActivity.this.k = "null";
                    }

                    @Override // chat.ola.vn.entry.c.e
                    public void a(Object... objArr) {
                        OlaCloudAlbumListActivity.this.c(false);
                        try {
                            List<l> list = (List) objArr[1];
                            if (m.a(OlaCloudAlbumListActivity.this.j)) {
                                OlaCloudAlbumListActivity.this.g.b(list);
                            } else {
                                OlaCloudAlbumListActivity.this.g.a(list);
                            }
                            if (objArr[2] != null) {
                                OlaCloudAlbumListActivity.this.j = (String) objArr[2];
                            } else {
                                OlaCloudAlbumListActivity.this.j = "null";
                                OlaCloudAlbumListActivity.this.k = "null";
                            }
                            OlaCloudAlbumListActivity.this.g.notifyDataSetChanged();
                        } catch (Throwable unused) {
                            OlaCloudAlbumListActivity.this.j = "null";
                            OlaCloudAlbumListActivity.this.k = "null";
                        }
                    }
                }));
            }
        }
    }

    @Override // chat.ola.vn.p.n
    public void b(String str, List<chat.ola.vn.entity.i> list, String str2) {
    }

    @Override // chat.ola.vn.cloud.d
    public void d(int i) {
        if (i == 0 || !H()) {
            this.i.setVisibility(8);
            return;
        }
        this.i.setVisibility(0);
        this.i.setText(getString(R.string.string_delete) + " (" + i + ")");
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
        if (this.g.c()) {
            this.g.e();
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
            if (id == R.id.olaActionBarButtonTextView && (listA = this.g.a()) != null && listA.size() > 0 && H()) {
                i.d(this, getString(R.string.string_delete_album), getString(R.string.message_delete_albums_confirm_format, new Object[]{listA.size() + ""}), getString(R.string.string_delete), getString(R.string.string_no), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.cloud.OlaCloudAlbumListActivity.1
                    @Override // android.content.DialogInterface.OnClickListener
                    public void onClick(DialogInterface dialogInterface, int i) {
                        if (i == 0) {
                            try {
                                List<l> listF = OlaCloudAlbumListActivity.this.g.f();
                                for (l lVar : listA) {
                                    listF.remove(lVar);
                                    OlaApplication.b.q(lVar.b, (short) 0);
                                }
                                OlaCloudAlbumListActivity.this.g.e();
                                OlaCloudAlbumListActivity.this.g.notifyDataSetChanged();
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
        F();
    }
}
