package android.support.v4.graphics;

import android.graphics.Path;
import android.support.annotation.RestrictTo;
import android.util.Log;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
@RestrictTo({RestrictTo.Scope.LIBRARY_GROUP})
public class PathParser {
    private static final String LOGTAG = "PathParser";

    private static class ExtractFloatResult {
        int mEndPosition;
        boolean mEndWithNegOrDot;

        ExtractFloatResult() {
        }
    }

    public static class PathDataNode {

        @RestrictTo({RestrictTo.Scope.LIBRARY_GROUP})
        public float[] mParams;

        @RestrictTo({RestrictTo.Scope.LIBRARY_GROUP})
        public char mType;

        PathDataNode(char c, float[] fArr) {
            this.mType = c;
            this.mParams = fArr;
        }

        PathDataNode(PathDataNode pathDataNode) {
            this.mType = pathDataNode.mType;
            this.mParams = PathParser.copyOfRange(pathDataNode.mParams, 0, pathDataNode.mParams.length);
        }

        /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
        private static void addCommand(Path path, float[] fArr, char c, char c2, float[] fArr2) {
            int i;
            int i2;
            float f;
            float f2;
            float f3;
            float f4;
            float f5;
            float f6;
            float f7;
            float f8;
            float f9;
            float f10;
            float f11 = fArr[0];
            float f12 = fArr[1];
            float f13 = fArr[2];
            float f14 = fArr[3];
            float f15 = fArr[4];
            float f16 = fArr[5];
            switch (c2) {
                case 'A':
                case 'a':
                    i = 7;
                    break;
                case 'C':
                case 'c':
                    i = 6;
                    break;
                case 'H':
                case 'V':
                case 'h':
                case 'v':
                    i = 1;
                    break;
                case 'L':
                case 'M':
                case 'T':
                case 'l':
                case 'm':
                case 't':
                default:
                    i = 2;
                    break;
                case 'Q':
                case 'S':
                case 'q':
                case 's':
                    i = 4;
                    break;
                case 'Z':
                case 'z':
                    path.close();
                    path.moveTo(f15, f16);
                    f11 = f15;
                    f13 = f11;
                    f12 = f16;
                    f14 = f12;
                    i = 2;
                    break;
            }
            float f17 = f11;
            float f18 = f12;
            float f19 = f15;
            float f20 = f16;
            int i3 = 0;
            char c3 = c;
            while (i3 < fArr2.length) {
                float f21 = 0.0f;
                switch (c2) {
                    case 'A':
                        i2 = i3;
                        int i4 = i2 + 5;
                        int i5 = i2 + 6;
                        drawArc(path, f17, f18, fArr2[i4], fArr2[i5], fArr2[i2 + 0], fArr2[i2 + 1], fArr2[i2 + 2], fArr2[i2 + 3] != 0.0f, fArr2[i2 + 4] != 0.0f);
                        f17 = fArr2[i4];
                        f18 = fArr2[i5];
                        f14 = f18;
                        f13 = f17;
                        break;
                    case 'C':
                        i2 = i3;
                        int i6 = i2 + 2;
                        int i7 = i2 + 3;
                        int i8 = i2 + 4;
                        int i9 = i2 + 5;
                        path.cubicTo(fArr2[i2 + 0], fArr2[i2 + 1], fArr2[i6], fArr2[i7], fArr2[i8], fArr2[i9]);
                        f17 = fArr2[i8];
                        float f22 = fArr2[i9];
                        float f23 = fArr2[i6];
                        float f24 = fArr2[i7];
                        f18 = f22;
                        f14 = f24;
                        f13 = f23;
                        break;
                    case 'H':
                        i2 = i3;
                        int i10 = i2 + 0;
                        path.lineTo(fArr2[i10], f18);
                        f17 = fArr2[i10];
                        break;
                    case 'L':
                        i2 = i3;
                        int i11 = i2 + 0;
                        int i12 = i2 + 1;
                        path.lineTo(fArr2[i11], fArr2[i12]);
                        f17 = fArr2[i11];
                        f18 = fArr2[i12];
                        break;
                    case 'M':
                        i2 = i3;
                        int i13 = i2 + 0;
                        f17 = fArr2[i13];
                        int i14 = i2 + 1;
                        f18 = fArr2[i14];
                        if (i2 <= 0) {
                            path.moveTo(fArr2[i13], fArr2[i14]);
                            f20 = f18;
                            f19 = f17;
                        } else {
                            path.lineTo(fArr2[i13], fArr2[i14]);
                        }
                        break;
                    case 'Q':
                        i2 = i3;
                        int i15 = i2 + 0;
                        int i16 = i2 + 1;
                        int i17 = i2 + 2;
                        int i18 = i2 + 3;
                        path.quadTo(fArr2[i15], fArr2[i16], fArr2[i17], fArr2[i18]);
                        f = fArr2[i15];
                        f2 = fArr2[i16];
                        f17 = fArr2[i17];
                        f18 = fArr2[i18];
                        f13 = f;
                        f14 = f2;
                        break;
                    case 'S':
                        float f25 = f18;
                        float f26 = f17;
                        i2 = i3;
                        if (c3 == 'c' || c3 == 's' || c3 == 'C' || c3 == 'S') {
                            float f27 = (f26 * 2.0f) - f13;
                            f3 = (f25 * 2.0f) - f14;
                            f4 = f27;
                        } else {
                            f4 = f26;
                            f3 = f25;
                        }
                        int i19 = i2 + 0;
                        int i20 = i2 + 1;
                        int i21 = i2 + 2;
                        int i22 = i2 + 3;
                        path.cubicTo(f4, f3, fArr2[i19], fArr2[i20], fArr2[i21], fArr2[i22]);
                        f = fArr2[i19];
                        f2 = fArr2[i20];
                        f17 = fArr2[i21];
                        f18 = fArr2[i22];
                        f13 = f;
                        f14 = f2;
                        break;
                    case 'T':
                        float f28 = f18;
                        float f29 = f17;
                        i2 = i3;
                        if (c3 == 'q' || c3 == 't' || c3 == 'Q' || c3 == 'T') {
                            f28 = (f28 * 2.0f) - f14;
                            f29 = (f29 * 2.0f) - f13;
                        }
                        int i23 = i2 + 0;
                        int i24 = i2 + 1;
                        path.quadTo(f29, f28, fArr2[i23], fArr2[i24]);
                        f17 = fArr2[i23];
                        f18 = fArr2[i24];
                        f13 = f29;
                        f14 = f28;
                        break;
                    case 'V':
                        i2 = i3;
                        int i25 = i2 + 0;
                        path.lineTo(f17, fArr2[i25]);
                        f18 = fArr2[i25];
                        break;
                    case 'a':
                        int i26 = i3 + 5;
                        int i27 = i3 + 6;
                        i2 = i3;
                        drawArc(path, f17, f18, fArr2[i26] + f17, fArr2[i27] + f18, fArr2[i3 + 0], fArr2[i3 + 1], fArr2[i3 + 2], fArr2[i3 + 3] != 0.0f, fArr2[i3 + 4] != 0.0f);
                        f17 += fArr2[i26];
                        f18 += fArr2[i27];
                        f14 = f18;
                        f13 = f17;
                        break;
                    case 'c':
                        int i28 = i3 + 2;
                        int i29 = i3 + 3;
                        int i30 = i3 + 4;
                        int i31 = i3 + 5;
                        path.rCubicTo(fArr2[i3 + 0], fArr2[i3 + 1], fArr2[i28], fArr2[i29], fArr2[i30], fArr2[i31]);
                        f5 = fArr2[i28] + f17;
                        f6 = fArr2[i29] + f18;
                        f17 += fArr2[i30];
                        f7 = fArr2[i31];
                        f18 += f7;
                        f13 = f5;
                        f14 = f6;
                        i2 = i3;
                        break;
                    case 'h':
                        int i32 = i3 + 0;
                        path.rLineTo(fArr2[i32], 0.0f);
                        f17 += fArr2[i32];
                        i2 = i3;
                        break;
                    case 'l':
                        int i33 = i3 + 0;
                        int i34 = i3 + 1;
                        path.rLineTo(fArr2[i33], fArr2[i34]);
                        f17 += fArr2[i33];
                        f8 = fArr2[i34];
                        f18 += f8;
                        i2 = i3;
                        break;
                    case 'm':
                        int i35 = i3 + 0;
                        f17 += fArr2[i35];
                        int i36 = i3 + 1;
                        f18 += fArr2[i36];
                        if (i3 > 0) {
                            path.rLineTo(fArr2[i35], fArr2[i36]);
                        } else {
                            path.rMoveTo(fArr2[i35], fArr2[i36]);
                            f20 = f18;
                            f19 = f17;
                        }
                        i2 = i3;
                        break;
                    case 'q':
                        int i37 = i3 + 0;
                        int i38 = i3 + 1;
                        int i39 = i3 + 2;
                        int i40 = i3 + 3;
                        path.rQuadTo(fArr2[i37], fArr2[i38], fArr2[i39], fArr2[i40]);
                        f5 = fArr2[i37] + f17;
                        f6 = fArr2[i38] + f18;
                        f17 += fArr2[i39];
                        f7 = fArr2[i40];
                        f18 += f7;
                        f13 = f5;
                        f14 = f6;
                        i2 = i3;
                        break;
                    case 's':
                        if (c3 == 'c' || c3 == 's' || c3 == 'C' || c3 == 'S') {
                            float f30 = f17 - f13;
                            f9 = f18 - f14;
                            f21 = f30;
                        } else {
                            f9 = 0.0f;
                        }
                        int i41 = i3 + 0;
                        int i42 = i3 + 1;
                        int i43 = i3 + 2;
                        int i44 = i3 + 3;
                        path.rCubicTo(f21, f9, fArr2[i41], fArr2[i42], fArr2[i43], fArr2[i44]);
                        f5 = fArr2[i41] + f17;
                        f6 = fArr2[i42] + f18;
                        f17 += fArr2[i43];
                        f7 = fArr2[i44];
                        f18 += f7;
                        f13 = f5;
                        f14 = f6;
                        i2 = i3;
                        break;
                    case 't':
                        if (c3 == 'q' || c3 == 't' || c3 == 'Q' || c3 == 'T') {
                            f21 = f17 - f13;
                            f10 = f18 - f14;
                        } else {
                            f10 = 0.0f;
                        }
                        int i45 = i3 + 0;
                        int i46 = i3 + 1;
                        path.rQuadTo(f21, f10, fArr2[i45], fArr2[i46]);
                        float f31 = f21 + f17;
                        float f32 = f10 + f18;
                        f17 += fArr2[i45];
                        f18 += fArr2[i46];
                        f14 = f32;
                        f13 = f31;
                        i2 = i3;
                        break;
                    case 'v':
                        int i47 = i3 + 0;
                        path.rLineTo(0.0f, fArr2[i47]);
                        f8 = fArr2[i47];
                        f18 += f8;
                        i2 = i3;
                        break;
                    default:
                        i2 = i3;
                        break;
                }
                i3 = i2 + i;
                c3 = c2;
            }
            fArr[0] = f17;
            fArr[1] = f18;
            fArr[2] = f13;
            fArr[3] = f14;
            fArr[4] = f19;
            fArr[5] = f20;
        }

        private static void arcToBezier(Path path, double d, double d2, double d3, double d4, double d5, double d6, double d7, double d8, double d9) {
            double d10 = d3;
            int iCeil = (int) Math.ceil(Math.abs((d9 * 4.0d) / 3.141592653589793d));
            double dCos = Math.cos(d7);
            double dSin = Math.sin(d7);
            double dCos2 = Math.cos(d8);
            double dSin2 = Math.sin(d8);
            double d11 = -d10;
            double d12 = d11 * dCos;
            double d13 = d4 * dSin;
            double d14 = (d12 * dSin2) - (d13 * dCos2);
            double d15 = d11 * dSin;
            double d16 = d4 * dCos;
            double d17 = (dSin2 * d15) + (dCos2 * d16);
            double d18 = d9 / ((double) iCeil);
            int i = 0;
            double d19 = d6;
            double d20 = d17;
            double d21 = d14;
            double d22 = d5;
            double d23 = d8;
            while (i < iCeil) {
                double d24 = d15;
                double d25 = d23 + d18;
                double dSin3 = Math.sin(d25);
                double dCos3 = Math.cos(d25);
                double d26 = d18;
                double d27 = (d + ((d10 * dCos) * dCos3)) - (d13 * dSin3);
                double d28 = d2 + (d10 * dSin * dCos3) + (d16 * dSin3);
                double d29 = (d12 * dSin3) - (d13 * dCos3);
                double d30 = (dSin3 * d24) + (dCos3 * d16);
                double d31 = d25 - d23;
                double d32 = d16;
                double dTan = Math.tan(d31 / 2.0d);
                double dSin4 = (Math.sin(d31) * (Math.sqrt(((dTan * 3.0d) * dTan) + 4.0d) - 1.0d)) / 3.0d;
                int i2 = iCeil;
                path.rLineTo(0.0f, 0.0f);
                path.cubicTo((float) (d22 + (d21 * dSin4)), (float) (d19 + (d20 * dSin4)), (float) (d27 - (dSin4 * d29)), (float) (d28 - (dSin4 * d30)), (float) d27, (float) d28);
                i++;
                d19 = d28;
                d22 = d27;
                d15 = d24;
                d20 = d30;
                d21 = d29;
                d18 = d26;
                d16 = d32;
                d23 = d25;
                iCeil = i2;
                dCos = dCos;
                dSin = dSin;
                d10 = d3;
            }
        }

        private static void drawArc(Path path, float f, float f2, float f3, float f4, float f5, float f6, float f7, boolean z, boolean z2) {
            double d;
            double d2;
            double radians = Math.toRadians(f7);
            double dCos = Math.cos(radians);
            double dSin = Math.sin(radians);
            double d3 = f;
            double d4 = f2;
            double d5 = (d3 * dCos) + (d4 * dSin);
            double d6 = f5;
            double d7 = d5 / d6;
            double d8 = (((double) (-f)) * dSin) + (d4 * dCos);
            double d9 = f6;
            double d10 = d8 / d9;
            double d11 = f4;
            double d12 = ((((double) f3) * dCos) + (d11 * dSin)) / d6;
            double d13 = ((((double) (-f3)) * dSin) + (d11 * dCos)) / d9;
            double d14 = d7 - d12;
            double d15 = d10 - d13;
            double d16 = (d7 + d12) / 2.0d;
            double d17 = (d10 + d13) / 2.0d;
            double d18 = (d14 * d14) + (d15 * d15);
            if (d18 == 0.0d) {
                Log.w(PathParser.LOGTAG, " Points are coincident");
                return;
            }
            double d19 = (1.0d / d18) - 0.25d;
            if (d19 < 0.0d) {
                Log.w(PathParser.LOGTAG, "Points are too far apart " + d18);
                float fSqrt = (float) (Math.sqrt(d18) / 1.99999d);
                drawArc(path, f, f2, f3, f4, f5 * fSqrt, f6 * fSqrt, f7, z, z2);
                return;
            }
            double dSqrt = Math.sqrt(d19);
            double d20 = d14 * dSqrt;
            double d21 = dSqrt * d15;
            if (z == z2) {
                d = d16 - d21;
                d2 = d17 + d20;
            } else {
                d = d16 + d21;
                d2 = d17 - d20;
            }
            double dAtan2 = Math.atan2(d10 - d2, d7 - d);
            double dAtan22 = Math.atan2(d13 - d2, d12 - d) - dAtan2;
            if (z2 != (dAtan22 >= 0.0d)) {
                dAtan22 = dAtan22 > 0.0d ? dAtan22 - 6.283185307179586d : dAtan22 + 6.283185307179586d;
            }
            double d22 = d * d6;
            double d23 = d2 * d9;
            arcToBezier(path, (d22 * dCos) - (d23 * dSin), (d22 * dSin) + (d23 * dCos), d6, d9, d3, d4, radians, dAtan2, dAtan22);
        }

        public static void nodesToPath(PathDataNode[] pathDataNodeArr, Path path) {
            float[] fArr = new float[6];
            char c = 'm';
            for (int i = 0; i < pathDataNodeArr.length; i++) {
                addCommand(path, fArr, c, pathDataNodeArr[i].mType, pathDataNodeArr[i].mParams);
                c = pathDataNodeArr[i].mType;
            }
        }

        public void interpolatePathDataNode(PathDataNode pathDataNode, PathDataNode pathDataNode2, float f) {
            for (int i = 0; i < pathDataNode.mParams.length; i++) {
                this.mParams[i] = (pathDataNode.mParams[i] * (1.0f - f)) + (pathDataNode2.mParams[i] * f);
            }
        }
    }

    private static void addNode(ArrayList<PathDataNode> arrayList, char c, float[] fArr) {
        arrayList.add(new PathDataNode(c, fArr));
    }

    public static boolean canMorph(PathDataNode[] pathDataNodeArr, PathDataNode[] pathDataNodeArr2) {
        if (pathDataNodeArr == null || pathDataNodeArr2 == null || pathDataNodeArr.length != pathDataNodeArr2.length) {
            return false;
        }
        for (int i = 0; i < pathDataNodeArr.length; i++) {
            if (pathDataNodeArr[i].mType != pathDataNodeArr2[i].mType || pathDataNodeArr[i].mParams.length != pathDataNodeArr2[i].mParams.length) {
                return false;
            }
        }
        return true;
    }

    static float[] copyOfRange(float[] fArr, int i, int i2) {
        if (i > i2) {
            throw new IllegalArgumentException();
        }
        int length = fArr.length;
        if (i < 0 || i > length) {
            throw new ArrayIndexOutOfBoundsException();
        }
        int i3 = i2 - i;
        int iMin = Math.min(i3, length - i);
        float[] fArr2 = new float[i3];
        System.arraycopy(fArr, i, fArr2, 0, iMin);
        return fArr2;
    }

    public static PathDataNode[] createNodesFromPathData(String str) {
        if (str == null) {
            return null;
        }
        ArrayList arrayList = new ArrayList();
        int i = 1;
        int i2 = 0;
        while (i < str.length()) {
            int iNextStart = nextStart(str, i);
            String strTrim = str.substring(i2, iNextStart).trim();
            if (strTrim.length() > 0) {
                addNode(arrayList, strTrim.charAt(0), getFloats(strTrim));
            }
            i2 = iNextStart;
            i = iNextStart + 1;
        }
        if (i - i2 == 1 && i2 < str.length()) {
            addNode(arrayList, str.charAt(i2), new float[0]);
        }
        return (PathDataNode[]) arrayList.toArray(new PathDataNode[arrayList.size()]);
    }

    public static Path createPathFromPathData(String str) {
        Path path = new Path();
        PathDataNode[] pathDataNodeArrCreateNodesFromPathData = createNodesFromPathData(str);
        if (pathDataNodeArrCreateNodesFromPathData == null) {
            return null;
        }
        try {
            PathDataNode.nodesToPath(pathDataNodeArrCreateNodesFromPathData, path);
            return path;
        } catch (RuntimeException e) {
            throw new RuntimeException("Error in parsing " + str, e);
        }
    }

    public static PathDataNode[] deepCopyNodes(PathDataNode[] pathDataNodeArr) {
        if (pathDataNodeArr == null) {
            return null;
        }
        PathDataNode[] pathDataNodeArr2 = new PathDataNode[pathDataNodeArr.length];
        for (int i = 0; i < pathDataNodeArr.length; i++) {
            pathDataNodeArr2[i] = new PathDataNode(pathDataNodeArr[i]);
        }
        return pathDataNodeArr2;
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    /* JADX WARN: Code restructure failed: missing block: B:17:0x002c, code lost:
    
        if (r2 == false) goto L15;
     */
    /* JADX WARN: Removed duplicated region for block: B:21:0x0033  */
    /* JADX WARN: Removed duplicated region for block: B:24:0x0038 A[LOOP:0: B:3:0x0007->B:24:0x0038, LOOP_END] */
    /* JADX WARN: Removed duplicated region for block: B:28:0x003b A[SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private static void extract(java.lang.String r8, int r9, android.support.v4.graphics.PathParser.ExtractFloatResult r10) {
        /*
            r0 = 0
            r10.mEndWithNegOrDot = r0
            r1 = r9
            r2 = 0
            r3 = 0
            r4 = 0
        L7:
            int r5 = r8.length()
            if (r1 >= r5) goto L3b
            char r5 = r8.charAt(r1)
            r6 = 32
            r7 = 1
            if (r5 == r6) goto L33
            r6 = 69
            if (r5 == r6) goto L31
            r6 = 101(0x65, float:1.42E-43)
            if (r5 == r6) goto L31
            switch(r5) {
                case 44: goto L33;
                case 45: goto L2a;
                case 46: goto L22;
                default: goto L21;
            }
        L21:
            goto L2f
        L22:
            if (r3 != 0) goto L27
            r2 = 0
            r3 = 1
            goto L35
        L27:
            r10.mEndWithNegOrDot = r7
            goto L33
        L2a:
            if (r1 == r9) goto L2f
            if (r2 != 0) goto L2f
            goto L27
        L2f:
            r2 = 0
            goto L35
        L31:
            r2 = 1
            goto L35
        L33:
            r2 = 0
            r4 = 1
        L35:
            if (r4 == 0) goto L38
            goto L3b
        L38:
            int r1 = r1 + 1
            goto L7
        L3b:
            r10.mEndPosition = r1
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: android.support.v4.graphics.PathParser.extract(java.lang.String, int, android.support.v4.graphics.PathParser$ExtractFloatResult):void");
    }

    private static float[] getFloats(String str) {
        if (str.charAt(0) == 'z' || str.charAt(0) == 'Z') {
            return new float[0];
        }
        try {
            float[] fArr = new float[str.length()];
            ExtractFloatResult extractFloatResult = new ExtractFloatResult();
            int length = str.length();
            int i = 1;
            int i2 = 0;
            while (i < length) {
                extract(str, i, extractFloatResult);
                int i3 = extractFloatResult.mEndPosition;
                if (i < i3) {
                    fArr[i2] = Float.parseFloat(str.substring(i, i3));
                    i2++;
                }
                i = extractFloatResult.mEndWithNegOrDot ? i3 : i3 + 1;
            }
            return copyOfRange(fArr, 0, i2);
        } catch (NumberFormatException e) {
            throw new RuntimeException("error in parsing \"" + str + "\"", e);
        }
    }

    private static int nextStart(String str, int i) {
        while (i < str.length()) {
            char cCharAt = str.charAt(i);
            if (((cCharAt - 'A') * (cCharAt - 'Z') <= 0 || (cCharAt - 'a') * (cCharAt - 'z') <= 0) && cCharAt != 'e' && cCharAt != 'E') {
                return i;
            }
            i++;
        }
        return i;
    }

    public static void updateNodes(PathDataNode[] pathDataNodeArr, PathDataNode[] pathDataNodeArr2) {
        for (int i = 0; i < pathDataNodeArr2.length; i++) {
            pathDataNodeArr[i].mType = pathDataNodeArr2[i].mType;
            for (int i2 = 0; i2 < pathDataNodeArr2[i].mParams.length; i2++) {
                pathDataNodeArr[i].mParams[i2] = pathDataNodeArr2[i].mParams[i2];
            }
        }
    }
}
