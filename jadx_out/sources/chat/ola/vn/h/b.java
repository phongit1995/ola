package chat.ola.vn.h;

import android.accounts.Account;
import android.accounts.AccountManager;
import android.annotation.SuppressLint;
import android.content.Context;
import android.os.AsyncTask;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c.x;
import chat.ola.vn.d;
import chat.ola.vn.e;
import chat.ola.vn.entity.af;
import chat.ola.vn.entity.ah;
import chat.ola.vn.entity.h;
import chat.ola.vn.entity.t;
import chat.ola.vn.entity.w;
import chat.ola.vn.entry.g;
import chat.ola.vn.message.f;
import chat.ola.vn.util.i;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import chat.ola.vn.w.cg;
import chat.ola.vn.w.s;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale", "NewApi"})
public class b {
    private static boolean a = false;

    private static s A(String str) {
        if (m.a(str)) {
            return null;
        }
        synchronized (".info.dat") {
            File fileA = d.a(str.toLowerCase());
            if (fileA != null) {
                File file = new File(fileA.getAbsolutePath(), ".info.dat");
                try {
                    if (file.exists()) {
                        FileInputStream fileInputStream = new FileInputStream(file);
                        s sVarA = o.a(fileInputStream);
                        fileInputStream.close();
                        if (sVarA == null) {
                            return null;
                        }
                        if (d(str, sVarA)) {
                            return sVarA;
                        }
                    }
                } catch (Throwable unused) {
                }
            }
            return null;
        }
    }

    public static long a() {
        try {
            s sVarH = h();
            if (sVarH != null && a(sVarH)) {
                String strB = sVarH.b((short) 71);
                if (m.a(strB)) {
                    return 0L;
                }
                return Long.parseLong(strB);
            }
        } catch (Throwable unused) {
        }
        return 0L;
    }

    public static List<a> a(Context context) {
        ArrayList arrayList = null;
        try {
            AccountManager accountManager = AccountManager.get(context);
            Account[] accountsByType = accountManager.getAccountsByType(context.getString(R.string.account_type));
            if (accountsByType != null && accountsByType.length > 0) {
                for (Account account : accountsByType) {
                    a aVar = new a();
                    aVar.a = account;
                    try {
                        aVar.b = accountManager.getPassword(account);
                    } catch (Throwable unused) {
                    }
                    try {
                        aVar.e = Long.parseLong(accountManager.getUserData(account, "_time"));
                    } catch (Throwable unused2) {
                    }
                    try {
                        aVar.d = accountManager.getUserData(account, "_trust_token");
                    } catch (Throwable unused3) {
                    }
                    if (arrayList == null) {
                        arrayList = new ArrayList(accountsByType.length);
                    }
                    arrayList.add(aVar);
                }
                if (arrayList != null) {
                    Collections.sort(arrayList, new chat.ola.vn.e.a());
                }
            }
        } catch (Throwable unused4) {
        }
        try {
            List<a> listN = e.a().n();
            if (listN != null && listN.size() > 0) {
                if (arrayList != null && arrayList.size() != 0) {
                    for (a aVar2 : arrayList) {
                        Iterator<a> it2 = listN.iterator();
                        while (it2.hasNext()) {
                            a next = it2.next();
                            if (m.b(aVar2.a.name, next.a.name)) {
                                if (m.a(aVar2.b) && !m.a(next.b)) {
                                    aVar2.b = next.b;
                                    aVar2.c = next.c;
                                    aVar2.d = next.d;
                                    aVar2.e = next.e;
                                }
                                it2.remove();
                            }
                        }
                    }
                    Iterator<a> it3 = listN.iterator();
                    while (it3.hasNext()) {
                        arrayList.add(it3.next());
                    }
                    Collections.sort(arrayList, new chat.ola.vn.e.a());
                }
                try {
                    Collections.sort(listN, new chat.ola.vn.e.a());
                    return listN;
                } catch (Throwable unused5) {
                    return listN;
                }
            }
        } catch (Throwable unused6) {
        }
        return arrayList;
    }

    public static List<g> a(byte[] bArr) {
        ArrayList arrayList = null;
        if (bArr == null) {
            return null;
        }
        s sVarA = o.a(new ByteArrayInputStream(bArr));
        int iC = sVarA.c((short) 30);
        if (iC > 0) {
            arrayList = new ArrayList(iC);
            int iB = sVarA.b((short) 30, 0);
            int i = 0;
            while (i < iC) {
                int iA = sVarA.a((short) 30, iB);
                String strC = sVarA.c(iB);
                if (!m.b(strC, "my diary") && !m.b(strC, "mariage diary")) {
                    g gVar = new g(strC, sVarA.b((short) 31, iB, iA));
                    gVar.b(sVarA.b((short) 44, iB, iA));
                    int i2 = iB;
                    gVar.a(sVarA.a((short) 42, i2, iA, 0L));
                    gVar.b(sVarA.a((short) 43, iB, iA, 0));
                    gVar.c(sVarA.a((short) 34, i2, iA, 0L));
                    arrayList.add(gVar);
                }
                i++;
                iB = iA;
            }
        }
        return arrayList;
    }

    public static void a(final int i) {
        try {
            AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.h.b.15
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    b.b((short) 39, String.valueOf(i));
                    return null;
                }
            };
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, new Void[0]);
            } else {
                asyncTask.execute(new Void[0]);
            }
        } catch (Throwable unused) {
        }
    }

    public static void a(final long j) {
        try {
            AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.h.b.7
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    b.b((short) 71, String.valueOf(j));
                    return null;
                }
            };
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, new Void[0]);
            } else {
                asyncTask.execute(new Void[0]);
            }
        } catch (Throwable unused) {
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:10:0x0022, code lost:
    
        r0.removeAccount(r3, null, null);
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static void a(android.content.Context r5, java.lang.String r6) {
        /*
            android.accounts.AccountManager r0 = android.accounts.AccountManager.get(r5)     // Catch: java.lang.Throwable -> L2a
            r1 = 2131689502(0x7f0f001e, float:1.9008021E38)
            java.lang.String r5 = r5.getString(r1)     // Catch: java.lang.Throwable -> L2a
            android.accounts.Account[] r5 = r0.getAccountsByType(r5)     // Catch: java.lang.Throwable -> L2a
            if (r5 == 0) goto L2e
            int r1 = r5.length     // Catch: java.lang.Throwable -> L2a
            if (r1 <= 0) goto L2e
            int r1 = r5.length     // Catch: java.lang.Throwable -> L2a
            r2 = 0
        L16:
            if (r2 >= r1) goto L2e
            r3 = r5[r2]     // Catch: java.lang.Throwable -> L2a
            java.lang.String r4 = r3.name     // Catch: java.lang.Throwable -> L2a
            boolean r4 = chat.ola.vn.util.m.b(r4, r6)     // Catch: java.lang.Throwable -> L2a
            if (r4 == 0) goto L27
            r5 = 0
            r0.removeAccount(r3, r5, r5)     // Catch: java.lang.Throwable -> L2a
            goto L2e
        L27:
            int r2 = r2 + 1
            goto L16
        L2a:
            r5 = move-exception
            r5.printStackTrace()
        L2e:
            chat.ola.vn.e r5 = chat.ola.vn.e.a()     // Catch: java.lang.Throwable -> L35
            r5.f(r6)     // Catch: java.lang.Throwable -> L35
        L35:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.h.b.a(android.content.Context, java.lang.String):void");
    }

    /* JADX WARN: Code restructure failed: missing block: B:10:0x002a, code lost:
    
        r6.setPassword(r3, r8);
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static void a(android.content.Context r6, java.lang.String r7, java.lang.String r8) {
        /*
            android.content.Context r6 = chat.ola.vn.OlaApplication.a()     // Catch: java.lang.Throwable -> L31
            android.accounts.AccountManager r6 = android.accounts.AccountManager.get(r6)     // Catch: java.lang.Throwable -> L31
            r0 = 2131689502(0x7f0f001e, float:1.9008021E38)
            java.lang.String r0 = chat.ola.vn.OlaApplication.a(r0)     // Catch: java.lang.Throwable -> L31
            android.accounts.Account[] r0 = r6.getAccountsByType(r0)     // Catch: java.lang.Throwable -> L31
            if (r0 == 0) goto L35
            int r1 = r0.length     // Catch: java.lang.Throwable -> L31
            if (r1 <= 0) goto L35
            int r1 = r0.length     // Catch: java.lang.Throwable -> L31
            r2 = 0
        L1a:
            if (r2 >= r1) goto L35
            r3 = r0[r2]     // Catch: java.lang.Throwable -> L31
            java.lang.String r4 = r3.name     // Catch: java.lang.Throwable -> L31
            java.lang.String r5 = chat.ola.vn.h.a()     // Catch: java.lang.Throwable -> L31
            boolean r4 = chat.ola.vn.util.m.b(r4, r5)     // Catch: java.lang.Throwable -> L31
            if (r4 == 0) goto L2e
            r6.setPassword(r3, r8)     // Catch: java.lang.Throwable -> L31
            goto L35
        L2e:
            int r2 = r2 + 1
            goto L1a
        L31:
            r6 = move-exception
            r6.printStackTrace()
        L35:
            chat.ola.vn.e r6 = chat.ola.vn.e.a()     // Catch: java.lang.Throwable -> L3c
            r6.a(r7, r8)     // Catch: java.lang.Throwable -> L3c
        L3c:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.h.b.a(android.content.Context, java.lang.String, java.lang.String):void");
    }

    public static void a(Context context, String str, String str2, String str3, String str4) {
        try {
            AccountManager accountManager = AccountManager.get(context);
            Account account = new Account(str, context.getString(R.string.account_type));
            if (accountManager.addAccountExplicitly(account, str2, null)) {
                accountManager.setAuthToken(account, context.getString(R.string.token_type), str3);
            } else {
                accountManager.setPassword(account, str2);
            }
            accountManager.setUserData(account, "_time", String.valueOf(System.currentTimeMillis()));
            if (!m.a(str4)) {
                accountManager.setUserData(account, "_trust_token", str4);
            }
        } catch (Throwable unused) {
        }
        try {
            e.a().a(str, str2, str3, str4);
        } catch (Throwable unused2) {
        }
    }

    private static void a(cg cgVar) {
        synchronized (".app2.info") {
            File file = new File(d.f().getAbsolutePath(), ".app.info");
            if (file.exists()) {
                file.delete();
            }
            File file2 = new File(d.f().getAbsolutePath(), ".app2.info");
            try {
                if (!file2.exists()) {
                    file2.createNewFile();
                }
                a(file2, cgVar);
            } catch (Throwable unused) {
            }
        }
    }

    private static void a(File file, cg cgVar) throws IOException {
        FileOutputStream fileOutputStream = new FileOutputStream(file);
        cg cgVar2 = new cg((short) 0);
        cgVar2.a((short) 1, "3.0");
        fileOutputStream.write(cgVar2.a());
        fileOutputStream.write(cgVar.a());
        fileOutputStream.flush();
        fileOutputStream.close();
    }

    private static void a(File file, List<f> list) throws IOException {
        FileOutputStream fileOutputStream = new FileOutputStream(file);
        cg cgVar = new cg((short) 0);
        cgVar.a((short) 1, "3.0");
        if (list != null) {
            int size = list.size();
            for (int i = 0; i < size; i++) {
                f fVar = list.get(i);
                cgVar.a((short) 25, fVar.j());
                String strB = fVar.b();
                if (!m.a(strB)) {
                    cgVar.a((short) 26, strB);
                }
                String strD = fVar.d();
                if (!m.a(strD)) {
                    cgVar.a((short) 38, strD);
                }
                String strO = fVar.o();
                if (!m.a(strO)) {
                    cgVar.a((short) 9, strO);
                }
            }
        }
        fileOutputStream.write(cgVar.a());
        fileOutputStream.flush();
        fileOutputStream.close();
    }

    public static void a(final String str) {
        try {
            AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.h.b.17
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    b.b((short) 80, m.a(str) ? "" : str);
                    return null;
                }
            };
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, new Void[0]);
            } else {
                asyncTask.execute(new Void[0]);
            }
        } catch (Throwable unused) {
        }
    }

    public static void a(final String str, final byte b) {
        if (m.a(str)) {
            return;
        }
        try {
            AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.h.b.2
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    b.b(str, (short) 59, String.valueOf((int) b));
                    return null;
                }
            };
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, new Void[0]);
            } else {
                asyncTask.execute(new Void[0]);
            }
        } catch (Throwable unused) {
        }
    }

    public static void a(final String str, final chat.ola.vn.me.a aVar) {
        if (m.a(str)) {
            return;
        }
        try {
            AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.h.b.12
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    String string = "";
                    try {
                        string = aVar.toString();
                    } catch (Throwable unused) {
                    }
                    b.b(str, (short) 111, string);
                    return null;
                }
            };
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, new Void[0]);
            } else {
                asyncTask.execute(new Void[0]);
            }
        } catch (Throwable unused) {
        }
    }

    private static void a(String str, cg cgVar) {
        if (m.a(str)) {
            return;
        }
        synchronized (".info.dat") {
            File fileA = d.a(str.toLowerCase());
            if (fileA != null) {
                File file = new File(fileA.getAbsolutePath(), ".info.dat");
                try {
                    if (!file.exists()) {
                        file.createNewFile();
                    }
                    b(file, cgVar);
                } catch (Throwable unused) {
                }
            }
        }
    }

    public static void a(final String str, final Long l) {
        if (m.a(str)) {
            return;
        }
        try {
            AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.h.b.19
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    String str2;
                    String strValueOf;
                    if (l != null) {
                        str2 = str;
                        strValueOf = String.valueOf(l);
                    } else {
                        str2 = str;
                        strValueOf = "";
                    }
                    b.b(str2, (short) 88, strValueOf);
                    return null;
                }
            };
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, new Void[0]);
            } else {
                asyncTask.execute(new Void[0]);
            }
        } catch (Throwable unused) {
        }
    }

    public static void a(String str, String str2, int i, byte[] bArr) {
        File fileA;
        if (str2 == null || m.a(str) || str2.length() <= 2 || i == 4 || (fileA = d.a(str.toLowerCase())) == null) {
            return;
        }
        File file = new File(fileA.getAbsolutePath(), ".message");
        if (!file.exists()) {
            file.mkdir();
        }
        File file2 = new File(file.getAbsolutePath(), ".background." + str2 + "." + i);
        if (bArr != null) {
            try {
                if (bArr.length > 0) {
                    if (!file2.exists()) {
                        file2.createNewFile();
                    }
                    com.mg.ola.common.d.c.a(file2, bArr);
                    return;
                }
            } catch (Throwable unused) {
                return;
            }
        }
        if (file2.exists()) {
            file2.delete();
        }
    }

    public static void a(String str, List<chat.ola.vn.entry.b> list) {
        File fileA;
        if (m.a(str) || list == null || list.size() == 0 || (fileA = d.a(str.toLowerCase())) == null) {
            return;
        }
        File file = new File(fileA.getAbsolutePath(), ".me");
        if (!file.exists()) {
            file.mkdir();
        }
        try {
            File file2 = new File(file.getAbsolutePath(), ".lastviewme.dat");
            if (!file2.exists()) {
                file2.createNewFile();
            }
            b(file2, list);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public static void a(final String str, final List<f> list, final int i) {
        if (m.a(str)) {
            return;
        }
        try {
            AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.h.b.21
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    synchronized (".contact.dat") {
                        File fileA = d.a(str.toLowerCase());
                        if (fileA != null) {
                            File file = new File(fileA.getAbsolutePath(), ".contact.dat");
                            try {
                                if (!file.exists()) {
                                    file.createNewFile();
                                }
                                b.b(file, (List<f>) list, i);
                            } catch (Throwable unused) {
                            }
                        }
                    }
                    return null;
                }
            };
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, new Void[0]);
            } else {
                asyncTask.execute(new Void[0]);
            }
        } catch (Throwable unused) {
        }
    }

    public static void a(final String str, final boolean z) {
        if (m.a(str)) {
            return;
        }
        try {
            AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.h.b.20
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    b.b(str, (short) 89, String.valueOf(z));
                    return null;
                }
            };
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, new Void[0]);
            } else {
                asyncTask.execute(new Void[0]);
            }
        } catch (Throwable unused) {
        }
    }

    public static void a(String str, byte[] bArr) {
        if (m.a(str)) {
            return;
        }
        try {
            File fileA = d.a(str.toLowerCase());
            if (fileA == null || !fileA.exists()) {
                return;
            }
            File file = new File(fileA.getAbsolutePath(), ".app.background");
            if (!file.exists()) {
                file.createNewFile();
            }
            com.mg.ola.common.d.c.a(file, bArr);
        } catch (Throwable unused) {
        }
    }

    public static void a(final List<String> list) {
        try {
            AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.h.b.16
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    String str;
                    if (list == null || list.size() == 0) {
                        str = "";
                    } else {
                        str = (String) list.get(0);
                        int size = list.size();
                        for (int i = 1; i < size; i++) {
                            str = str + ";" + ((String) list.get(i));
                        }
                    }
                    b.b((short) 79, str);
                    return null;
                }
            };
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, new Void[0]);
            } else {
                asyncTask.execute(new Void[0]);
            }
        } catch (Throwable unused) {
        }
    }

    private static boolean a(s sVar) {
        String strB;
        if (sVar == null || (strB = sVar.b((short) 1)) == null) {
            return false;
        }
        if (strB.equals("3.0")) {
            return true;
        }
        File fileF = d.f();
        if (fileF != null) {
            File file = new File(fileF.getAbsolutePath(), ".app2.info");
            if (file.exists()) {
                com.mg.ola.common.d.c.c(file);
            }
        }
        return false;
    }

    private static boolean a(String str, s sVar) {
        if (m.a(str)) {
            return false;
        }
        if (sVar.b((short) 1).equals("3.0")) {
            return true;
        }
        File fileA = d.a(str.toLowerCase());
        if (fileA != null) {
            File file = new File(fileA.getAbsolutePath(), ".contact.dat");
            if (file.exists()) {
                com.mg.ola.common.d.c.c(file);
            }
        }
        return false;
    }

    public static byte[] a(String str, String str2, int i) {
        File fileA;
        if (str2 != null && !m.a(str) && str2.length() > 2 && (fileA = d.a(str.toLowerCase())) != null) {
            File file = new File(fileA.getAbsolutePath(), ".message");
            if (!file.exists()) {
                file.mkdir();
            }
            File file2 = new File(file.getAbsolutePath(), ".background." + str2 + "." + i);
            try {
                if (file2.exists()) {
                    return com.mg.ola.common.d.c.a(file2);
                }
                return null;
            } catch (Throwable unused) {
            }
        }
        return null;
    }

    public static List<String> b() {
        try {
            s sVarH = h();
            if (sVarH != null && a(sVarH)) {
                String strB = sVarH.b((short) 79);
                int i = 0;
                if (m.a(strB)) {
                    ArrayList arrayList = new ArrayList(chat.ola.vn.f.d.e_.length);
                    while (i < chat.ola.vn.f.d.e_.length) {
                        arrayList.add(chat.ola.vn.f.d.e_[i]);
                        i++;
                    }
                    return arrayList;
                }
                String[] strArrSplit = strB.split(";");
                if (strArrSplit != null && strArrSplit.length != 0) {
                    ArrayList arrayList2 = new ArrayList(strArrSplit.length);
                    while (i < strArrSplit.length) {
                        arrayList2.add(strArrSplit[i]);
                        i++;
                    }
                    return arrayList2;
                }
                ArrayList arrayList3 = new ArrayList(chat.ola.vn.f.d.e_.length);
                while (i < chat.ola.vn.f.d.e_.length) {
                    arrayList3.add(chat.ola.vn.f.d.e_[i]);
                    i++;
                }
                return arrayList3;
            }
        } catch (Throwable unused) {
        }
        return null;
    }

    public static List<t> b(byte[] bArr) {
        s sVarA = o.a(new ByteArrayInputStream(bArr));
        int iC = sVarA.c((short) 30);
        if (iC <= 0) {
            return null;
        }
        ArrayList arrayList = new ArrayList(iC);
        int iB = sVarA.b((short) 30, 0);
        int i = 0;
        while (i < iC) {
            int iA = sVarA.a((short) 30, iB);
            t tVar = new t(sVarA.c(iB));
            tVar.b(sVarA.b((short) 31, iB, iA));
            tVar.e(sVarA.a((short) 43, iB, iA, 0));
            int i2 = iB;
            tVar.e(sVarA.a((short) 42, i2, iA, 0L));
            tVar.d(sVarA.a((short) 34, i2, iA, 0L));
            arrayList.add(tVar);
            i++;
            iB = iA;
        }
        return arrayList;
    }

    /* JADX WARN: Code restructure failed: missing block: B:10:0x0022, code lost:
    
        r0.clearPassword(r3);
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static void b(android.content.Context r5, java.lang.String r6) {
        /*
            android.accounts.AccountManager r0 = android.accounts.AccountManager.get(r5)     // Catch: java.lang.Throwable -> L29
            r1 = 2131689502(0x7f0f001e, float:1.9008021E38)
            java.lang.String r5 = r5.getString(r1)     // Catch: java.lang.Throwable -> L29
            android.accounts.Account[] r5 = r0.getAccountsByType(r5)     // Catch: java.lang.Throwable -> L29
            if (r5 == 0) goto L2d
            int r1 = r5.length     // Catch: java.lang.Throwable -> L29
            if (r1 <= 0) goto L2d
            int r1 = r5.length     // Catch: java.lang.Throwable -> L29
            r2 = 0
        L16:
            if (r2 >= r1) goto L2d
            r3 = r5[r2]     // Catch: java.lang.Throwable -> L29
            java.lang.String r4 = r3.name     // Catch: java.lang.Throwable -> L29
            boolean r4 = chat.ola.vn.util.m.b(r6, r4)     // Catch: java.lang.Throwable -> L29
            if (r4 == 0) goto L26
            r0.clearPassword(r3)     // Catch: java.lang.Throwable -> L29
            goto L2d
        L26:
            int r2 = r2 + 1
            goto L16
        L29:
            r5 = move-exception
            r5.printStackTrace()
        L2d:
            chat.ola.vn.e r5 = chat.ola.vn.e.a()     // Catch: java.lang.Throwable -> L34
            r5.e(r6)     // Catch: java.lang.Throwable -> L34
        L34:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.h.b.b(android.content.Context, java.lang.String):void");
    }

    private static void b(File file, cg cgVar) throws IOException {
        FileOutputStream fileOutputStream = new FileOutputStream(file);
        cg cgVar2 = new cg((short) 0);
        cgVar2.a((short) 1, "3.0");
        fileOutputStream.write(cgVar2.a());
        fileOutputStream.write(cgVar.a());
        fileOutputStream.flush();
        fileOutputStream.close();
    }

    /* JADX WARN: Removed duplicated region for block: B:27:0x00d9  */
    /* JADX WARN: Removed duplicated region for block: B:32:0x00f5  */
    /* JADX WARN: Removed duplicated region for block: B:44:0x013f  */
    /* JADX WARN: Removed duplicated region for block: B:47:0x0147  */
    /* JADX WARN: Removed duplicated region for block: B:50:0x0169  */
    /* JADX WARN: Removed duplicated region for block: B:60:0x0172 A[SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:8:0x002f  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private static void b(java.io.File r17, java.util.List<chat.ola.vn.entry.b> r18) throws java.io.IOException {
        /*
            Method dump skipped, instruction units count: 391
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.h.b.b(java.io.File, java.util.List):void");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void b(File file, List<f> list, int i) throws IOException {
        FileOutputStream fileOutputStream = new FileOutputStream(file);
        cg cgVar = new cg((short) 0);
        cgVar.a((short) 1, "3.0");
        cgVar.a((short) 22, i);
        if (list != null) {
            int size = list.size();
            for (int i2 = 0; i2 < size; i2++) {
                f fVar = list.get(i2);
                cgVar.a((short) 7, fVar.j());
                cgVar.a((short) 22, fVar.b());
                cgVar.a((short) 12, (byte) fVar.g());
                String strD = fVar.d();
                if (!m.a(strD)) {
                    cgVar.a((short) 13, strD);
                }
                cgVar.a((short) 45, (byte) fVar.i());
                cgVar.a((short) 38, (byte) fVar.h());
            }
        }
        fileOutputStream.write(cgVar.a());
        fileOutputStream.flush();
        fileOutputStream.close();
    }

    public static void b(final String str) {
        if (m.a(str)) {
            return;
        }
        try {
            AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.h.b.18
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    File fileA = d.a(str.toLowerCase());
                    if (fileA == null || !fileA.exists()) {
                        return null;
                    }
                    File file = new File(fileA.getAbsolutePath(), ".app.background");
                    try {
                        if (!file.exists()) {
                            return null;
                        }
                        file.delete();
                        return null;
                    } catch (Throwable unused) {
                        return null;
                    }
                }
            };
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, new Void[0]);
            } else {
                asyncTask.execute(new Void[0]);
            }
        } catch (Throwable unused) {
        }
    }

    public static void b(final String str, final byte b) {
        if (m.a(str)) {
            return;
        }
        try {
            AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.h.b.3
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    b.b(str, (short) 63, String.valueOf((int) b));
                    return null;
                }
            };
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, new Void[0]);
            } else {
                asyncTask.execute(new Void[0]);
            }
        } catch (Throwable unused) {
        }
    }

    public static void b(final String str, final List<f> list) {
        if (m.a(str)) {
            return;
        }
        try {
            AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.h.b.13
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    try {
                        byte[] bArrE = b.e((List<f>) list);
                        synchronized (".conversation.list") {
                            File fileA = d.a(str.toLowerCase());
                            if (fileA != null) {
                                File file = new File(fileA.getAbsolutePath(), ".conversation.list");
                                try {
                                    if (bArrE == null) {
                                        file.delete();
                                    } else {
                                        if (!file.exists()) {
                                            file.createNewFile();
                                        }
                                        com.mg.ola.common.d.c.a(file, bArrE);
                                    }
                                } catch (Throwable unused) {
                                }
                            }
                        }
                        return null;
                    } catch (Throwable unused2) {
                        return null;
                    }
                }
            };
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, new Void[0]);
            } else {
                asyncTask.execute(new Void[0]);
            }
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Removed duplicated region for block: B:4:0x000c  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static void b(java.lang.String r9, short r10, java.lang.String r11) {
        /*
            chat.ola.vn.w.s r0 = z(r9)
            chat.ola.vn.w.cg r1 = new chat.ola.vn.w.cg
            r2 = 0
            r1.<init>(r2)
            if (r0 != 0) goto L10
        Lc:
            r1.a(r10, r11)
            goto L40
        L10:
            int r3 = r0.a()
            r4 = 1
            r5 = 0
            r6 = 1
        L17:
            if (r5 >= r3) goto L3d
            java.lang.Short r7 = r0.a(r5)
            short r8 = r7.shortValue()
            if (r8 != r4) goto L24
            goto L3a
        L24:
            short r8 = r7.shortValue()
            if (r8 != r10) goto L2f
            r1.a(r10, r11)
            r6 = 0
            goto L3a
        L2f:
            short r7 = r7.shortValue()
            byte[] r8 = r0.b(r5)
            r1.a(r7, r8)
        L3a:
            int r5 = r5 + 1
            goto L17
        L3d:
            if (r6 == 0) goto L40
            goto Lc
        L40:
            a(r9, r1)
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.h.b.b(java.lang.String, short, java.lang.String):void");
    }

    public static void b(final String str, final boolean z) {
        if (m.a(str)) {
            return;
        }
        try {
            AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.h.b.4
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    b.b(str, (short) 67, String.valueOf(z));
                    return null;
                }
            };
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, new Void[0]);
            } else {
                asyncTask.execute(new Void[0]);
            }
        } catch (Throwable unused) {
        }
    }

    public static void b(final String str, final byte[] bArr) {
        if (m.a(str)) {
            return;
        }
        try {
            AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.h.b.1
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    synchronized (".contact.dat") {
                        File fileA = d.a(str.toLowerCase());
                        if (fileA != null) {
                            File file = new File(fileA.getAbsolutePath(), ".ovatar.dat");
                            try {
                                if (file.exists()) {
                                    if (bArr == null) {
                                        file.delete();
                                        return null;
                                    }
                                } else {
                                    if (bArr == null) {
                                        return null;
                                    }
                                    file.createNewFile();
                                }
                                com.mg.ola.common.d.c.a(file, bArr);
                            } catch (Throwable unused) {
                            }
                        }
                        return null;
                    }
                }
            };
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, new Void[0]);
            } else {
                asyncTask.execute(new Void[0]);
            }
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Removed duplicated region for block: B:4:0x000c  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static void b(short r9, java.lang.String r10) {
        /*
            chat.ola.vn.w.s r0 = h()
            chat.ola.vn.w.cg r1 = new chat.ola.vn.w.cg
            r2 = 0
            r1.<init>(r2)
            if (r0 != 0) goto L10
        Lc:
            r1.a(r9, r10)
            goto L40
        L10:
            int r3 = r0.a()
            r4 = 1
            r5 = 0
            r6 = 1
        L17:
            if (r5 >= r3) goto L3d
            java.lang.Short r7 = r0.a(r5)
            short r8 = r7.shortValue()
            if (r8 != r4) goto L24
            goto L3a
        L24:
            short r8 = r7.shortValue()
            if (r8 != r9) goto L2f
            r1.a(r9, r10)
            r6 = 0
            goto L3a
        L2f:
            short r7 = r7.shortValue()
            byte[] r8 = r0.b(r5)
            r1.a(r7, r8)
        L3a:
            int r5 = r5 + 1
            goto L17
        L3d:
            if (r6 == 0) goto L40
            goto Lc
        L40:
            a(r1)
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.h.b.b(short, java.lang.String):void");
    }

    private static boolean b(s sVar) {
        String strB = sVar.b((short) 1);
        if (strB == null) {
            return false;
        }
        if (strB.equals("3.0")) {
            return true;
        }
        File fileF = d.f();
        if (fileF != null) {
            File file = new File(fileF.getAbsolutePath(), ".systemme.info");
            if (file.exists()) {
                com.mg.ola.common.d.c.c(file);
            }
        }
        return false;
    }

    private static boolean b(String str, s sVar) {
        if (m.a(str)) {
            return false;
        }
        if (sVar.b((short) 1).equals("3.0")) {
            return true;
        }
        File fileA = d.a(str.toLowerCase());
        if (fileA != null) {
            File file = new File(fileA.getAbsolutePath(), ".info.dat");
            if (file.exists()) {
                com.mg.ola.common.d.c.c(file);
            }
        }
        return false;
    }

    public static byte[] b(List<g> list) {
        try {
            int size = list.size();
            if (size > 100) {
                size = 100;
            }
            cg cgVar = new cg((short) 0);
            for (int i = 0; i < size; i++) {
                g gVar = list.get(i);
                cgVar.a((short) 30, gVar.a() == null ? "null" : gVar.a());
                String strB = gVar.b();
                if (!m.a(strB)) {
                    cgVar.a((short) 31, strB);
                }
                String strE = gVar.e();
                if (!m.a(strE)) {
                    cgVar.a((short) 44, strE);
                }
                cgVar.a((short) 42, gVar.c());
                cgVar.a((short) 43, gVar.d());
                cgVar.a((short) 34, gVar.f());
            }
            return cgVar.a();
        } catch (Throwable unused) {
            return null;
        }
    }

    public static String c() {
        try {
            s sVarH = h();
            if (sVarH != null && a(sVarH)) {
                return sVarH.b((short) 80);
            }
        } catch (Throwable unused) {
        }
        return null;
    }

    /* JADX WARN: Code restructure failed: missing block: B:14:0x002e, code lost:
    
        r1 = r0.getPassword(r4);
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static java.lang.String c(android.content.Context r6, java.lang.String r7) {
        /*
            boolean r0 = chat.ola.vn.util.m.a(r7)
            r1 = 0
            if (r0 == 0) goto L8
            return r1
        L8:
            android.accounts.AccountManager r0 = android.accounts.AccountManager.get(r6)     // Catch: java.lang.Throwable -> L33
            r2 = 2131689502(0x7f0f001e, float:1.9008021E38)
            java.lang.String r6 = r6.getString(r2)     // Catch: java.lang.Throwable -> L33
            android.accounts.Account[] r6 = r0.getAccountsByType(r6)     // Catch: java.lang.Throwable -> L33
            if (r6 == 0) goto L33
            int r2 = r6.length     // Catch: java.lang.Throwable -> L33
            if (r2 <= 0) goto L33
            int r2 = r6.length     // Catch: java.lang.Throwable -> L33
            r3 = 0
        L1e:
            if (r3 >= r2) goto L33
            r4 = r6[r3]     // Catch: java.lang.Throwable -> L33
            java.lang.String r5 = r4.name     // Catch: java.lang.Throwable -> L33
            boolean r5 = chat.ola.vn.util.m.b(r5, r7)     // Catch: java.lang.Throwable -> L33
            if (r5 == 0) goto L30
            java.lang.String r6 = r0.getPassword(r4)     // Catch: java.lang.Throwable -> L33
            r1 = r6
            goto L33
        L30:
            int r3 = r3 + 1
            goto L1e
        L33:
            boolean r6 = chat.ola.vn.util.m.a(r1)
            if (r6 == 0) goto L41
            chat.ola.vn.e r6 = chat.ola.vn.e.a()
            java.lang.String r1 = r6.m(r7)
        L41:
            return r1
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.h.b.c(android.content.Context, java.lang.String):java.lang.String");
    }

    private static List<f> c(s sVar) {
        int iC = sVar.c((short) 25);
        if (iC <= 0) {
            return null;
        }
        ArrayList arrayList = new ArrayList(iC);
        int iA = sVar.a((short) 7, 0);
        int i = 0;
        while (i < iC) {
            int iA2 = sVar.a((short) 7, iA);
            String lowerCase = sVar.c(iA).toLowerCase();
            f fVar = new f(lowerCase, (short) 0);
            String strB = sVar.b((short) 22, iA, iA2);
            if (strB != null) {
                lowerCase = strB;
            }
            fVar.c(lowerCase);
            fVar.b(sVar.a((short) 12, iA, iA2, (short) 0));
            fVar.e(sVar.b((short) 13, iA, iA2));
            fVar.e(sVar.a((short) 45, iA, iA2, (short) 0));
            fVar.c(sVar.a((short) 38, iA, iA2, (short) 0));
            fVar.b((byte) 1);
            arrayList.add(fVar);
            i++;
            iA = iA2;
        }
        return arrayList;
    }

    public static List<f> c(byte[] bArr) {
        try {
            s sVarA = o.a(new ByteArrayInputStream(bArr));
            short s = 2;
            int iC = sVarA.c((short) 2);
            if (iC > 0) {
                ArrayList arrayList = new ArrayList(iC);
                int iB = sVarA.b((short) 2, 0);
                int i = 0;
                while (i < iC) {
                    int iA = sVarA.a(s, iB);
                    String strC = sVarA.c(iB);
                    short sA = sVarA.a((short) 85, iB, iA, (short) 0);
                    long jA = sVarA.a((short) 46, iB, iA, 0L);
                    f fVar = new f(strC, sA);
                    if (fVar.m()) {
                        fVar.M = 0L;
                        if (jA > 0) {
                            fVar.J = Long.valueOf(jA);
                        } else {
                            fVar.J = null;
                        }
                        fVar.a(0);
                        fVar.a(true, false);
                        arrayList.add(fVar);
                        iB = iA;
                    }
                    i++;
                    s = 2;
                }
                return arrayList;
            }
        } catch (Throwable unused) {
        }
        return null;
    }

    private static void c(File file, List<af> list) throws IOException {
        FileOutputStream fileOutputStream = new FileOutputStream(file);
        cg cgVar = new cg((short) 0);
        cgVar.a((short) 1, "3.0");
        for (af afVar : list) {
            cgVar.a((short) 25, afVar.b());
            cgVar.a((short) 26, afVar.a());
        }
        fileOutputStream.write(cgVar.a());
        fileOutputStream.flush();
        fileOutputStream.close();
    }

    public static void c(final String str, final byte b) {
        if (m.a(str)) {
            return;
        }
        try {
            AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.h.b.5
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    b.b(str, (short) 64, String.valueOf((int) b));
                    return null;
                }
            };
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, new Void[0]);
            } else {
                asyncTask.execute(new Void[0]);
            }
        } catch (Throwable unused) {
        }
    }

    public static void c(final String str, final List<f> list) {
        if (m.a(str)) {
            return;
        }
        try {
            AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.h.b.14
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    synchronized (".phoneignore.list") {
                        try {
                            byte[] bArrF = (list == null || list.size() <= 0) ? null : b.f((List<f>) list);
                            File fileA = d.a(str.toLowerCase());
                            if (fileA != null) {
                                File file = new File(fileA.getAbsolutePath(), ".phoneignore.list");
                                if (bArrF == null) {
                                    file.delete();
                                } else {
                                    if (!file.exists()) {
                                        file.createNewFile();
                                    }
                                    com.mg.ola.common.d.c.a(file, bArrF);
                                }
                            }
                        } catch (Throwable unused) {
                        }
                    }
                    return null;
                }
            };
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, new Void[0]);
            } else {
                asyncTask.execute(new Void[0]);
            }
        } catch (Throwable unused) {
        }
    }

    public static void c(final String str, final boolean z) {
        if (m.a(str)) {
            return;
        }
        try {
            AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.h.b.6
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    b.b(str, (short) 73, String.valueOf(z));
                    return null;
                }
            };
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, new Void[0]);
            } else {
                asyncTask.execute(new Void[0]);
            }
        } catch (Throwable unused) {
        }
    }

    private static boolean c(String str, s sVar) {
        if (m.a(str)) {
            return false;
        }
        if (sVar.b((short) 1).equals("2.0")) {
            return true;
        }
        File fileA = d.a(str.toLowerCase());
        if (fileA != null) {
            File file = new File(fileA.getAbsolutePath(), ".info.dat");
            if (file.exists()) {
                com.mg.ola.common.d.c.c(file);
            }
        }
        return false;
    }

    public static byte[] c(String str) {
        File fileA;
        if (!m.a(str) && (fileA = d.a(str.toLowerCase())) != null && fileA.exists()) {
            File file = new File(fileA.getAbsolutePath(), ".app.background");
            try {
                if (file.exists()) {
                    return com.mg.ola.common.d.c.a(file);
                }
                return null;
            } catch (Throwable unused) {
            }
        }
        return null;
    }

    public static byte[] c(List<t> list) {
        try {
            int size = list.size();
            if (size > 100) {
                size = 100;
            }
            cg cgVar = new cg((short) 0);
            for (int i = 0; i < size; i++) {
                t tVar = list.get(i);
                cgVar.a((short) 30, tVar.o() == null ? "null" : tVar.o());
                String strL = tVar.l();
                if (!m.a(strL)) {
                    cgVar.a((short) 31, strL);
                }
                cgVar.a((short) 42, tVar.A());
                cgVar.a((short) 43, tVar.z());
                cgVar.a((short) 34, tVar.y());
            }
            return cgVar.a();
        } catch (Throwable unused) {
            return null;
        }
    }

    public static String d(Context context, String str) {
        if (m.a(str)) {
            return null;
        }
        try {
            AccountManager accountManager = AccountManager.get(context);
            Account[] accountsByType = accountManager.getAccountsByType(context.getString(R.string.account_type));
            if (accountsByType != null && accountsByType.length > 0) {
                for (Account account : accountsByType) {
                    if (m.b(account.name, str)) {
                        return accountManager.getUserData(account, "_trust_token");
                    }
                }
            }
            return null;
        } catch (Throwable unused) {
            return e.a().n(str);
        }
    }

    public static List<ah> d() {
        try {
            InputStream inputStreamOpen = OlaApplication.a().getAssets().open("vipicon.dat");
            byte[] bArr = new byte[inputStreamOpen.available()];
            inputStreamOpen.read(bArr);
            inputStreamOpen.close();
            return ah.b(bArr);
        } catch (Throwable unused) {
            return null;
        }
    }

    private static List<f> d(s sVar) {
        int iC = sVar.c((short) 25);
        if (iC <= 0) {
            return null;
        }
        ArrayList arrayList = new ArrayList(iC);
        int i = 0;
        int iB = sVar.b((short) 25, 0);
        while (i < iC) {
            int iA = sVar.a((short) 25, iB);
            f fVar = new f(sVar.c(iB), (short) 2);
            fVar.a((short) 2);
            fVar.b(sVar.b((short) 26, iB, iA));
            fVar.d(sVar.b((short) 38, iB, iA));
            fVar.g(sVar.b((short) 9, iB, iA));
            arrayList.add(fVar);
            i++;
            iB = iA;
        }
        return arrayList;
    }

    public static List<f> d(String str) {
        if (m.a(str)) {
            return null;
        }
        try {
            s sVarY = y(str);
            if (sVarY != null && a(str, sVarY)) {
                return c(sVarY);
            }
        } catch (Throwable unused) {
        }
        return null;
    }

    public static List<f> d(byte[] bArr) {
        try {
            s sVarA = o.a(new ByteArrayInputStream(bArr));
            int iC = sVarA.c((short) 2);
            if (iC <= 0) {
                return null;
            }
            ArrayList arrayList = new ArrayList(iC);
            int iB = sVarA.b((short) 2, 0);
            int i = 0;
            while (i < iC) {
                int iA = sVarA.a((short) 2, iB);
                String strC = sVarA.c(iB);
                short sA = sVarA.a((short) 85, iB, iA, (short) 0);
                String strB = sVarA.b((short) 28, iB, iA);
                f fVar = new f(strC, sA);
                fVar.h(strB);
                arrayList.add(fVar);
                i++;
                iB = iA;
            }
            return arrayList;
        } catch (Throwable unused) {
            return null;
        }
    }

    public static void d(final String str, final byte b) {
        if (m.a(str)) {
            return;
        }
        try {
            AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.h.b.11
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    b.b(str, (short) 56, String.valueOf((int) b));
                    return null;
                }
            };
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, new Void[0]);
            } else {
                asyncTask.execute(new Void[0]);
            }
        } catch (Throwable unused) {
        }
    }

    public static void d(String str, List<f> list) {
        File fileA;
        if (m.a(str) || (fileA = d.a(str.toLowerCase())) == null) {
            return;
        }
        File file = new File(fileA.getAbsolutePath(), ".chatgroup.dat");
        try {
            if (!file.exists()) {
                file.createNewFile();
            }
            a(file, list);
        } catch (Throwable unused) {
        }
    }

    public static void d(final String str, final boolean z) {
        if (m.a(str)) {
            return;
        }
        try {
            AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.h.b.8
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    b.b(str, (short) 65, String.valueOf(z));
                    return null;
                }
            };
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, new Void[0]);
            } else {
                asyncTask.execute(new Void[0]);
            }
        } catch (Throwable unused) {
        }
    }

    public static void d(List<af> list) {
        File fileF = d.f();
        if (fileF != null) {
            File file = new File(fileF.getAbsolutePath(), ".systemme.info");
            try {
                if (!file.exists()) {
                    file.createNewFile();
                }
                c(file, list);
            } catch (Throwable unused) {
            }
        }
    }

    private static boolean d(String str, s sVar) {
        if (m.a(str)) {
            return false;
        }
        if (sVar.b((short) 1).equals("2.0")) {
            return true;
        }
        File fileA = d.a(str.toLowerCase());
        if (fileA != null) {
            File file = new File(fileA.getAbsolutePath(), ".contact.dat");
            if (file.exists()) {
                com.mg.ola.common.d.c.c(file);
            }
        }
        return false;
    }

    public static long e(String str) {
        if (m.a(str)) {
            return 0L;
        }
        try {
            s sVarZ = z(str);
            if (sVarZ != null && b(str, sVarZ)) {
                return Long.parseLong(sVarZ.b((short) 97));
            }
        } catch (Throwable unused) {
        }
        return 0L;
    }

    public static List<af> e() {
        int iC;
        File fileF = d.f();
        if (fileF != null) {
            File file = new File(fileF.getAbsolutePath(), ".systemme.info");
            try {
                if (file.exists()) {
                    FileInputStream fileInputStream = new FileInputStream(file);
                    s sVarA = o.a(fileInputStream);
                    fileInputStream.close();
                    if (sVarA != null && b(sVarA) && (iC = sVarA.c((short) 25)) > 0) {
                        ArrayList arrayList = new ArrayList();
                        int iB = sVarA.b((short) 25, 0);
                        int iB2 = sVarA.b((short) 26, 0);
                        for (int i = 0; i < iC; i++) {
                            String strC = sVarA.c(iB);
                            if (!m.b("#sh", strC)) {
                                arrayList.add(new af(sVarA.c(iB2), strC));
                                iB = sVarA.a((short) 25, iB);
                                iB2 = sVarA.a((short) 26, iB2);
                            }
                        }
                        return arrayList;
                    }
                }
            } catch (Throwable unused) {
            }
        }
        return null;
    }

    public static void e(final String str, final boolean z) {
        if (m.a(str)) {
            return;
        }
        try {
            AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.h.b.9
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    b.b(str, (short) 110, String.valueOf(z));
                    return null;
                }
            };
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, new Void[0]);
            } else {
                asyncTask.execute(new Void[0]);
            }
        } catch (Throwable unused) {
        }
    }

    private static boolean e(String str, s sVar) {
        if (m.a(str)) {
            return false;
        }
        if (sVar.b((short) 1).equals("3.0")) {
            return true;
        }
        File fileA = d.a(str.toLowerCase());
        if (fileA != null) {
            File file = new File(fileA.getAbsolutePath(), ".chatgroup.dat");
            if (file.exists()) {
                com.mg.ola.common.d.c.c(file);
            }
        }
        return false;
    }

    public static byte[] e(List<f> list) {
        try {
            int size = list.size();
            if (size > 60) {
                size = 60;
            }
            cg cgVar = null;
            for (int i = 0; i < size; i++) {
                f fVar = list.get(i);
                if (fVar.m() && fVar.V()) {
                    if (cgVar == null) {
                        cgVar = new cg((short) 0);
                    }
                    cgVar.a((short) 2, fVar.j());
                    cgVar.a((short) 85, (byte) fVar.k());
                    cgVar.a((short) 6, fVar.a());
                    if (fVar.J != null) {
                        cgVar.a((short) 46, fVar.J.longValue());
                    }
                }
            }
            if (cgVar != null) {
                return cgVar.a();
            }
        } catch (Throwable unused) {
        }
        return null;
    }

    public static Long f(String str) {
        if (m.a(str)) {
            return null;
        }
        try {
            s sVarZ = z(str);
            if (sVarZ != null && b(str, sVarZ)) {
                return Long.valueOf(sVarZ.b((short) 88));
            }
        } catch (Throwable unused) {
        }
        return null;
    }

    public static void f(final String str, final boolean z) {
        if (m.a(str)) {
            return;
        }
        try {
            AsyncTask<Void, Void, Void> asyncTask = new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.h.b.10
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    b.b(str, (short) 112, String.valueOf(z));
                    return null;
                }
            };
            if (com.mg.ola.common.d.g.c()) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, new Void[0]);
            } else {
                asyncTask.execute(new Void[0]);
            }
        } catch (Throwable unused) {
        }
    }

    private static boolean f(String str, s sVar) {
        if (m.a(str)) {
            return false;
        }
        if (sVar.b((short) 1).equals("3.0")) {
            return true;
        }
        File fileA = d.a(str.toLowerCase());
        if (fileA != null) {
            File file = new File(fileA.getAbsolutePath(), ".lastviewme.dat");
            if (file.exists()) {
                com.mg.ola.common.d.c.c(file);
            }
        }
        return false;
    }

    public static byte[] f() {
        try {
            cg cgVar = new cg((short) 0);
            cgVar.a((short) 56, String.valueOf((int) x.k));
            cgVar.a((short) 107, String.valueOf(x.u));
            cgVar.a((short) 86, String.valueOf((int) x.l));
            cgVar.a((short) 90, String.valueOf(false));
            cgVar.a((short) 91, String.valueOf(x.r));
            cgVar.a((short) 95, String.valueOf(x.s));
            cgVar.a((short) 101, String.valueOf((int) x.p));
            cgVar.a((short) 104, String.valueOf(x.t));
            cgVar.a((short) 19, String.valueOf(false));
            cgVar.a((short) 105, x.b != null ? String.valueOf(x.b) : String.valueOf(false));
            if (cgVar != null) {
                return cgVar.a();
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    public static byte[] f(List<f> list) {
        try {
            int size = list.size();
            cg cgVar = null;
            for (int i = 0; i < size; i++) {
                f fVar = list.get(i);
                String strP = fVar.p();
                if (!m.a(strP)) {
                    if (cgVar == null) {
                        cgVar = new cg((short) 0);
                    }
                    cgVar.a((short) 2, fVar.j());
                    cgVar.a((short) 85, (byte) fVar.k());
                    cgVar.a((short) 28, strP);
                }
            }
            if (cgVar != null) {
                return cgVar.a();
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        return null;
    }

    public static byte g(String str) {
        s sVarZ;
        if (m.a(str)) {
            return i();
        }
        try {
            sVarZ = z(str);
        } catch (Throwable unused) {
        }
        if (sVarZ == null) {
            return i();
        }
        if (b(str, sVarZ)) {
            String strB = sVarZ.b((short) 59);
            return m.a(strB) ? i() : Byte.parseByte(strB);
        }
        return i();
    }

    public static void g() {
        File[] fileArrListFiles;
        String name;
        try {
            if (a) {
                return;
            }
            if (e.a().b() > 88) {
                a = true;
                return;
            }
            File fileJ = d.j();
            if (fileJ != null && fileJ.exists() && (fileArrListFiles = fileJ.listFiles()) != null) {
                for (int i = 0; i < fileArrListFiles.length; i++) {
                    if (fileArrListFiles[i] != null && fileArrListFiles[i].isDirectory() && (name = fileArrListFiles[i].getName()) != null && name.startsWith(".") && name.length() > ".".length()) {
                        String strSubstring = name.substring(".".length());
                        if (!m.a(strSubstring)) {
                            String strW = w(strSubstring);
                            String strX = x(strSubstring);
                            long jE = e(strSubstring);
                            try {
                                AccountManager accountManager = AccountManager.get(OlaApplication.a());
                                Account account = new Account(strSubstring, OlaApplication.a(R.string.account_type));
                                if (accountManager.addAccountExplicitly(account, strW, null)) {
                                    accountManager.setAuthToken(account, OlaApplication.a(R.string.token_type), strX);
                                    accountManager.setUserData(account, "_time", String.valueOf(jE));
                                } else {
                                    accountManager.setPassword(account, strW);
                                }
                            } catch (Throwable th) {
                                th.printStackTrace();
                            }
                        }
                    }
                }
            }
        } finally {
            a = true;
        }
    }

    public static byte h(String str) {
        if (m.a(str)) {
            return (byte) 0;
        }
        try {
            s sVarZ = z(str);
            if (sVarZ != null && b(str, sVarZ)) {
                String strB = sVarZ.b((short) 56);
                if (m.a(strB)) {
                    return (byte) 0;
                }
                byte b = Byte.parseByte(strB);
                if (b > 2) {
                    return (byte) 0;
                }
                return b;
            }
        } catch (Throwable unused) {
        }
        return (byte) 0;
    }

    private static s h() {
        synchronized (".app2.info") {
            File fileF = d.f();
            if (fileF != null) {
                File file = new File(fileF.getAbsolutePath(), ".app2.info");
                try {
                    if (file.exists()) {
                        FileInputStream fileInputStream = new FileInputStream(file);
                        s sVarA = o.a(fileInputStream);
                        fileInputStream.close();
                        return sVarA;
                    }
                } catch (Throwable unused) {
                }
            }
            return null;
        }
    }

    private static byte i() {
        return (byte) 2;
    }

    public static boolean i(String str) {
        if (m.a(str)) {
            return true;
        }
        try {
            s sVarZ = z(str);
            if (sVarZ != null && b(str, sVarZ)) {
                String strB = sVarZ.b((short) 89);
                if (m.a(strB)) {
                    return true;
                }
                return Boolean.parseBoolean(strB);
            }
        } catch (Throwable unused) {
        }
        return true;
    }

    public static byte j(String str) {
        if (m.a(str)) {
            return (byte) 3;
        }
        try {
            s sVarZ = z(str);
            if (sVarZ != null && b(str, sVarZ)) {
                String strB = sVarZ.b((short) 63);
                if (m.a(strB)) {
                    return (byte) 3;
                }
                return Byte.parseByte(strB);
            }
        } catch (Throwable unused) {
        }
        return (byte) 3;
    }

    public static boolean k(String str) {
        if (m.a(str)) {
            return true;
        }
        try {
            s sVarZ = z(str);
            if (sVarZ != null && b(str, sVarZ)) {
                String strB = sVarZ.b((short) 67);
                if (m.a(strB)) {
                    return true;
                }
                return Boolean.parseBoolean(strB);
            }
        } catch (Throwable unused) {
        }
        return true;
    }

    public static boolean l(String str) {
        if (m.a(str)) {
            return true;
        }
        try {
            s sVarZ = z(str);
            if (sVarZ != null && b(str, sVarZ)) {
                String strB = sVarZ.b((short) 110);
                if (m.a(strB)) {
                    return true;
                }
                return Boolean.parseBoolean(strB);
            }
        } catch (Throwable unused) {
        }
        return true;
    }

    public static boolean m(String str) {
        if (m.a(str)) {
            return false;
        }
        try {
            s sVarZ = z(str);
            if (sVarZ != null && b(str, sVarZ)) {
                String strB = sVarZ.b((short) 112);
                if (m.a(strB)) {
                    return false;
                }
                return Boolean.parseBoolean(strB);
            }
        } catch (Throwable unused) {
        }
        return false;
    }

    public static byte n(String str) {
        if (m.a(str)) {
            return (byte) 0;
        }
        try {
            s sVarZ = z(str);
            if (sVarZ != null && b(str, sVarZ)) {
                String strB = sVarZ.b((short) 64);
                if (m.a(strB)) {
                    return (byte) 0;
                }
                return Byte.parseByte(strB);
            }
        } catch (Throwable unused) {
        }
        return (byte) 0;
    }

    public static boolean o(String str) {
        return false;
    }

    public static List<String> p(String str) {
        String[] strArrSplit;
        if (m.a(str)) {
            return null;
        }
        try {
            s sVarZ = z(str);
            if (sVarZ != null && b(str, sVarZ)) {
                String strB = sVarZ.b((short) 81);
                if (m.a(strB) || (strArrSplit = strB.split(";")) == null || strArrSplit.length == 0) {
                    return null;
                }
                ArrayList arrayList = new ArrayList();
                HashMap map = new HashMap();
                for (String str2 : strArrSplit) {
                    if (map.get(str2) == null) {
                        arrayList.add(str2);
                        map.put(str2, str2);
                    }
                }
                return arrayList;
            }
        } catch (Throwable unused) {
        }
        return null;
    }

    public static boolean q(String str) {
        if (m.a(str)) {
            return true;
        }
        try {
            s sVarZ = z(str);
            if (sVarZ != null && b(str, sVarZ)) {
                String strB = sVarZ.b((short) 65);
                if (m.a(strB)) {
                    return true;
                }
                return Boolean.parseBoolean(strB);
            }
        } catch (Throwable unused) {
        }
        return true;
    }

    public static chat.ola.vn.me.a r(String str) {
        if (m.a(str)) {
            return null;
        }
        try {
            s sVarZ = z(str);
            if (sVarZ != null && b(str, sVarZ)) {
                return chat.ola.vn.me.a.a(sVarZ.b((short) 111));
            }
        } catch (Throwable unused) {
        }
        return null;
    }

    public static List<chat.ola.vn.entity.g> s(String str) {
        w wVar;
        ArrayList arrayList;
        if (m.a(str)) {
            return null;
        }
        File fileA = d.a(str.toLowerCase());
        if (fileA != null) {
            File file = new File(fileA.getAbsolutePath(), ".me");
            if (file.exists()) {
                File file2 = new File(file.getAbsolutePath(), ".lastviewme.dat");
                if (file2.exists()) {
                    try {
                        FileInputStream fileInputStream = new FileInputStream(file2);
                        s sVarA = o.a(fileInputStream);
                        fileInputStream.close();
                        if (sVarA == null || !f(str, sVarA)) {
                            return null;
                        }
                        short s = 12;
                        int iC = sVarA.c((short) 12);
                        if (iC <= 0) {
                            return null;
                        }
                        ArrayList arrayList2 = new ArrayList(iC);
                        byte b = 0;
                        int iB = sVarA.b((short) 12, 0);
                        long jCurrentTimeMillis = System.currentTimeMillis();
                        int i = iB;
                        int i2 = 0;
                        ArrayList arrayList3 = null;
                        while (i2 < iC) {
                            int iA = sVarA.a(s, i);
                            long jA = sVarA.a(i, 0L);
                            if (arrayList3 == null) {
                                arrayList3 = new ArrayList();
                            }
                            ArrayList arrayList4 = arrayList3;
                            arrayList4.add("" + jA);
                            String strB = sVarA.b((short) 4, i, iA);
                            short sA = (short) sVarA.a((short) 13, i, iA, b);
                            short sA2 = (short) sVarA.a((short) 7, i, iA, b);
                            short sA3 = sVarA.a((short) 8, i, iA, b);
                            String strB2 = sVarA.b((short) 26, i, iA);
                            int iA2 = sVarA.a((short) 14, i, iA, 0);
                            int i3 = iC;
                            ArrayList arrayList5 = arrayList2;
                            int i4 = i2;
                            int i5 = i;
                            long jA2 = sVarA.a((short) 6, i, iA, 0L);
                            long jA3 = sVarA.a((short) 98, i5, iA, 0L);
                            long jA4 = sVarA.a((short) 99, i5, iA, 0L);
                            i = iA;
                            String strB3 = sVarA.b((short) 5, i5, i);
                            String strB4 = sVarA.b((short) 9, i5, i);
                            short sA4 = sVarA.a((short) 17, i5, i, (short) 0);
                            String strB5 = sVarA.b((short) 108, i5, i);
                            if (chat.ola.vn.entity.g.a(sA4)) {
                                String strB6 = sVarA.b((short) 82, i5, i);
                                if (strB3 == null && sA2 == 0 && strB4 == null) {
                                    arrayList = arrayList5;
                                } else {
                                    chat.ola.vn.entity.g gVar = new chat.ola.vn.entity.g();
                                    gVar.b(jA);
                                    gVar.a(strB);
                                    gVar.b(iA2);
                                    gVar.b(sA);
                                    if (sA2 > 0) {
                                        wVar = new w();
                                        wVar.a(sA2);
                                    } else if (w.b(strB4)) {
                                        wVar = new w();
                                        wVar.a(strB4);
                                        strB4 = null;
                                    } else {
                                        wVar = null;
                                    }
                                    gVar.a(wVar);
                                    gVar.e(sA3);
                                    gVar.i(strB2);
                                    gVar.a(jCurrentTimeMillis - jA2);
                                    gVar.b(strB3);
                                    gVar.c(strB4);
                                    gVar.d(sA4);
                                    if (jA3 == 0 && m.a(strB4)) {
                                        try {
                                            String strE = i.e(strB3);
                                            if (m.a(strE)) {
                                                String strF = i.f(strB3);
                                                if (!m.a(strF)) {
                                                    gVar.d((short) 2);
                                                    gVar.m(strF);
                                                }
                                            } else {
                                                gVar.d((short) 2);
                                                gVar.l(strE);
                                            }
                                        } catch (Throwable unused) {
                                        }
                                    }
                                    gVar.a(false);
                                    gVar.f(strB6);
                                    gVar.d(jA3);
                                    gVar.k(strB5);
                                    if (jA4 != 0) {
                                        h hVar = new h();
                                        hVar.a(jA4);
                                        gVar.a(hVar);
                                    }
                                    arrayList = arrayList5;
                                    arrayList.add(gVar);
                                }
                            } else {
                                arrayList = arrayList5;
                            }
                            i2 = i4 + 1;
                            arrayList2 = arrayList;
                            arrayList3 = arrayList4;
                            iC = i3;
                            s = 12;
                            b = 0;
                        }
                        ArrayList arrayList6 = arrayList2;
                        Collections.sort(arrayList6, new chat.ola.vn.e.c(false));
                        chat.ola.vn.r.a.e.e(arrayList6);
                        try {
                            OlaApplication.b.a(arrayList3);
                        } catch (Throwable unused2) {
                        }
                        chat.ola.vn.entity.g gVarD = chat.ola.vn.r.a.e.d((String) null);
                        if (gVarD != null) {
                            arrayList6.add(0, gVarD);
                        }
                        return arrayList6;
                    } catch (Throwable th) {
                        th.printStackTrace();
                        return null;
                    }
                }
            }
        }
        return null;
    }

    public static List<f> t(String str) {
        synchronized (".conversation.list") {
            File fileA = d.a(str.toLowerCase());
            if (fileA != null) {
                File file = new File(fileA.getAbsolutePath(), ".conversation.list");
                try {
                    if (file.exists()) {
                        return c(com.mg.ola.common.d.c.a(file));
                    }
                } catch (Throwable unused) {
                }
            }
            return null;
        }
    }

    public static List<f> u(String str) {
        if (m.a(str)) {
            return null;
        }
        synchronized (".phoneignore.list") {
            File fileA = d.a(str.toLowerCase());
            if (fileA != null) {
                File file = new File(fileA.getAbsolutePath(), ".phoneignore.list");
                try {
                    if (file.exists()) {
                        return d(com.mg.ola.common.d.c.a(file));
                    }
                } catch (Throwable unused) {
                }
            }
            return null;
        }
    }

    public static List<f> v(String str) {
        File fileA;
        if (!m.a(str) && (fileA = d.a(str.toLowerCase())) != null) {
            File file = new File(fileA.getAbsolutePath(), ".chatgroup.dat");
            try {
                if (file.exists()) {
                    FileInputStream fileInputStream = new FileInputStream(file);
                    s sVarA = o.a(fileInputStream);
                    fileInputStream.close();
                    if (sVarA != null && e(str, sVarA)) {
                        return d(sVarA);
                    }
                }
            } catch (Throwable unused) {
            }
        }
        return null;
    }

    public static String w(String str) {
        byte[] bArrA;
        byte[] bArrA2;
        if (m.a(str)) {
            return null;
        }
        try {
            s sVarA = A(str);
            if (sVarA != null && c(str, sVarA) && (bArrA = sVarA.a((short) 49)) != null && (bArrA2 = sVarA.a((short) 50)) != null) {
                return chat.ola.vn.j.a.a(bArrA, bArrA2);
            }
        } catch (Throwable unused) {
        }
        return null;
    }

    public static String x(String str) {
        if (m.a(str)) {
            return null;
        }
        try {
            s sVarA = A(str);
            if (sVarA != null && c(str, sVarA)) {
                return sVarA.b((short) 29);
            }
        } catch (Throwable unused) {
        }
        return null;
    }

    private static s y(String str) {
        synchronized (".contact.dat") {
            File fileA = d.a(str.toLowerCase());
            if (fileA != null) {
                File file = new File(fileA.getAbsolutePath(), ".contact.dat");
                try {
                    if (file.exists()) {
                        FileInputStream fileInputStream = new FileInputStream(file);
                        s sVarA = o.a(fileInputStream);
                        fileInputStream.close();
                        return sVarA;
                    }
                } catch (Throwable unused) {
                }
            }
            return null;
        }
    }

    private static s z(String str) {
        if (m.a(str)) {
            return null;
        }
        synchronized (".info.dat") {
            File fileA = d.a(str.toLowerCase());
            if (fileA != null) {
                File file = new File(fileA.getAbsolutePath(), ".info.dat");
                try {
                    if (file.exists()) {
                        FileInputStream fileInputStream = new FileInputStream(file);
                        s sVarA = o.a(fileInputStream);
                        fileInputStream.close();
                        if (sVarA == null) {
                            return null;
                        }
                        if (a(str, sVarA)) {
                            return sVarA;
                        }
                    }
                } catch (Throwable unused) {
                }
            }
            return null;
        }
    }
}
