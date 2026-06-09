package com.google.android.gms.internal.firebase_auth;

import android.support.v7.widget.helper.ItemTouchHelper;
import java.lang.reflect.Array;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

/* JADX INFO: loaded from: classes2.dex */
public final class zzgu {
    private static void zza(String str, Object obj, StringBuffer stringBuffer, StringBuffer stringBuffer2) throws IllegalAccessException {
        String str2;
        if (obj != null) {
            if (obj instanceof zzgt) {
                int length = stringBuffer.length();
                if (str != null) {
                    stringBuffer2.append(stringBuffer);
                    stringBuffer2.append(zzar(str));
                    stringBuffer2.append(" <\n");
                    stringBuffer.append("  ");
                }
                Class<?> cls = obj.getClass();
                for (Field field : cls.getFields()) {
                    int modifiers = field.getModifiers();
                    String name = field.getName();
                    if (!"cachedSize".equals(name) && (modifiers & 1) == 1 && (modifiers & 8) != 8 && !name.startsWith("_") && !name.endsWith("_")) {
                        Class<?> type = field.getType();
                        Object obj2 = field.get(obj);
                        if (!type.isArray() || type.getComponentType() == Byte.TYPE) {
                            zza(name, obj2, stringBuffer, stringBuffer2);
                        } else {
                            int length2 = obj2 == null ? 0 : Array.getLength(obj2);
                            for (int i = 0; i < length2; i++) {
                                zza(name, Array.get(obj2, i), stringBuffer, stringBuffer2);
                            }
                        }
                    }
                }
                for (Method method : cls.getMethods()) {
                    String name2 = method.getName();
                    if (name2.startsWith("set")) {
                        String strSubstring = name2.substring(3);
                        try {
                            String strValueOf = String.valueOf(strSubstring);
                            if (((Boolean) cls.getMethod(strValueOf.length() != 0 ? "has".concat(strValueOf) : new String("has"), new Class[0]).invoke(obj, new Object[0])).booleanValue()) {
                                String strValueOf2 = String.valueOf(strSubstring);
                                zza(strSubstring, cls.getMethod(strValueOf2.length() != 0 ? "get".concat(strValueOf2) : new String("get"), new Class[0]).invoke(obj, new Object[0]), stringBuffer, stringBuffer2);
                            }
                        } catch (NoSuchMethodException unused) {
                        }
                    }
                }
                if (str != null) {
                    stringBuffer.setLength(length);
                    stringBuffer2.append(stringBuffer);
                    stringBuffer2.append(">\n");
                    return;
                }
                return;
            }
            String strZzar = zzar(str);
            stringBuffer2.append(stringBuffer);
            stringBuffer2.append(strZzar);
            stringBuffer2.append(": ");
            if (!(obj instanceof String)) {
                if (obj instanceof byte[]) {
                    byte[] bArr = (byte[]) obj;
                    if (bArr == null) {
                        str2 = "\"\"";
                    } else {
                        stringBuffer2.append('\"');
                        for (byte b : bArr) {
                            int i2 = b & 255;
                            if (i2 == 92 || i2 == 34) {
                                stringBuffer2.append('\\');
                            } else {
                                if (i2 < 32 || i2 >= 127) {
                                    stringBuffer2.append(String.format("\\%03o", Integer.valueOf(i2)));
                                }
                            }
                            stringBuffer2.append((char) i2);
                        }
                        stringBuffer2.append('\"');
                    }
                } else {
                    stringBuffer2.append(obj);
                }
                stringBuffer2.append("\n");
            }
            String strConcat = (String) obj;
            if (!strConcat.startsWith("http") && strConcat.length() > 200) {
                strConcat = String.valueOf(strConcat.substring(0, ItemTouchHelper.Callback.DEFAULT_DRAG_ANIMATION_DURATION)).concat("[...]");
            }
            int length3 = strConcat.length();
            StringBuilder sb = new StringBuilder(length3);
            for (int i3 = 0; i3 < length3; i3++) {
                char cCharAt = strConcat.charAt(i3);
                if (cCharAt < ' ' || cCharAt > '~' || cCharAt == '\"' || cCharAt == '\'') {
                    sb.append(String.format("\\u%04x", Integer.valueOf(cCharAt)));
                } else {
                    sb.append(cCharAt);
                }
            }
            String string = sb.toString();
            stringBuffer2.append("\"");
            stringBuffer2.append(string);
            str2 = "\"";
            stringBuffer2.append(str2);
            stringBuffer2.append("\n");
        }
    }

    private static String zzar(String str) {
        StringBuffer stringBuffer = new StringBuffer();
        for (int i = 0; i < str.length(); i++) {
            char cCharAt = str.charAt(i);
            if (i == 0) {
                cCharAt = Character.toLowerCase(cCharAt);
            } else if (Character.isUpperCase(cCharAt)) {
                stringBuffer.append('_');
                cCharAt = Character.toLowerCase(cCharAt);
            }
            stringBuffer.append(cCharAt);
        }
        return stringBuffer.toString();
    }

    public static <T extends zzgt> String zzc(T t) {
        if (t == null) {
            return "";
        }
        StringBuffer stringBuffer = new StringBuffer();
        try {
            zza(null, t, new StringBuffer(), stringBuffer);
            return stringBuffer.toString();
        } catch (IllegalAccessException e) {
            String strValueOf = String.valueOf(e.getMessage());
            return strValueOf.length() != 0 ? "Error printing proto: ".concat(strValueOf) : new String("Error printing proto: ");
        } catch (InvocationTargetException e2) {
            String strValueOf2 = String.valueOf(e2.getMessage());
            return strValueOf2.length() != 0 ? "Error printing proto: ".concat(strValueOf2) : new String("Error printing proto: ");
        }
    }
}
