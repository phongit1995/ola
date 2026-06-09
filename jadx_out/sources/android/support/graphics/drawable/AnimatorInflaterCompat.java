package android.support.graphics.drawable;

import android.animation.Animator;
import android.animation.AnimatorInflater;
import android.animation.Keyframe;
import android.animation.ObjectAnimator;
import android.animation.PropertyValuesHolder;
import android.animation.TypeEvaluator;
import android.animation.ValueAnimator;
import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.content.res.XmlResourceParser;
import android.graphics.Path;
import android.graphics.PathMeasure;
import android.os.Build;
import android.support.annotation.AnimatorRes;
import android.support.annotation.RestrictTo;
import android.support.v4.content.res.TypedArrayUtils;
import android.support.v4.graphics.PathParser;
import android.util.AttributeSet;
import android.util.Log;
import android.util.TypedValue;
import android.util.Xml;
import android.view.InflateException;
import com.google.firebase.analytics.FirebaseAnalytics;
import java.io.IOException;
import java.util.ArrayList;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

/* JADX INFO: loaded from: classes.dex */
@RestrictTo({RestrictTo.Scope.LIBRARY_GROUP})
public class AnimatorInflaterCompat {
    private static final boolean DBG_ANIMATOR_INFLATER = false;
    private static final int MAX_NUM_POINTS = 100;
    private static final String TAG = "AnimatorInflater";
    private static final int TOGETHER = 0;
    private static final int VALUE_TYPE_COLOR = 3;
    private static final int VALUE_TYPE_FLOAT = 0;
    private static final int VALUE_TYPE_INT = 1;
    private static final int VALUE_TYPE_PATH = 2;
    private static final int VALUE_TYPE_UNDEFINED = 4;

    private static class PathDataEvaluator implements TypeEvaluator<PathParser.PathDataNode[]> {
        private PathParser.PathDataNode[] mNodeArray;

        private PathDataEvaluator() {
        }

        PathDataEvaluator(PathParser.PathDataNode[] pathDataNodeArr) {
            this.mNodeArray = pathDataNodeArr;
        }

        @Override // android.animation.TypeEvaluator
        public PathParser.PathDataNode[] evaluate(float f, PathParser.PathDataNode[] pathDataNodeArr, PathParser.PathDataNode[] pathDataNodeArr2) {
            if (!PathParser.canMorph(pathDataNodeArr, pathDataNodeArr2)) {
                throw new IllegalArgumentException("Can't interpolate between two incompatible pathData");
            }
            if (this.mNodeArray == null || !PathParser.canMorph(this.mNodeArray, pathDataNodeArr)) {
                this.mNodeArray = PathParser.deepCopyNodes(pathDataNodeArr);
            }
            for (int i = 0; i < pathDataNodeArr.length; i++) {
                this.mNodeArray[i].interpolatePathDataNode(pathDataNodeArr[i], pathDataNodeArr2[i], f);
            }
            return this.mNodeArray;
        }
    }

    private static Animator createAnimatorFromXml(Context context, Resources resources, Resources.Theme theme, XmlPullParser xmlPullParser, float f) {
        return createAnimatorFromXml(context, resources, theme, xmlPullParser, Xml.asAttributeSet(xmlPullParser), null, 0, f);
    }

    /* JADX WARN: Code restructure failed: missing block: B:38:0x00d7, code lost:
    
        if (r23 == null) goto L48;
     */
    /* JADX WARN: Code restructure failed: missing block: B:39:0x00d9, code lost:
    
        if (r13 == null) goto L48;
     */
    /* JADX WARN: Code restructure failed: missing block: B:40:0x00db, code lost:
    
        r1 = new android.animation.Animator[r13.size()];
        r2 = r13.iterator();
        r17 = 0;
     */
    /* JADX WARN: Code restructure failed: missing block: B:42:0x00eb, code lost:
    
        if (r2.hasNext() == false) goto L60;
     */
    /* JADX WARN: Code restructure failed: missing block: B:43:0x00ed, code lost:
    
        r1[r17] = (android.animation.Animator) r2.next();
        r17 = r17 + 1;
     */
    /* JADX WARN: Code restructure failed: missing block: B:44:0x00fa, code lost:
    
        if (r24 != 0) goto L47;
     */
    /* JADX WARN: Code restructure failed: missing block: B:45:0x00fc, code lost:
    
        r23.playTogether(r1);
     */
    /* JADX WARN: Code restructure failed: missing block: B:46:0x00ff, code lost:
    
        return r0;
     */
    /* JADX WARN: Code restructure failed: missing block: B:47:0x0100, code lost:
    
        r23.playSequentially(r1);
     */
    /* JADX WARN: Code restructure failed: missing block: B:48:0x0103, code lost:
    
        return r0;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private static android.animation.Animator createAnimatorFromXml(android.content.Context r18, android.content.res.Resources r19, android.content.res.Resources.Theme r20, org.xmlpull.v1.XmlPullParser r21, android.util.AttributeSet r22, android.animation.AnimatorSet r23, int r24, float r25) throws org.xmlpull.v1.XmlPullParserException, java.io.IOException {
        /*
            Method dump skipped, instruction units count: 260
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: android.support.graphics.drawable.AnimatorInflaterCompat.createAnimatorFromXml(android.content.Context, android.content.res.Resources, android.content.res.Resources$Theme, org.xmlpull.v1.XmlPullParser, android.util.AttributeSet, android.animation.AnimatorSet, int, float):android.animation.Animator");
    }

    private static Keyframe createNewKeyframe(Keyframe keyframe, float f) {
        return keyframe.getType() == Float.TYPE ? Keyframe.ofFloat(f) : keyframe.getType() == Integer.TYPE ? Keyframe.ofInt(f) : Keyframe.ofObject(f);
    }

    private static void distributeKeyframes(Keyframe[] keyframeArr, float f, int i, int i2) {
        float f2 = f / ((i2 - i) + 2);
        while (i <= i2) {
            keyframeArr[i].setFraction(keyframeArr[i - 1].getFraction() + f2);
            i++;
        }
    }

    private static void dumpKeyframes(Object[] objArr, String str) {
        if (objArr == null || objArr.length == 0) {
            return;
        }
        Log.d(TAG, str);
        int length = objArr.length;
        for (int i = 0; i < length; i++) {
            Keyframe keyframe = (Keyframe) objArr[i];
            StringBuilder sb = new StringBuilder();
            sb.append("Keyframe ");
            sb.append(i);
            sb.append(": fraction ");
            sb.append(keyframe.getFraction() < 0.0f ? "null" : Float.valueOf(keyframe.getFraction()));
            sb.append(", ");
            sb.append(", value : ");
            sb.append(keyframe.hasValue() ? keyframe.getValue() : "null");
            Log.d(TAG, sb.toString());
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r9v0, types: [android.support.graphics.drawable.AnimatorInflaterCompat$1] */
    /* JADX WARN: Type inference failed for: r9v10 */
    /* JADX WARN: Type inference failed for: r9v11 */
    /* JADX WARN: Type inference failed for: r9v12 */
    /* JADX WARN: Type inference failed for: r9v5 */
    private static PropertyValuesHolder getPVH(TypedArray typedArray, int i, int i2, int i3, String str) {
        PropertyValuesHolder propertyValuesHolderOfFloat;
        Object[] objArr;
        TypedValue typedValuePeekValue = typedArray.peekValue(i2);
        boolean z = typedValuePeekValue != null;
        int i4 = z ? typedValuePeekValue.type : 0;
        TypedValue typedValuePeekValue2 = typedArray.peekValue(i3);
        boolean z2 = typedValuePeekValue2 != null;
        int i5 = z2 ? typedValuePeekValue2.type : 0;
        if (i == 4) {
            i = ((z && isColorType(i4)) || (z2 && isColorType(i5))) ? 3 : 0;
        }
        boolean z3 = i == 0;
        PropertyValuesHolder propertyValuesHolderOfInt = 0;
        propertyValuesHolderOfInt = 0;
        propertyValuesHolderOfInt = 0;
        if (i == 2) {
            String string = typedArray.getString(i2);
            String string2 = typedArray.getString(i3);
            PathParser.PathDataNode[] pathDataNodeArrCreateNodesFromPathData = PathParser.createNodesFromPathData(string);
            PathParser.PathDataNode[] pathDataNodeArrCreateNodesFromPathData2 = PathParser.createNodesFromPathData(string2);
            if (pathDataNodeArrCreateNodesFromPathData != null || pathDataNodeArrCreateNodesFromPathData2 != null) {
                if (pathDataNodeArrCreateNodesFromPathData != null) {
                    PathDataEvaluator pathDataEvaluator = new PathDataEvaluator();
                    if (pathDataNodeArrCreateNodesFromPathData2 == null) {
                        objArr = new Object[]{pathDataNodeArrCreateNodesFromPathData};
                    } else {
                        if (!PathParser.canMorph(pathDataNodeArrCreateNodesFromPathData, pathDataNodeArrCreateNodesFromPathData2)) {
                            throw new InflateException(" Can't morph from " + string + " to " + string2);
                        }
                        objArr = new Object[]{pathDataNodeArrCreateNodesFromPathData, pathDataNodeArrCreateNodesFromPathData2};
                    }
                    return PropertyValuesHolder.ofObject(str, pathDataEvaluator, objArr);
                }
                if (pathDataNodeArrCreateNodesFromPathData2 != null) {
                    return PropertyValuesHolder.ofObject(str, new PathDataEvaluator(), pathDataNodeArrCreateNodesFromPathData2);
                }
            }
        } else {
            ArgbEvaluator argbEvaluator = i == 3 ? ArgbEvaluator.getInstance() : null;
            if (z3) {
                if (z) {
                    float dimension = i4 == 5 ? typedArray.getDimension(i2, 0.0f) : typedArray.getFloat(i2, 0.0f);
                    if (z2) {
                        propertyValuesHolderOfFloat = PropertyValuesHolder.ofFloat(str, dimension, i5 == 5 ? typedArray.getDimension(i3, 0.0f) : typedArray.getFloat(i3, 0.0f));
                    } else {
                        propertyValuesHolderOfFloat = PropertyValuesHolder.ofFloat(str, dimension);
                    }
                } else {
                    propertyValuesHolderOfFloat = PropertyValuesHolder.ofFloat(str, i5 == 5 ? typedArray.getDimension(i3, 0.0f) : typedArray.getFloat(i3, 0.0f));
                }
                propertyValuesHolderOfInt = propertyValuesHolderOfFloat;
            } else if (z) {
                int dimension2 = i4 == 5 ? (int) typedArray.getDimension(i2, 0.0f) : isColorType(i4) ? typedArray.getColor(i2, 0) : typedArray.getInt(i2, 0);
                if (z2) {
                    propertyValuesHolderOfInt = PropertyValuesHolder.ofInt(str, dimension2, i5 == 5 ? (int) typedArray.getDimension(i3, 0.0f) : isColorType(i5) ? typedArray.getColor(i3, 0) : typedArray.getInt(i3, 0));
                } else {
                    propertyValuesHolderOfInt = PropertyValuesHolder.ofInt(str, dimension2);
                }
            } else if (z2) {
                propertyValuesHolderOfInt = PropertyValuesHolder.ofInt(str, i5 == 5 ? (int) typedArray.getDimension(i3, 0.0f) : isColorType(i5) ? typedArray.getColor(i3, 0) : typedArray.getInt(i3, 0));
            }
            if (propertyValuesHolderOfInt != 0 && argbEvaluator != null) {
                propertyValuesHolderOfInt.setEvaluator(argbEvaluator);
            }
        }
        return propertyValuesHolderOfInt;
    }

    private static int inferValueTypeFromValues(TypedArray typedArray, int i, int i2) {
        TypedValue typedValuePeekValue = typedArray.peekValue(i);
        boolean z = typedValuePeekValue != null;
        int i3 = z ? typedValuePeekValue.type : 0;
        TypedValue typedValuePeekValue2 = typedArray.peekValue(i2);
        boolean z2 = typedValuePeekValue2 != null;
        return ((z && isColorType(i3)) || (z2 && isColorType(z2 ? typedValuePeekValue2.type : 0))) ? 3 : 0;
    }

    private static int inferValueTypeOfKeyframe(Resources resources, Resources.Theme theme, AttributeSet attributeSet, XmlPullParser xmlPullParser) {
        TypedArray typedArrayObtainAttributes = TypedArrayUtils.obtainAttributes(resources, theme, attributeSet, AndroidResources.STYLEABLE_KEYFRAME);
        int i = 0;
        TypedValue typedValuePeekNamedValue = TypedArrayUtils.peekNamedValue(typedArrayObtainAttributes, xmlPullParser, FirebaseAnalytics.Param.VALUE, 0);
        if ((typedValuePeekNamedValue != null) && isColorType(typedValuePeekNamedValue.type)) {
            i = 3;
        }
        typedArrayObtainAttributes.recycle();
        return i;
    }

    private static boolean isColorType(int i) {
        return i >= 28 && i <= 31;
    }

    public static Animator loadAnimator(Context context, @AnimatorRes int i) {
        return Build.VERSION.SDK_INT >= 24 ? AnimatorInflater.loadAnimator(context, i) : loadAnimator(context, context.getResources(), context.getTheme(), i);
    }

    public static Animator loadAnimator(Context context, Resources resources, Resources.Theme theme, @AnimatorRes int i) {
        return loadAnimator(context, resources, theme, i, 1.0f);
    }

    public static Animator loadAnimator(Context context, Resources resources, Resources.Theme theme, @AnimatorRes int i, float f) throws Throwable {
        XmlResourceParser animation;
        XmlResourceParser xmlResourceParser = null;
        try {
            try {
                animation = resources.getAnimation(i);
            } catch (Throwable th) {
                th = th;
            }
        } catch (IOException e) {
            e = e;
        } catch (XmlPullParserException e2) {
            e = e2;
        }
        try {
            Animator animatorCreateAnimatorFromXml = createAnimatorFromXml(context, resources, theme, animation, f);
            if (animation != null) {
                animation.close();
            }
            return animatorCreateAnimatorFromXml;
        } catch (IOException e3) {
            e = e3;
            Resources.NotFoundException notFoundException = new Resources.NotFoundException("Can't load animation resource ID #0x" + Integer.toHexString(i));
            notFoundException.initCause(e);
            throw notFoundException;
        } catch (XmlPullParserException e4) {
            e = e4;
            Resources.NotFoundException notFoundException2 = new Resources.NotFoundException("Can't load animation resource ID #0x" + Integer.toHexString(i));
            notFoundException2.initCause(e);
            throw notFoundException2;
        } catch (Throwable th2) {
            th = th2;
            xmlResourceParser = animation;
            if (xmlResourceParser != null) {
                xmlResourceParser.close();
            }
            throw th;
        }
    }

    private static ValueAnimator loadAnimator(Context context, Resources resources, Resources.Theme theme, AttributeSet attributeSet, ValueAnimator valueAnimator, float f, XmlPullParser xmlPullParser) {
        TypedArray typedArrayObtainAttributes = TypedArrayUtils.obtainAttributes(resources, theme, attributeSet, AndroidResources.STYLEABLE_ANIMATOR);
        TypedArray typedArrayObtainAttributes2 = TypedArrayUtils.obtainAttributes(resources, theme, attributeSet, AndroidResources.STYLEABLE_PROPERTY_ANIMATOR);
        if (valueAnimator == null) {
            valueAnimator = new ValueAnimator();
        }
        parseAnimatorFromTypeArray(valueAnimator, typedArrayObtainAttributes, typedArrayObtainAttributes2, f, xmlPullParser);
        int namedResourceId = TypedArrayUtils.getNamedResourceId(typedArrayObtainAttributes, xmlPullParser, "interpolator", 0, 0);
        if (namedResourceId > 0) {
            valueAnimator.setInterpolator(AnimationUtilsCompat.loadInterpolator(context, namedResourceId));
        }
        typedArrayObtainAttributes.recycle();
        if (typedArrayObtainAttributes2 != null) {
            typedArrayObtainAttributes2.recycle();
        }
        return valueAnimator;
    }

    /* JADX WARN: Removed duplicated region for block: B:18:0x0041  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private static android.animation.Keyframe loadKeyframe(android.content.Context r5, android.content.res.Resources r6, android.content.res.Resources.Theme r7, android.util.AttributeSet r8, int r9, org.xmlpull.v1.XmlPullParser r10) {
        /*
            int[] r0 = android.support.graphics.drawable.AndroidResources.STYLEABLE_KEYFRAME
            android.content.res.TypedArray r6 = android.support.v4.content.res.TypedArrayUtils.obtainAttributes(r6, r7, r8, r0)
            java.lang.String r7 = "fraction"
            r8 = 3
            r0 = -1082130432(0xffffffffbf800000, float:-1.0)
            float r7 = android.support.v4.content.res.TypedArrayUtils.getNamedFloat(r6, r10, r7, r8, r0)
            java.lang.String r0 = "value"
            r1 = 0
            android.util.TypedValue r0 = android.support.v4.content.res.TypedArrayUtils.peekNamedValue(r6, r10, r0, r1)
            r2 = 1
            if (r0 == 0) goto L1b
            r3 = 1
            goto L1c
        L1b:
            r3 = 0
        L1c:
            r4 = 4
            if (r9 != r4) goto L2c
            if (r3 == 0) goto L2b
            int r9 = r0.type
            boolean r9 = isColorType(r9)
            if (r9 == 0) goto L2b
            r9 = 3
            goto L2c
        L2b:
            r9 = 0
        L2c:
            if (r3 == 0) goto L4c
            if (r9 == r8) goto L41
            switch(r9) {
                case 0: goto L35;
                case 1: goto L41;
                default: goto L33;
            }
        L33:
            r7 = 0
            goto L57
        L35:
            java.lang.String r8 = "value"
            r9 = 0
            float r8 = android.support.v4.content.res.TypedArrayUtils.getNamedFloat(r6, r10, r8, r1, r9)
            android.animation.Keyframe r7 = android.animation.Keyframe.ofFloat(r7, r8)
            goto L57
        L41:
            java.lang.String r8 = "value"
            int r8 = android.support.v4.content.res.TypedArrayUtils.getNamedInt(r6, r10, r8, r1, r1)
            android.animation.Keyframe r7 = android.animation.Keyframe.ofInt(r7, r8)
            goto L57
        L4c:
            if (r9 != 0) goto L53
            android.animation.Keyframe r7 = android.animation.Keyframe.ofFloat(r7)
            goto L57
        L53:
            android.animation.Keyframe r7 = android.animation.Keyframe.ofInt(r7)
        L57:
            java.lang.String r8 = "interpolator"
            int r8 = android.support.v4.content.res.TypedArrayUtils.getNamedResourceId(r6, r10, r8, r2, r1)
            if (r8 <= 0) goto L66
            android.view.animation.Interpolator r5 = android.support.graphics.drawable.AnimationUtilsCompat.loadInterpolator(r5, r8)
            r7.setInterpolator(r5)
        L66:
            r6.recycle()
            return r7
        */
        throw new UnsupportedOperationException("Method not decompiled: android.support.graphics.drawable.AnimatorInflaterCompat.loadKeyframe(android.content.Context, android.content.res.Resources, android.content.res.Resources$Theme, android.util.AttributeSet, int, org.xmlpull.v1.XmlPullParser):android.animation.Keyframe");
    }

    private static ObjectAnimator loadObjectAnimator(Context context, Resources resources, Resources.Theme theme, AttributeSet attributeSet, float f, XmlPullParser xmlPullParser) {
        ObjectAnimator objectAnimator = new ObjectAnimator();
        loadAnimator(context, resources, theme, attributeSet, objectAnimator, f, xmlPullParser);
        return objectAnimator;
    }

    private static PropertyValuesHolder loadPvh(Context context, Resources resources, Resources.Theme theme, XmlPullParser xmlPullParser, String str, int i) throws XmlPullParserException, IOException {
        int size;
        PropertyValuesHolder propertyValuesHolderOfKeyframe = null;
        int iInferValueTypeOfKeyframe = i;
        ArrayList arrayList = null;
        while (true) {
            int next = xmlPullParser.next();
            if (next == 3 || next == 1) {
                break;
            }
            if (xmlPullParser.getName().equals("keyframe")) {
                if (iInferValueTypeOfKeyframe == 4) {
                    iInferValueTypeOfKeyframe = inferValueTypeOfKeyframe(resources, theme, Xml.asAttributeSet(xmlPullParser), xmlPullParser);
                }
                Keyframe keyframeLoadKeyframe = loadKeyframe(context, resources, theme, Xml.asAttributeSet(xmlPullParser), iInferValueTypeOfKeyframe, xmlPullParser);
                if (keyframeLoadKeyframe != null) {
                    if (arrayList == null) {
                        arrayList = new ArrayList();
                    }
                    arrayList.add(keyframeLoadKeyframe);
                }
                xmlPullParser.next();
            }
        }
        if (arrayList != null && (size = arrayList.size()) > 0) {
            Keyframe keyframe = (Keyframe) arrayList.get(0);
            Keyframe keyframe2 = (Keyframe) arrayList.get(size - 1);
            float fraction = keyframe2.getFraction();
            if (fraction < 1.0f) {
                if (fraction < 0.0f) {
                    keyframe2.setFraction(1.0f);
                } else {
                    arrayList.add(arrayList.size(), createNewKeyframe(keyframe2, 1.0f));
                    size++;
                }
            }
            float fraction2 = keyframe.getFraction();
            if (fraction2 != 0.0f) {
                if (fraction2 < 0.0f) {
                    keyframe.setFraction(0.0f);
                } else {
                    arrayList.add(0, createNewKeyframe(keyframe, 0.0f));
                    size++;
                }
            }
            Keyframe[] keyframeArr = new Keyframe[size];
            arrayList.toArray(keyframeArr);
            for (int i2 = 0; i2 < size; i2++) {
                Keyframe keyframe3 = keyframeArr[i2];
                if (keyframe3.getFraction() < 0.0f) {
                    if (i2 == 0) {
                        keyframe3.setFraction(0.0f);
                    } else {
                        int i3 = size - 1;
                        if (i2 == i3) {
                            keyframe3.setFraction(1.0f);
                        } else {
                            int i4 = i2;
                            for (int i5 = i2 + 1; i5 < i3 && keyframeArr[i5].getFraction() < 0.0f; i5++) {
                                i4 = i5;
                            }
                            distributeKeyframes(keyframeArr, keyframeArr[i4 + 1].getFraction() - keyframeArr[i2 - 1].getFraction(), i2, i4);
                        }
                    }
                }
            }
            propertyValuesHolderOfKeyframe = PropertyValuesHolder.ofKeyframe(str, keyframeArr);
            if (iInferValueTypeOfKeyframe == 3) {
                propertyValuesHolderOfKeyframe.setEvaluator(ArgbEvaluator.getInstance());
            }
        }
        return propertyValuesHolderOfKeyframe;
    }

    private static PropertyValuesHolder[] loadValues(Context context, Resources resources, Resources.Theme theme, XmlPullParser xmlPullParser, AttributeSet attributeSet) throws XmlPullParserException, IOException {
        int i;
        PropertyValuesHolder[] propertyValuesHolderArr = null;
        ArrayList arrayList = null;
        while (true) {
            int eventType = xmlPullParser.getEventType();
            if (eventType == 3 || eventType == 1) {
                break;
            }
            if (eventType == 2 && xmlPullParser.getName().equals("propertyValuesHolder")) {
                TypedArray typedArrayObtainAttributes = TypedArrayUtils.obtainAttributes(resources, theme, attributeSet, AndroidResources.STYLEABLE_PROPERTY_VALUES_HOLDER);
                String namedString = TypedArrayUtils.getNamedString(typedArrayObtainAttributes, xmlPullParser, "propertyName", 3);
                int namedInt = TypedArrayUtils.getNamedInt(typedArrayObtainAttributes, xmlPullParser, "valueType", 2, 4);
                PropertyValuesHolder propertyValuesHolderLoadPvh = loadPvh(context, resources, theme, xmlPullParser, namedString, namedInt);
                if (propertyValuesHolderLoadPvh == null) {
                    propertyValuesHolderLoadPvh = getPVH(typedArrayObtainAttributes, namedInt, 0, 1, namedString);
                }
                if (propertyValuesHolderLoadPvh != null) {
                    if (arrayList == null) {
                        arrayList = new ArrayList();
                    }
                    arrayList.add(propertyValuesHolderLoadPvh);
                }
                typedArrayObtainAttributes.recycle();
            }
            xmlPullParser.next();
        }
        if (arrayList != null) {
            int size = arrayList.size();
            propertyValuesHolderArr = new PropertyValuesHolder[size];
            for (i = 0; i < size; i++) {
                propertyValuesHolderArr[i] = (PropertyValuesHolder) arrayList.get(i);
            }
        }
        return propertyValuesHolderArr;
    }

    private static void parseAnimatorFromTypeArray(ValueAnimator valueAnimator, TypedArray typedArray, TypedArray typedArray2, float f, XmlPullParser xmlPullParser) {
        long namedInt = TypedArrayUtils.getNamedInt(typedArray, xmlPullParser, "duration", 1, 300);
        long namedInt2 = TypedArrayUtils.getNamedInt(typedArray, xmlPullParser, "startOffset", 2, 0);
        int namedInt3 = TypedArrayUtils.getNamedInt(typedArray, xmlPullParser, "valueType", 7, 4);
        if (TypedArrayUtils.hasAttribute(xmlPullParser, "valueFrom") && TypedArrayUtils.hasAttribute(xmlPullParser, "valueTo")) {
            if (namedInt3 == 4) {
                namedInt3 = inferValueTypeFromValues(typedArray, 5, 6);
            }
            PropertyValuesHolder pvh = getPVH(typedArray, namedInt3, 5, 6, "");
            if (pvh != null) {
                valueAnimator.setValues(pvh);
            }
        }
        valueAnimator.setDuration(namedInt);
        valueAnimator.setStartDelay(namedInt2);
        valueAnimator.setRepeatCount(TypedArrayUtils.getNamedInt(typedArray, xmlPullParser, "repeatCount", 3, 0));
        valueAnimator.setRepeatMode(TypedArrayUtils.getNamedInt(typedArray, xmlPullParser, "repeatMode", 4, 1));
        if (typedArray2 != null) {
            setupObjectAnimator(valueAnimator, typedArray2, namedInt3, f, xmlPullParser);
        }
    }

    private static void setupObjectAnimator(ValueAnimator valueAnimator, TypedArray typedArray, int i, float f, XmlPullParser xmlPullParser) {
        ObjectAnimator objectAnimator = (ObjectAnimator) valueAnimator;
        String namedString = TypedArrayUtils.getNamedString(typedArray, xmlPullParser, "pathData", 1);
        if (namedString == null) {
            objectAnimator.setPropertyName(TypedArrayUtils.getNamedString(typedArray, xmlPullParser, "propertyName", 0));
            return;
        }
        String namedString2 = TypedArrayUtils.getNamedString(typedArray, xmlPullParser, "propertyXName", 2);
        String namedString3 = TypedArrayUtils.getNamedString(typedArray, xmlPullParser, "propertyYName", 3);
        if (i != 2) {
        }
        if (namedString2 != null || namedString3 != null) {
            setupPathMotion(PathParser.createPathFromPathData(namedString), objectAnimator, f * 0.5f, namedString2, namedString3);
            return;
        }
        throw new InflateException(typedArray.getPositionDescription() + " propertyXName or propertyYName is needed for PathData");
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    private static void setupPathMotion(Path path, ObjectAnimator objectAnimator, float f, String str, String str2) {
        char c = 0;
        PathMeasure pathMeasure = new PathMeasure(path, false);
        ArrayList arrayList = new ArrayList();
        arrayList.add(Float.valueOf(0.0f));
        float length = 0.0f;
        do {
            length += pathMeasure.getLength();
            arrayList.add(Float.valueOf(length));
        } while (pathMeasure.nextContour());
        PathMeasure pathMeasure2 = new PathMeasure(path, false);
        int iMin = Math.min(100, ((int) (length / f)) + 1);
        float[] fArr = new float[iMin];
        float[] fArr2 = new float[iMin];
        float[] fArr3 = new float[2];
        float f2 = length / (iMin - 1);
        int i = 0;
        float fFloatValue = 0.0f;
        int i2 = 0;
        while (true) {
            if (i >= iMin) {
                break;
            }
            pathMeasure2.getPosTan(fFloatValue, fArr3, null);
            pathMeasure2.getPosTan(fFloatValue, fArr3, null);
            fArr[i] = fArr3[c];
            fArr2[i] = fArr3[1];
            fFloatValue += f2;
            int i3 = i2 + 1;
            if (i3 < arrayList.size() && fFloatValue > ((Float) arrayList.get(i3)).floatValue()) {
                fFloatValue -= ((Float) arrayList.get(i3)).floatValue();
                pathMeasure2.nextContour();
                i2 = i3;
            }
            i++;
            c = 0;
        }
        PropertyValuesHolder propertyValuesHolderOfFloat = str != null ? PropertyValuesHolder.ofFloat(str, fArr) : null;
        PropertyValuesHolder propertyValuesHolderOfFloat2 = str2 != null ? PropertyValuesHolder.ofFloat(str2, fArr2) : null;
        if (propertyValuesHolderOfFloat == null) {
            objectAnimator.setValues(propertyValuesHolderOfFloat2);
        } else {
            objectAnimator.setValues(propertyValuesHolderOfFloat2 == null ? new PropertyValuesHolder[]{propertyValuesHolderOfFloat} : new PropertyValuesHolder[]{propertyValuesHolderOfFloat, propertyValuesHolderOfFloat2});
        }
    }
}
