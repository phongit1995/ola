package chat.ola.vn.v;

import android.content.Context;
import android.os.AsyncTask;

/* JADX INFO: loaded from: classes.dex */
public class d extends AsyncTask<Context, Void, Void> {
    /* JADX INFO: Access modifiers changed from: protected */
    /* JADX WARN: Removed duplicated region for block: B:31:0x009b A[Catch: Throwable -> 0x00b8, TRY_ENTER, TryCatch #1 {Throwable -> 0x00b8, blocks: (B:10:0x000d, B:12:0x0035, B:14:0x004e, B:16:0x0058, B:19:0x0073, B:31:0x009b, B:32:0x00a9, B:34:0x00af), top: B:42:0x000d }] */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public java.lang.Void doInBackground(android.content.Context... r12) {
        /*
            r11 = this;
            r0 = 0
            if (r12 == 0) goto Lbc
            int r1 = r12.length
            if (r1 != 0) goto L7
            return r0
        L7:
            r1 = 0
            r12 = r12[r1]
            if (r12 != 0) goto Ld
            return r0
        Ld:
            java.lang.String r2 = chat.ola.vn.h.a()     // Catch: java.lang.Throwable -> Lb8
            java.util.List r2 = chat.ola.vn.h.b.u(r2)     // Catch: java.lang.Throwable -> Lb8
            chat.ola.vn.message.g r3 = chat.ola.vn.h.t     // Catch: java.lang.Throwable -> Lb8
            r3.k(r2)     // Catch: java.lang.Throwable -> Lb8
            android.net.Uri r5 = android.provider.ContactsContract.CommonDataKinds.Phone.CONTENT_URI     // Catch: java.lang.Throwable -> Lb8
            r3 = 2
            java.lang.String[] r6 = new java.lang.String[r3]     // Catch: java.lang.Throwable -> Lb8
            java.lang.String r3 = "display_name"
            r6[r1] = r3     // Catch: java.lang.Throwable -> Lb8
            java.lang.String r3 = "data1"
            r10 = 1
            r6[r10] = r3     // Catch: java.lang.Throwable -> Lb8
            android.content.ContentResolver r4 = r12.getContentResolver()     // Catch: java.lang.Throwable -> Lb8
            r7 = 0
            r8 = 0
            r9 = 0
            android.database.Cursor r12 = r4.query(r5, r6, r7, r8, r9)     // Catch: java.lang.Throwable -> Lb8
            if (r12 == 0) goto Lbc
            java.lang.String r3 = "display_name"
            int r3 = r12.getColumnIndex(r3)     // Catch: java.lang.Throwable -> Lb8
            java.lang.String r4 = "data1"
            int r4 = r12.getColumnIndex(r4)     // Catch: java.lang.Throwable -> Lb8
            java.util.ArrayList r5 = new java.util.ArrayList     // Catch: java.lang.Throwable -> Lb8
            r6 = 1000(0x3e8, float:1.401E-42)
            r5.<init>(r6)     // Catch: java.lang.Throwable -> Lb8
            boolean r6 = r12.moveToFirst()     // Catch: java.lang.Throwable -> Lb8
            if (r6 == 0) goto Laf
        L4e:
            java.lang.String r6 = r12.getString(r4)     // Catch: java.lang.Throwable -> Lb8
            boolean r7 = chat.ola.vn.util.m.a(r6)     // Catch: java.lang.Throwable -> Lb8
            if (r7 != 0) goto La9
            java.lang.String r7 = "-"
            java.lang.String r8 = ""
            java.lang.String r6 = r6.replace(r7, r8)     // Catch: java.lang.Throwable -> Lb8
            java.lang.String r7 = " "
            java.lang.String r8 = ""
            java.lang.String r6 = r6.replace(r7, r8)     // Catch: java.lang.Throwable -> Lb8
            java.lang.String r7 = r12.getString(r3)     // Catch: java.lang.Throwable -> Lb8
            boolean r8 = chat.ola.vn.util.m.a(r7)     // Catch: java.lang.Throwable -> Lb8
            if (r8 == 0) goto L73
            r7 = r6
        L73:
            int r8 = r6.length()     // Catch: java.lang.Throwable -> Lb8
            r9 = 4
            if (r8 < r9) goto La9
            if (r2 == 0) goto L98
            java.util.Iterator r8 = r2.iterator()     // Catch: java.lang.Throwable -> L98
        L80:
            boolean r9 = r8.hasNext()     // Catch: java.lang.Throwable -> L98
            if (r9 == 0) goto L98
            java.lang.Object r9 = r8.next()     // Catch: java.lang.Throwable -> L98
            chat.ola.vn.message.f r9 = (chat.ola.vn.message.f) r9     // Catch: java.lang.Throwable -> L98
            java.lang.String r9 = r9.p()     // Catch: java.lang.Throwable -> L98
            boolean r9 = chat.ola.vn.util.o.b(r9, r6)     // Catch: java.lang.Throwable -> L98
            if (r9 == 0) goto L80
            r8 = 0
            goto L99
        L98:
            r8 = 1
        L99:
            if (r8 == 0) goto La9
            chat.ola.vn.message.f r8 = new chat.ola.vn.message.f     // Catch: java.lang.Throwable -> Lb8
            r8.<init>(r0, r1)     // Catch: java.lang.Throwable -> Lb8
            r8.h(r6)     // Catch: java.lang.Throwable -> Lb8
            r8.c(r7)     // Catch: java.lang.Throwable -> Lb8
            r5.add(r8)     // Catch: java.lang.Throwable -> Lb8
        La9:
            boolean r6 = r12.moveToNext()     // Catch: java.lang.Throwable -> Lb8
            if (r6 != 0) goto L4e
        Laf:
            chat.ola.vn.message.g r1 = chat.ola.vn.h.t     // Catch: java.lang.Throwable -> Lb8
            r1.g(r5)     // Catch: java.lang.Throwable -> Lb8
            r12.close()     // Catch: java.lang.Throwable -> Lb8
            return r0
        Lb8:
            r12 = move-exception
            r12.printStackTrace()
        Lbc:
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.v.d.doInBackground(android.content.Context[]):java.lang.Void");
    }
}
