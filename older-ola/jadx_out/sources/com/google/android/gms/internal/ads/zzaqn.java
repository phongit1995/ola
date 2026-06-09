package com.google.android.gms.internal.ads;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzaqn extends zzaqh {
    private static final Set<String> zzdbg = Collections.synchronizedSet(new HashSet());
    private static final DecimalFormat zzdbh = new DecimalFormat("#,###");
    private File zzdbi;
    private boolean zzdbj;

    public zzaqn(zzapw zzapwVar) {
        super(zzapwVar);
        File cacheDir = this.mContext.getCacheDir();
        if (cacheDir == null) {
            zzakb.zzdk("Context.getCacheDir() returned null");
            return;
        }
        this.zzdbi = new File(cacheDir, "admobVideoStreams");
        if (!this.zzdbi.isDirectory() && !this.zzdbi.mkdirs()) {
            String strValueOf = String.valueOf(this.zzdbi.getAbsolutePath());
            zzakb.zzdk(strValueOf.length() != 0 ? "Could not create preload cache directory at ".concat(strValueOf) : new String("Could not create preload cache directory at "));
            this.zzdbi = null;
        } else {
            if (this.zzdbi.setReadable(true, false) && this.zzdbi.setExecutable(true, false)) {
                return;
            }
            String strValueOf2 = String.valueOf(this.zzdbi.getAbsolutePath());
            zzakb.zzdk(strValueOf2.length() != 0 ? "Could not set cache file permissions at ".concat(strValueOf2) : new String("Could not set cache file permissions at "));
            this.zzdbi = null;
        }
    }

    private final File zzc(File file) {
        return new File(this.zzdbi, String.valueOf(file.getName()).concat(".done"));
    }

    @Override // com.google.android.gms.internal.ads.zzaqh
    public final void abort() {
        this.zzdbj = true;
    }

    /* JADX WARN: Can't wrap try/catch for region: R(13:64|(2:66|(3:281|68|69)(13:72|73|(3:269|75|(3:283|77|78)(2:79|(3:284|81|82)(2:83|(4:93|(1:95)(1:96)|97|98)(5:285|87|(1:89)(1:90)|91|92))))(1:282)|220|(1:222)|254|223|224|(1:226)(1:227)|228|(3:232|(1:234)(1:235)|236)|237|238))(5:280|212|259|213|214)|219|220|(0)|254|223|224|(0)(0)|228|(4:230|232|(0)(0)|236)|237|238) */
    /* JADX WARN: Code restructure failed: missing block: B:100:0x01fe, code lost:
    
        if ((r5 instanceof java.net.HttpURLConnection) == false) goto L116;
     */
    /* JADX WARN: Code restructure failed: missing block: B:101:0x0200, code lost:
    
        r1 = r5.getResponseCode();
     */
    /* JADX WARN: Code restructure failed: missing block: B:102:0x0209, code lost:
    
        if (r1 < 400) goto L116;
     */
    /* JADX WARN: Code restructure failed: missing block: B:104:0x020d, code lost:
    
        r4 = java.lang.String.valueOf(java.lang.Integer.toString(r1));
     */
    /* JADX WARN: Code restructure failed: missing block: B:105:0x021b, code lost:
    
        if (r4.length() == 0) goto L107;
     */
    /* JADX WARN: Code restructure failed: missing block: B:106:0x021d, code lost:
    
        r3 = "HTTP request failed. Code: ".concat(r4);
     */
    /* JADX WARN: Code restructure failed: missing block: B:108:0x0227, code lost:
    
        r3 = new java.lang.String("HTTP request failed. Code: ");
     */
    /* JADX WARN: Code restructure failed: missing block: B:109:0x0228, code lost:
    
        r6 = new java.lang.StringBuilder(java.lang.String.valueOf(r34).length() + 32);
        r6.append("HTTP status code ");
        r6.append(r1);
        r6.append(" at ");
        r6.append(r34);
     */
    /* JADX WARN: Code restructure failed: missing block: B:110:0x0250, code lost:
    
        throw new java.io.IOException(r6.toString());
     */
    /* JADX WARN: Code restructure failed: missing block: B:111:0x0251, code lost:
    
        r0 = move-exception;
     */
    /* JADX WARN: Code restructure failed: missing block: B:112:0x0252, code lost:
    
        r1 = r0;
        r4 = r3;
        r3 = "badUrl";
     */
    /* JADX WARN: Code restructure failed: missing block: B:113:0x0256, code lost:
    
        r0 = move-exception;
     */
    /* JADX WARN: Code restructure failed: missing block: B:114:0x0257, code lost:
    
        r1 = r0;
        r3 = "badUrl";
        r4 = null;
     */
    /* JADX WARN: Code restructure failed: missing block: B:115:0x025a, code lost:
    
        r2 = r15;
        r3 = r3;
        r4 = r4;
     */
    /* JADX WARN: Code restructure failed: missing block: B:116:0x025d, code lost:
    
        r7 = r5.getContentLength();
     */
    /* JADX WARN: Code restructure failed: missing block: B:117:0x0261, code lost:
    
        if (r7 >= 0) goto L124;
     */
    /* JADX WARN: Code restructure failed: missing block: B:118:0x0263, code lost:
    
        r2 = java.lang.String.valueOf(r34);
     */
    /* JADX WARN: Code restructure failed: missing block: B:119:0x026d, code lost:
    
        if (r2.length() == 0) goto L121;
     */
    /* JADX WARN: Code restructure failed: missing block: B:120:0x026f, code lost:
    
        r1 = "Stream cache aborted, missing content-length header at ".concat(r2);
     */
    /* JADX WARN: Code restructure failed: missing block: B:121:0x0274, code lost:
    
        r1 = new java.lang.String("Stream cache aborted, missing content-length header at ");
     */
    /* JADX WARN: Code restructure failed: missing block: B:122:0x027a, code lost:
    
        com.google.android.gms.internal.ads.zzakb.zzdk(r1);
        zza(r34, r12.getAbsolutePath(), "contentLengthMissing", null);
        com.google.android.gms.internal.ads.zzaqn.zzdbg.remove(r15);
     */
    /* JADX WARN: Code restructure failed: missing block: B:123:0x028b, code lost:
    
        return false;
     */
    /* JADX WARN: Code restructure failed: missing block: B:124:0x028c, code lost:
    
        r1 = com.google.android.gms.internal.ads.zzaqn.zzdbh.format(r7);
        r3 = ((java.lang.Integer) com.google.android.gms.internal.ads.zzkb.zzik().zzd(com.google.android.gms.internal.ads.zznk.zzauy)).intValue();
     */
    /* JADX WARN: Code restructure failed: missing block: B:125:0x02a3, code lost:
    
        if (r7 <= r3) goto L132;
     */
    /* JADX WARN: Code restructure failed: missing block: B:126:0x02a5, code lost:
    
        r3 = new java.lang.StringBuilder((java.lang.String.valueOf(r1).length() + 33) + java.lang.String.valueOf(r34).length());
        r3.append("Content length ");
        r3.append(r1);
        r3.append(" exceeds limit at ");
        r3.append(r34);
        com.google.android.gms.internal.ads.zzakb.zzdk(r3.toString());
        r1 = java.lang.String.valueOf(r1);
     */
    /* JADX WARN: Code restructure failed: missing block: B:127:0x02de, code lost:
    
        if (r1.length() == 0) goto L129;
     */
    /* JADX WARN: Code restructure failed: missing block: B:128:0x02e0, code lost:
    
        r1 = "File too big for full file cache. Size: ".concat(r1);
     */
    /* JADX WARN: Code restructure failed: missing block: B:129:0x02e5, code lost:
    
        r1 = new java.lang.String("File too big for full file cache. Size: ");
     */
    /* JADX WARN: Code restructure failed: missing block: B:130:0x02ea, code lost:
    
        zza(r34, r12.getAbsolutePath(), "sizeExceeded", r1);
        com.google.android.gms.internal.ads.zzaqn.zzdbg.remove(r15);
     */
    /* JADX WARN: Code restructure failed: missing block: B:131:0x02f8, code lost:
    
        return false;
     */
    /* JADX WARN: Code restructure failed: missing block: B:132:0x02f9, code lost:
    
        r4 = new java.lang.StringBuilder((java.lang.String.valueOf(r1).length() + 20) + java.lang.String.valueOf(r34).length());
        r4.append("Caching ");
        r4.append(r1);
        r4.append(" bytes from ");
        r4.append(r34);
        com.google.android.gms.internal.ads.zzakb.zzck(r4.toString());
        r5 = java.nio.channels.Channels.newChannel(r5.getInputStream());
        r4 = new java.io.FileOutputStream(r12);
     */
    /* JADX WARN: Code restructure failed: missing block: B:133:0x0334, code lost:
    
        r2 = r4.getChannel();
        r1 = java.nio.ByteBuffer.allocate(1048576);
        r10 = com.google.android.gms.ads.internal.zzbv.zzer();
        r17 = r10.currentTimeMillis();
     */
    /* JADX WARN: Code restructure failed: missing block: B:134:0x0352, code lost:
    
        r20 = r15;
     */
    /* JADX WARN: Code restructure failed: missing block: B:135:0x0354, code lost:
    
        r11 = new com.google.android.gms.internal.ads.zzamj(((java.lang.Long) com.google.android.gms.internal.ads.zzkb.zzik().zzd(com.google.android.gms.internal.ads.zznk.zzavb)).longValue());
        r14 = ((java.lang.Long) com.google.android.gms.internal.ads.zzkb.zzik().zzd(com.google.android.gms.internal.ads.zznk.zzava)).longValue();
        r6 = 0;
     */
    /* JADX WARN: Code restructure failed: missing block: B:136:0x036e, code lost:
    
        r21 = r5.read(r1);
     */
    /* JADX WARN: Code restructure failed: missing block: B:137:0x0372, code lost:
    
        if (r21 < 0) goto L288;
     */
    /* JADX WARN: Code restructure failed: missing block: B:138:0x0374, code lost:
    
        r6 = r6 + r21;
     */
    /* JADX WARN: Code restructure failed: missing block: B:139:0x0376, code lost:
    
        if (r6 <= r3) goto L252;
     */
    /* JADX WARN: Code restructure failed: missing block: B:141:0x037a, code lost:
    
        r3 = java.lang.String.valueOf(java.lang.Integer.toString(r6));
     */
    /* JADX WARN: Code restructure failed: missing block: B:142:0x0388, code lost:
    
        if (r3.length() == 0) goto L144;
     */
    /* JADX WARN: Code restructure failed: missing block: B:143:0x038a, code lost:
    
        r2 = "File too big for full file cache. Size: ".concat(r3);
     */
    /* JADX WARN: Code restructure failed: missing block: B:144:0x0390, code lost:
    
        new java.lang.String("File too big for full file cache. Size: ");
     */
    /* JADX WARN: Code restructure failed: missing block: B:147:0x039d, code lost:
    
        throw new java.io.IOException("stream cache file size limit exceeded");
     */
    /* JADX WARN: Code restructure failed: missing block: B:148:0x039e, code lost:
    
        r0 = move-exception;
     */
    /* JADX WARN: Code restructure failed: missing block: B:149:0x039f, code lost:
    
        r3 = r1;
        r2 = r20;
        r1 = r0;
        r32 = r10;
        r10 = r4;
        r4 = r32;
     */
    /* JADX WARN: Code restructure failed: missing block: B:150:0x03aa, code lost:
    
        r0 = move-exception;
     */
    /* JADX WARN: Code restructure failed: missing block: B:151:0x03ab, code lost:
    
        r3 = r1;
        r10 = r4;
        r2 = r20;
        r4 = 0;
        r1 = r0;
     */
    /* JADX WARN: Code restructure failed: missing block: B:154:0x03b6, code lost:
    
        r3 = "error";
        r2 = r20;
     */
    /* JADX WARN: Code restructure failed: missing block: B:155:0x03bc, code lost:
    
        r1.flip();
     */
    /* JADX WARN: Code restructure failed: missing block: B:157:0x03c3, code lost:
    
        if (r2.write(r1) > 0) goto L179;
     */
    /* JADX WARN: Code restructure failed: missing block: B:158:0x03c5, code lost:
    
        r1.clear();
     */
    /* JADX WARN: Code restructure failed: missing block: B:160:0x03d6, code lost:
    
        if ((r10.currentTimeMillis() - r17) <= (1000 * r14)) goto L165;
     */
    /* JADX WARN: Code restructure failed: missing block: B:162:0x03da, code lost:
    
        r2 = java.lang.Long.toString(r14);
        r5 = new java.lang.StringBuilder(java.lang.String.valueOf(r2).length() + 29);
        r5.append("Timeout exceeded. Limit: ");
        r5.append(r2);
        r5.append(" sec");
        r5.toString();
     */
    /* JADX WARN: Code restructure failed: missing block: B:164:0x0405, code lost:
    
        throw new java.io.IOException("stream cache time limit exceeded");
     */
    /* JADX WARN: Code restructure failed: missing block: B:165:0x0406, code lost:
    
        r26 = r1;
     */
    /* JADX WARN: Code restructure failed: missing block: B:167:0x040a, code lost:
    
        if (r33.zzdbj == false) goto L171;
     */
    /* JADX WARN: Code restructure failed: missing block: B:170:0x0415, code lost:
    
        throw new java.io.IOException("abort requested");
     */
    /* JADX WARN: Code restructure failed: missing block: B:172:0x041a, code lost:
    
        if (r11.tryAcquire() == false) goto L177;
     */
    /* JADX WARN: Code restructure failed: missing block: B:173:0x041c, code lost:
    
        r27 = r10;
     */
    /* JADX WARN: Code restructure failed: missing block: B:174:0x0426, code lost:
    
        r28 = r11;
        r23 = r26;
        r24 = r2;
        r25 = r3;
        r29 = r14;
        r14 = r4;
        r19 = r6;
        r31 = r5;
        r21 = r7;
     */
    /* JADX WARN: Code restructure failed: missing block: B:175:0x0445, code lost:
    
        com.google.android.gms.internal.ads.zzamu.zzsy.post(new com.google.android.gms.internal.ads.zzaqi(r33, r34, r12.getAbsolutePath(), r6, r7, false));
     */
    /* JADX WARN: Code restructure failed: missing block: B:177:0x044c, code lost:
    
        r24 = r2;
        r25 = r3;
        r31 = r5;
        r19 = r6;
        r21 = r7;
        r27 = r10;
        r28 = r11;
        r29 = r14;
        r23 = r26;
        r14 = r4;
     */
    /* JADX WARN: Code restructure failed: missing block: B:178:0x0460, code lost:
    
        r4 = r14;
        r6 = r19;
        r7 = r21;
        r1 = r23;
        r2 = r24;
        r3 = r25;
        r10 = r27;
        r11 = r28;
        r14 = r29;
        r5 = r31;
     */
    /* JADX WARN: Code restructure failed: missing block: B:180:0x0479, code lost:
    
        r0 = e;
     */
    /* JADX WARN: Code restructure failed: missing block: B:181:0x047a, code lost:
    
        r14 = r4;
     */
    /* JADX WARN: Code restructure failed: missing block: B:182:0x047b, code lost:
    
        r1 = r0;
        r10 = r14;
     */
    /* JADX WARN: Code restructure failed: missing block: B:183:0x047f, code lost:
    
        r14 = r4;
     */
    /* JADX WARN: Code restructure failed: missing block: B:184:0x0481, code lost:
    
        r14.close();
     */
    /* JADX WARN: Code restructure failed: missing block: B:185:0x0488, code lost:
    
        if (com.google.android.gms.internal.ads.zzakb.isLoggable(3) == false) goto L190;
     */
    /* JADX WARN: Code restructure failed: missing block: B:186:0x048a, code lost:
    
        r1 = com.google.android.gms.internal.ads.zzaqn.zzdbh.format(r6);
        r3 = new java.lang.StringBuilder((java.lang.String.valueOf(r1).length() + 22) + java.lang.String.valueOf(r34).length());
        r3.append("Preloaded ");
        r3.append(r1);
        r3.append(" bytes from ");
        r3.append(r34);
        com.google.android.gms.internal.ads.zzakb.zzck(r3.toString());
     */
    /* JADX WARN: Code restructure failed: missing block: B:188:0x04c1, code lost:
    
        r0 = e;
     */
    /* JADX WARN: Code restructure failed: missing block: B:191:0x04c5, code lost:
    
        r12.setReadable(true, false);
     */
    /* JADX WARN: Code restructure failed: missing block: B:192:0x04cc, code lost:
    
        if (r13.isFile() == false) goto L245;
     */
    /* JADX WARN: Code restructure failed: missing block: B:193:0x04ce, code lost:
    
        r13.setLastModified(java.lang.System.currentTimeMillis());
     */
    /* JADX WARN: Code restructure failed: missing block: B:195:0x04d6, code lost:
    
        r13.createNewFile();
     */
    /* JADX WARN: Code restructure failed: missing block: B:203:0x04eb, code lost:
    
        r0 = e;
     */
    /* JADX WARN: Code restructure failed: missing block: B:205:0x04ed, code lost:
    
        r0 = e;
     */
    /* JADX WARN: Code restructure failed: missing block: B:206:0x04ee, code lost:
    
        r14 = r4;
     */
    /* JADX WARN: Code restructure failed: missing block: B:207:0x04ef, code lost:
    
        r2 = r20;
     */
    /* JADX WARN: Code restructure failed: missing block: B:208:0x04f2, code lost:
    
        r0 = e;
     */
    /* JADX WARN: Code restructure failed: missing block: B:209:0x04f3, code lost:
    
        r14 = r4;
        r2 = r15;
     */
    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Removed duplicated region for block: B:20:0x004a  */
    /* JADX WARN: Removed duplicated region for block: B:222:0x0511  */
    /* JADX WARN: Removed duplicated region for block: B:226:0x0521  */
    /* JADX WARN: Removed duplicated region for block: B:227:0x0545  */
    /* JADX WARN: Removed duplicated region for block: B:230:0x056e  */
    /* JADX WARN: Removed duplicated region for block: B:234:0x0584  */
    /* JADX WARN: Removed duplicated region for block: B:235:0x0589  */
    /* JADX WARN: Unreachable blocks removed: 2, instructions: 3 */
    @Override // com.google.android.gms.internal.ads.zzaqh
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final boolean zzdp(java.lang.String r34) {
        /*
            Method dump skipped, instruction units count: 1444
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzaqn.zzdp(java.lang.String):boolean");
    }
}
