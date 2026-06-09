package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
final class zzbea {
    static String zzaq(zzbah zzbahVar) {
        String str;
        zzbeb zzbebVar = new zzbeb(zzbahVar);
        StringBuilder sb = new StringBuilder(zzbebVar.size());
        for (int i = 0; i < zzbebVar.size(); i++) {
            int iZzbn = zzbebVar.zzbn(i);
            if (iZzbn == 34) {
                str = "\\\"";
            } else if (iZzbn == 39) {
                str = "\\'";
            } else if (iZzbn != 92) {
                switch (iZzbn) {
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
                        if (iZzbn < 32 || iZzbn > 126) {
                            sb.append('\\');
                            sb.append((char) (((iZzbn >>> 6) & 3) + 48));
                            sb.append((char) (((iZzbn >>> 3) & 7) + 48));
                            iZzbn = (iZzbn & 7) + 48;
                        }
                        sb.append((char) iZzbn);
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
