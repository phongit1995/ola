package chat.ola.vn.cloud;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.GridView;
import android.widget.ListAdapter;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaImageViewerActivity;
import chat.ola.vn.b.j;
import chat.ola.vn.entity.i;
import chat.ola.vn.entity.l;
import chat.ola.vn.h;
import chat.ola.vn.me.OlaMeComposerActivity;
import chat.ola.vn.mediastore.OlaMediaEntity;
import chat.ola.vn.message.f;
import chat.ola.vn.p.n;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaCloudPhotoListActivity extends chat.ola.vn.c implements View.OnClickListener, j.a, d, n {
    private static l e;
    private static String f;
    private GridView g = null;
    private b h = null;
    private View i = null;
    private View j = null;
    private TextView k = null;
    private String l = null;
    private String m = null;
    private Runnable n;

    private void F() {
        TextView textView;
        String str;
        this.g = (GridView) findViewById(R.id.albumGridView);
        this.g.setFadingEdgeLength(0);
        findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
        findViewById(R.id.olaActionBarTitleViewLayout).setOnClickListener(this);
        if (e == null || m.a(e.a)) {
            if (m.a(f)) {
                ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.general_tab_mediastore);
            } else {
                f fVarD = h.t.d(f);
                if (fVarD != null) {
                    ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(fVarD.L().toString());
                } else {
                    textView = (TextView) findViewById(R.id.olaActionBarTitleTextView);
                    str = f;
                }
            }
            this.i = findViewById(R.id.wattingProgressBar);
            this.j = findViewById(R.id.olaActionBarMoreButtonImageView);
            this.j.setOnClickListener(this);
            this.k = (TextView) findViewById(R.id.olaActionBarButtonTextView);
            this.k.setOnClickListener(this);
        }
        textView = (TextView) findViewById(R.id.olaActionBarTitleTextView);
        str = e.a;
        textView.setText(str);
        this.i = findViewById(R.id.wattingProgressBar);
        this.j = findViewById(R.id.olaActionBarMoreButtonImageView);
        this.j.setOnClickListener(this);
        this.k = (TextView) findViewById(R.id.olaActionBarButtonTextView);
        this.k.setOnClickListener(this);
    }

    private void G() {
        try {
            if (this.h == null) {
                this.h = new b(this);
                this.h.a((d) this);
                this.h.a((j.a) this);
                this.g.setAdapter((ListAdapter) this.h);
            }
            if (this.h.g() != null && this.h.g().size() != 0) {
                this.h.notifyDataSetChanged();
                return;
            }
            a_(0);
        } catch (Throwable unused) {
        }
    }

    private void H() {
        try {
            final ArrayList arrayList = new ArrayList();
            if (J()) {
                arrayList.add(getString(R.string.string_post_me));
                arrayList.add(getString(R.string.string_copy));
            } else {
                arrayList.add(getString(R.string.string_copy));
            }
            arrayList.add(getString(R.string.string_copy_plus));
            chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(this);
            mVar.a(arrayList);
            mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.cloud.OlaCloudPhotoListActivity.2
                @Override // android.widget.AdapterView.OnItemClickListener
                public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                    List<i> listC;
                    try {
                        String str = (String) arrayList.get(i);
                        if (m.b(OlaCloudPhotoListActivity.this.getString(R.string.string_post_me), str)) {
                            List<i> listC2 = OlaCloudPhotoListActivity.this.h.c();
                            ArrayList arrayList2 = new ArrayList();
                            for (i iVar : listC2) {
                                if (!m.a(iVar.d())) {
                                    arrayList2.add(iVar.d());
                                }
                            }
                            OlaMeComposerActivity.a(OlaCloudPhotoListActivity.this, (String) null, (String) null, arrayList2);
                            return;
                        }
                        int i2 = 1;
                        if (m.b(OlaCloudPhotoListActivity.this.getString(R.string.string_copy), str)) {
                            List<i> listC3 = OlaCloudPhotoListActivity.this.h.c();
                            if (listC3 == null || listC3.size() <= 0) {
                                return;
                            }
                            String str2 = "##" + listC3.get(0).d() + "#";
                            int size = listC3.size();
                            while (i2 < size) {
                                i iVar2 = listC3.get(i2);
                                if (!m.a(iVar2.d())) {
                                    str2 = str2 + " ##" + iVar2.d() + "#";
                                }
                                i2++;
                            }
                            if (m.a(str2)) {
                                return;
                            }
                            o.a(OlaCloudPhotoListActivity.this, str2);
                            return;
                        }
                        if (!m.b(OlaCloudPhotoListActivity.this.getString(R.string.string_copy_plus), str) || (listC = OlaCloudPhotoListActivity.this.h.c()) == null || listC.size() <= 0) {
                            return;
                        }
                        String str3 = "##" + listC.get(0).d() + "#";
                        int size2 = listC.size();
                        while (i2 < size2) {
                            i iVar3 = listC.get(i2);
                            if (!m.a(iVar3.d())) {
                                str3 = str3 + " ##" + iVar3.d() + "#";
                            }
                            i2++;
                        }
                        if (m.a(str3)) {
                            return;
                        }
                        o.a(OlaCloudPhotoListActivity.this, o.a(OlaCloudPhotoListActivity.this) + " " + str3);
                    } catch (Throwable unused) {
                    }
                }
            });
            mVar.show();
        } catch (Throwable unused) {
        }
    }

    private boolean I() {
        return true;
    }

    private boolean J() {
        try {
            if (m.a(f)) {
                return true;
            }
            return m.b(f, h.a());
        } catch (Throwable unused) {
            return false;
        }
    }

    public static void a(Context context, l lVar) {
        a(context, (String) null, lVar);
    }

    public static void a(Context context, String str) {
        a(context, str, (l) null);
    }

    public static void a(Context context, String str, l lVar) {
        e = lVar;
        f = str;
        context.startActivity(new Intent(context, (Class<?>) OlaCloudPhotoListActivity.class));
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(boolean z) {
        if (this.n == null) {
            this.n = new Runnable() { // from class: chat.ola.vn.cloud.OlaCloudPhotoListActivity.3
                @Override // java.lang.Runnable
                public void run() {
                    OlaCloudPhotoListActivity.this.c(false);
                    chat.ola.vn.i.i.a(OlaCloudPhotoListActivity.this, R.string.dialog_title_inform, R.string.message_process_timeout);
                }
            };
        }
        try {
            OlaApplication.c(this.n);
        } catch (Throwable unused) {
        }
        if (!z) {
            this.i.setVisibility(8);
        } else {
            this.i.setVisibility(0);
            OlaApplication.a(this.n, 30000L);
        }
    }

    @Override // chat.ola.vn.b.j.a
    public boolean B() {
        return !m.b(this.l, "null");
    }

    @Override // chat.ola.vn.cloud.d
    public void C() {
    }

    @Override // chat.ola.vn.cloud.d
    public void D() {
        this.j.setVisibility(8);
        this.k.setVisibility(8);
    }

    @Override // chat.ola.vn.c
    protected void a() {
        G();
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(int i, String str, byte[] bArr, chat.ola.vn.entity.d[] dVarArr, short s) {
        c(false);
        this.l = "null";
        this.m = "null";
    }

    @Override // chat.ola.vn.cloud.d
    public void a(View view, i iVar) {
        String strD = iVar.d();
        switch (iVar.f()) {
            case 1:
                ArrayList arrayList = new ArrayList();
                List<i> listG = this.h.g();
                if (listG != null) {
                    int size = listG.size();
                    int size2 = 0;
                    for (int i = 0; i < size; i++) {
                        i iVar2 = listG.get(i);
                        if (iVar2.f() == 1) {
                            if (m.a(iVar2.d(), strD)) {
                                size2 = arrayList.size();
                            }
                            arrayList.add(new OlaMediaEntity(iVar2.d(), 1, (short) 1));
                        }
                    }
                    if (arrayList != null && arrayList.size() > 0) {
                        OlaImageViewerActivity.a(this, view, (Bitmap) null, size2, (ArrayList<OlaMediaEntity>) arrayList);
                        break;
                    }
                }
                break;
            case 2:
                chat.ola.vn.util.b.h(this, strD);
                break;
            case 3:
                chat.ola.vn.util.b.f(this, strD);
                break;
        }
    }

    @Override // chat.ola.vn.cloud.d
    public void a(l lVar) {
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(String str, String str2, List<i> list, String str3, short s) {
        try {
            c(false);
            this.l = str3;
            if (m.a(str3) || list == null || list.size() == 0) {
                this.l = "null";
                this.m = "null";
            }
            this.h.a(list);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.p.n
    public void a(String str, List<l> list, String str2) {
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(String str, List<i> list, String str2, short s) {
        try {
            c(false);
            this.l = str2;
            if (m.a(str2) || list == null || list.size() == 0) {
                this.l = "null";
                this.m = "null";
            }
            this.h.a(list);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.p.n
    public void a(List<l> list, String str) {
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        String str;
        if (this.l == null || !m.b(this.l, this.m)) {
            if (i == 0) {
                c(true);
            } else {
                c(false);
            }
            this.m = this.l;
            try {
                str = e.b;
            } catch (Throwable unused) {
                str = null;
            }
            if (m.b(this.l, "null")) {
                return;
            }
            if (J()) {
                OlaApplication.b.a(str, (byte) 50, this.l, (short) 0);
            } else {
                OlaApplication.b.a(f, str, (byte) 50, this.l, (short) 0);
            }
        }
    }

    @Override // chat.ola.vn.p.n
    public void b(String str, List<i> list, String str2) {
        c(false);
        this.l = str2;
        this.h.a(list);
    }

    @Override // chat.ola.vn.cloud.d
    public void d(int i) {
        TextView textView;
        StringBuilder sb;
        int i2;
        if (i <= 0) {
            this.j.setVisibility(8);
            this.k.setVisibility(8);
            return;
        }
        if (I()) {
            this.j.setVisibility(0);
        }
        if (J()) {
            textView = this.k;
            sb = new StringBuilder();
            i2 = R.string.string_delete;
        } else {
            textView = this.k;
            sb = new StringBuilder();
            i2 = R.string.string_post_me;
        }
        sb.append(getString(i2));
        sb.append(" (");
        sb.append(i);
        sb.append(")");
        textView.setText(sb.toString());
        this.k.setVisibility(0);
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
        if (this.h.d()) {
            this.h.f();
        } else {
            super.onBackPressed();
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.olaActionBarBackViewLayout) {
                finish();
                return;
            }
            if (id != R.id.olaActionBarButtonTextView) {
                if (id != R.id.olaActionBarMoreButtonImageView) {
                    return;
                }
                H();
                return;
            }
            final List<i> listC = this.h.c();
            if (listC == null || listC.size() <= 0) {
                return;
            }
            if (J()) {
                chat.ola.vn.i.i.d(this, getString(R.string.string_delete_media), getString(R.string.message_delete_media_in_album_format, new Object[]{listC.size() + "", e.a}), getString(R.string.string_delete), getString(R.string.string_no), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.cloud.OlaCloudPhotoListActivity.1
                    @Override // android.content.DialogInterface.OnClickListener
                    public void onClick(DialogInterface dialogInterface, int i) {
                        if (i == 0) {
                            try {
                                List<i> listG = OlaCloudPhotoListActivity.this.h.g();
                                String[] strArr = new String[listC.size()];
                                for (int i2 = 0; i2 < strArr.length; i2++) {
                                    i iVar = (i) listC.get(i2);
                                    listG.remove(iVar);
                                    strArr[i2] = iVar.d();
                                }
                                OlaApplication.b.a(OlaCloudPhotoListActivity.e.b, strArr, (short) 0);
                                OlaCloudPhotoListActivity.this.h.f();
                                OlaCloudPhotoListActivity.this.h.notifyDataSetChanged();
                            } catch (Throwable unused) {
                                return;
                            }
                        }
                        dialogInterface.dismiss();
                    }
                });
                return;
            }
            ArrayList arrayList = new ArrayList();
            for (i iVar : listC) {
                if (!m.a(iVar.d())) {
                    arrayList.add(iVar.d());
                }
            }
            OlaMeComposerActivity.a(this, (String) null, (String) null, arrayList);
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
