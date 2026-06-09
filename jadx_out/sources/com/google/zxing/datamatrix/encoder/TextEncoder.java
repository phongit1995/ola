package com.google.zxing.datamatrix.encoder;

/* JADX INFO: loaded from: classes2.dex */
final class TextEncoder extends C40Encoder {
    TextEncoder() {
    }

    @Override // com.google.zxing.datamatrix.encoder.C40Encoder
    int encodeChar(char c, StringBuilder sb) {
        int i;
        int i2;
        char c2;
        if (c == ' ') {
            c2 = 3;
        } else {
            if (c >= '0' && c <= '9') {
                i2 = (c - '0') + 4;
            } else {
                if (c < 'a' || c > 'z') {
                    if (c < 0 || c > 31) {
                        char c3 = '!';
                        if (c < '!' || c > '/') {
                            if (c >= ':' && c <= '@') {
                                sb.append((char) 1);
                                i = (c - ':') + 15;
                            } else if (c < '[' || c > '_') {
                                c3 = '`';
                                if (c == '`') {
                                    sb.append((char) 2);
                                } else if (c >= 'A' && c <= 'Z') {
                                    sb.append((char) 2);
                                    i = (c - 'A') + 1;
                                } else {
                                    if (c < '{' || c > 127) {
                                        if (c >= 128) {
                                            sb.append("\u0001\u001e");
                                            return encodeChar((char) (c - 128), sb) + 2;
                                        }
                                        HighLevelEncoder.illegalCharacter(c);
                                        return -1;
                                    }
                                    sb.append((char) 2);
                                    i = (c - '{') + 27;
                                }
                            } else {
                                sb.append((char) 1);
                                i = (c - '[') + 22;
                            }
                            c = (char) i;
                        } else {
                            sb.append((char) 1);
                        }
                        i = c - c3;
                        c = (char) i;
                    } else {
                        sb.append((char) 0);
                    }
                    sb.append(c);
                    return 2;
                }
                i2 = (c - 'a') + 14;
            }
            c2 = (char) i2;
        }
        sb.append(c2);
        return 1;
    }

    @Override // com.google.zxing.datamatrix.encoder.C40Encoder, com.google.zxing.datamatrix.encoder.Encoder
    public int getEncodingMode() {
        return 2;
    }
}
