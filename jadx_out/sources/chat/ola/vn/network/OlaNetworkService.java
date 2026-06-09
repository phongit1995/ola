package chat.ola.vn.network;

import android.annotation.TargetApi;
import android.app.Service;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.util.Log;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.activity.OlaFacebookActivity;
import chat.ola.vn.c.x;
import chat.ola.vn.entity.aa;
import chat.ola.vn.entity.v;
import chat.ola.vn.network.a.a.ab;
import chat.ola.vn.network.a.a.ac;
import chat.ola.vn.network.a.a.ad;
import chat.ola.vn.network.a.a.ae;
import chat.ola.vn.network.a.a.af;
import chat.ola.vn.network.a.a.ag;
import chat.ola.vn.network.a.a.ah;
import chat.ola.vn.network.a.a.ai;
import chat.ola.vn.network.a.a.aj;
import chat.ola.vn.network.a.a.ak;
import chat.ola.vn.network.a.a.al;
import chat.ola.vn.network.a.a.am;
import chat.ola.vn.network.a.a.k;
import chat.ola.vn.network.a.a.l;
import chat.ola.vn.network.a.a.o;
import chat.ola.vn.network.a.a.p;
import chat.ola.vn.network.a.a.q;
import chat.ola.vn.network.a.a.r;
import chat.ola.vn.network.a.a.s;
import chat.ola.vn.network.a.a.t;
import chat.ola.vn.network.a.a.u;
import chat.ola.vn.network.a.a.w;
import chat.ola.vn.network.a.a.y;
import chat.ola.vn.network.a.a.z;
import chat.ola.vn.p.j;
import chat.ola.vn.p.n;
import chat.ola.vn.p.p;
import chat.ola.vn.util.m;
import chat.ola.vn.w.ci;
import com.facebook.AccessToken;
import com.facebook.GraphRequest;
import com.facebook.GraphResponse;
import com.facebook.HttpMethod;
import com.facebook.internal.NativeProtocol;
import com.facebook.share.internal.ShareConstants;
import com.google.firebase.analytics.FirebaseAnalytics;
import java.io.File;
import java.lang.ref.WeakReference;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class OlaNetworkService extends Service implements i, chat.ola.vn.s.b {
    public static int b = 0;
    public static int c = 1239;
    private static List<String> x = new ArrayList();
    protected d d;
    protected Socket e;
    protected ci g;
    protected e h;
    protected Handler i;
    private Runnable m;
    private long n;
    private long o;
    private long p;
    private long q;
    private WeakReference<chat.ola.vn.s.b> w;
    long a = 5000;
    private int l = 1;
    protected String f = null;
    List<f> j = new CopyOnWriteArrayList();
    private long r = 0;
    private String s = null;
    private long t = 0;
    public boolean k = false;
    private ExecutorService u = null;
    private List<chat.ola.vn.s.a> v = null;
    private long y = 0;

    private chat.ola.vn.entity.c A() {
        chat.ola.vn.entity.c cVar = new chat.ola.vn.entity.c();
        cVar.a(chat.ola.vn.e.c);
        cVar.b(chat.ola.vn.e.d);
        cVar.f(chat.ola.vn.h.f);
        cVar.d(chat.ola.vn.h.g);
        cVar.e(chat.ola.vn.f.a.n);
        int iG = chat.ola.vn.h.r;
        if (iG == 0) {
            iG = chat.ola.vn.e.a().g();
        }
        cVar.c(iG);
        cVar.b("GooglePlay");
        cVar.a(x.i());
        String str = "SDK_INT=" + Build.VERSION.SDK_INT;
        if (!m.a(Build.BOARD)) {
            str = str + "\nBOARD=" + Build.BOARD;
        }
        if (!m.a(Build.BOARD)) {
            str = str + "\nBRAND=" + Build.BRAND;
        }
        if (!m.a(Build.CPU_ABI)) {
            str = str + "\nCPU_ABI=" + Build.CPU_ABI;
        }
        if (!m.a(Build.CPU_ABI2)) {
            str = str + "\nCPU_ABI2=" + Build.CPU_ABI2;
        }
        if (!m.a(Build.DEVICE)) {
            str = str + "\nDEVICE=" + Build.DEVICE;
        }
        if (!m.a(Build.DISPLAY)) {
            str = str + "\nDISPLAY=" + Build.DISPLAY;
        }
        if (!m.a(Build.FINGERPRINT)) {
            str = str + "\nFINGERPRINT=" + Build.FINGERPRINT;
        }
        if (!m.a(Build.HARDWARE)) {
            str = str + "\nHARDWARE=" + Build.HARDWARE;
        }
        if (!m.a(Build.HOST)) {
            str = str + "\nHOST=" + Build.HOST;
        }
        if (!m.a(Build.ID)) {
            str = str + "\nID=" + Build.ID;
        }
        if (!m.a(Build.MANUFACTURER)) {
            str = str + "\nMANUFACTURER=" + Build.MANUFACTURER;
        }
        if (!m.a(Build.MODEL)) {
            str = str + "\nMODEL=" + Build.MODEL;
        }
        if (!m.a(Build.PRODUCT)) {
            str = str + "\nPRODUCT=" + Build.PRODUCT;
        }
        cVar.c(str);
        return cVar;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void B() {
        d();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void C() {
        if (this.i == null) {
            return;
        }
        this.a = 5000L;
        if (this.m == null) {
            this.m = new Runnable() { // from class: chat.ola.vn.network.OlaNetworkService.6
                /* JADX WARN: Removed duplicated region for block: B:26:0x0097 A[Catch: Throwable -> 0x008b, TRY_LEAVE, TryCatch #0 {Throwable -> 0x008b, blocks: (B:21:0x0086, B:24:0x008d, B:26:0x0097, B:32:0x00b3), top: B:101:0x0086, outer: #1 }] */
                /* JADX WARN: Removed duplicated region for block: B:32:0x00b3 A[Catch: Throwable -> 0x008b, TRY_ENTER, TRY_LEAVE, TryCatch #0 {Throwable -> 0x008b, blocks: (B:21:0x0086, B:24:0x008d, B:26:0x0097, B:32:0x00b3), top: B:101:0x0086, outer: #1 }] */
                @Override // java.lang.Runnable
                /*
                    Code decompiled incorrectly, please refer to instructions dump.
                    To view partially-correct add '--show-bad-code' argument
                */
                public void run() {
                    /*
                        Method dump skipped, instruction units count: 548
                        To view this dump add '--comments-level debug' option
                    */
                    throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.network.OlaNetworkService.AnonymousClass6.run():void");
                }
            };
        } else {
            try {
                this.i.removeCallbacks(this.m);
            } catch (Throwable unused) {
            }
        }
        this.i.postDelayed(this.m, this.a);
    }

    private void D() {
        try {
            Iterator<chat.ola.vn.s.a> it2 = this.v.iterator();
            while (it2.hasNext()) {
                it2.next().stopWatching();
            }
            this.v.clear();
            this.v = null;
        } catch (Throwable unused) {
        }
    }

    private void E() {
        aa aaVar = new aa();
        aaVar.a = "lastRoomId";
        OlaApplication.b.b("bmk", new aa[]{aaVar}, (short) 0);
    }

    public static void E(String str) {
        try {
            synchronized (x) {
                if (!x.contains(str)) {
                    x.add(str);
                }
            }
        } catch (Throwable unused) {
        }
    }

    private void F() {
        this.g.l();
    }

    /* JADX WARN: Type inference failed for: r0v0, types: [chat.ola.vn.network.OlaNetworkService$1] */
    public static void a() {
        try {
            new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.network.OlaNetworkService.1
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    File fileF = chat.ola.vn.d.f();
                    if (!fileF.exists()) {
                        return null;
                    }
                    File file = new File(fileF.getAbsoluteFile(), ".cached");
                    if (!file.exists()) {
                        return null;
                    }
                    com.mg.ola.common.d.c.c(file);
                    return null;
                }
            }.execute(new Void[0]);
        } catch (Throwable unused) {
        }
    }

    private void a(chat.ola.vn.entity.m<?> mVar) {
        String strA = mVar.a();
        if (m.a(strA)) {
            return;
        }
        chat.ola.vn.k.a.a(mVar);
        this.g.a(strA, mVar.a, mVar.b);
    }

    private void a(final String str, final String str2, final short s, final short s2) {
        try {
            if (AccessToken.getCurrentAccessToken() == null || AccessToken.getCurrentAccessToken().isExpired()) {
                OlaFacebookActivity.a(this, (Bundle) null, new OlaFacebookActivity.a() { // from class: chat.ola.vn.network.OlaNetworkService.9
                    @Override // chat.ola.vn.activity.OlaFacebookActivity.a
                    public void a() {
                        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.OlaNetworkService.9.1
                            @Override // java.lang.Runnable
                            public void run() {
                                OlaNetworkService.this.b(str, str2, s, s2);
                            }
                        }, 1000L);
                    }
                });
            } else {
                b(str, str2, s, s2);
            }
        } catch (Throwable unused) {
        }
    }

    private void a(List<chat.ola.vn.s.a> list, String str, int i) {
        try {
            if (!m.a(str) && com.mg.ola.common.d.c.a(str) && com.mg.ola.common.d.c.b(str)) {
                chat.ola.vn.s.a aVar = new chat.ola.vn.s.a(str);
                aVar.a(this);
                aVar.startWatching();
                list.add(aVar);
                if (i > 0) {
                    int i2 = i - 1;
                    File[] fileArrC = com.mg.ola.common.d.c.c(str);
                    if (fileArrC == null || fileArrC.length <= 0) {
                        return;
                    }
                    for (int i3 = 0; i3 < fileArrC.length; i3++) {
                        if (!m.b(fileArrC[i3].getName(), "cache")) {
                            a(list, fileArrC[i3].getAbsolutePath(), i2);
                        }
                    }
                }
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private boolean a(String str, String str2, String str3, String str4, chat.ola.vn.entity.c cVar) {
        boolean zA = this.g.a(str, str2, str3, str4, cVar, (short) 59);
        if (zA && this.j != null) {
            Iterator<f> it2 = this.j.iterator();
            while (it2.hasNext()) {
                it2.next().s();
            }
        }
        return zA;
    }

    /* JADX WARN: Type inference failed for: r0v0, types: [chat.ola.vn.network.OlaNetworkService$4] */
    public static void b() {
        try {
            new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.network.OlaNetworkService.4
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    File fileF = chat.ola.vn.d.f();
                    if (!fileF.exists()) {
                        return null;
                    }
                    File file = new File(fileF.getAbsoluteFile(), ".cached");
                    if (!file.exists()) {
                        file.mkdir();
                        return null;
                    }
                    try {
                        OlaNetworkService.d(file, true);
                        return null;
                    } catch (Throwable unused) {
                        com.mg.ola.common.d.c.c(file);
                        return null;
                    }
                }
            }.execute(new Void[0]);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void b(final String str, final String str2, final short s, final short s2) {
        try {
            if (!OlaFacebookActivity.B() && !OlaFacebookActivity.f) {
                OlaFacebookActivity.a(chat.ola.vn.c.c(), new OlaFacebookActivity.b() { // from class: chat.ola.vn.network.OlaNetworkService.10
                    @Override // chat.ola.vn.activity.OlaFacebookActivity.b
                    public void a() {
                        OlaNetworkService.this.c(str, str2, s, s2);
                    }

                    @Override // chat.ola.vn.activity.OlaFacebookActivity.b
                    public void b() {
                    }
                });
                return;
            }
            c(str, str2, s, s2);
        } catch (Throwable unused) {
        }
    }

    private void b(String str, String[] strArr) {
        ad adVar = new ad(System.currentTimeMillis());
        adVar.c = str;
        adVar.d = strArr;
        a(adVar);
    }

    /* JADX WARN: Type inference failed for: r0v0, types: [chat.ola.vn.network.OlaNetworkService$5] */
    public static void c() {
        try {
            new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.network.OlaNetworkService.5
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    File fileF = chat.ola.vn.d.f();
                    if (!fileF.exists()) {
                        return null;
                    }
                    File file = new File(fileF.getAbsoluteFile(), ".cached");
                    if (file.exists()) {
                        try {
                            OlaNetworkService.c(file, false);
                        } catch (Throwable unused) {
                            com.mg.ola.common.d.c.c(file);
                        }
                        try {
                            OlaNetworkService.d(file, false);
                        } catch (Throwable unused2) {
                            com.mg.ola.common.d.c.c(file);
                        }
                        try {
                            com.mg.ola.common.d.c.c(new File(chat.ola.vn.d.a()));
                        } catch (Throwable unused3) {
                        }
                    } else {
                        file.mkdir();
                    }
                    File file2 = new File(chat.ola.vn.d.a());
                    if (!file2.exists()) {
                        return null;
                    }
                    try {
                        com.mg.ola.common.d.c.f(file2);
                        return null;
                    } catch (Throwable unused4) {
                        return null;
                    }
                }
            }.execute(new Void[0]);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void c(File file, boolean z) {
        File[] fileArrListFiles;
        File[] fileArrListFiles2;
        if (!file.isDirectory() || (fileArrListFiles = file.listFiles()) == null || fileArrListFiles.length <= 0) {
            return;
        }
        ArrayList arrayList = new ArrayList(fileArrListFiles.length);
        long length = 0;
        for (File file2 : fileArrListFiles) {
            if (file2.isFile()) {
                arrayList.add(file2);
                length += file2.length();
            } else if (file2.isDirectory() && (fileArrListFiles2 = file2.listFiles()) != null && fileArrListFiles2.length > 0) {
                long length2 = length;
                for (File file3 : fileArrListFiles2) {
                    if (file3.isFile()) {
                        arrayList.add(file3);
                        length2 += file3.length();
                    } else {
                        com.mg.ola.common.d.c.c(file3);
                    }
                }
                length = length2;
            }
        }
        Collections.sort(arrayList, new chat.ola.vn.e.b());
        Iterator it2 = arrayList.iterator();
        while (it2.hasNext()) {
            File file4 = (File) it2.next();
            if (!z && length <= 26214400) {
                return;
            }
            long length3 = file4.length();
            if (file4.isDirectory()) {
                com.mg.ola.common.d.c.c(file4);
            } else if (file4.delete()) {
                length -= length3;
            }
            it2.remove();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(String str, String str2, short s, short s2) {
        String str3;
        String str4;
        try {
            Bundle bundle = new Bundle();
            try {
                JSONObject jSONObject = new JSONObject();
                if (s2 == 11) {
                    return;
                }
                if (s2 == 10) {
                    str3 = FirebaseAnalytics.Param.VALUE;
                    str4 = "SELF";
                } else {
                    str3 = FirebaseAnalytics.Param.VALUE;
                    str4 = "EVERYONE";
                }
                jSONObject.put(str3, str4);
                bundle.putString(ShareConstants.WEB_DIALOG_PARAM_PRIVACY, jSONObject.toString());
            } catch (Throwable unused) {
            }
            if (!m.a(str)) {
                String strD = chat.ola.vn.util.i.d(str, "");
                if (!m.a(strD)) {
                    bundle.putString("message", strD);
                }
            }
            if (!m.a(str2) && chat.ola.vn.entity.i.i(str2) == 1) {
                bundle.putString("picture", chat.ola.vn.entity.i.k(str2));
            }
            new GraphRequest(AccessToken.getCurrentAccessToken(), "/me/feed", bundle, HttpMethod.POST, new GraphRequest.Callback() { // from class: chat.ola.vn.network.OlaNetworkService.11
                @Override // com.facebook.GraphRequest.Callback
                public void onCompleted(GraphResponse graphResponse) {
                    try {
                        chat.ola.vn.util.f.a().c("Share status to FB");
                    } catch (Throwable unused2) {
                    }
                }
            }).executeAsync();
        } catch (Throwable unused2) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public String d(int i) {
        switch (i) {
            case 0:
                return "STATE_NO_NETWORK";
            case 1:
                return "STATE_NOT_CONNECTED";
            case 2:
                return "STATE_CONNECTING";
            case 3:
                return "STATE_CONNECTED";
            case 4:
            default:
                return "";
            case 5:
                return "STATE_READY";
            case 6:
                return "STATE_AUTHENTICATING";
            case 7:
                return "STATE_ONLINE";
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Removed duplicated region for block: B:29:0x0062 A[Catch: Throwable -> 0x0066, TRY_LEAVE, TryCatch #2 {Throwable -> 0x0066, blocks: (B:25:0x0053, B:27:0x0057, B:29:0x0062), top: B:68:0x0053 }] */
    /* JADX WARN: Removed duplicated region for block: B:58:0x00c2 A[Catch: Throwable -> 0x00c6, TRY_LEAVE, TryCatch #1 {Throwable -> 0x00c6, blocks: (B:54:0x00b3, B:56:0x00b7, B:58:0x00c2), top: B:66:0x00b3 }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static void d(java.io.File r16, boolean r17) {
        /*
            Method dump skipped, instruction units count: 209
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.network.OlaNetworkService.d(java.io.File, boolean):void");
    }

    private boolean m(String str, String str2, short s) {
        if (System.currentTimeMillis() - this.y < 200) {
            return false;
        }
        this.y = System.currentTimeMillis();
        ag agVar = new ag(System.currentTimeMillis());
        agVar.c = str;
        agVar.d = str2;
        agVar.e = s;
        a(agVar);
        return true;
    }

    private void z() {
        try {
            if (this.v != null) {
                return;
            }
            this.v = new ArrayList();
            List<String> listB = chat.ola.vn.d.b();
            if (listB != null && listB.size() > 0) {
                Iterator<String> it2 = listB.iterator();
                while (it2.hasNext()) {
                    a(this.v, it2.next(), 0);
                }
            }
            List<String> listC = chat.ola.vn.d.c();
            if (listC != null && listC.size() > 0) {
                Iterator<String> it3 = listC.iterator();
                while (it3.hasNext()) {
                    a(this.v, it3.next(), 0);
                }
            }
            List<String> listD = chat.ola.vn.d.d();
            if (listD == null || listD.size() <= 0) {
                return;
            }
            Iterator<String> it4 = listD.iterator();
            while (it4.hasNext()) {
                a(this.v, it4.next(), 0);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.s.b
    public void A(final String str) {
        try {
            synchronized (x) {
                for (String str2 : x) {
                    if (m.b(str2, str)) {
                        x.remove(str2);
                        return;
                    }
                }
                OlaApplication.b(new Runnable() { // from class: chat.ola.vn.network.OlaNetworkService.3
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            if (!m.a(chat.ola.vn.d.f(str)) || com.mg.ola.common.d.c.h(new File(str)) == 0) {
                                OlaNetworkService.x.add(str);
                                return;
                            }
                        } catch (Throwable unused) {
                        }
                        try {
                            String strF = com.mg.ola.common.d.d.f(str);
                            if (m.b(strF, "jpg") || m.b(strF, "jpeg") || m.b(strF, "png")) {
                                chat.ola.vn.e.a().h(str);
                                if (x.b()) {
                                    if (OlaNetworkService.this.h()) {
                                        chat.ola.vn.u.b.a().a(str, null, null);
                                    } else {
                                        chat.ola.vn.e.a().j(str);
                                    }
                                }
                                ((chat.ola.vn.s.b) OlaNetworkService.this.w.get()).A(str);
                            }
                        } catch (Throwable unused2) {
                        }
                    }
                }, 10000L);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.s.b
    public void B(String str) {
        try {
            chat.ola.vn.e.a().i(str);
        } catch (Throwable unused) {
        }
    }

    public void C(String str) {
        this.g.a(str);
    }

    public void D(String str) {
        this.g.b(str);
    }

    public void a(double d, int i, String str, String str2, l.a aVar) {
        if (m.c(str) || m.c(str2)) {
            return;
        }
        l lVar = new l(d, i, str, str2, System.currentTimeMillis());
        lVar.a(aVar);
        a(lVar);
    }

    void a(int i) {
        if (this.l == i) {
        }
        this.l = i;
        Log.e("OlaNetworkService", "-------SET STATE: " + d(i));
        this.n = System.currentTimeMillis();
        if (i == 1) {
            e();
            return;
        }
        switch (i) {
            case 5:
                if (chat.ola.vn.h.g()) {
                    b(chat.ola.vn.h.a());
                }
                break;
            case 6:
                this.t = 0L;
                break;
            case 7:
                chat.ola.vn.h.t.z();
                chat.ola.vn.r.a.e.b = 0;
                chat.ola.vn.r.a.e.c = 0L;
                chat.ola.vn.r.a.e.a = null;
                this.o = 0L;
                this.p = 0L;
                this.q = 0L;
                F();
                d((String) null, (short) 0);
                break;
        }
    }

    public void a(long j) {
        a("@113 topme", j, (String) null, (short) 0, (String) null, (short) 0);
    }

    public void a(long j, long j2, short s) {
        this.g.a(j, j2, s);
    }

    public void a(long j, chat.ola.vn.p.c cVar) {
        r rVar = new r(j, System.currentTimeMillis());
        rVar.c = cVar;
        a(rVar);
    }

    public void a(long j, String str) {
        a("@113 top #" + m.k(str), j, (String) null, (short) 0, (String) null, (short) 0);
    }

    public void a(long j, String str, String str2, short s) {
        a(j, false, str, str2, s);
    }

    public void a(long j, String str, short s) {
        try {
            if (m.a(str) && s == 0) {
                return;
            }
            if (m.o(str)) {
                chat.ola.vn.i.i.a();
            } else {
                this.g.a(j, str, s);
            }
        } catch (Throwable unused) {
        }
    }

    public void a(long j, short s) {
        this.g.a(j, s);
    }

    public void a(long j, boolean z) {
        m("me", "" + j, z ? (short) 2 : (short) 0);
    }

    public void a(long j, boolean z, String str, String str2, short s) {
        try {
            chat.ola.vn.h.b.a(chat.ola.vn.h.a(), z);
        } catch (Throwable unused) {
        }
        this.g.a(j, z, str, str2, s);
    }

    public void a(long j, boolean z, short s) {
        this.g.a(j, z, s);
    }

    public void a(v vVar, chat.ola.vn.p.m mVar) {
        chat.ola.vn.network.a.a.aa aaVar = new chat.ola.vn.network.a.a.aa(vVar, System.currentTimeMillis());
        aaVar.a(mVar);
        a(aaVar);
    }

    public void a(chat.ola.vn.message.f fVar) {
        this.g.a("Friends", fVar.j());
        a(fVar.j(), true, (short) 0);
        chat.ola.vn.h.t.e(fVar);
        if (m.a(fVar.p())) {
            chat.ola.vn.h.t.a(fVar.j());
        } else {
            chat.ola.vn.h.t.a(fVar.j(), fVar.p());
        }
    }

    public void a(l.a aVar) {
        try {
            if (m.c(chat.ola.vn.n.c.a().b()) || m.c(chat.ola.vn.n.c.a().c())) {
                return;
            }
            a(25.0d, 1, chat.ola.vn.n.c.a().b(), chat.ola.vn.n.c.a().c(), aVar);
        } catch (Throwable unused) {
        }
    }

    public void a(f fVar) {
        if (fVar == null) {
            return;
        }
        try {
            int size = this.j.size();
            for (int i = 0; i < size; i++) {
                if (m.b(this.j.get(i).getClass().getName(), fVar.getClass().getName())) {
                    this.j.remove(i);
                    this.j.add(fVar);
                    return;
                }
            }
            this.j.add(fVar);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.network.i
    public void a(g gVar) {
        this.l = 3;
        this.n = System.currentTimeMillis();
        try {
            if (this.j != null) {
                Iterator<f> it2 = this.j.iterator();
                while (it2.hasNext()) {
                    it2.next().p();
                }
            }
        } catch (Throwable unused) {
        }
        this.e = gVar.f;
        this.f = gVar.b;
        this.g.a(gVar.b());
        this.g.a(gVar.c());
        this.g.a(A());
        if (m.a(gVar.a)) {
            this.g.a(true);
        } else {
            this.g.a(false);
        }
        if (this.u == null) {
            this.u = Executors.newFixedThreadPool(1);
        }
        this.u.execute(this.g.p());
    }

    public void a(chat.ola.vn.p.m mVar) {
        z zVar = new z(System.currentTimeMillis());
        zVar.a(mVar);
        a(zVar);
    }

    public void a(n nVar) {
        ab abVar = new ab(System.currentTimeMillis());
        abVar.a(nVar);
        a(abVar);
    }

    public void a(p pVar) {
        am amVar = new am(System.currentTimeMillis());
        amVar.c = pVar;
        a(amVar);
    }

    public void a(chat.ola.vn.s.b bVar) {
        if (bVar != null) {
            this.w = new WeakReference<>(bVar);
        } else {
            this.w = null;
        }
    }

    public void a(String str) {
        a(new o(str, System.currentTimeMillis()));
    }

    public void a(String str, byte b2, String str2, short s) {
        this.g.a(str, b2, str2, s);
    }

    public void a(String str, int i, chat.ola.vn.p.a aVar) {
        if (m.c(chat.ola.vn.n.c.a().b()) || m.c(chat.ola.vn.n.c.a().c())) {
            return;
        }
        k kVar = new k(str, i, chat.ola.vn.n.c.a().b(), chat.ola.vn.n.c.a().c(), System.currentTimeMillis());
        kVar.a(aVar);
        a(kVar);
    }

    public void a(String str, int i, chat.ola.vn.p.k kVar) {
        u uVar = new u(str, i, System.currentTimeMillis());
        uVar.e = kVar;
        a(uVar);
    }

    public void a(String str, int i, short s, short s2) {
        this.g.a(m.j(str), i, s, s2);
    }

    public void a(String str, long j, chat.ola.vn.p.a aVar) {
        chat.ola.vn.network.a.a.h hVar = new chat.ola.vn.network.a.a.h(str, j, System.currentTimeMillis());
        hVar.a(aVar);
        a(hVar);
    }

    public void a(String str, long j, String str2, short s, String str3, short s2) {
        a(str, j, str2, s, (short) 2, str3, s2);
    }

    public void a(String str, long j, String str2, short s, short s2, String str3, short s3) {
        switch (s2) {
            case 10:
                this.g.a(str, str2, s, s3);
                break;
            case 11:
                this.g.b(str, str2, s, s3);
                break;
            default:
                this.g.b(str, j, str2, s, str3, (byte) s2, s3);
                break;
        }
    }

    public void a(String str, long j, short s) {
        this.g.a(str, j, s);
    }

    public void a(String str, aj.a aVar) {
        if (m.a(str)) {
            return;
        }
        a(new aj(str, aVar, System.currentTimeMillis()));
    }

    public void a(String str, al.a aVar) {
        al alVar = new al(str, System.currentTimeMillis());
        alVar.a(aVar);
        a(alVar);
    }

    public void a(String str, p.a aVar) {
        chat.ola.vn.network.a.a.p pVar = new chat.ola.vn.network.a.a.p(str, System.currentTimeMillis());
        pVar.a(aVar);
        chat.ola.vn.l.c cVar = new chat.ola.vn.l.c();
        cVar.a(pVar);
        cVar.execute(new Void[0]);
    }

    public void a(String str, chat.ola.vn.p.a aVar) {
        chat.ola.vn.network.a.a.b bVar = new chat.ola.vn.network.a.a.b(str, System.currentTimeMillis());
        bVar.a(aVar);
        a(bVar);
    }

    public void a(String str, chat.ola.vn.p.b bVar) {
        q qVar = new q(str, System.currentTimeMillis());
        qVar.c = bVar;
        a(qVar);
    }

    public void a(String str, chat.ola.vn.p.d dVar) {
        w wVar = new w(str, System.currentTimeMillis());
        wVar.d = dVar;
        wVar.a("name", "gender", "birthday", "registerMs", "socialLinkType", "noFans", "noFriends", "statusMessage", "cared", "isFan", "blocked", "boxSpouse", "phone", NativeProtocol.AUDIENCE_FRIENDS, "fans", "noMedias", "medias", "lastActiveAgo", "vip", "like");
        a(wVar);
    }

    public void a(String str, chat.ola.vn.p.i iVar) {
        try {
            str = m.j(str);
        } catch (Throwable unused) {
        }
        chat.ola.vn.network.a.a.a aVar = new chat.ola.vn.network.a.a.a(str, System.currentTimeMillis());
        aVar.a(iVar);
        a(aVar);
    }

    public void a(String str, j jVar) {
        chat.ola.vn.network.a.a.m mVar = new chat.ola.vn.network.a.a.m(str, System.currentTimeMillis());
        mVar.a(jVar);
        a(mVar);
    }

    public void a(String str, chat.ola.vn.p.l lVar) {
        try {
            if (str.toLowerCase(Locale.US).startsWith("rss://")) {
                str = str.substring("rss://".length());
            }
        } catch (Throwable unused) {
        }
        chat.ola.vn.network.a.a.x xVar = new chat.ola.vn.network.a.a.x(str, System.currentTimeMillis());
        xVar.a(lVar);
        a(xVar);
    }

    public void a(String str, n nVar) {
        ab abVar = new ab(str, System.currentTimeMillis());
        abVar.a(nVar);
        a(abVar);
    }

    public void a(String str, chat.ola.vn.p.o oVar) {
        ac acVar = new ac(str, System.currentTimeMillis());
        acVar.c = oVar;
        a(acVar);
    }

    public void a(String str, String str2) {
        this.g.f(str, str2, (short) 0);
    }

    public void a(String str, String str2, byte b2, String str3, short s) {
        this.g.a(str, str2, b2, str3, s);
    }

    public void a(String str, String str2, int i, long j, short s) {
        this.g.a(m.j(str), str2, i, j, s);
    }

    public void a(String str, String str2, int i, chat.ola.vn.p.a aVar) {
        if (m.c(chat.ola.vn.n.c.a().b()) || m.c(chat.ola.vn.n.c.a().c())) {
            return;
        }
        chat.ola.vn.network.a.a.g gVar = new chat.ola.vn.network.a.a.g(str, str2, i, chat.ola.vn.n.c.a().b(), chat.ola.vn.n.c.a().c(), System.currentTimeMillis());
        gVar.a(aVar);
        a(gVar);
    }

    public void a(String str, String str2, long j, short s) {
        this.g.a(m.j(str), str2, j, s);
    }

    public void a(String str, String str2, ai.a aVar) {
        ai aiVar = new ai(str, str2, System.currentTimeMillis());
        aiVar.a(aVar);
        chat.ola.vn.l.j jVar = new chat.ola.vn.l.j();
        jVar.a(aiVar);
        jVar.execute(new Void[0]);
    }

    public void a(String str, String str2, chat.ola.vn.p.q qVar) {
        chat.ola.vn.network.a.a.v vVar = new chat.ola.vn.network.a.a.v(str, str2, System.currentTimeMillis());
        vVar.a(qVar);
        a(vVar);
    }

    public void a(String str, String str2, Long l, Byte b2) {
        this.g.a(str, str2, l, b2, (byte[]) null);
    }

    public void a(String str, String str2, String str3) {
        this.g.c(str, str2, str3);
    }

    public void a(String str, String str2, String str3, int i, chat.ola.vn.p.a aVar) {
        if (m.c(str2) || m.c(str3)) {
            return;
        }
        k kVar = new k(str, i, str2, str3, System.currentTimeMillis());
        kVar.a(aVar);
        a(kVar);
    }

    public void a(String str, String str2, String str3, chat.ola.vn.p.a aVar) {
        chat.ola.vn.network.a.a.i iVar = new chat.ola.vn.network.a.a.i(str, str2, str3, System.currentTimeMillis());
        iVar.a(aVar);
        a(iVar);
    }

    public void a(String str, String str2, String str3, chat.ola.vn.p.q qVar) {
        chat.ola.vn.network.a.a.n nVar = new chat.ola.vn.network.a.a.n(str, str2, str3, System.currentTimeMillis());
        nVar.a(qVar);
        a(nVar);
    }

    public void a(String str, String str2, String str3, String str4, String str5, Long l, byte b2, short s) {
        this.g.a(str, str2, str3, str4, str5, l, b2, s);
    }

    public void a(String str, String str2, String str3, String str4, String str5, Long l, String str6, byte b2, short s) {
        this.g.a(str, str2, str3, str4, str5, l, str6, b2, s);
    }

    public void a(String str, String str2, String str3, String str4, short s) {
        this.g.b(str, str2, str3, str4, s);
    }

    public void a(String str, String str2, String str3, short s) {
        try {
            if (m.a(str2) && s == 0) {
                return;
            }
            if (m.o(str2)) {
                chat.ola.vn.i.i.a();
            } else {
                this.g.a(str, str2, str3, s, (short) 0);
            }
        } catch (Throwable unused) {
        }
    }

    public void a(String str, String str2, List<String> list, String str3, String str4, chat.ola.vn.p.a aVar) {
        chat.ola.vn.network.a.a.j jVar = new chat.ola.vn.network.a.a.j(str, str2, list, str3, str4, System.currentTimeMillis());
        jVar.a(aVar);
        a(jVar);
    }

    public void a(String str, String str2, short s) {
        this.g.h(str, str2, s);
    }

    public void a(String str, String str2, short s, String str3, short s2) {
        a(str, str2, s, (short) 2, str3, (String) null, s2);
    }

    public void a(String str, String str2, short s, short s2, String str3, String str4, short s3) {
        try {
            if (m.o(str)) {
                return;
            }
        } catch (Throwable unused) {
        }
        short s4 = (short) (s2 & 16383);
        switch (s4) {
            case 10:
                this.g.a(str, str2, s, s3);
                break;
            case 11:
                this.g.b(str, str2, s, s3);
                break;
            default:
                this.g.a(str, str2, s, str3, str4, (byte) s4, s3);
                break;
        }
        if ((s2 & 16384) == 16384) {
            a(str, str2, s, s4);
        }
    }

    public void a(String str, String str2, boolean z, chat.ola.vn.p.q qVar) {
        y yVar = new y(str, str2, z, System.currentTimeMillis());
        yVar.a(qVar);
        a(yVar);
    }

    public void a(String str, String str2, String[] strArr, short s) {
        if (strArr == null || strArr.length == 0) {
            return;
        }
        ArrayList arrayList = new ArrayList(strArr.length);
        for (String str3 : strArr) {
            if (!m.b(str3, chat.ola.vn.h.a())) {
                arrayList.add(str3);
            }
        }
        if (arrayList.size() == 0) {
            return;
        }
        this.g.a(str, str2, (String[]) arrayList.toArray(new String[arrayList.size()]), s);
    }

    public void a(String str, List<String> list, String str2, String str3, chat.ola.vn.p.a aVar) {
        if (m.c(chat.ola.vn.n.c.a().b()) || m.c(chat.ola.vn.n.c.a().c())) {
            return;
        }
        chat.ola.vn.network.a.a.d dVar = new chat.ola.vn.network.a.a.d(str, list, str2, str3, chat.ola.vn.n.c.a().b(), chat.ola.vn.n.c.a().c(), System.currentTimeMillis());
        dVar.a(aVar);
        a(dVar);
    }

    public void a(String str, short s) {
        this.g.a(str, 0L, s);
    }

    public void a(String str, short s, String str2) {
        this.g.a(str, s, str2);
    }

    public void a(String str, short s, String str2, short s2) {
        if (chat.ola.vn.message.d.g(str2)) {
            return;
        }
        this.g.a(str, s, str2, s2);
    }

    public void a(String str, short s, boolean z) {
        this.g.a(str, s, z);
    }

    public void a(String str, short s, int[] iArr, int[] iArr2) {
        this.g.a(str, s, iArr, iArr2);
    }

    public void a(String str, boolean z) {
        if (!z) {
            this.g.f(str);
            return;
        }
        this.g.e(str);
        if (x.e()) {
            chat.ola.vn.util.n.a(OlaApplication.a(), chat.ola.vn.util.c.a.u);
        }
    }

    public void a(String str, boolean z, short s) {
        if (z) {
            this.g.h(str, s);
        } else {
            this.g.i(str, s);
        }
    }

    public void a(String str, byte[] bArr, short s) {
        this.g.a(str, bArr, s);
    }

    public void a(String str, aa[] aaVarArr, short s) {
        this.g.a(str, aaVarArr, s);
    }

    public void a(String str, String... strArr) {
        this.g.a(str, strArr);
    }

    public void a(String str, String[] strArr, chat.ola.vn.p.d dVar) {
        String strTrim = str.trim();
        w wVar = new w(strTrim, System.currentTimeMillis());
        wVar.c(strTrim);
        wVar.d = dVar;
        wVar.a(strArr);
        a(wVar);
    }

    public void a(String str, String[] strArr, short s) {
        this.g.a(str, strArr, s);
    }

    public void a(String str, String[] strArr, String[] strArr2) {
        String strK = m.k(str);
        if (m.a(strK)) {
            return;
        }
        this.g.a(strK, strArr, strArr2, (short) 0);
    }

    public void a(List<String> list) {
        if (list == null || list.size() == 0) {
            return;
        }
        String[] strArr = new String[list.size()];
        for (int i = 0; i < strArr.length; i++) {
            strArr[i] = list.get(i);
        }
        b("me", strArr);
    }

    public void a(short s) {
        this.g.a(s);
    }

    public void a(short s, short s2) {
        this.g.a(s, s2);
    }

    public void a(boolean z) {
        try {
            if (this.g.j()) {
                this.g.b(z);
            }
        } catch (Throwable unused) {
        }
    }

    public void a(String[] strArr) {
        this.g.c(strArr);
    }

    public void a(String[] strArr, String[] strArr2) {
        if (strArr == null || strArr.length == 0) {
            return;
        }
        this.g.a("Friends", strArr, strArr2);
        for (String str : strArr) {
            a(str, true, (short) 0);
        }
    }

    public void a(String[] strArr, String[] strArr2, short s) {
        this.g.a(strArr, strArr2, s);
    }

    public boolean a(String str, String str2, String str3, String str4) {
        try {
            int iIndexOf = str.indexOf(64);
            if (iIndexOf > 0) {
                str = str.substring(0, iIndexOf);
            }
        } catch (Throwable unused) {
        }
        String str5 = str;
        try {
            if (g()) {
                if (a(str5, str2, str3, str4, A())) {
                    return true;
                }
            }
        } catch (Throwable unused2) {
        }
        return false;
    }

    public void b(int i) {
        this.g.a(i);
    }

    public void b(long j) {
        this.g.a(j);
    }

    public void b(long j, chat.ola.vn.p.c cVar) {
        s sVar = new s(j, System.currentTimeMillis());
        sVar.c = cVar;
        a(sVar);
    }

    public void b(long j, String str) {
        a("@113 all #" + m.k(str), j, (String) null, (short) 0, (String) null, (short) 0);
    }

    public void b(long j, String str, short s) {
        this.g.b(j, str, s);
    }

    public void b(long j, short s) {
        this.g.b(j, s);
    }

    public void b(f fVar) {
        if (fVar == null || this.j == null) {
            return;
        }
        int size = this.j.size();
        for (int i = 0; i < size; i++) {
            if (m.b(this.j.get(i).getClass().getName(), fVar.getClass().getName())) {
                this.j.remove(i);
                return;
            }
        }
    }

    public void b(String str) {
        if (g()) {
            a(6);
            this.g.a(str, A(), (short) 58);
            if (this.j != null) {
                Iterator<f> it2 = this.j.iterator();
                while (it2.hasNext()) {
                    it2.next().t();
                }
            }
        }
    }

    public void b(String str, long j, String str2, short s, short s2, String str3, short s3) {
        switch (s2) {
            case 10:
                this.g.a(str, str2, s, s3);
                break;
            case 11:
                this.g.b(str, str2, s, s3);
                break;
            default:
                this.g.a(str, j, str2, s, str3, (byte) s2, s3);
                break;
        }
    }

    public void b(String str, chat.ola.vn.p.a aVar) {
        chat.ola.vn.network.a.a.f fVar = new chat.ola.vn.network.a.a.f(str, System.currentTimeMillis());
        fVar.a(aVar);
        a(fVar);
    }

    public void b(String str, chat.ola.vn.p.b bVar) {
        q qVar = new q(System.currentTimeMillis());
        qVar.c(str);
        qVar.c = bVar;
        a(qVar);
    }

    public void b(String str, chat.ola.vn.p.d dVar) {
        b(str, new String[]{"lastActiveAgo"}, dVar);
    }

    public void b(String str, String str2) {
        this.g.a("Friends", new String[]{str}, new String[]{str2});
        a(str, true, (short) 0);
    }

    public void b(String str, String str2, String str3) {
        this.g.d(str, str2, str3);
    }

    public void b(String str, String str2, String str3, chat.ola.vn.p.a aVar) {
        if (m.c(chat.ola.vn.n.c.a().b()) || m.c(chat.ola.vn.n.c.a().c())) {
            return;
        }
        chat.ola.vn.network.a.a.c cVar = new chat.ola.vn.network.a.a.c(str, str2, str3, chat.ola.vn.n.c.a().b(), chat.ola.vn.n.c.a().c(), System.currentTimeMillis());
        cVar.a(aVar);
        a(cVar);
    }

    public void b(String str, String str2, String str3, String str4, short s) {
        this.g.a(str, str2, str3, str4, s);
    }

    public void b(String str, String str2, String str3, short s) {
        this.g.b(str, str2, str3, s);
    }

    public void b(String str, String str2, short s) {
        this.g.b(str, str2, s);
    }

    public void b(String str, String str2, short s, String str3, short s2) {
        this.g.a(m.j(str), str2, s, str3, s2);
    }

    public void b(String str, short s) {
        if (m.a(str)) {
            str = chat.ola.vn.h.a();
        }
        w wVar = new w(str, System.currentTimeMillis());
        wVar.c = this.h;
        wVar.e = s;
        wVar.a("name", "gender", "birthday", "registerMs", "socialLinkType", "noFans", "noFriends", "statusMessage", "cared", "isFan", "blocked", "boxSpouse", "phone", NativeProtocol.AUDIENCE_FRIENDS, "fans", "noMedias", "medias", "lastActiveAgo", "vip", "like");
        a(wVar);
    }

    public void b(String str, short s, String str2) {
        this.g.b(str, s, str2);
    }

    public void b(String str, boolean z) {
        a(new ah(str, z, System.currentTimeMillis()));
        if (x.e() && z) {
            chat.ola.vn.util.n.a(OlaApplication.a(), chat.ola.vn.util.c.a.u);
        }
    }

    public void b(String str, byte[] bArr, short s) {
        this.g.b(str, bArr, s);
    }

    public void b(String str, aa[] aaVarArr, short s) {
        this.g.b(str, aaVarArr, s);
    }

    public void b(String str, String[] strArr, chat.ola.vn.p.d dVar) {
        w wVar = new w(str, System.currentTimeMillis());
        wVar.d = dVar;
        wVar.a(strArr);
        a(wVar);
    }

    public void b(String str, String[] strArr, short s) {
        this.g.b(str, strArr, s);
    }

    public void b(List<chat.ola.vn.message.f> list) {
        this.g.a(list, true);
    }

    public void b(short s) {
        this.g.b(s);
    }

    public void b(String[] strArr) {
        this.g.d(strArr);
    }

    public void b(String[] strArr, String[] strArr2) {
        this.g.b(strArr, strArr2, (short) 0);
    }

    public boolean b(long j, boolean z) {
        short s;
        if (z) {
            s = 1;
            if (x.e()) {
                chat.ola.vn.util.n.a(OlaApplication.a(), chat.ola.vn.util.c.a.u);
            }
        } else {
            s = 0;
        }
        return m("me", "" + j, s);
    }

    public void c(int i) {
        this.g.b(i);
    }

    public void c(long j) {
        chat.ola.vn.message.f fVarA;
        this.g.b(j);
        E();
        try {
            if (chat.ola.vn.h.x.p() != null && (fVarA = chat.ola.vn.h.t.a(chat.ola.vn.h.x.p().c())) != null) {
                fVarA.a(0);
                try {
                    ((OlaBottomTabActivity) OlaBottomTabActivity.c()).G();
                } catch (Throwable unused) {
                }
            }
            chat.ola.vn.h.t.v();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void c(long j, chat.ola.vn.p.c cVar) {
        t tVar = new t(j, System.currentTimeMillis());
        tVar.c = cVar;
        a(tVar);
    }

    public void c(long j, short s) {
        this.g.c(j, s);
    }

    public void c(String str) {
        this.g.c(str);
    }

    public void c(String str, chat.ola.vn.p.a aVar) {
        chat.ola.vn.network.a.a.e eVar = new chat.ola.vn.network.a.a.e(str, System.currentTimeMillis());
        eVar.a(aVar);
        a(eVar);
    }

    public void c(String str, String str2) {
        this.g.c(str, str2);
    }

    public void c(String str, String str2, String str3) {
        this.g.b(str, str2, str3);
    }

    public void c(String str, String str2, String str3, short s) {
        try {
            if (m.a(str2) && s == 0) {
                return;
            }
            if (m.o(str2)) {
                chat.ola.vn.i.i.a();
            } else {
                this.g.a(str, str2, str3, s);
            }
        } catch (Throwable unused) {
        }
    }

    public void c(String str, String str2, short s) {
        this.g.c(str, str2, s);
    }

    public void c(String str, short s) {
        this.g.n(str, s);
    }

    public void c(String str, short s, String str2) {
        this.g.c(str, s, str2);
    }

    public void c(short s) {
        this.g.f(s);
    }

    public void c(String[] strArr) {
        this.g.b(strArr);
    }

    public chat.ola.vn.message.f d(long j) {
        this.g.c(j);
        chat.ola.vn.message.f fVarA = chat.ola.vn.h.t.a(chat.ola.vn.h.x.k());
        if (fVarA == null) {
            fVarA = chat.ola.vn.h.t.a(chat.ola.vn.h.x.k(), chat.ola.vn.h.x.p().d());
        }
        chat.ola.vn.h.b.a(chat.ola.vn.h.a(), true);
        return fVarA;
    }

    @TargetApi(11)
    public void d() {
        if (this.l == 1 && chat.ola.vn.h.F) {
            this.l = 2;
            this.n = System.currentTimeMillis();
            if (this.j != null) {
                Iterator<f> it2 = this.j.iterator();
                while (it2.hasNext()) {
                    it2.next().o();
                }
            }
            g gVar = new g();
            gVar.a = this.s;
            this.s = null;
            gVar.a((Long) null);
            gVar.a(this);
            try {
                h hVar = new h();
                if (com.mg.ola.common.d.g.c()) {
                    hVar.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, gVar);
                } else {
                    hVar.execute(gVar);
                }
            } catch (Throwable unused) {
            }
        }
    }

    public void d(String str) {
        chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(str, (short) 0);
        if (fVarD == null) {
            fVarD = new chat.ola.vn.message.f(str, (short) 0);
        }
        a(fVarD);
    }

    public void d(String str, String str2) {
        if (!h() || m.a(str2)) {
            return;
        }
        this.g.g(str, str2);
        chat.ola.vn.h.h = true;
    }

    public void d(String str, String str2, String str3) {
        this.g.a(str, str2, str3);
    }

    public void d(String str, String str2, short s) {
    }

    public void d(String str, short s) {
        if (this.g == null) {
            return;
        }
        this.g.e(str, s);
    }

    public void d(String str, short s, String str2) {
        this.g.d(str, s, str2);
    }

    public void d(short s) {
        this.g.h(s);
    }

    public void d(String[] strArr) {
        this.g.a(strArr);
    }

    @TargetApi(11)
    void e() {
        Log.d("OlaNetworkService", "-----CLOSE SOCKET-----");
        this.l = 1;
        try {
            this.g.h();
        } catch (Throwable unused) {
        }
        try {
            chat.ola.vn.h.x.o();
            chat.ola.vn.u.b.a().b();
        } catch (Throwable unused2) {
        }
        try {
            OlaApplication.c.b();
        } catch (Throwable unused3) {
        }
        try {
            b bVar = new b();
            bVar.a = this.e;
            this.e = null;
            this.f = null;
            if (com.mg.ola.common.d.g.c()) {
                new a().executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, bVar);
            } else {
                new a().execute(bVar);
            }
        } catch (Throwable unused4) {
        }
    }

    public void e(long j) {
        chat.ola.vn.message.f fVarA;
        this.g.d(j);
        chat.ola.vn.h.b.a(chat.ola.vn.h.a(), false);
        try {
            if (chat.ola.vn.h.x.p() != null && (fVarA = chat.ola.vn.h.t.a(chat.ola.vn.h.x.p().c())) != null) {
                fVarA.a(0);
                try {
                    ((OlaBottomTabActivity) OlaBottomTabActivity.c()).G();
                } catch (Throwable unused) {
                }
            }
            chat.ola.vn.h.t.v();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void e(String str) {
        this.g.d(str, (String) null);
    }

    public void e(String str, String str2) {
        String str3;
        try {
            String strK = m.k(str);
            String strJ = m.j(str2);
            if (m.a(strJ)) {
                str3 = "@113 PBC.X #" + strK;
            } else {
                str3 = "@113 PBC @" + strJ + " #" + strK;
            }
            a(str3, (String) null, (short) 0, (String) null, (short) 0);
        } catch (Throwable unused) {
        }
    }

    public void e(String str, String str2, short s) {
        this.g.d(str, str2, s);
    }

    public void e(String str, short s) {
        this.g.m(str, s);
    }

    public void e(short s) {
        this.g.c(s);
    }

    @Override // chat.ola.vn.network.i
    public void f() {
        a(1);
        if (this.j != null) {
            Iterator<f> it2 = this.j.iterator();
            while (it2.hasNext()) {
                it2.next().r();
            }
        }
    }

    public void f(String str) {
        this.g.j(str);
    }

    public void f(String str, String str2) {
        String str3;
        try {
            String strK = m.k(str);
            String strJ = m.j(str2);
            if (m.a(strJ)) {
                str3 = "@113 DS.X #" + strK;
            } else {
                str3 = "@113 DS @" + strJ + " #" + strK;
            }
            a(str3, (String) null, (short) 0, (String) null, (short) 0);
        } catch (Throwable unused) {
        }
    }

    public void f(String str, String str2, short s) {
        this.g.a(str, str2, s);
    }

    public void f(String str, short s) {
        this.g.d(str.replaceFirst("#", ""), s);
    }

    public void f(short s) {
        this.g.d(s);
    }

    public void g(String str) {
        this.g.i(str);
    }

    public void g(String str, String str2) {
        try {
            String strK = m.k(str2);
            a("@113 BAN @" + m.j(str) + " #" + strK, (String) null, (short) 0, (String) null, (short) 0);
        } catch (Throwable unused) {
        }
    }

    public void g(String str, String str2, short s) {
        this.g.g(str, str2, s);
    }

    public void g(String str, short s) {
        this.g.c(str, s);
    }

    public void g(short s) {
        this.g.e(s);
    }

    public boolean g() {
        return this.l == 5;
    }

    public void h(final String str) {
        try {
            if (m.o(str)) {
                return;
            }
        } catch (Throwable unused) {
        }
        try {
            final long jK = chat.ola.vn.h.x.k();
            if (jK != 0 && !m.c(str) && m.n(str)) {
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.network.OlaNetworkService.2
                    @Override // java.lang.Runnable
                    public void run() {
                        chat.ola.vn.i.i.a(chat.ola.vn.c.c(), R.string.string_sponsor, R.string.message_adme_public_room_suggestion, R.string.string_try_now, R.string.string_no, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.network.OlaNetworkService.2.1
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i) {
                                if (i == 0) {
                                    try {
                                        chat.ola.vn.util.b.a(chat.ola.vn.c.c(), jK, str);
                                    } catch (Throwable unused2) {
                                        return;
                                    }
                                }
                                dialogInterface.dismiss();
                            }
                        }).setCancelable(false);
                    }
                }, 30000L);
            }
        } catch (Throwable unused2) {
        }
        x.c = str;
        this.g.g(str);
    }

    public void h(String str, String str2) {
        try {
            String strK = m.k(str2);
            a("@113 CLEAR @" + m.j(str) + " #" + strK, (String) null, (short) 0, (String) null, (short) 0);
        } catch (Throwable unused) {
        }
    }

    public void h(String str, short s) {
        this.g.a(str, s);
    }

    public void h(short s) {
        this.g.i(s);
    }

    public boolean h() {
        return this.l == 7;
    }

    public boolean h(String str, String str2, short s) {
        if (!this.g.j() || m.b(str2, "null")) {
            return false;
        }
        this.g.b(str, (short) 1, str2, s);
        return true;
    }

    public void i(String str) {
        try {
            String strJ = m.j(str);
            if (m.b(strJ, chat.ola.vn.h.a())) {
                return;
            }
            if (x.e()) {
                chat.ola.vn.util.n.a(OlaApplication.a(), chat.ola.vn.util.c.a.v);
            }
            m("mem", strJ, (short) 3);
        } catch (Throwable unused) {
        }
    }

    public void i(String str, String str2) {
        try {
            String strK = m.k(str2);
            a("@113 OK @" + m.j(str) + " #" + strK, (String) null, (short) 0, (String) null, (short) 0);
        } catch (Throwable unused) {
        }
    }

    public void i(String str, short s) {
        this.g.b(str, s);
    }

    public void i(short s) {
        this.g.j(s);
    }

    public boolean i() {
        return this.l == 6;
    }

    public boolean i(String str, String str2, short s) {
        if (!this.g.j() || m.b(str2, "null")) {
            return false;
        }
        this.g.b(str, (short) 0, str2, s);
        return true;
    }

    public int j() {
        return this.l;
    }

    public void j(String str) {
        this.g.h(str);
    }

    public void j(String str, String str2) {
        try {
            String strK = m.k(str2);
            a("@113 OK.X @" + m.j(str) + " #" + strK, (String) null, (short) 0, (String) null, (short) 0);
        } catch (Throwable unused) {
        }
    }

    public void j(String str, String str2, short s) {
        this.g.i(str, str2, s);
    }

    public void j(String str, short s) {
        this.g.j(str, s);
    }

    public void k() {
        Log.d("OlaNetworkService", "-----DISCONNECT-----");
        a(1);
    }

    public void k(String str) {
        this.g.d(str);
    }

    public void k(String str, String str2) {
        String strJ = m.j(str);
        this.g.s(strJ);
        l(strJ);
    }

    public void k(String str, String str2, short s) {
        this.g.j(str, str2, s);
    }

    public void k(String str, short s) {
        this.g.l(str, s);
    }

    public void l() {
        a(new ak(System.currentTimeMillis()));
    }

    public void l(String str) {
        this.g.o(str);
        m(str);
        try {
            chat.ola.vn.message.f fVarF = chat.ola.vn.h.t.f(str, (short) 0);
            if (fVarF != null) {
                e(str);
                chat.ola.vn.h.t.b(fVarF);
            }
        } catch (Throwable unused) {
        }
    }

    public void l(String str, String str2) {
        if (m.a(str) || m.a(str2)) {
            return;
        }
        this.g.h(str, str2);
    }

    public void l(String str, String str2, short s) {
        this.g.e(str, str2, s);
    }

    public void l(String str, short s) {
        this.g.k(str, s);
    }

    void m() {
        try {
            if (!chat.ola.vn.h.h() || a(chat.ola.vn.h.a(), chat.ola.vn.h.b(), chat.ola.vn.h.c(), (String) null)) {
                return;
            }
            OlaApplication.b(new Runnable() { // from class: chat.ola.vn.network.OlaNetworkService.7
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        OlaNetworkService.this.m();
                    } catch (Throwable unused) {
                    }
                }
            }, 3000L);
        } catch (Throwable unused) {
            OlaApplication.b(new Runnable() { // from class: chat.ola.vn.network.OlaNetworkService.8
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        OlaNetworkService.this.m();
                    } catch (Throwable unused2) {
                    }
                }
            }, 3000L);
        }
    }

    public void m(String str) {
        this.g.f(str, (short) 0);
    }

    public void m(String str, short s) {
        StringBuilder sb;
        String strK = m.k(str);
        if (m.a(strK)) {
            return;
        }
        try {
            switch (s) {
                case 0:
                    sb = new StringBuilder();
                    sb.append("@113 restrict #");
                    sb.append(strK);
                    sb.append(" none");
                    break;
                case 1:
                    sb = new StringBuilder();
                    sb.append("@113 restrict #");
                    sb.append(strK);
                    sb.append(" join");
                    break;
                case 2:
                    sb = new StringBuilder();
                    sb.append("@113 restrict #");
                    sb.append(strK);
                    sb.append(" write");
                    break;
                case 3:
                    sb = new StringBuilder();
                    sb.append("@113 restrict #");
                    sb.append(strK);
                    sb.append(" all");
                    break;
                case 4:
                    sb = new StringBuilder();
                    sb.append("@113 restrict #");
                    sb.append(strK);
                    sb.append(" view");
                    break;
                default:
                    return;
            }
            a(sb.toString(), (String) null, (short) 0, (String) null, (short) 0);
        } catch (Throwable unused) {
        }
    }

    public void n() {
        this.g.g();
    }

    public void n(String str) {
        this.g.p(str);
        o(str);
    }

    public void n(String str, short s) {
        this.g.p(str, s);
    }

    public void o() {
        this.g.f();
    }

    public void o(String str) {
        this.g.g(str, (short) 0);
    }

    public void o(String str, short s) {
        this.g.r(str, s);
    }

    @Override // android.app.Service
    public IBinder onBind(Intent intent) {
        return this.d;
    }

    @Override // android.app.Service
    public void onCreate() {
        super.onCreate();
        this.g = new ci();
        this.h = new e(this);
        this.g.a(this.h);
        OlaApplication.b = this;
        this.t = 0L;
        this.l = 1;
        this.d = new d();
        this.d.a(this);
        this.i = new Handler();
        a(chat.ola.vn.c.c());
        c();
        chat.ola.vn.h.j = chat.ola.vn.h.b.b();
        String strA = chat.ola.vn.h.a();
        if (!m.a(strA)) {
            x.m = chat.ola.vn.h.b.g(strA);
            x.n = chat.ola.vn.h.b.j(strA);
            x.o = chat.ola.vn.h.b.n(strA);
            x.v = chat.ola.vn.h.b.o(strA);
            x.h = chat.ola.vn.h.b.k(strA);
            x.x = chat.ola.vn.h.b.l(strA);
            x.y = chat.ola.vn.h.b.m(strA);
        }
        z();
        C();
    }

    @Override // android.app.Service
    public void onDestroy() {
        super.onDestroy();
        OlaApplication.b = null;
        e();
        if (this.m != null) {
            if (this.i != null) {
                this.i.removeCallbacks(this.m);
                this.i = null;
            }
            this.m = null;
        }
        try {
            this.u.shutdownNow();
        } catch (Throwable unused) {
        }
        this.u = null;
        D();
    }

    @Override // android.app.Service
    public int onStartCommand(Intent intent, int i, int i2) {
        if (this.l != 7 || this.g == null || !this.g.j()) {
            return 1;
        }
        chat.ola.vn.h.H = this.g.m();
        x.c = this.g.k();
        return 1;
    }

    public void p() {
        a("@113 topme.x", (String) null, (short) 0, (String) null, (short) 0);
    }

    public void p(String str) {
        this.g.k(str);
    }

    public void p(String str, short s) {
        this.g.o(str, s);
    }

    public void q() {
        this.g.o();
    }

    public void q(String str) {
        a("@113 top.x #" + m.k(str), 0L, (String) null, (short) 0, (String) null, (short) 0);
    }

    public void q(String str, short s) {
        this.g.q(str, s);
    }

    public void r() {
        this.g.g((short) 0);
    }

    public void r(String str) {
        this.g.m(str);
    }

    public void r(String str, short s) {
        k(str, null, s);
    }

    public void s() {
        this.g.d();
        this.o = System.currentTimeMillis();
    }

    public void s(String str) {
        this.g.n(str);
    }

    public void s(String str, short s) {
        this.g.s(str, s);
    }

    public e t() {
        if (this.h == null) {
            this.h = new e(this);
        }
        return this.h;
    }

    public void t(String str) {
        this.g.q(str);
    }

    public void t(String str, short s) {
        this.g.t(str, s);
    }

    public void u() {
        this.g.r();
    }

    public void u(String str) {
        this.g.r(str);
    }

    public void u(String str, short s) {
        this.g.u(str, s);
    }

    public void v() {
        this.g.q();
    }

    public void v(String str) {
        this.g.t(str);
    }

    public void v(String str, short s) {
        this.g.v(str, s);
    }

    public void w() {
        a(new ae(System.currentTimeMillis()));
    }

    public void w(String str) {
        this.g.u(str);
    }

    public void w(String str, short s) {
        this.g.w(str, s);
    }

    public void x() {
        this.g.d(true);
    }

    void x(String str) {
        this.s = str;
        Log.d("OlaNetworkService", "-----Change SERVER-----");
        a(1);
    }

    public void x(String str, short s) {
        this.g.y(str, s);
    }

    public void y(String str) {
        this.g.l(str);
    }

    public void y(String str, short s) {
        this.g.x(str, s);
    }

    public void z(String str) {
        a(new af(str, System.currentTimeMillis()));
    }
}
