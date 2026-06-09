package com.google.zxing.datamatrix.encoder;

/* JADX INFO: loaded from: classes2.dex */
class C40Encoder implements Encoder {
    C40Encoder() {
    }

    private int backtrackOneCharacter(EncoderContext encoderContext, StringBuilder sb, StringBuilder sb2, int i) {
        int length = sb.length();
        sb.delete(length - i, length);
        encoderContext.pos--;
        int iEncodeChar = encodeChar(encoderContext.getCurrentChar(), sb2);
        encoderContext.resetSymbolInfo();
        return iEncodeChar;
    }

    private static String encodeToCodewords(CharSequence charSequence, int i) {
        int iCharAt = (charSequence.charAt(i) * 1600) + (charSequence.charAt(i + 1) * '(') + charSequence.charAt(i + 2) + 1;
        return new String(new char[]{(char) (iCharAt / 256), (char) (iCharAt % 256)});
    }

    static void writeNextTriplet(EncoderContext encoderContext, StringBuilder sb) {
        encoderContext.writeCodewords(encodeToCodewords(sb, 0));
        sb.delete(0, 3);
    }

    @Override // com.google.zxing.datamatrix.encoder.Encoder
    public void encode(EncoderContext encoderContext) {
        int iLookAheadTest;
        StringBuilder sb = new StringBuilder();
        while (true) {
            if (!encoderContext.hasMoreCharacters()) {
                break;
            }
            char currentChar = encoderContext.getCurrentChar();
            encoderContext.pos++;
            int iEncodeChar = encodeChar(currentChar, sb);
            int codewordCount = encoderContext.getCodewordCount() + ((sb.length() / 3) << 1);
            encoderContext.updateSymbolInfo(codewordCount);
            int dataCapacity = encoderContext.getSymbolInfo().getDataCapacity() - codewordCount;
            if (!encoderContext.hasMoreCharacters()) {
                StringBuilder sb2 = new StringBuilder();
                if (sb.length() % 3 == 2 && (dataCapacity < 2 || dataCapacity > 2)) {
                    iEncodeChar = backtrackOneCharacter(encoderContext, sb, sb2, iEncodeChar);
                }
                while (sb.length() % 3 == 1) {
                    if (iEncodeChar <= 3 && dataCapacity != 1) {
                        iEncodeChar = backtrackOneCharacter(encoderContext, sb, sb2, iEncodeChar);
                    } else if (iEncodeChar <= 3) {
                        break;
                    } else {
                        iEncodeChar = backtrackOneCharacter(encoderContext, sb, sb2, iEncodeChar);
                    }
                }
            } else if (sb.length() % 3 == 0 && (iLookAheadTest = HighLevelEncoder.lookAheadTest(encoderContext.getMessage(), encoderContext.pos, getEncodingMode())) != getEncodingMode()) {
                encoderContext.signalEncoderChange(iLookAheadTest);
                break;
            }
        }
        handleEOD(encoderContext, sb);
    }

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
                if (c < 'A' || c > 'Z') {
                    if (c < 0 || c > 31) {
                        if (c >= '!' && c <= '/') {
                            sb.append((char) 1);
                            i = c - '!';
                        } else if (c >= ':' && c <= '@') {
                            sb.append((char) 1);
                            i = (c - ':') + 15;
                        } else if (c >= '[' && c <= '_') {
                            sb.append((char) 1);
                            i = (c - '[') + 22;
                        } else {
                            if (c < '`' || c > 127) {
                                if (c >= 128) {
                                    sb.append("\u0001\u001e");
                                    return encodeChar((char) (c - 128), sb) + 2;
                                }
                                throw new IllegalArgumentException("Illegal character: " + c);
                            }
                            sb.append((char) 2);
                            i = c - '`';
                        }
                        c = (char) i;
                    } else {
                        sb.append((char) 0);
                    }
                    sb.append(c);
                    return 2;
                }
                i2 = (c - 'A') + 14;
            }
            c2 = (char) i2;
        }
        sb.append(c2);
        return 1;
    }

    @Override // com.google.zxing.datamatrix.encoder.Encoder
    public int getEncodingMode() {
        return 1;
    }

    /* JADX WARN: Removed duplicated region for block: B:10:0x0037  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    void handleEOD(com.google.zxing.datamatrix.encoder.EncoderContext r8, java.lang.StringBuilder r9) {
        /*
            r7 = this;
            int r0 = r9.length()
            r1 = 3
            int r0 = r0 / r1
            r2 = 1
            int r0 = r0 << r2
            int r3 = r9.length()
            int r3 = r3 % r1
            int r4 = r8.getCodewordCount()
            int r4 = r4 + r0
            r8.updateSymbolInfo(r4)
            com.google.zxing.datamatrix.encoder.SymbolInfo r0 = r8.getSymbolInfo()
            int r0 = r0.getDataCapacity()
            int r0 = r0 - r4
            r4 = 0
            r5 = 254(0xfe, float:3.56E-43)
            r6 = 2
            if (r3 != r6) goto L3b
            r9.append(r4)
        L27:
            int r0 = r9.length()
            if (r0 < r1) goto L31
            writeNextTriplet(r8, r9)
            goto L27
        L31:
            boolean r9 = r8.hasMoreCharacters()
            if (r9 == 0) goto L6d
        L37:
            r8.writeCodeword(r5)
            goto L6d
        L3b:
            if (r0 != r2) goto L58
            if (r3 != r2) goto L58
        L3f:
            int r0 = r9.length()
            if (r0 < r1) goto L49
            writeNextTriplet(r8, r9)
            goto L3f
        L49:
            boolean r9 = r8.hasMoreCharacters()
            if (r9 == 0) goto L52
            r8.writeCodeword(r5)
        L52:
            int r9 = r8.pos
            int r9 = r9 - r2
            r8.pos = r9
            goto L6d
        L58:
            if (r3 != 0) goto L71
        L5a:
            int r2 = r9.length()
            if (r2 < r1) goto L64
            writeNextTriplet(r8, r9)
            goto L5a
        L64:
            if (r0 > 0) goto L37
            boolean r9 = r8.hasMoreCharacters()
            if (r9 == 0) goto L6d
            goto L37
        L6d:
            r8.signalEncoderChange(r4)
            return
        L71:
            java.lang.IllegalStateException r8 = new java.lang.IllegalStateException
            java.lang.String r9 = "Unexpected case. Please report!"
            r8.<init>(r9)
            throw r8
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.zxing.datamatrix.encoder.C40Encoder.handleEOD(com.google.zxing.datamatrix.encoder.EncoderContext, java.lang.StringBuilder):void");
    }
}
