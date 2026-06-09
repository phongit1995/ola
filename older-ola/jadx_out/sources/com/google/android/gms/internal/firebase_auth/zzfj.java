package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
final class zzfj {
    static String zzd(zzbu zzbuVar) {
        String str;
        zzfk zzfkVar = new zzfk(zzbuVar);
        StringBuilder sb = new StringBuilder(zzfkVar.size());
        for (int i = 0; i < zzfkVar.size(); i++) {
            int iZzk = zzfkVar.zzk(i);
            if (iZzk == 34) {
                str = "\\\"";
            } else if (iZzk == 39) {
                str = "\\'";
            } else if (iZzk != 92) {
                switch (iZzk) {
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
                        if (iZzk < 32 || iZzk > 126) {
                            sb.append('\\');
                            sb.append((char) (((iZzk >>> 6) & 3) + 48));
                            sb.append((char) (((iZzk >>> 3) & 7) + 48));
                            iZzk = (iZzk & 7) + 48;
                        }
                        sb.append((char) iZzk);
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
