package chat.ola.vn.cloud;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.provider.MediaStore;
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
import chat.ola.vn.entry.ImageEntry;
import chat.ola.vn.entry.VideoEntry;
import chat.ola.vn.util.m;
import chat.ola.vn.view.g;
import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaLocalPhotoChooserActivity extends chat.ola.vn.c implements View.OnClickListener, j.a, d {
    private static g.e e;
    private GridView f = null;
    private chat.ola.vn.cloud.b g = null;
    private View h = null;
    private View i = null;
    private TextView j = null;
    private List<l> k = null;
    private l l = null;
    private File m = null;
    private ListView n;
    private chat.ola.vn.b.a o;
    private Runnable p;

    private class a extends AsyncTask<Context, Void, List<i>> {
        private a() {
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public List<i> doInBackground(Context... contextArr) {
            try {
                Cursor cursorQuery = contextArr[0].getContentResolver().query(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, ImageEntry.b, null, null, "datetaken DESC");
                if (!cursorQuery.moveToFirst()) {
                    return null;
                }
                long jCurrentTimeMillis = System.currentTimeMillis();
                ArrayList arrayList = new ArrayList(1000);
                do {
                    ImageEntry imageEntryA = ImageEntry.a(cursorQuery);
                    i iVar = new i();
                    iVar.a((short) 1);
                    iVar.m(imageEntryA.d);
                    iVar.a(imageEntryA.g);
                    if (com.mg.ola.common.d.c.a(imageEntryA.d) && com.mg.ola.common.d.c.h(new File(imageEntryA.d)) > 0) {
                        arrayList.add(iVar);
                    }
                    if (System.currentTimeMillis() - jCurrentTimeMillis > 5000) {
                        break;
                    }
                } while (cursorQuery.moveToNext());
                if (OlaLocalPhotoChooserActivity.this.l.b == null && arrayList.size() > 0) {
                    OlaLocalPhotoChooserActivity.this.l.d = ((i) arrayList.get(0)).m();
                    OlaLocalPhotoChooserActivity.this.l.g += arrayList.size();
                }
                return arrayList;
            } catch (Throwable unused) {
                return null;
            }
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public void onPostExecute(List<i> list) {
            boolean z;
            if (list != null) {
                try {
                    if (list.size() > 0) {
                        List<i> listG = OlaLocalPhotoChooserActivity.this.g.g();
                        if (listG == null) {
                            listG = new ArrayList<>();
                            z = true;
                        } else {
                            z = false;
                        }
                        listG.addAll(list);
                        Collections.sort(listG, new Comparator<i>() { // from class: chat.ola.vn.cloud.OlaLocalPhotoChooserActivity.a.1
                            @Override // java.util.Comparator
                            /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                            public int compare(i iVar, i iVar2) {
                                if (iVar.c() > iVar2.c()) {
                                    return -1;
                                }
                                return iVar.c() < iVar2.c() ? 1 : 0;
                            }
                        });
                        if (z) {
                            OlaLocalPhotoChooserActivity.this.g.b(listG);
                        }
                        OlaLocalPhotoChooserActivity.this.g.notifyDataSetChanged();
                    }
                } catch (Throwable unused) {
                }
            }
            OlaLocalPhotoChooserActivity.this.d(false);
        }
    }

    private class b extends AsyncTask<Context, Void, List<l>> {
        private b() {
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public List<l> doInBackground(Context... contextArr) {
            try {
                Cursor cursorQuery = contextArr[0].getContentResolver().query(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, ImageEntry.a, null, null, "datetaken DESC");
                ArrayList arrayList = new ArrayList(100);
                ArrayList arrayList2 = new ArrayList(100);
                if (cursorQuery != null) {
                    while (cursorQuery.moveToNext()) {
                        l lVar = new l();
                        lVar.b = cursorQuery.getString(cursorQuery.getColumnIndex("bucket_id"));
                        if (arrayList.contains(lVar.b)) {
                            l lVar2 = (l) arrayList2.get(arrayList.indexOf(lVar.b));
                            lVar2.g++;
                            try {
                                int columnIndex = cursorQuery.getColumnIndex("_data");
                                i iVar = new i();
                                iVar.a((short) 1);
                                iVar.m(cursorQuery.getString(columnIndex));
                                iVar.a(cursorQuery.getLong(cursorQuery.getColumnIndex("date_modified")));
                                if (lVar2.l == null) {
                                    lVar2.l = new ArrayList(100);
                                }
                                lVar2.l.add(iVar);
                            } catch (Throwable unused) {
                            }
                        } else {
                            lVar.a = cursorQuery.getString(cursorQuery.getColumnIndex("bucket_display_name"));
                            cursorQuery.getColumnIndex("_id");
                            try {
                                lVar.d = cursorQuery.getString(cursorQuery.getColumnIndex("_data"));
                                i iVar2 = new i();
                                iVar2.a((short) 1);
                                iVar2.m(lVar.d);
                                iVar2.a(cursorQuery.getLong(cursorQuery.getColumnIndex("date_modified")));
                                if (lVar.l == null) {
                                    lVar.l = new ArrayList(100);
                                }
                                lVar.l.add(iVar2);
                            } catch (Throwable unused2) {
                            }
                            lVar.g = 1;
                            arrayList2.add(lVar);
                            arrayList.add(lVar.b);
                        }
                    }
                    cursorQuery.close();
                }
                return arrayList2;
            } catch (Throwable unused3) {
                return null;
            }
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public void onPostExecute(List<l> list) {
            if (list != null) {
                try {
                    if (list.size() > 0) {
                        if (OlaLocalPhotoChooserActivity.this.k == null) {
                            OlaLocalPhotoChooserActivity.this.k = new ArrayList();
                        }
                        OlaLocalPhotoChooserActivity.this.k.addAll(list);
                        Collections.sort(OlaLocalPhotoChooserActivity.this.k, new Comparator<l>() { // from class: chat.ola.vn.cloud.OlaLocalPhotoChooserActivity.b.1
                            @Override // java.util.Comparator
                            /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                            public int compare(l lVar, l lVar2) {
                                if (lVar.f > lVar2.f) {
                                    return -1;
                                }
                                return lVar.f < lVar2.f ? 1 : 0;
                            }
                        });
                        OlaLocalPhotoChooserActivity.this.o.a(OlaLocalPhotoChooserActivity.this.k);
                        OlaLocalPhotoChooserActivity.this.o.notifyDataSetChanged();
                    }
                } catch (Throwable unused) {
                }
            }
            OlaLocalPhotoChooserActivity.this.d(false);
        }
    }

    private class c extends AsyncTask<Context, Void, List<i>> {
        private c() {
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public List<i> doInBackground(Context... contextArr) {
            try {
                Cursor cursorQuery = contextArr[0].getContentResolver().query(MediaStore.Video.Media.EXTERNAL_CONTENT_URI, VideoEntry.a, null, null, "datetaken DESC");
                if (!cursorQuery.moveToFirst()) {
                    return null;
                }
                int i = 10000;
                ArrayList arrayList = new ArrayList(10000);
                do {
                    VideoEntry videoEntryA = VideoEntry.a(cursorQuery);
                    if (videoEntryA.d < 3145728) {
                        i iVar = new i();
                        iVar.a((short) 2);
                        iVar.m(videoEntryA.c);
                        iVar.a(videoEntryA.f);
                        iVar.b(videoEntryA.g);
                        arrayList.add(iVar);
                        i--;
                    }
                    if (i <= 0) {
                        break;
                    }
                } while (cursorQuery.moveToNext());
                if (OlaLocalPhotoChooserActivity.this.l.b == null && arrayList.size() > 0) {
                    if (m.a(OlaLocalPhotoChooserActivity.this.l.c)) {
                        OlaLocalPhotoChooserActivity.this.l.d = ((i) arrayList.get(0)).m();
                    }
                    OlaLocalPhotoChooserActivity.this.l.g += arrayList.size();
                }
                return arrayList;
            } catch (Throwable unused) {
                return null;
            }
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public void onPostExecute(List<i> list) {
            boolean z;
            if (list != null) {
                try {
                    if (list.size() > 0) {
                        List<i> listG = OlaLocalPhotoChooserActivity.this.g.g();
                        if (listG == null) {
                            listG = new ArrayList<>();
                            z = true;
                        } else {
                            z = false;
                        }
                        listG.addAll(list);
                        Collections.sort(listG, new Comparator<i>() { // from class: chat.ola.vn.cloud.OlaLocalPhotoChooserActivity.c.1
                            @Override // java.util.Comparator
                            /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                            public int compare(i iVar, i iVar2) {
                                if (iVar.c() > iVar2.c()) {
                                    return -1;
                                }
                                return iVar.c() < iVar2.c() ? 1 : 0;
                            }
                        });
                        if (z) {
                            OlaLocalPhotoChooserActivity.this.g.b(listG);
                        }
                        OlaLocalPhotoChooserActivity.this.g.notifyDataSetChanged();
                    }
                } catch (Throwable unused) {
                }
            }
            OlaLocalPhotoChooserActivity.this.d(false);
        }
    }

    private void E() {
        this.f = (GridView) findViewById(R.id.albumGridView);
        this.f.setFadingEdgeLength(0);
        this.j = (TextView) findViewById(R.id.olaActionBarTitleTextView);
        findViewById(R.id.olaActionBarTitleViewLayout).setOnClickListener(this);
        findViewById(R.id.olaActionBarButtonTextView).setOnClickListener(this);
        findViewById(R.id.cameraImageView).setOnClickListener(this);
        this.h = findViewById(R.id.wattingProgressBar);
        this.i = findViewById(R.id.darkLayerLayout);
        this.i.setOnClickListener(this);
        this.n = (ListView) findViewById(R.id.albumChooserListView);
        this.o = new chat.ola.vn.b.a(this);
        this.n.setAdapter((ListAdapter) this.o);
        this.n.setOnItemClickListener(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.cloud.OlaLocalPhotoChooserActivity.1
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                try {
                    l item = OlaLocalPhotoChooserActivity.this.o.getItem(i);
                    if (item.k) {
                        return;
                    }
                    OlaLocalPhotoChooserActivity.this.f.setSelection(0);
                    OlaLocalPhotoChooserActivity.this.l.k = false;
                    OlaLocalPhotoChooserActivity.this.l = item;
                    OlaLocalPhotoChooserActivity.this.l.k = true;
                    OlaLocalPhotoChooserActivity.this.g.a();
                    OlaLocalPhotoChooserActivity.this.g.notifyDataSetChanged();
                    OlaLocalPhotoChooserActivity.this.j.setText(OlaLocalPhotoChooserActivity.this.l.a);
                    OlaLocalPhotoChooserActivity.this.o.notifyDataSetChanged();
                    OlaLocalPhotoChooserActivity.this.a_(0);
                    OlaLocalPhotoChooserActivity.this.c(false);
                } catch (Throwable unused) {
                }
            }
        });
    }

    private void F() {
        try {
            if (this.g == null) {
                this.g = new chat.ola.vn.cloud.b(this);
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
            this.l = new l();
            this.l.a = getString(R.string.string_all);
            this.k = new ArrayList();
            this.k.add(this.l);
            this.l.k = true;
            this.j.setText(this.l.a);
            this.o.a(this.k);
            this.o.notifyDataSetChanged();
            I();
            J();
        } catch (Throwable unused) {
        }
    }

    private void G() {
        try {
            if (Build.VERSION.SDK_INT < 23 || checkSelfPermission("android.permission.CAMERA") == 0) {
                H();
            } else {
                requestPermissions(new String[]{"android.permission.CAMERA"}, 105);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void H() {
        try {
            Intent intent = new Intent("android.media.action.IMAGE_CAPTURE");
            this.m = new File(chat.ola.vn.d.a(System.currentTimeMillis()));
            if (this.m.exists()) {
                this.m.delete();
            }
            intent.putExtra("output", Uri.fromFile(this.m));
            startActivityForResult(intent, 2);
        } catch (Throwable unused) {
        }
    }

    private void I() {
        d(true);
        List<l> listA = this.o.a();
        if (listA != null) {
            listA.clear();
            this.o.notifyDataSetChanged();
        }
        try {
            new b().execute(this);
        } catch (Throwable unused) {
        }
    }

    private void J() {
        d(true);
        List<i> listG = this.g.g();
        if (listG != null) {
            listG.clear();
            this.g.notifyDataSetChanged();
        }
        try {
            new a().execute(this);
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, g.e eVar) {
        e = eVar;
        context.startActivity(new Intent(context, (Class<?>) OlaLocalPhotoChooserActivity.class));
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_bottom_in, R.anim.push_top_out);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(boolean z) {
        if (z) {
            if (this.n.getVisibility() != 0) {
                this.n.setVisibility(0);
                this.i.setVisibility(0);
                Animation animationLoadAnimation = AnimationUtils.loadAnimation(this, R.anim.expand_animation);
                this.n.setVisibility(0);
                this.n.startAnimation(animationLoadAnimation);
                return;
            }
            return;
        }
        if (this.n.getVisibility() == 0) {
            Animation animationLoadAnimation2 = AnimationUtils.loadAnimation(this, R.anim.collapse_animation);
            this.n.setVisibility(8);
            this.n.startAnimation(animationLoadAnimation2);
            if (this.h.getVisibility() != 0) {
                this.i.setVisibility(8);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void d(boolean z) {
        if (this.p == null) {
            this.p = new Runnable() { // from class: chat.ola.vn.cloud.OlaLocalPhotoChooserActivity.2
                @Override // java.lang.Runnable
                public void run() {
                    OlaLocalPhotoChooserActivity.this.d(false);
                }
            };
        }
        try {
            OlaApplication.c(this.p);
        } catch (Throwable unused) {
        }
        if (z) {
            this.h.setVisibility(0);
            this.i.setVisibility(0);
            OlaApplication.a(this.p, 30000L);
        } else {
            this.h.setVisibility(8);
            if (this.n.getVisibility() != 0) {
                this.i.setVisibility(8);
            }
        }
    }

    @Override // chat.ola.vn.b.j.a
    public boolean B() {
        return false;
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
    public void a(View view, i iVar) {
    }

    @Override // chat.ola.vn.cloud.d
    public void a(l lVar) {
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(List<l> list, String str, short s) {
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        boolean z = false;
        if (this.l == null) {
            d(false);
            return;
        }
        if (this.l.b == null) {
            J();
            return;
        }
        if (this.l.l == null || this.l.l.size() <= 0) {
            return;
        }
        List<i> listG = this.g.g();
        if (listG == null) {
            listG = new ArrayList<>();
            z = true;
        }
        listG.addAll(this.l.l);
        Collections.sort(listG, new Comparator<i>() { // from class: chat.ola.vn.cloud.OlaLocalPhotoChooserActivity.3
            @Override // java.util.Comparator
            /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
            public int compare(i iVar, i iVar2) {
                if (iVar.c() > iVar2.c()) {
                    return -1;
                }
                return iVar.c() < iVar2.c() ? 1 : 0;
            }
        });
        if (z) {
            this.g.b(listG);
        }
        this.g.notifyDataSetChanged();
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

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) {
        if (i == 2 && i2 == -1) {
            try {
                if (this.m != null && this.m.exists()) {
                    File file = new File(chat.ola.vn.d.a(this.m.length()));
                    com.mg.ola.common.d.c.a(this.m, file, true);
                    this.m.delete();
                    ArrayList arrayList = new ArrayList(1);
                    arrayList.add(file.getAbsolutePath());
                    e.f(arrayList);
                    finish();
                }
            } catch (Throwable unused) {
            }
        }
        this.m = null;
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        if (this.n.getVisibility() == 0) {
            c(false);
        } else {
            super.onBackPressed();
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.cameraImageView) {
                G();
                return;
            }
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
                                arrayList.add(iVar.m());
                            } else if (iVar.f() == 2) {
                                arrayList2.add(iVar.m());
                            }
                        }
                        if (arrayList.size() > 0) {
                            e.f(arrayList);
                        }
                        if (arrayList2.size() > 0) {
                            e.g(arrayList2);
                        }
                    }
                    finish();
                    return;
                }
                if (id != R.id.olaActionBarTitleViewLayout) {
                    return;
                }
                if (this.n.getVisibility() != 0) {
                    if (this.k == null || this.k.size() <= 0) {
                        return;
                    }
                    c(true);
                    return;
                }
            }
            c(false);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_cloud_photo_chooser_layout);
        E();
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity, android.support.v4.app.ActivityCompat.OnRequestPermissionsResultCallback
    public void onRequestPermissionsResult(int i, String[] strArr, int[] iArr) {
        if (i == 105 && iArr[0] == 0) {
            H();
        }
    }
}
