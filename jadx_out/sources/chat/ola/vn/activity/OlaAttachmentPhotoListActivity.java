package chat.ola.vn.activity;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.os.AsyncTask;
import android.os.Bundle;
import android.provider.MediaStore;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.b.j;
import chat.ola.vn.entity.i;
import chat.ola.vn.entry.ImageEntry;
import chat.ola.vn.entry.VideoEntry;
import chat.ola.vn.entry.c.f;
import chat.ola.vn.h;
import chat.ola.vn.network.OlaNetworkService;
import chat.ola.vn.util.m;
import chat.ola.vn.view.OlaCachedImageView;
import chat.ola.vn.view.g;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaAttachmentPhotoListActivity extends chat.ola.vn.c implements View.OnClickListener, j.a {
    private static byte m = 0;
    private static boolean n = true;
    private static boolean o = true;
    private static g.e p;
    private GridView e = null;
    private String f = null;
    private View g = null;
    private View h = null;
    private TextView i = null;
    private d j = null;
    private List<e> k = null;
    private List<e> l = null;

    private class a extends AsyncTask<Context, Void, List<e>> {
        private a() {
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public List<e> doInBackground(Context... contextArr) {
            try {
                Cursor cursorQuery = contextArr[0].getContentResolver().query(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, ImageEntry.b, null, null, "datetaken DESC");
                if (cursorQuery.moveToFirst()) {
                    long jCurrentTimeMillis = System.currentTimeMillis();
                    ArrayList arrayList = new ArrayList(1000);
                    do {
                        ImageEntry imageEntryA = ImageEntry.a(cursorQuery);
                        e eVar = new e();
                        eVar.c = (short) 1;
                        eVar.e = imageEntryA.d;
                        if (com.mg.ola.common.d.c.a(eVar.e) && com.mg.ola.common.d.c.h(new File(eVar.e)) > 0) {
                            eVar.a = imageEntryA.g;
                            arrayList.add(eVar);
                        }
                        if (System.currentTimeMillis() - jCurrentTimeMillis > 10000) {
                            break;
                        }
                    } while (cursorQuery.moveToNext());
                    return arrayList;
                }
            } catch (Throwable unused) {
            }
            return null;
        }

        /* JADX INFO: Access modifiers changed from: protected */
        /* JADX WARN: Removed duplicated region for block: B:9:0x003b A[Catch: Throwable -> 0x0042, TRY_LEAVE, TryCatch #0 {Throwable -> 0x0042, blocks: (B:3:0x0002, B:5:0x0008, B:7:0x0010, B:8:0x001a, B:9:0x003b), top: B:13:0x0002 }] */
        @Override // android.os.AsyncTask
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        public void onPostExecute(java.util.List<chat.ola.vn.activity.OlaAttachmentPhotoListActivity.e> r3) {
            /*
                r2 = this;
                if (r3 == 0) goto L3b
                int r0 = r3.size()     // Catch: java.lang.Throwable -> L42
                if (r0 <= 0) goto L3b
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity r0 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.this     // Catch: java.lang.Throwable -> L42
                java.util.List r0 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.a(r0)     // Catch: java.lang.Throwable -> L42
                if (r0 != 0) goto L1a
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity r0 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.this     // Catch: java.lang.Throwable -> L42
                java.util.ArrayList r1 = new java.util.ArrayList     // Catch: java.lang.Throwable -> L42
                r1.<init>()     // Catch: java.lang.Throwable -> L42
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity.a(r0, r1)     // Catch: java.lang.Throwable -> L42
            L1a:
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity r0 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.this     // Catch: java.lang.Throwable -> L42
                java.util.List r0 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.a(r0)     // Catch: java.lang.Throwable -> L42
                r0.addAll(r3)     // Catch: java.lang.Throwable -> L42
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity r3 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.this     // Catch: java.lang.Throwable -> L42
                java.util.List r3 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.a(r3)     // Catch: java.lang.Throwable -> L42
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity$a$1 r0 = new chat.ola.vn.activity.OlaAttachmentPhotoListActivity$a$1     // Catch: java.lang.Throwable -> L42
                r0.<init>()     // Catch: java.lang.Throwable -> L42
                java.util.Collections.sort(r3, r0)     // Catch: java.lang.Throwable -> L42
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity r3 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.this     // Catch: java.lang.Throwable -> L42
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity$d r3 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.b(r3)     // Catch: java.lang.Throwable -> L42
                r3.notifyDataSetChanged()     // Catch: java.lang.Throwable -> L42
                goto L42
            L3b:
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity r3 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.this     // Catch: java.lang.Throwable -> L42
                java.lang.String r0 = "null"
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity.a(r3, r0)     // Catch: java.lang.Throwable -> L42
            L42:
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity r3 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.this
                r0 = 0
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity.a(r3, r0)
                return
            */
            throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.activity.OlaAttachmentPhotoListActivity.a.onPostExecute(java.util.List):void");
        }
    }

    private class b extends AsyncTask<Context, Void, List<e>> {
        private b() {
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public List<e> doInBackground(Context... contextArr) {
            try {
                Cursor cursorQuery = contextArr[0].getContentResolver().query(MediaStore.Video.Media.EXTERNAL_CONTENT_URI, VideoEntry.a, null, null, "datetaken DESC");
                if (cursorQuery.moveToFirst()) {
                    int i = 10000;
                    ArrayList arrayList = new ArrayList(10000);
                    do {
                        VideoEntry videoEntryA = VideoEntry.a(cursorQuery);
                        if (videoEntryA.d < 3145728) {
                            e eVar = new e();
                            eVar.c = (short) 2;
                            eVar.e = videoEntryA.c;
                            eVar.a = videoEntryA.f;
                            eVar.b = videoEntryA.g;
                            arrayList.add(eVar);
                            i--;
                        }
                        if (i <= 0) {
                            break;
                        }
                    } while (cursorQuery.moveToNext());
                    return arrayList;
                }
            } catch (Throwable unused) {
            }
            return null;
        }

        /* JADX INFO: Access modifiers changed from: protected */
        /* JADX WARN: Removed duplicated region for block: B:9:0x003b A[Catch: Throwable -> 0x0042, TRY_LEAVE, TryCatch #0 {Throwable -> 0x0042, blocks: (B:3:0x0002, B:5:0x0008, B:7:0x0010, B:8:0x001a, B:9:0x003b), top: B:13:0x0002 }] */
        @Override // android.os.AsyncTask
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        public void onPostExecute(java.util.List<chat.ola.vn.activity.OlaAttachmentPhotoListActivity.e> r3) {
            /*
                r2 = this;
                if (r3 == 0) goto L3b
                int r0 = r3.size()     // Catch: java.lang.Throwable -> L42
                if (r0 <= 0) goto L3b
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity r0 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.this     // Catch: java.lang.Throwable -> L42
                java.util.List r0 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.a(r0)     // Catch: java.lang.Throwable -> L42
                if (r0 != 0) goto L1a
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity r0 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.this     // Catch: java.lang.Throwable -> L42
                java.util.ArrayList r1 = new java.util.ArrayList     // Catch: java.lang.Throwable -> L42
                r1.<init>()     // Catch: java.lang.Throwable -> L42
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity.a(r0, r1)     // Catch: java.lang.Throwable -> L42
            L1a:
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity r0 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.this     // Catch: java.lang.Throwable -> L42
                java.util.List r0 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.a(r0)     // Catch: java.lang.Throwable -> L42
                r0.addAll(r3)     // Catch: java.lang.Throwable -> L42
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity r3 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.this     // Catch: java.lang.Throwable -> L42
                java.util.List r3 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.a(r3)     // Catch: java.lang.Throwable -> L42
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity$b$1 r0 = new chat.ola.vn.activity.OlaAttachmentPhotoListActivity$b$1     // Catch: java.lang.Throwable -> L42
                r0.<init>()     // Catch: java.lang.Throwable -> L42
                java.util.Collections.sort(r3, r0)     // Catch: java.lang.Throwable -> L42
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity r3 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.this     // Catch: java.lang.Throwable -> L42
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity$d r3 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.b(r3)     // Catch: java.lang.Throwable -> L42
                r3.notifyDataSetChanged()     // Catch: java.lang.Throwable -> L42
                goto L42
            L3b:
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity r3 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.this     // Catch: java.lang.Throwable -> L42
                java.lang.String r0 = "null"
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity.a(r3, r0)     // Catch: java.lang.Throwable -> L42
            L42:
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity r3 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.this
                r0 = 0
                chat.ola.vn.activity.OlaAttachmentPhotoListActivity.a(r3, r0)
                return
            */
            throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.activity.OlaAttachmentPhotoListActivity.b.onPostExecute(java.util.List):void");
        }
    }

    private class c implements View.OnClickListener {
        private OlaCachedImageView b;
        private View c;
        private TextView d;
        private ImageView e;

        public c(View view) {
            this.b = (OlaCachedImageView) view.findViewById(R.id.photoImageView);
            this.b.setOnClickListener(this);
            this.e = (ImageView) view.findViewById(R.id.photoCheckedImageView);
            this.c = view.findViewById(R.id.videoLayout);
            this.d = (TextView) view.findViewById(R.id.videoDurationTextView);
        }

        /* JADX WARN: Removed duplicated region for block: B:10:0x0042  */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        public void a(chat.ola.vn.activity.OlaAttachmentPhotoListActivity.e r10) {
            /*
                r9 = this;
                chat.ola.vn.view.OlaCachedImageView r0 = r9.b
                r0.setTag(r10)
                java.lang.String r0 = r10.d
                r1 = 2131232538(0x7f08071a, float:1.8081188E38)
                r2 = 2
                r3 = 1
                r4 = 0
                r5 = 0
                r6 = 8
                if (r0 == 0) goto L4d
                short r7 = r10.c
                if (r7 != r3) goto L27
                android.view.View r1 = r9.c
                r1.setVisibility(r6)
                chat.ola.vn.c.t r1 = chat.ola.vn.c.t.a()
                chat.ola.vn.view.OlaCachedImageView r2 = r9.b
                r3 = 320(0x140, float:4.48E-43)
                r1.b(r0, r2, r3)
                goto L8d
            L27:
                short r0 = r10.c
                if (r0 != r2) goto L42
                android.widget.TextView r0 = r9.d
                r0.setVisibility(r6)
                android.view.View r0 = r9.c
                r0.setVisibility(r5)
                chat.ola.vn.view.OlaCachedImageView r0 = r9.b
                android.widget.ImageView$ScaleType r2 = android.widget.ImageView.ScaleType.CENTER_INSIDE
                r0.setScaleType(r2)
                chat.ola.vn.view.OlaCachedImageView r0 = r9.b
                r0.setImageResource(r1)
                goto L8d
            L42:
                android.view.View r0 = r9.c
                r0.setVisibility(r6)
                chat.ola.vn.view.OlaCachedImageView r0 = r9.b
                r0.a(r4, r4)
                goto L8d
            L4d:
                short r0 = r10.c
                if (r0 != r3) goto L62
                android.view.View r0 = r9.c
                r0.setVisibility(r6)
                java.lang.String r0 = r10.e
                chat.ola.vn.c.t r1 = chat.ola.vn.c.t.a()
                chat.ola.vn.view.OlaCachedImageView r2 = r9.b
                r1.e(r0, r2)
                goto L8d
            L62:
                short r0 = r10.c
                if (r0 != r2) goto L42
                android.widget.TextView r0 = r9.d
                r0.setVisibility(r5)
                android.widget.TextView r0 = r9.d
                long r2 = r10.b
                r7 = 1000(0x3e8, double:4.94E-321)
                long r2 = r2 / r7
                java.lang.String r4 = ":"
                java.lang.String r7 = ":"
                java.lang.String r2 = com.mg.ola.common.d.i.a(r2, r4, r7)
                r0.setText(r2)
                android.view.View r0 = r9.c
                r0.setVisibility(r5)
                java.lang.String r0 = r10.e
                chat.ola.vn.c.t r2 = chat.ola.vn.c.t.a()
                chat.ola.vn.view.OlaCachedImageView r3 = r9.b
                r2.c(r0, r3, r1)
            L8d:
                boolean r0 = chat.ola.vn.activity.OlaAttachmentPhotoListActivity.C()
                if (r0 == 0) goto Lab
                android.widget.ImageView r0 = r9.e
                r0.setVisibility(r5)
                boolean r10 = r10.f
                if (r10 == 0) goto La5
                android.widget.ImageView r10 = r9.e
                r0 = 2131232439(0x7f0806b7, float:1.8080987E38)
            La1:
                r10.setImageResource(r0)
                return
            La5:
                android.widget.ImageView r10 = r9.e
                r0 = 2131232440(0x7f0806b8, float:1.808099E38)
                goto La1
            Lab:
                android.widget.ImageView r10 = r9.e
                r10.setVisibility(r6)
                return
            */
            throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.activity.OlaAttachmentPhotoListActivity.c.a(chat.ola.vn.activity.OlaAttachmentPhotoListActivity$e):void");
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            try {
                if (view.getId() != R.id.photoImageView) {
                    return;
                }
                e eVar = (e) view.getTag();
                if (OlaAttachmentPhotoListActivity.n) {
                    eVar.f = !eVar.f;
                    OlaAttachmentPhotoListActivity.this.a(eVar);
                    OlaAttachmentPhotoListActivity.this.j.notifyDataSetChanged();
                    return;
                }
                try {
                    if (OlaAttachmentPhotoListActivity.m == 0) {
                        ArrayList arrayList = new ArrayList(1);
                        arrayList.add(eVar.d);
                        if (eVar.c == 1) {
                            OlaAttachmentPhotoListActivity.p.d(arrayList);
                        } else if (eVar.c == 2) {
                            OlaAttachmentPhotoListActivity.p.e(arrayList);
                        }
                    } else {
                        ArrayList arrayList2 = new ArrayList(1);
                        arrayList2.add(eVar.e);
                        if (eVar.c == 1) {
                            OlaAttachmentPhotoListActivity.p.f(arrayList2);
                        } else if (eVar.c == 2) {
                            OlaAttachmentPhotoListActivity.p.g(arrayList2);
                        }
                    }
                } catch (Throwable unused) {
                }
                OlaAttachmentPhotoListActivity.this.finish();
            } catch (Throwable unused2) {
            }
        }
    }

    private class d extends j<e> {
        private LayoutInflater b;

        public d() {
            super(OlaAttachmentPhotoListActivity.this);
            this.b = LayoutInflater.from(OlaAttachmentPhotoListActivity.this);
        }

        @Override // chat.ola.vn.b.j
        public View a(int i, View view, ViewGroup viewGroup) {
            try {
                if (view == null) {
                    View viewInflate = this.b.inflate(R.layout.ola_attachment_photo_selection_item_layout, (ViewGroup) null);
                    try {
                        viewInflate.setTag(OlaAttachmentPhotoListActivity.this.new c(viewInflate));
                        view = viewInflate;
                    } catch (Throwable th) {
                        th = th;
                        view = viewInflate;
                        th.printStackTrace();
                    }
                } else if (view.getTag() == null) {
                    view.setTag(OlaAttachmentPhotoListActivity.this.new c(view));
                }
                ((c) view.getTag()).a(getItem(i));
            } catch (Throwable th2) {
                th = th2;
            }
            return view == null ? viewGroup : view;
        }

        @Override // android.widget.Adapter
        /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
        public e getItem(int i) {
            try {
                return (e) OlaAttachmentPhotoListActivity.this.k.get(i);
            } catch (Throwable unused) {
                return null;
            }
        }

        @Override // chat.ola.vn.b.j, android.widget.Adapter
        public int getCount() {
            try {
                return OlaAttachmentPhotoListActivity.this.k.size();
            } catch (Throwable unused) {
                return 0;
            }
        }
    }

    private class e {
        long a;
        long b;
        public short c;
        public String d;
        public String e;
        public boolean f;

        private e() {
            this.a = 0L;
            this.b = 0L;
            this.c = (short) 1;
            this.d = null;
            this.e = null;
            this.f = false;
        }
    }

    private void G() {
        this.e = (GridView) findViewById(R.id.photoGridView);
        this.e.setFadingEdgeLength(0);
        this.e.setNumColumns(3);
        this.i = (TextView) findViewById(R.id.numberSelectedPhotoTextView);
        this.h = findViewById(R.id.wattingProgressBar);
        findViewById(R.id.collapseStorageImageView).setOnClickListener(this);
        View viewFindViewById = findViewById(R.id.sendImageView);
        viewFindViewById.setOnClickListener(this);
        viewFindViewById.setVisibility(n ? 0 : 8);
        this.g = getLayoutInflater().inflate(R.layout.load_more_watting_span_view, (ViewGroup) null);
        this.g.setVisibility(4);
        this.j = new d();
        this.j.a(this);
        this.e.setAdapter((ListAdapter) this.j);
        switch (m) {
            case 0:
                I();
                break;
            case 1:
                J();
                break;
        }
    }

    private void H() {
    }

    private void I() {
        c(true);
        OlaNetworkService olaNetworkService = OlaApplication.b;
        if (olaNetworkService != null) {
            olaNetworkService.a("upload:" + h.a(), (byte) 30, this.f, f.a(new chat.ola.vn.entry.c.e() { // from class: chat.ola.vn.activity.OlaAttachmentPhotoListActivity.1
                @Override // chat.ola.vn.entry.c.e
                public short a() {
                    return (short) 15;
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
                    OlaAttachmentPhotoListActivity.this.c(false);
                    OlaAttachmentPhotoListActivity.this.f = "null";
                }

                @Override // chat.ola.vn.entry.c.e
                public void a(Object... objArr) {
                    OlaAttachmentPhotoListActivity olaAttachmentPhotoListActivity;
                    String str;
                    try {
                        OlaAttachmentPhotoListActivity.this.c(false);
                        if (objArr.length > 1) {
                            List<i> list = (List) objArr[1];
                            if ((list == null || list.size() == 0) && m.a(OlaAttachmentPhotoListActivity.this.f)) {
                                return;
                            }
                            ArrayList arrayList = new ArrayList(list.size());
                            for (i iVar : list) {
                                if (iVar.f() == 1 || (OlaAttachmentPhotoListActivity.o && iVar.f() == 2)) {
                                    e eVar = new e();
                                    eVar.c = iVar.f();
                                    eVar.d = iVar.d();
                                    arrayList.add(eVar);
                                }
                            }
                            if (OlaAttachmentPhotoListActivity.this.k == null) {
                                OlaAttachmentPhotoListActivity.this.k = new ArrayList();
                            }
                            if (m.a(OlaAttachmentPhotoListActivity.this.f)) {
                                OlaAttachmentPhotoListActivity.this.k.clear();
                            }
                            if (arrayList.size() > 0) {
                                OlaAttachmentPhotoListActivity.this.k.addAll(arrayList);
                            }
                            if (objArr.length > 2) {
                                OlaAttachmentPhotoListActivity.this.f = (String) objArr[2];
                                if (m.a(OlaAttachmentPhotoListActivity.this.f)) {
                                    olaAttachmentPhotoListActivity = OlaAttachmentPhotoListActivity.this;
                                    str = "null";
                                }
                                OlaAttachmentPhotoListActivity.this.j.notifyDataSetChanged();
                            }
                            olaAttachmentPhotoListActivity = OlaAttachmentPhotoListActivity.this;
                            str = "null";
                            olaAttachmentPhotoListActivity.f = str;
                            OlaAttachmentPhotoListActivity.this.j.notifyDataSetChanged();
                        }
                    } catch (Throwable th) {
                        th.printStackTrace();
                    }
                }
            }));
        }
    }

    private void J() {
        c(true);
        if (this.k != null) {
            this.k.clear();
        }
        try {
            new a().execute(this);
        } catch (Throwable unused) {
        }
        if (o) {
            try {
                new b().execute(this);
            } catch (Throwable unused2) {
            }
        }
    }

    private static void a(Activity activity, byte b2, boolean z, g.e eVar) {
        m = b2;
        p = eVar;
        n = z;
        Intent intent = new Intent(activity, (Class<?>) OlaAttachmentPhotoListActivity.class);
        intent.addFlags(131072);
        activity.startActivity(intent);
        try {
            activity.overridePendingTransition(R.anim.push_bottom_in, R.anim.push_top_out);
        } catch (Throwable unused) {
        }
    }

    public static void a(Activity activity, boolean z, g.e eVar) {
        o = z;
        a(activity, (byte) 0, true, eVar);
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    public void a(e eVar) {
        TextView textView;
        int i;
        if (this.l == null) {
            this.l = new ArrayList();
        }
        if (!eVar.f) {
            this.l.remove(eVar);
        } else if (!this.l.contains(eVar)) {
            this.l.add(eVar);
        }
        if (this.l.size() > 0) {
            this.i.setText("" + this.l.size());
            textView = this.i;
            i = 0;
        } else {
            textView = this.i;
            i = 8;
        }
        textView.setVisibility(i);
    }

    public static void b(Activity activity, boolean z, g.e eVar) {
        o = z;
        a(activity, (byte) 1, true, eVar);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(boolean z) {
        this.h.setVisibility(z ? 0 : 8);
    }

    @Override // chat.ola.vn.b.j.a
    public boolean B() {
        if (m != 0) {
            return false;
        }
        return !m.b(this.f, "null");
    }

    @Override // chat.ola.vn.c
    protected void a() {
        H();
    }

    @Override // chat.ola.vn.b.j.a
    public void a_(int i) {
        try {
            if (i == 0) {
                this.h.setVisibility(0);
                this.g.setVisibility(4);
            } else {
                this.h.setVisibility(8);
                this.g.setVisibility(0);
            }
            if (m != 0) {
                return;
            }
            I();
        } catch (Throwable unused) {
        }
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
        if (p != null) {
            p.M();
        }
        super.onBackPressed();
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id != R.id.collapseStorageImageView) {
                if (id != R.id.sendImageView || this.l == null || this.l.size() <= 0) {
                    return;
                }
                try {
                    ArrayList arrayList = null;
                    if (m == 0) {
                        ArrayList arrayList2 = null;
                        for (e eVar : this.l) {
                            if (eVar.c == 1) {
                                if (arrayList == null) {
                                    arrayList = new ArrayList(this.l.size());
                                }
                                arrayList.add(eVar.d);
                            } else if (eVar.c == 2) {
                                if (arrayList2 == null) {
                                    arrayList2 = new ArrayList(this.l.size());
                                }
                                arrayList2.add(eVar.d);
                            }
                        }
                        if (arrayList != null) {
                            p.d(arrayList);
                        }
                        if (arrayList2 != null) {
                            p.e(arrayList2);
                        }
                    } else {
                        ArrayList arrayList3 = null;
                        for (e eVar2 : this.l) {
                            if (eVar2.c == 1) {
                                if (arrayList == null) {
                                    arrayList = new ArrayList(this.l.size());
                                }
                                arrayList.add(eVar2.e);
                            } else if (eVar2.c == 2) {
                                if (arrayList3 == null) {
                                    arrayList3 = new ArrayList(this.l.size());
                                }
                                arrayList3.add(eVar2.e);
                            }
                        }
                        if (arrayList != null) {
                            p.f(arrayList);
                        }
                        if (arrayList3 != null) {
                            p.g(arrayList3);
                        }
                    }
                } catch (Throwable unused) {
                }
            }
            finish();
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_attachment_photo_list_activity_layout);
        G();
    }
}
