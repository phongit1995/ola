package chat.ola.vn.c;

import android.os.AsyncTask;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
class d extends AsyncTask<f, Integer, f[]> {
    public static Integer a = 0;
    private static Map<String, f> b = new HashMap();

    d() {
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public void onProgressUpdate(Integer... numArr) {
    }

    /* JADX INFO: Access modifiers changed from: protected */
    /* JADX WARN: Code restructure failed: missing block: B:505:0x0630, code lost:
    
        continue;
     */
    /* JADX WARN: Removed duplicated region for block: B:108:0x0188 A[Catch: Throwable -> 0x063b, TryCatch #10 {Throwable -> 0x063b, blocks: (B:3:0x0002, B:4:0x0004, B:9:0x0017, B:13:0x001d, B:15:0x0020, B:18:0x0026, B:21:0x002c, B:22:0x002e, B:373:0x0635, B:60:0x00b0, B:85:0x0123, B:106:0x0184, B:108:0x0188, B:110:0x018c, B:113:0x019c, B:114:0x01a0, B:116:0x01a8, B:127:0x01f7, B:129:0x01fb, B:133:0x020c, B:194:0x0309, B:196:0x030f, B:198:0x0313, B:200:0x031b, B:201:0x0336, B:203:0x033e, B:205:0x0346, B:207:0x0353, B:213:0x0380, B:214:0x0384, B:215:0x0389, B:217:0x0399, B:245:0x040b, B:257:0x0451, B:259:0x0459, B:261:0x0461, B:263:0x046e, B:265:0x0479, B:286:0x04de, B:288:0x04e3, B:290:0x04e7, B:292:0x04f5, B:295:0x04fd, B:297:0x050b, B:299:0x0521, B:300:0x0523, B:370:0x062f, B:378:0x063a, B:23:0x002f, B:25:0x0035, B:27:0x003f, B:29:0x0043, B:32:0x004a, B:34:0x0054, B:36:0x0058, B:37:0x005f, B:39:0x0063, B:40:0x006e, B:42:0x0071, B:44:0x0075, B:45:0x007c, B:47:0x0080, B:48:0x008a, B:50:0x008e, B:51:0x0095, B:53:0x0099, B:54:0x00a2, B:55:0x00a5, B:59:0x00af, B:5:0x0005, B:6:0x0013), top: B:419:0x0002, inners: #5, #9 }] */
    /* JADX WARN: Removed duplicated region for block: B:127:0x01f7 A[Catch: Throwable -> 0x063b, TRY_ENTER, TryCatch #10 {Throwable -> 0x063b, blocks: (B:3:0x0002, B:4:0x0004, B:9:0x0017, B:13:0x001d, B:15:0x0020, B:18:0x0026, B:21:0x002c, B:22:0x002e, B:373:0x0635, B:60:0x00b0, B:85:0x0123, B:106:0x0184, B:108:0x0188, B:110:0x018c, B:113:0x019c, B:114:0x01a0, B:116:0x01a8, B:127:0x01f7, B:129:0x01fb, B:133:0x020c, B:194:0x0309, B:196:0x030f, B:198:0x0313, B:200:0x031b, B:201:0x0336, B:203:0x033e, B:205:0x0346, B:207:0x0353, B:213:0x0380, B:214:0x0384, B:215:0x0389, B:217:0x0399, B:245:0x040b, B:257:0x0451, B:259:0x0459, B:261:0x0461, B:263:0x046e, B:265:0x0479, B:286:0x04de, B:288:0x04e3, B:290:0x04e7, B:292:0x04f5, B:295:0x04fd, B:297:0x050b, B:299:0x0521, B:300:0x0523, B:370:0x062f, B:378:0x063a, B:23:0x002f, B:25:0x0035, B:27:0x003f, B:29:0x0043, B:32:0x004a, B:34:0x0054, B:36:0x0058, B:37:0x005f, B:39:0x0063, B:40:0x006e, B:42:0x0071, B:44:0x0075, B:45:0x007c, B:47:0x0080, B:48:0x008a, B:50:0x008e, B:51:0x0095, B:53:0x0099, B:54:0x00a2, B:55:0x00a5, B:59:0x00af, B:5:0x0005, B:6:0x0013), top: B:419:0x0002, inners: #5, #9 }] */
    /* JADX WARN: Removed duplicated region for block: B:194:0x0309 A[Catch: Throwable -> 0x063b, TRY_ENTER, TryCatch #10 {Throwable -> 0x063b, blocks: (B:3:0x0002, B:4:0x0004, B:9:0x0017, B:13:0x001d, B:15:0x0020, B:18:0x0026, B:21:0x002c, B:22:0x002e, B:373:0x0635, B:60:0x00b0, B:85:0x0123, B:106:0x0184, B:108:0x0188, B:110:0x018c, B:113:0x019c, B:114:0x01a0, B:116:0x01a8, B:127:0x01f7, B:129:0x01fb, B:133:0x020c, B:194:0x0309, B:196:0x030f, B:198:0x0313, B:200:0x031b, B:201:0x0336, B:203:0x033e, B:205:0x0346, B:207:0x0353, B:213:0x0380, B:214:0x0384, B:215:0x0389, B:217:0x0399, B:245:0x040b, B:257:0x0451, B:259:0x0459, B:261:0x0461, B:263:0x046e, B:265:0x0479, B:286:0x04de, B:288:0x04e3, B:290:0x04e7, B:292:0x04f5, B:295:0x04fd, B:297:0x050b, B:299:0x0521, B:300:0x0523, B:370:0x062f, B:378:0x063a, B:23:0x002f, B:25:0x0035, B:27:0x003f, B:29:0x0043, B:32:0x004a, B:34:0x0054, B:36:0x0058, B:37:0x005f, B:39:0x0063, B:40:0x006e, B:42:0x0071, B:44:0x0075, B:45:0x007c, B:47:0x0080, B:48:0x008a, B:50:0x008e, B:51:0x0095, B:53:0x0099, B:54:0x00a2, B:55:0x00a5, B:59:0x00af, B:5:0x0005, B:6:0x0013), top: B:419:0x0002, inners: #5, #9 }] */
    /* JADX WARN: Removed duplicated region for block: B:201:0x0336 A[Catch: Throwable -> 0x063b, TryCatch #10 {Throwable -> 0x063b, blocks: (B:3:0x0002, B:4:0x0004, B:9:0x0017, B:13:0x001d, B:15:0x0020, B:18:0x0026, B:21:0x002c, B:22:0x002e, B:373:0x0635, B:60:0x00b0, B:85:0x0123, B:106:0x0184, B:108:0x0188, B:110:0x018c, B:113:0x019c, B:114:0x01a0, B:116:0x01a8, B:127:0x01f7, B:129:0x01fb, B:133:0x020c, B:194:0x0309, B:196:0x030f, B:198:0x0313, B:200:0x031b, B:201:0x0336, B:203:0x033e, B:205:0x0346, B:207:0x0353, B:213:0x0380, B:214:0x0384, B:215:0x0389, B:217:0x0399, B:245:0x040b, B:257:0x0451, B:259:0x0459, B:261:0x0461, B:263:0x046e, B:265:0x0479, B:286:0x04de, B:288:0x04e3, B:290:0x04e7, B:292:0x04f5, B:295:0x04fd, B:297:0x050b, B:299:0x0521, B:300:0x0523, B:370:0x062f, B:378:0x063a, B:23:0x002f, B:25:0x0035, B:27:0x003f, B:29:0x0043, B:32:0x004a, B:34:0x0054, B:36:0x0058, B:37:0x005f, B:39:0x0063, B:40:0x006e, B:42:0x0071, B:44:0x0075, B:45:0x007c, B:47:0x0080, B:48:0x008a, B:50:0x008e, B:51:0x0095, B:53:0x0099, B:54:0x00a2, B:55:0x00a5, B:59:0x00af, B:5:0x0005, B:6:0x0013), top: B:419:0x0002, inners: #5, #9 }] */
    /* JADX WARN: Removed duplicated region for block: B:288:0x04e3 A[Catch: Throwable -> 0x063b, TryCatch #10 {Throwable -> 0x063b, blocks: (B:3:0x0002, B:4:0x0004, B:9:0x0017, B:13:0x001d, B:15:0x0020, B:18:0x0026, B:21:0x002c, B:22:0x002e, B:373:0x0635, B:60:0x00b0, B:85:0x0123, B:106:0x0184, B:108:0x0188, B:110:0x018c, B:113:0x019c, B:114:0x01a0, B:116:0x01a8, B:127:0x01f7, B:129:0x01fb, B:133:0x020c, B:194:0x0309, B:196:0x030f, B:198:0x0313, B:200:0x031b, B:201:0x0336, B:203:0x033e, B:205:0x0346, B:207:0x0353, B:213:0x0380, B:214:0x0384, B:215:0x0389, B:217:0x0399, B:245:0x040b, B:257:0x0451, B:259:0x0459, B:261:0x0461, B:263:0x046e, B:265:0x0479, B:286:0x04de, B:288:0x04e3, B:290:0x04e7, B:292:0x04f5, B:295:0x04fd, B:297:0x050b, B:299:0x0521, B:300:0x0523, B:370:0x062f, B:378:0x063a, B:23:0x002f, B:25:0x0035, B:27:0x003f, B:29:0x0043, B:32:0x004a, B:34:0x0054, B:36:0x0058, B:37:0x005f, B:39:0x0063, B:40:0x006e, B:42:0x0071, B:44:0x0075, B:45:0x007c, B:47:0x0080, B:48:0x008a, B:50:0x008e, B:51:0x0095, B:53:0x0099, B:54:0x00a2, B:55:0x00a5, B:59:0x00af, B:5:0x0005, B:6:0x0013), top: B:419:0x0002, inners: #5, #9 }] */
    /* JADX WARN: Removed duplicated region for block: B:415:0x040c A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:474:0x047f A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:484:0x00bf A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:490:0x039e A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:498:0x0127 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:505:0x0630 A[SYNTHETIC] */
    @Override // android.os.AsyncTask
    @android.annotation.TargetApi(10)
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public chat.ola.vn.c.f[] doInBackground(chat.ola.vn.c.f... r18) {
        /*
            Method dump skipped, instruction units count: 1622
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.c.d.doInBackground(chat.ola.vn.c.f[]):chat.ola.vn.c.f[]");
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public void onPostExecute(f[] fVarArr) {
        synchronized (a) {
            a = Integer.valueOf(a.intValue() - 1);
            if (a.intValue() < 0) {
                a = 0;
            }
        }
        if (fVarArr == null) {
            return;
        }
        for (f fVar : fVarArr) {
            if (fVar != null) {
                String strE = fVar.e();
                try {
                    if (b != null && strE != null) {
                        synchronized (b) {
                            if (!fVar.t) {
                                b.remove(strE);
                            }
                            fVar.t = false;
                        }
                    }
                } catch (Throwable unused) {
                }
                if (fVar.q != null) {
                    if (fVar.n && strE != null) {
                        if (fVar.e == 1 || fVar.e == 9) {
                            t.a().b(strE, fVar.q);
                        } else {
                            t.a().a(strE, fVar.q, fVar.o);
                        }
                    }
                    if (fVar.r != null) {
                        fVar.r.a(fVar);
                    }
                    if (fVar.s != null) {
                        Iterator<g> it2 = fVar.s.iterator();
                        while (it2.hasNext()) {
                            it2.next().a(fVar);
                        }
                        fVar.s.clear();
                        fVar.s = null;
                    }
                } else {
                    if (fVar.r != null) {
                        fVar.r.b(fVar);
                    }
                    if (fVar.s != null) {
                        Iterator<g> it3 = fVar.s.iterator();
                        while (it3.hasNext()) {
                            it3.next().b(fVar);
                        }
                        fVar.s.clear();
                        fVar.s = null;
                    }
                }
            }
        }
    }
}
