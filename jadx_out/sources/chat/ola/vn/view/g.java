package chat.ola.vn.view;

import android.content.Context;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.os.AsyncTask;
import android.provider.MediaStore;
import android.util.AttributeSet;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaAttachmentPhotoListActivity;
import chat.ola.vn.activity.OlaImageViewerActivity;
import chat.ola.vn.b.j;
import chat.ola.vn.c.t;
import chat.ola.vn.entry.ImageEntry;
import chat.ola.vn.entry.VideoEntry;
import chat.ola.vn.mediastore.OlaMediaEntity;
import chat.ola.vn.network.OlaNetworkService;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import it.sephiroth.android.library.widget.HListView;
import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class g extends chat.ola.vn.view.d implements View.OnClickListener, j.a, chat.ola.vn.s.b {
    protected e a;
    private String b;
    private HListView c;
    private c d;
    private c e;
    private View f;
    private ImageView g;
    private ImageView h;
    private int i;
    private String j;
    private boolean k;
    private boolean l;
    private int m;
    private int n;
    private boolean o;
    private Animation p;
    private Animation q;
    private d r;

    private class a extends AsyncTask<Context, Void, List<chat.ola.vn.entity.i>> {
        private a() {
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public List<chat.ola.vn.entity.i> doInBackground(Context... contextArr) {
            try {
                Cursor cursorQuery = contextArr[0].getContentResolver().query(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, ImageEntry.b, null, null, "datetaken DESC");
                if (!cursorQuery.moveToFirst()) {
                    return null;
                }
                long jCurrentTimeMillis = System.currentTimeMillis();
                ArrayList arrayList = new ArrayList(1000);
                do {
                    ImageEntry imageEntryA = ImageEntry.a(cursorQuery);
                    chat.ola.vn.entity.i iVar = new chat.ola.vn.entity.i();
                    iVar.j(imageEntryA.d);
                    iVar.a((short) 1);
                    iVar.a(imageEntryA.g);
                    if (com.mg.ola.common.d.c.a(imageEntryA.d) && com.mg.ola.common.d.c.h(new File(imageEntryA.d)) > 0) {
                        arrayList.add(iVar);
                    }
                    if (System.currentTimeMillis() - jCurrentTimeMillis > 10000) {
                        break;
                    }
                } while (cursorQuery.moveToNext());
                return arrayList;
            } catch (Throwable unused) {
                return null;
            }
        }

        /* JADX INFO: Access modifiers changed from: protected */
        /* JADX WARN: Removed duplicated region for block: B:7:0x0025 A[Catch: Throwable -> 0x002a, TRY_LEAVE, TryCatch #0 {Throwable -> 0x002a, blocks: (B:4:0x0003, B:6:0x0009, B:7:0x0025), top: B:12:0x0003 }] */
        @Override // android.os.AsyncTask
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        public void onPostExecute(java.util.List<chat.ola.vn.entity.i> r4) {
            /*
                r3 = this;
                r0 = 0
                if (r4 == 0) goto L25
                int r1 = r4.size()     // Catch: java.lang.Throwable -> L2a
                if (r1 <= 0) goto L25
                chat.ola.vn.view.g r1 = chat.ola.vn.view.g.this     // Catch: java.lang.Throwable -> L2a
                int r2 = r4.size()     // Catch: java.lang.Throwable -> L2a
                chat.ola.vn.view.g.b(r1, r2)     // Catch: java.lang.Throwable -> L2a
                chat.ola.vn.view.g r1 = chat.ola.vn.view.g.this     // Catch: java.lang.Throwable -> L2a
                chat.ola.vn.view.g$c r1 = chat.ola.vn.view.g.i(r1)     // Catch: java.lang.Throwable -> L2a
                r1.a(r4)     // Catch: java.lang.Throwable -> L2a
                chat.ola.vn.view.g r4 = chat.ola.vn.view.g.this     // Catch: java.lang.Throwable -> L2a
                chat.ola.vn.view.g$c r4 = chat.ola.vn.view.g.i(r4)     // Catch: java.lang.Throwable -> L2a
                r4.notifyDataSetChanged()     // Catch: java.lang.Throwable -> L2a
                goto L2a
            L25:
                chat.ola.vn.view.g r4 = chat.ola.vn.view.g.this     // Catch: java.lang.Throwable -> L2a
                chat.ola.vn.view.g.c(r4, r0)     // Catch: java.lang.Throwable -> L2a
            L2a:
                chat.ola.vn.view.g r4 = chat.ola.vn.view.g.this
                chat.ola.vn.view.g.a(r4, r0)
                return
            */
            throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.view.g.a.onPostExecute(java.util.List):void");
        }
    }

    private class b extends AsyncTask<Context, Void, List<chat.ola.vn.entity.i>> {
        private b() {
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public List<chat.ola.vn.entity.i> doInBackground(Context... contextArr) {
            try {
                Cursor cursorQuery = contextArr[0].getContentResolver().query(MediaStore.Video.Media.EXTERNAL_CONTENT_URI, VideoEntry.a, null, null, "datetaken DESC");
                if (!cursorQuery.moveToFirst()) {
                    return null;
                }
                int i = 1000;
                ArrayList arrayList = new ArrayList(20);
                do {
                    VideoEntry videoEntryA = VideoEntry.a(cursorQuery);
                    if (videoEntryA.d < 3145728) {
                        chat.ola.vn.entity.i iVar = new chat.ola.vn.entity.i();
                        iVar.j(videoEntryA.c);
                        iVar.a((short) 2);
                        iVar.a(videoEntryA.f);
                        iVar.b(videoEntryA.g);
                        arrayList.add(iVar);
                        i--;
                    }
                    if (i <= 0) {
                        break;
                    }
                } while (cursorQuery.moveToNext());
                return arrayList;
            } catch (Throwable th) {
                th.printStackTrace();
                return null;
            }
        }

        /* JADX INFO: Access modifiers changed from: protected */
        /* JADX WARN: Removed duplicated region for block: B:7:0x0025 A[Catch: Throwable -> 0x002a, TRY_LEAVE, TryCatch #0 {Throwable -> 0x002a, blocks: (B:4:0x0003, B:6:0x0009, B:7:0x0025), top: B:12:0x0003 }] */
        @Override // android.os.AsyncTask
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        public void onPostExecute(java.util.List<chat.ola.vn.entity.i> r4) {
            /*
                r3 = this;
                r0 = 0
                if (r4 == 0) goto L25
                int r1 = r4.size()     // Catch: java.lang.Throwable -> L2a
                if (r1 <= 0) goto L25
                chat.ola.vn.view.g r1 = chat.ola.vn.view.g.this     // Catch: java.lang.Throwable -> L2a
                int r2 = r4.size()     // Catch: java.lang.Throwable -> L2a
                chat.ola.vn.view.g.b(r1, r2)     // Catch: java.lang.Throwable -> L2a
                chat.ola.vn.view.g r1 = chat.ola.vn.view.g.this     // Catch: java.lang.Throwable -> L2a
                chat.ola.vn.view.g$c r1 = chat.ola.vn.view.g.i(r1)     // Catch: java.lang.Throwable -> L2a
                r1.a(r4)     // Catch: java.lang.Throwable -> L2a
                chat.ola.vn.view.g r4 = chat.ola.vn.view.g.this     // Catch: java.lang.Throwable -> L2a
                chat.ola.vn.view.g$c r4 = chat.ola.vn.view.g.i(r4)     // Catch: java.lang.Throwable -> L2a
                r4.notifyDataSetChanged()     // Catch: java.lang.Throwable -> L2a
                goto L2a
            L25:
                chat.ola.vn.view.g r4 = chat.ola.vn.view.g.this     // Catch: java.lang.Throwable -> L2a
                chat.ola.vn.view.g.c(r4, r0)     // Catch: java.lang.Throwable -> L2a
            L2a:
                chat.ola.vn.view.g r4 = chat.ola.vn.view.g.this
                chat.ola.vn.view.g.a(r4, r0)
                return
            */
            throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.view.g.b.onPostExecute(java.util.List):void");
        }
    }

    private class c extends chat.ola.vn.b.j<chat.ola.vn.entity.i> {
        private LayoutInflater b;
        private List<chat.ola.vn.entity.i> c;
        private chat.ola.vn.e.i d;

        public c(Context context) {
            super(context);
            this.c = null;
            this.b = LayoutInflater.from(context);
        }

        @Override // chat.ola.vn.b.j
        public View a(int i, View view, ViewGroup viewGroup) {
            try {
                if (view == null) {
                    View viewInflate = this.b.inflate(R.layout.ola_attachment_photo_item_layout, (ViewGroup) null);
                    try {
                        viewInflate.setTag(g.this.new d(viewInflate, g.this.b));
                        view = viewInflate;
                    } catch (Throwable th) {
                        th = th;
                        view = viewInflate;
                        th.printStackTrace();
                    }
                } else if (view.getTag() == null) {
                    view.setTag(g.this.new d(view, g.this.b));
                }
                d dVar = (d) view.getTag();
                dVar.a();
                dVar.a(getItem(i));
            } catch (Throwable th2) {
                th = th2;
            }
            return view == null ? viewGroup : view;
        }

        @Override // android.widget.Adapter
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public chat.ola.vn.entity.i getItem(int i) {
            try {
                return this.c.get(i);
            } catch (Throwable unused) {
                return null;
            }
        }

        public void a() {
            try {
                this.c.clear();
            } catch (Throwable unused) {
            }
        }

        public void a(chat.ola.vn.entity.i iVar) {
            if (iVar == null) {
                return;
            }
            if (this.c == null) {
                this.c = new ArrayList();
            }
            this.c.add(0, iVar);
        }

        public void a(String str) {
            try {
                int size = this.c.size();
                for (int i = 0; i < size; i++) {
                    if (m.a(str, this.c.get(i).h())) {
                        this.c.remove(i);
                        return;
                    }
                }
            } catch (Throwable unused) {
            }
        }

        public void a(List<chat.ola.vn.entity.i> list) {
            if (list == null || list.size() == 0) {
                return;
            }
            if (this.c == null) {
                this.c = new ArrayList(list.size());
            }
            this.c.addAll(list);
            if (this.d == null) {
                this.d = new chat.ola.vn.e.i();
            }
            Collections.sort(this.c, this.d);
        }

        public boolean c() {
            try {
                return this.c.size() > 0;
            } catch (Throwable unused) {
                return false;
            }
        }

        @Override // chat.ola.vn.b.j, android.widget.Adapter
        public int getCount() {
            try {
                return this.c.size();
            } catch (Throwable unused) {
                return 0;
            }
        }
    }

    private class d implements View.OnClickListener {
        private View b;
        private View c;
        private View d;
        private OlaCachedImageView e;
        private View f;
        private TextView g;
        private TextView h;

        public d(View view, String str) {
            this.b = view.findViewById(R.id.photoImageViewLayout);
            this.c = view.findViewById(R.id.selectionLayout);
            this.d = view.findViewById(R.id.videoLayout);
            this.b.setOnClickListener(this);
            this.e = (OlaCachedImageView) view.findViewById(R.id.photoImageView);
            if (g.this.m > 0) {
                ViewGroup.LayoutParams layoutParams = this.e.getLayoutParams();
                layoutParams.height = g.this.m;
                layoutParams.width = g.this.m;
                this.e.setLayoutParams(layoutParams);
                ViewGroup.LayoutParams layoutParams2 = this.c.getLayoutParams();
                layoutParams2.height = g.this.m;
                layoutParams2.width = g.this.m;
                this.c.setLayoutParams(layoutParams2);
                ViewGroup.LayoutParams layoutParams3 = this.d.getLayoutParams();
                layoutParams3.width = g.this.m;
                this.d.setLayoutParams(layoutParams3);
            }
            this.f = view.findViewById(R.id.viewPhotoTextView);
            this.f.setOnClickListener(this);
            this.g = (TextView) view.findViewById(R.id.sendPhotoTextView);
            this.h = (TextView) view.findViewById(R.id.videoDurationTextView);
            if (m.a(str)) {
                this.g.setText(R.string.string_send);
            } else {
                this.g.setText(str);
            }
            this.g.setOnClickListener(this);
        }

        /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
        private void c() {
            View view;
            int i;
            if (this.c.getVisibility() == 0) {
                g.this.p.cancel();
                this.c.startAnimation(g.this.p);
                view = this.c;
                i = 8;
            } else {
                g.this.q.cancel();
                this.c.startAnimation(g.this.q);
                view = this.c;
                i = 0;
            }
            view.setVisibility(i);
        }

        public void a() {
            try {
                this.c.setVisibility(8);
            } catch (Throwable unused) {
            }
        }

        public void a(chat.ola.vn.entity.i iVar) {
            this.f.setTag(iVar);
            this.g.setTag(iVar);
            String strD = iVar.d();
            if (strD != null) {
                if (iVar.f() == 1) {
                    this.d.setVisibility(8);
                    t.a().b(strD, this.e, g.this.m > 0 ? g.this.m : 320);
                    return;
                } else if (iVar.f() == 2) {
                    this.d.setVisibility(0);
                    this.e.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
                    this.e.setImageResource(R.drawable.ic_media_video);
                    this.h.setVisibility(8);
                    return;
                }
            } else if (iVar.f() == 1) {
                this.d.setVisibility(8);
                t.a().e(iVar.h(), this.e);
                return;
            } else if (iVar.f() == 2) {
                this.h.setVisibility(0);
                this.h.setText(com.mg.ola.common.d.i.a(iVar.l() / 1000, ":", ":"));
                this.d.setVisibility(0);
                t.a().c(iVar.h(), this.e, R.drawable.ic_media_video);
                return;
            }
            this.d.setVisibility(8);
            this.e.a(null, null);
        }

        public void b() {
            try {
                g.this.p.cancel();
                this.c.startAnimation(g.this.p);
                this.c.setVisibility(8);
            } catch (Throwable unused) {
            }
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            try {
                int id = view.getId();
                if (id == R.id.photoImageViewLayout) {
                    if (g.this.r != null && g.this.r != this) {
                        g.this.r.b();
                    }
                    g.this.r = this;
                    c();
                    return;
                }
                if (id != R.id.sendPhotoTextView) {
                    if (id != R.id.viewPhotoTextView) {
                        return;
                    }
                    chat.ola.vn.entity.i iVar = (chat.ola.vn.entity.i) view.getTag();
                    if (g.this.a != null) {
                        String strD = iVar.d();
                        if (strD != null) {
                            if (iVar.f() == 1) {
                                OlaImageViewerActivity.a(chat.ola.vn.c.c(), this.e, (Bitmap) null, 0, new OlaMediaEntity(strD, 1, o.g(strD)));
                                return;
                            } else {
                                if (iVar.f() == 2) {
                                    chat.ola.vn.util.b.h(chat.ola.vn.c.c(), iVar.d());
                                    return;
                                }
                                return;
                            }
                        }
                        if (iVar.f() == 1) {
                            OlaImageViewerActivity.a(chat.ola.vn.c.c(), this.e, (Bitmap) null, 0, new OlaMediaEntity(iVar.h(), 2, (short) 1));
                            return;
                        } else {
                            if (iVar.f() == 2) {
                                chat.ola.vn.util.b.a(chat.ola.vn.c.c(), iVar.h(), 0);
                                return;
                            }
                            return;
                        }
                    }
                    return;
                }
                chat.ola.vn.entity.i iVar2 = (chat.ola.vn.entity.i) view.getTag();
                b();
                g.this.r = null;
                if (g.this.a != null) {
                    String strD2 = iVar2.d();
                    if (strD2 != null) {
                        if (iVar2.f() == 1) {
                            g.this.a.j(strD2);
                            return;
                        } else {
                            if (iVar2.f() == 2) {
                                g.this.a.k(strD2);
                                return;
                            }
                            return;
                        }
                    }
                    if (iVar2.f() == 1) {
                        g.this.a.h(iVar2.h());
                    } else if (iVar2.f() == 2) {
                        g.this.a.i(iVar2.h());
                    }
                }
            } catch (Throwable unused) {
            }
        }
    }

    public interface e {
        void M();

        void d(List<String> list);

        void e(List<String> list);

        void f(List<String> list);

        void g(List<String> list);

        void h(String str);

        void i(String str);

        void j(String str);

        void k(String str);
    }

    public g(Context context) {
        super(context);
        this.b = null;
        this.i = 1;
        this.k = true;
        this.l = true;
        this.m = 0;
        this.n = 0;
        this.o = true;
        this.r = null;
        a(context);
    }

    public g(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.b = null;
        this.i = 1;
        this.k = true;
        this.l = true;
        this.m = 0;
        this.n = 0;
        this.o = true;
        this.r = null;
        a(context);
    }

    public g(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.b = null;
        this.i = 1;
        this.k = true;
        this.l = true;
        this.m = 0;
        this.n = 0;
        this.o = true;
        this.r = null;
        a(context);
    }

    private void a(int i) {
        if (i == 0) {
            this.e.a();
            try {
                new a().execute(getContext());
            } catch (Throwable unused) {
            }
            if (this.o) {
                try {
                    new b().execute(getContext());
                } catch (Throwable unused2) {
                }
            }
        }
    }

    private void a(Context context) {
        inflate(context, R.layout.ola_attachment_photo_tab_layout, this);
        try {
            this.p = AnimationUtils.loadAnimation(context, R.anim.fade_out);
            this.p.setDuration(300L);
            this.q = AnimationUtils.loadAnimation(context, R.anim.fade_in);
            this.q.setDuration(300L);
            this.c = (HListView) findViewById(R.id.photoGalleryView);
            this.f = findViewById(R.id.loadingPhotoProgressBar);
            this.g = (ImageView) findViewById(R.id.expandStorageImageView);
            this.g.setOnClickListener(this);
            this.h = (ImageView) findViewById(R.id.switchStorageImageView);
            this.h.setSelected(false);
            this.h.setOnClickListener(this);
            this.d = new c(context);
            this.d.a(this);
            this.e = new c(context);
            this.e.a(this);
            OlaApplication.b.a(this);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void b() {
        Log.d("OlaChat", "------LOAD CLOUD PHOTO------");
        OlaNetworkService olaNetworkService = OlaApplication.b;
        if (olaNetworkService != null) {
            olaNetworkService.a("upload:" + chat.ola.vn.h.a(), (byte) 10, this.j, chat.ola.vn.entry.c.f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.view.g.1
                @Override // chat.ola.vn.entry.c.e
                public short a() {
                    return (short) 15;
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                    g.this.setProgressBarVisibility(false);
                    if (m.a(g.this.j)) {
                        g.this.setTab(1);
                    }
                    g.this.k = false;
                    g.this.j = null;
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(Object... objArr) {
                    try {
                        g.this.setProgressBarVisibility(false);
                        if (objArr.length > 1) {
                            List<chat.ola.vn.entity.i> list = (List) objArr[1];
                            if ((list == null || list.size() == 0) && m.a(g.this.j)) {
                                g.this.setTab(1);
                                return;
                            }
                            ArrayList arrayList = new ArrayList(list.size());
                            for (chat.ola.vn.entity.i iVar : list) {
                                if (iVar.f() == 1 || (g.this.o && iVar.f() == 2)) {
                                    arrayList.add(iVar);
                                }
                            }
                            if (m.a(g.this.j)) {
                                g.this.d.a();
                            }
                            if (arrayList.size() > 0) {
                                g.this.d.a(arrayList);
                            }
                            if (objArr.length > 2) {
                                g.this.j = (String) objArr[2];
                            } else {
                                g.this.j = null;
                            }
                            g.this.k = !m.a(g.this.j);
                            g.this.d.notifyDataSetChanged();
                        }
                    } catch (Throwable th) {
                        th.printStackTrace();
                    }
                }
            }));
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    public void setProgressBarVisibility(boolean z) {
        View view;
        int i;
        if (z) {
            view = this.f;
            i = 0;
        } else {
            view = this.f;
            i = 8;
        }
        view.setVisibility(i);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void setTab(int i) {
        this.i = i;
        switch (this.i) {
            case 0:
                this.h.setSelected(false);
                this.c.setAdapter((ListAdapter) this.d);
                if (!this.d.c()) {
                    setProgressBarVisibility(true);
                    b();
                }
                break;
            case 1:
                this.h.setSelected(true);
                this.c.setAdapter((ListAdapter) this.e);
                if (!this.e.c()) {
                    setProgressBarVisibility(true);
                    a(0);
                }
                break;
        }
    }

    @Override // chat.ola.vn.s.b
    public void A(String str) {
        try {
            final chat.ola.vn.entity.i iVar = new chat.ola.vn.entity.i();
            iVar.a((short) 1);
            iVar.j(str);
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.view.g.2
                @Override // java.lang.Runnable
                public void run() {
                    g.this.e.a(iVar);
                    g.this.e.notifyDataSetChanged();
                    g.this.c.c(0);
                }
            });
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.s.b
    public void B(final String str) {
        try {
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.view.g.3
                @Override // java.lang.Runnable
                public void run() {
                    g.this.e.a(str);
                    g.this.e.notifyDataSetChanged();
                    g.this.c.c(0);
                }
            });
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.b.j.a
    public boolean B() {
        return this.i != 0 ? this.l : this.k;
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        if (this.i != 0) {
            a(this.n);
        } else {
            b();
        }
    }

    public e getOlaPhotoListener() {
        return this.a;
    }

    public String getSendButtonText() {
        return this.b;
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.expandStorageImageView) {
                if (this.i == 0) {
                    OlaAttachmentPhotoListActivity.a(chat.ola.vn.c.c(), this.o, this.a);
                    return;
                } else {
                    OlaAttachmentPhotoListActivity.b(chat.ola.vn.c.c(), this.o, this.a);
                    return;
                }
            }
            if (id != R.id.switchStorageImageView) {
                return;
            }
            if (this.i == 0) {
                this.i = 1;
            } else {
                this.i = 0;
            }
            setTab(this.i);
        } catch (Throwable unused) {
        }
    }

    @Override // android.view.View
    protected void onSizeChanged(int i, int i2, int i3, int i4) {
        super.onSizeChanged(i, i2, i3, i4);
        this.m = i2;
        if (this.d.c() || this.e.c()) {
            return;
        }
        setProgressBarVisibility(true);
        setTab(this.i);
    }

    public void setAllowVideo(boolean z) {
        this.o = z;
    }

    public void setOlaPhotoListener(e eVar) {
        this.a = eVar;
    }

    public void setSendButtonText(String str) {
        this.b = str;
    }
}
