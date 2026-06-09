package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
final class zzabl {
    static String zza(zzzb zzzbVar) {
        String str;
        zzabm zzabmVar = new zzabm(zzzbVar);
        StringBuilder sb = new StringBuilder(zzabmVar.size());
        for (int i = 0; i < zzabmVar.size(); i++) {
            int iZzae = zzabmVar.zzae(i);
            if (iZzae == 34) {
                str = "\\\"";
            } else if (iZzae == 39) {
                str = "\\'";
            } else if (iZzae != 92) {
                switch (iZzae) {
                    case 7:
                        str = "\\a";
                        break;
                    case 8:
                        str = "\\b";
                        break;
                    case 9:
                        str = "\\t";
                        break;
                    case 10:
                        str = "\\n";
                        break;
                    case 11:
                        str = "\\v";
                        break;
                    case 12:
                        str = "\\f";
                        break;
                    case 13:
                        str = "\\r";
                        break;
                    default:
                        if (iZzae < 32 || iZzae > 126) {
                            sb.append('\\');
                            sb.append((char) (((iZzae >>> 6) & 3) + 48));
                            sb.append((char) (((iZzae >>> 3) & 7) + 48));
                            iZzae = (iZzae & 7) + 48;
                        }
                        sb.append((char) iZzae);
                        continue;
                        break;
                }
            } else {
                str = "\\\\";
            }
            sb.append(str);
        }
        return sb.toString();
    }
}
