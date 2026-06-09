package com.google.android.gms.internal.ads;

import android.location.Location;
import android.support.annotation.Nullable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import org.json.JSONArray;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzafs {
    private static final SimpleDateFormat zzcho = new SimpleDateFormat("yyyyMMdd", Locale.US);

    /* JADX WARN: Removed duplicated region for block: B:35:0x00d9  */
    /* JADX WARN: Removed duplicated region for block: B:37:0x00e1 A[Catch: JSONException -> 0x0270, TryCatch #0 {JSONException -> 0x0270, blocks: (B:3:0x0003, B:5:0x0025, B:9:0x002e, B:11:0x0036, B:13:0x003e, B:15:0x0046, B:17:0x004e, B:18:0x0052, B:20:0x0068, B:22:0x007b, B:24:0x008a, B:30:0x00a8, B:32:0x00ae, B:34:0x00b4, B:37:0x00e1, B:39:0x00e7, B:44:0x00f5, B:45:0x00fa, B:50:0x0108, B:51:0x010d, B:56:0x011b, B:58:0x0124, B:63:0x0132, B:66:0x013d, B:68:0x0141, B:69:0x0145, B:71:0x014d, B:73:0x0153, B:75:0x0161, B:77:0x016c, B:61:0x012e, B:54:0x0117, B:48:0x0104, B:42:0x00f1, B:26:0x0095, B:28:0x009d), top: B:86:0x0003 }] */
    /* JADX WARN: Removed duplicated region for block: B:39:0x00e7 A[Catch: JSONException -> 0x0270, TryCatch #0 {JSONException -> 0x0270, blocks: (B:3:0x0003, B:5:0x0025, B:9:0x002e, B:11:0x0036, B:13:0x003e, B:15:0x0046, B:17:0x004e, B:18:0x0052, B:20:0x0068, B:22:0x007b, B:24:0x008a, B:30:0x00a8, B:32:0x00ae, B:34:0x00b4, B:37:0x00e1, B:39:0x00e7, B:44:0x00f5, B:45:0x00fa, B:50:0x0108, B:51:0x010d, B:56:0x011b, B:58:0x0124, B:63:0x0132, B:66:0x013d, B:68:0x0141, B:69:0x0145, B:71:0x014d, B:73:0x0153, B:75:0x0161, B:77:0x016c, B:61:0x012e, B:54:0x0117, B:48:0x0104, B:42:0x00f1, B:26:0x0095, B:28:0x009d), top: B:86:0x0003 }] */
    /* JADX WARN: Removed duplicated region for block: B:72:0x0151 A[PHI: r18
      0x0151: PHI (r18v2 int) = (r18v1 int), (r18v4 int) binds: [B:65:0x013b, B:70:0x014b] A[DONT_GENERATE, DONT_INLINE]] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static com.google.android.gms.internal.ads.zzaej zza(android.content.Context r57, com.google.android.gms.internal.ads.zzaef r58, java.lang.String r59) {
        /*
            Method dump skipped, instruction units count: 662
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzafs.zza(android.content.Context, com.google.android.gms.internal.ads.zzaef, java.lang.String):com.google.android.gms.internal.ads.zzaej");
    }

    @Nullable
    private static List<String> zza(@Nullable JSONArray jSONArray, @Nullable List<String> list) {
        if (jSONArray == null) {
            return null;
        }
        if (list == null) {
            list = new ArrayList<>();
        }
        for (int i = 0; i < jSONArray.length(); i++) {
            list.add(jSONArray.getString(i));
        }
        return list;
    }

    /* JADX WARN: Removed duplicated region for block: B:121:0x0233  */
    /* JADX WARN: Removed duplicated region for block: B:129:0x024e A[Catch: JSONException -> 0x0934, TryCatch #0 {JSONException -> 0x0934, blocks: (B:3:0x000c, B:5:0x0028, B:6:0x0035, B:8:0x0039, B:9:0x0040, B:11:0x0048, B:12:0x004d, B:14:0x0055, B:15:0x0067, B:17:0x006b, B:18:0x0072, B:20:0x0077, B:21:0x0082, B:23:0x0086, B:24:0x008d, B:26:0x0091, B:27:0x009c, B:29:0x00a1, B:31:0x00b3, B:32:0x00b9, B:34:0x00c2, B:36:0x00c7, B:38:0x00cb, B:39:0x00d4, B:41:0x00dc, B:42:0x00e3, B:44:0x00e8, B:46:0x00ec, B:47:0x00f3, B:49:0x00f8, B:51:0x00fc, B:52:0x0103, B:54:0x0107, B:55:0x010e, B:57:0x0112, B:58:0x0119, B:60:0x011e, B:62:0x0122, B:63:0x0129, B:65:0x012e, B:66:0x0139, B:68:0x013f, B:70:0x014e, B:84:0x018c, B:86:0x0192, B:87:0x0199, B:89:0x01a0, B:90:0x01a7, B:92:0x01ad, B:94:0x01bb, B:109:0x01f6, B:97:0x01c3, B:99:0x01c9, B:100:0x01ce, B:102:0x01d2, B:104:0x01dc, B:106:0x01e9, B:108:0x01f3, B:107:0x01f1, B:103:0x01da, B:111:0x01fd, B:113:0x0203, B:115:0x020b, B:116:0x0210, B:117:0x0215, B:119:0x021b, B:127:0x0243, B:129:0x024e, B:130:0x0255, B:132:0x0259, B:133:0x0264, B:139:0x027b, B:122:0x0236, B:123:0x0238, B:140:0x0280, B:142:0x0284, B:144:0x028c, B:145:0x0292, B:147:0x0298, B:149:0x02a5, B:150:0x02ac, B:151:0x02b0, B:153:0x02b7, B:154:0x02be, B:156:0x02c4, B:157:0x02ce, B:159:0x02e0, B:160:0x02ea, B:162:0x02ee, B:163:0x0305, B:165:0x0319, B:166:0x0326, B:168:0x0373, B:169:0x037a, B:171:0x0385, B:172:0x038f, B:174:0x0393, B:176:0x039f, B:178:0x03c4, B:179:0x03cb, B:181:0x03db, B:182:0x03e6, B:184:0x0454, B:185:0x0473, B:187:0x048b, B:189:0x04e7, B:190:0x054a, B:192:0x0559, B:194:0x056d, B:195:0x0574, B:197:0x05a3, B:199:0x05a7, B:201:0x05b6, B:203:0x05bc, B:204:0x05ca, B:205:0x05ce, B:206:0x05df, B:208:0x05f4, B:214:0x0612, B:216:0x0617, B:217:0x061e, B:219:0x0623, B:221:0x0627, B:223:0x0634, B:224:0x063b, B:226:0x0640, B:228:0x0683, B:230:0x0688, B:237:0x06a4, B:236:0x069f, B:238:0x06af, B:240:0x06b4, B:241:0x06bb, B:243:0x06c1, B:245:0x06c9, B:246:0x06d0, B:248:0x06d6, B:249:0x06e1, B:251:0x06e7, B:252:0x06f2, B:254:0x06f8, B:256:0x06fc, B:257:0x0707, B:259:0x070d, B:263:0x0718, B:262:0x0715, B:264:0x071f, B:266:0x0725, B:267:0x0730, B:269:0x0734, B:276:0x0750, B:275:0x074b, B:277:0x075b, B:279:0x075f, B:280:0x076a, B:282:0x07d7, B:283:0x07de, B:285:0x07e4, B:287:0x07e8, B:288:0x07ef, B:290:0x0801, B:292:0x080d, B:297:0x0819, B:303:0x0826, B:304:0x0835, B:306:0x0839, B:307:0x0840, B:309:0x0844, B:311:0x084e, B:312:0x085a, B:315:0x0868, B:317:0x086c, B:318:0x0873, B:320:0x0879, B:321:0x0884, B:323:0x0892, B:325:0x0898, B:327:0x08ac, B:329:0x08ba, B:330:0x08c6, B:331:0x08cb, B:333:0x08dd, B:334:0x08ec, B:336:0x08f0, B:338:0x08f8, B:339:0x08ff, B:341:0x0906, B:343:0x091e, B:345:0x0928, B:344:0x0923, B:346:0x092b, B:313:0x085e, B:227:0x0662, B:209:0x05fc, B:211:0x0605, B:213:0x060b, B:71:0x0156, B:73:0x0162, B:76:0x016a, B:77:0x0173, B:80:0x0179, B:83:0x0186, B:271:0x073c, B:135:0x026c, B:232:0x0690), top: B:355:0x000c, inners: #1, #2, #3 }] */
    /* JADX WARN: Removed duplicated region for block: B:132:0x0259 A[Catch: JSONException -> 0x0934, TryCatch #0 {JSONException -> 0x0934, blocks: (B:3:0x000c, B:5:0x0028, B:6:0x0035, B:8:0x0039, B:9:0x0040, B:11:0x0048, B:12:0x004d, B:14:0x0055, B:15:0x0067, B:17:0x006b, B:18:0x0072, B:20:0x0077, B:21:0x0082, B:23:0x0086, B:24:0x008d, B:26:0x0091, B:27:0x009c, B:29:0x00a1, B:31:0x00b3, B:32:0x00b9, B:34:0x00c2, B:36:0x00c7, B:38:0x00cb, B:39:0x00d4, B:41:0x00dc, B:42:0x00e3, B:44:0x00e8, B:46:0x00ec, B:47:0x00f3, B:49:0x00f8, B:51:0x00fc, B:52:0x0103, B:54:0x0107, B:55:0x010e, B:57:0x0112, B:58:0x0119, B:60:0x011e, B:62:0x0122, B:63:0x0129, B:65:0x012e, B:66:0x0139, B:68:0x013f, B:70:0x014e, B:84:0x018c, B:86:0x0192, B:87:0x0199, B:89:0x01a0, B:90:0x01a7, B:92:0x01ad, B:94:0x01bb, B:109:0x01f6, B:97:0x01c3, B:99:0x01c9, B:100:0x01ce, B:102:0x01d2, B:104:0x01dc, B:106:0x01e9, B:108:0x01f3, B:107:0x01f1, B:103:0x01da, B:111:0x01fd, B:113:0x0203, B:115:0x020b, B:116:0x0210, B:117:0x0215, B:119:0x021b, B:127:0x0243, B:129:0x024e, B:130:0x0255, B:132:0x0259, B:133:0x0264, B:139:0x027b, B:122:0x0236, B:123:0x0238, B:140:0x0280, B:142:0x0284, B:144:0x028c, B:145:0x0292, B:147:0x0298, B:149:0x02a5, B:150:0x02ac, B:151:0x02b0, B:153:0x02b7, B:154:0x02be, B:156:0x02c4, B:157:0x02ce, B:159:0x02e0, B:160:0x02ea, B:162:0x02ee, B:163:0x0305, B:165:0x0319, B:166:0x0326, B:168:0x0373, B:169:0x037a, B:171:0x0385, B:172:0x038f, B:174:0x0393, B:176:0x039f, B:178:0x03c4, B:179:0x03cb, B:181:0x03db, B:182:0x03e6, B:184:0x0454, B:185:0x0473, B:187:0x048b, B:189:0x04e7, B:190:0x054a, B:192:0x0559, B:194:0x056d, B:195:0x0574, B:197:0x05a3, B:199:0x05a7, B:201:0x05b6, B:203:0x05bc, B:204:0x05ca, B:205:0x05ce, B:206:0x05df, B:208:0x05f4, B:214:0x0612, B:216:0x0617, B:217:0x061e, B:219:0x0623, B:221:0x0627, B:223:0x0634, B:224:0x063b, B:226:0x0640, B:228:0x0683, B:230:0x0688, B:237:0x06a4, B:236:0x069f, B:238:0x06af, B:240:0x06b4, B:241:0x06bb, B:243:0x06c1, B:245:0x06c9, B:246:0x06d0, B:248:0x06d6, B:249:0x06e1, B:251:0x06e7, B:252:0x06f2, B:254:0x06f8, B:256:0x06fc, B:257:0x0707, B:259:0x070d, B:263:0x0718, B:262:0x0715, B:264:0x071f, B:266:0x0725, B:267:0x0730, B:269:0x0734, B:276:0x0750, B:275:0x074b, B:277:0x075b, B:279:0x075f, B:280:0x076a, B:282:0x07d7, B:283:0x07de, B:285:0x07e4, B:287:0x07e8, B:288:0x07ef, B:290:0x0801, B:292:0x080d, B:297:0x0819, B:303:0x0826, B:304:0x0835, B:306:0x0839, B:307:0x0840, B:309:0x0844, B:311:0x084e, B:312:0x085a, B:315:0x0868, B:317:0x086c, B:318:0x0873, B:320:0x0879, B:321:0x0884, B:323:0x0892, B:325:0x0898, B:327:0x08ac, B:329:0x08ba, B:330:0x08c6, B:331:0x08cb, B:333:0x08dd, B:334:0x08ec, B:336:0x08f0, B:338:0x08f8, B:339:0x08ff, B:341:0x0906, B:343:0x091e, B:345:0x0928, B:344:0x0923, B:346:0x092b, B:313:0x085e, B:227:0x0662, B:209:0x05fc, B:211:0x0605, B:213:0x060b, B:71:0x0156, B:73:0x0162, B:76:0x016a, B:77:0x0173, B:80:0x0179, B:83:0x0186, B:271:0x073c, B:135:0x026c, B:232:0x0690), top: B:355:0x000c, inners: #1, #2, #3 }] */
    /* JADX WARN: Removed duplicated region for block: B:359:0x026c A[EXC_TOP_SPLITTER, SYNTHETIC] */
    @android.support.annotation.Nullable
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static org.json.JSONObject zza(android.content.Context r25, com.google.android.gms.internal.ads.zzafl r26) {
        /*
            Method dump skipped, instruction units count: 2400
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzafs.zza(android.content.Context, com.google.android.gms.internal.ads.zzafl):org.json.JSONObject");
    }

    private static void zza(HashMap<String, Object> map, Location location) {
        HashMap map2 = new HashMap();
        Float fValueOf = Float.valueOf(location.getAccuracy() * 1000.0f);
        Long lValueOf = Long.valueOf(location.getTime() * 1000);
        Long lValueOf2 = Long.valueOf((long) (location.getLatitude() * 1.0E7d));
        Long lValueOf3 = Long.valueOf((long) (location.getLongitude() * 1.0E7d));
        map2.put("radius", fValueOf);
        map2.put("lat", lValueOf2);
        map2.put("long", lValueOf3);
        map2.put("time", lValueOf);
        map.put("uule", map2);
    }

    /* JADX WARN: Removed duplicated region for block: B:31:0x0086  */
    /* JADX WARN: Removed duplicated region for block: B:34:0x0095  */
    /* JADX WARN: Removed duplicated region for block: B:37:0x00a4  */
    /* JADX WARN: Removed duplicated region for block: B:40:0x00b3  */
    /* JADX WARN: Removed duplicated region for block: B:43:0x00c2  */
    /* JADX WARN: Removed duplicated region for block: B:46:0x00d4  */
    /* JADX WARN: Removed duplicated region for block: B:49:0x0104  */
    /* JADX WARN: Removed duplicated region for block: B:52:0x0111  */
    /* JADX WARN: Removed duplicated region for block: B:55:0x0120  */
    /* JADX WARN: Removed duplicated region for block: B:58:0x012d  */
    /* JADX WARN: Removed duplicated region for block: B:59:0x0130  */
    /* JADX WARN: Removed duplicated region for block: B:62:0x0140  */
    /* JADX WARN: Removed duplicated region for block: B:65:0x014f  */
    /* JADX WARN: Removed duplicated region for block: B:68:0x015e  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static org.json.JSONObject zzb(com.google.android.gms.internal.ads.zzaej r9) throws org.json.JSONException {
        /*
            Method dump skipped, instruction units count: 413
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzafs.zzb(com.google.android.gms.internal.ads.zzaej):org.json.JSONObject");
    }

    @Nullable
    private static JSONArray zzm(List<String> list) {
        JSONArray jSONArray = new JSONArray();
        Iterator<String> it2 = list.iterator();
        while (it2.hasNext()) {
            jSONArray.put(it2.next());
        }
        return jSONArray;
    }

    private static Integer zzv(boolean z) {
        return Integer.valueOf(z ? 1 : 0);
    }
}
