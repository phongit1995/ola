package com.mg.ola.common.d;

import android.annotation.SuppressLint;
import android.text.SpannableString;
import android.text.SpannableStringBuilder;
import android.text.style.StyleSpan;
import com.facebook.appevents.AppEventsConstants;
import java.util.Calendar;
import java.util.Locale;

/* JADX INFO: loaded from: classes2.dex */
@SuppressLint({"SimpleDateFormat"})
public class i {
    public static CharSequence a(CharSequence charSequence) {
        if (charSequence == null) {
            return "";
        }
        SpannableString spannableString = new SpannableString(charSequence.toString().toUpperCase(Locale.US) + " ");
        spannableString.setSpan(new StyleSpan(1), 0, spannableString.length(), 33);
        return spannableString;
    }

    private static CharSequence a(String[] strArr, int i) {
        switch (i) {
            case 1:
                return strArr[7];
            case 2:
                return strArr[1];
            case 3:
                return strArr[2];
            case 4:
                return strArr[3];
            case 5:
                return strArr[4];
            case 6:
                return strArr[5];
            case 7:
                return strArr[6];
            default:
                return "";
        }
    }

    private static String a(int i) {
        Object objValueOf;
        StringBuilder sb = new StringBuilder();
        if (i < 10) {
            objValueOf = AppEventsConstants.EVENT_PARAM_VALUE_NO + i;
        } else {
            objValueOf = Integer.valueOf(i);
        }
        sb.append(objValueOf);
        sb.append("");
        return sb.toString();
    }

    public static String a(long j) {
        StringBuilder sb;
        String str;
        StringBuilder sb2;
        String str2;
        StringBuilder sb3;
        String str3;
        StringBuilder sb4;
        String str4;
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(j);
        int i = calendar.get(1);
        int i2 = calendar.get(2) + 1;
        int i3 = calendar.get(5);
        int i4 = calendar.get(11);
        int i5 = calendar.get(12);
        if (i4 < 10) {
            sb = new StringBuilder();
            sb.append("");
            str = AppEventsConstants.EVENT_PARAM_VALUE_NO;
        } else {
            sb = new StringBuilder();
            sb.append("");
            str = "";
        }
        sb.append(str);
        sb.append(i4);
        String string = sb.toString();
        if (i5 < 10) {
            sb2 = new StringBuilder();
            sb2.append(string);
            str2 = ":0";
        } else {
            sb2 = new StringBuilder();
            sb2.append(string);
            str2 = ":";
        }
        sb2.append(str2);
        sb2.append(i5);
        String string2 = sb2.toString();
        if (i3 < 10) {
            sb3 = new StringBuilder();
            sb3.append(string2);
            str3 = "  0";
        } else {
            sb3 = new StringBuilder();
            sb3.append(string2);
            str3 = "  ";
        }
        sb3.append(str3);
        sb3.append(i3);
        String string3 = sb3.toString();
        if (i2 < 10) {
            sb4 = new StringBuilder();
            sb4.append(string3);
            str4 = "/0";
        } else {
            sb4 = new StringBuilder();
            sb4.append(string3);
            str4 = "/";
        }
        sb4.append(str4);
        sb4.append(i2);
        return sb4.toString() + "/" + i;
    }

    @SuppressLint({"NewApi"})
    public static String a(long j, String str, String str2) {
        String str3;
        StringBuilder sb;
        if (j < 0) {
            return "0:0:0";
        }
        int i = (int) (j / 60);
        int i2 = i / 60;
        int i3 = i % 60;
        int i4 = (int) (j % 60);
        String str4 = i2 + "";
        String str5 = i3 + "";
        String str6 = i4 + "";
        if (i2 <= 0) {
            str3 = "";
        } else {
            str3 = i2 + "" + str;
        }
        if (i3 < 10) {
            sb = new StringBuilder();
            sb.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
        } else {
            sb = new StringBuilder();
        }
        sb.append(i3);
        sb.append(str2);
        String string = sb.toString();
        if (i4 < 10) {
            str6 = AppEventsConstants.EVENT_PARAM_VALUE_NO + i4;
        }
        return str3 + string + str6;
    }

    public static String a(long j, String[] strArr, String[] strArr2) {
        long jAbs = Math.abs(j) / 1000;
        if (jAbs <= 60) {
            return jAbs > 1 ? strArr2[0] : strArr[0];
        }
        long j2 = jAbs / 60;
        if (j2 < 60) {
            if (j2 > 1) {
                return j2 + " " + strArr2[2];
            }
            return j2 + " " + strArr[2];
        }
        long j3 = j2 / 60;
        if (j3 < 24) {
            if (j3 > 1) {
                return j3 + " " + strArr2[3];
            }
            return j3 + " " + strArr[3];
        }
        long j4 = j3 / 24;
        if (j4 < 7) {
            if (j4 > 1) {
                return j4 + " " + strArr2[4];
            }
            return j4 + " " + strArr[4];
        }
        if (j4 < 30) {
            long j5 = j4 / 7;
            if (j5 > 1) {
                return j5 + " " + strArr2[5];
            }
            return j5 + " " + strArr[5];
        }
        if (j4 < 365) {
            if (j4 > 1) {
                return (j4 / 30) + " " + strArr2[6];
            }
            return (j4 / 30) + " " + strArr[6];
        }
        long j6 = j4 / 365;
        if (j6 > 1) {
            return j6 + " " + strArr2[7];
        }
        return j6 + " " + strArr[7];
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    public static String a(long j, String[] strArr, String[] strArr2, String[] strArr3) {
        int i;
        Object objValueOf;
        StringBuilder sb;
        StringBuilder sb2;
        Object objValueOf2;
        int i2;
        StringBuilder sb3;
        String str;
        Object objValueOf3;
        StringBuilder sb4;
        String str2;
        Calendar calendar = Calendar.getInstance();
        long jCurrentTimeMillis = System.currentTimeMillis();
        calendar.setTimeInMillis(jCurrentTimeMillis);
        int i3 = calendar.get(7);
        int i4 = calendar.get(5);
        int i5 = calendar.get(1);
        int i6 = calendar.get(3);
        calendar.setTimeInMillis(jCurrentTimeMillis - j);
        int i7 = calendar.get(11);
        int i8 = calendar.get(12);
        int i9 = calendar.get(7);
        int i10 = calendar.get(5);
        int i11 = calendar.get(2) + 1;
        int i12 = calendar.get(1);
        int i13 = calendar.get(3);
        StringBuilder sb5 = new StringBuilder();
        if (i7 < 10) {
            StringBuilder sb6 = new StringBuilder();
            i = i11;
            sb6.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
            sb6.append(i7);
            objValueOf = sb6.toString();
        } else {
            i = i11;
            objValueOf = Integer.valueOf(i7);
        }
        sb5.append(objValueOf);
        sb5.append(":");
        sb5.append(i8 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i8 : Integer.valueOf(i8));
        sb5.append(" ");
        String string = sb5.toString();
        if (i12 != i5) {
            int i14 = i;
            switch (i9) {
                case 1:
                    sb = new StringBuilder();
                    sb.append(string);
                    sb.append(strArr[6]);
                    sb.append(" ");
                    sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                    sb.append("/");
                    if (i14 < 10) {
                        sb2 = new StringBuilder();
                        sb2.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                        sb2.append(i14);
                        objValueOf2 = sb2.toString();
                        sb.append(objValueOf2);
                        sb.append("/");
                        sb.append(i12);
                    }
                    objValueOf2 = Integer.valueOf(i14);
                    sb.append(objValueOf2);
                    sb.append("/");
                    sb.append(i12);
                    break;
                case 2:
                    sb = new StringBuilder();
                    sb.append(string);
                    sb.append(strArr[0]);
                    sb.append(" ");
                    sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                    sb.append("/");
                    if (i14 < 10) {
                        sb2 = new StringBuilder();
                        sb2.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                        sb2.append(i14);
                        objValueOf2 = sb2.toString();
                        sb.append(objValueOf2);
                        sb.append("/");
                        sb.append(i12);
                    }
                    objValueOf2 = Integer.valueOf(i14);
                    sb.append(objValueOf2);
                    sb.append("/");
                    sb.append(i12);
                    break;
                case 3:
                    sb = new StringBuilder();
                    sb.append(string);
                    sb.append(strArr[1]);
                    sb.append(" ");
                    sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                    sb.append("/");
                    if (i14 < 10) {
                        sb2 = new StringBuilder();
                        sb2.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                        sb2.append(i14);
                        objValueOf2 = sb2.toString();
                        sb.append(objValueOf2);
                        sb.append("/");
                        sb.append(i12);
                    }
                    objValueOf2 = Integer.valueOf(i14);
                    sb.append(objValueOf2);
                    sb.append("/");
                    sb.append(i12);
                    break;
                case 4:
                    sb = new StringBuilder();
                    sb.append(string);
                    sb.append(strArr[2]);
                    sb.append(" ");
                    sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                    sb.append("/");
                    if (i14 < 10) {
                        sb2 = new StringBuilder();
                        sb2.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                        sb2.append(i14);
                        objValueOf2 = sb2.toString();
                        sb.append(objValueOf2);
                        sb.append("/");
                        sb.append(i12);
                    }
                    objValueOf2 = Integer.valueOf(i14);
                    sb.append(objValueOf2);
                    sb.append("/");
                    sb.append(i12);
                    break;
                case 5:
                    sb = new StringBuilder();
                    sb.append(string);
                    sb.append(strArr[3]);
                    sb.append(" ");
                    sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                    sb.append("/");
                    if (i14 < 10) {
                        sb2 = new StringBuilder();
                        sb2.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                        sb2.append(i14);
                        objValueOf2 = sb2.toString();
                        sb.append(objValueOf2);
                        sb.append("/");
                        sb.append(i12);
                    }
                    objValueOf2 = Integer.valueOf(i14);
                    sb.append(objValueOf2);
                    sb.append("/");
                    sb.append(i12);
                    break;
                case 6:
                    sb = new StringBuilder();
                    sb.append(string);
                    sb.append(strArr[4]);
                    sb.append(" ");
                    sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                    sb.append("/");
                    if (i14 < 10) {
                        sb2 = new StringBuilder();
                        sb2.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                        sb2.append(i14);
                        objValueOf2 = sb2.toString();
                        sb.append(objValueOf2);
                        sb.append("/");
                        sb.append(i12);
                    }
                    objValueOf2 = Integer.valueOf(i14);
                    sb.append(objValueOf2);
                    sb.append("/");
                    sb.append(i12);
                    break;
                case 7:
                    sb = new StringBuilder();
                    sb.append(string);
                    sb.append(strArr[5]);
                    sb.append(" ");
                    sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                    sb.append("/");
                    if (i14 < 10) {
                        sb2 = new StringBuilder();
                        sb2.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                        sb2.append(i14);
                        objValueOf2 = sb2.toString();
                        sb.append(objValueOf2);
                        sb.append("/");
                        sb.append(i12);
                    }
                    objValueOf2 = Integer.valueOf(i14);
                    sb.append(objValueOf2);
                    sb.append("/");
                    sb.append(i12);
                    break;
                default:
                    return string;
            }
        } else if (i13 == i6) {
            if (i10 == i4) {
                long jAbs = Math.abs(j) / 1000;
                if (jAbs <= 60) {
                    return strArr2[0];
                }
                long j2 = jAbs / 60;
                if (j2 >= 60) {
                    long j3 = j2 / 60;
                    if (j3 >= 7) {
                        sb = new StringBuilder();
                        sb.append(string);
                        str = strArr[7];
                    } else if (j3 > 1) {
                        sb4 = new StringBuilder();
                        sb4.append(j3);
                        sb4.append(" ");
                        str2 = strArr3[3];
                    } else {
                        sb4 = new StringBuilder();
                        sb4.append(j3);
                        sb4.append(" ");
                        str2 = strArr2[3];
                    }
                } else if (j2 > 1) {
                    sb4 = new StringBuilder();
                    sb4.append(j2);
                    sb4.append(" ");
                    str2 = strArr3[2];
                } else {
                    sb4 = new StringBuilder();
                    sb4.append(j2);
                    sb4.append(" ");
                    str2 = strArr2[2];
                }
                sb4.append(str2);
                return sb4.toString();
            }
            int i15 = i4 - i10;
            if (i15 > 2) {
                switch (i9) {
                    case 1:
                        sb = new StringBuilder();
                        sb.append(string);
                        str = strArr[6];
                        break;
                    case 2:
                        sb = new StringBuilder();
                        sb.append(string);
                        str = strArr[0];
                        break;
                    case 3:
                        sb = new StringBuilder();
                        sb.append(string);
                        str = strArr[1];
                        break;
                    case 4:
                        sb = new StringBuilder();
                        sb.append(string);
                        str = strArr[2];
                        break;
                    case 5:
                        sb = new StringBuilder();
                        sb.append(string);
                        str = strArr[3];
                        break;
                    case 6:
                        sb = new StringBuilder();
                        sb.append(string);
                        str = strArr[4];
                        break;
                    case 7:
                        sb = new StringBuilder();
                        sb.append(string);
                        str = strArr[5];
                        break;
                    default:
                        return string;
                }
            } else if (i15 > 1) {
                sb = new StringBuilder();
                sb.append(string);
                str = strArr[9];
            } else if (i15 > 0) {
                sb = new StringBuilder();
                sb.append(string);
                str = strArr[8];
            } else {
                switch (i9) {
                    case 1:
                        i2 = i;
                        sb = new StringBuilder();
                        sb.append(string);
                        sb.append(strArr[6]);
                        sb.append(" ");
                        sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                        sb.append("/");
                        if (i2 < 10) {
                            sb3 = new StringBuilder();
                            sb3.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                            sb3.append(i2);
                            objValueOf3 = sb3.toString();
                            sb.append(objValueOf3);
                        }
                        objValueOf3 = Integer.valueOf(i2);
                        sb.append(objValueOf3);
                        break;
                    case 2:
                        i2 = i;
                        sb = new StringBuilder();
                        sb.append(string);
                        sb.append(strArr[0]);
                        sb.append(" ");
                        sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                        sb.append("/");
                        if (i2 < 10) {
                            sb3 = new StringBuilder();
                            sb3.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                            sb3.append(i2);
                            objValueOf3 = sb3.toString();
                            sb.append(objValueOf3);
                        }
                        objValueOf3 = Integer.valueOf(i2);
                        sb.append(objValueOf3);
                        break;
                    case 3:
                        i2 = i;
                        sb = new StringBuilder();
                        sb.append(string);
                        sb.append(strArr[1]);
                        sb.append(" ");
                        sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                        sb.append("/");
                        if (i2 < 10) {
                            sb3 = new StringBuilder();
                            sb3.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                            sb3.append(i2);
                            objValueOf3 = sb3.toString();
                            sb.append(objValueOf3);
                        }
                        objValueOf3 = Integer.valueOf(i2);
                        sb.append(objValueOf3);
                        break;
                    case 4:
                        i2 = i;
                        sb = new StringBuilder();
                        sb.append(string);
                        sb.append(strArr[2]);
                        sb.append(" ");
                        sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                        sb.append("/");
                        if (i2 < 10) {
                            sb3 = new StringBuilder();
                            sb3.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                            sb3.append(i2);
                            objValueOf3 = sb3.toString();
                            sb.append(objValueOf3);
                        }
                        objValueOf3 = Integer.valueOf(i2);
                        sb.append(objValueOf3);
                        break;
                    case 5:
                        i2 = i;
                        sb = new StringBuilder();
                        sb.append(string);
                        sb.append(strArr[3]);
                        sb.append(" ");
                        sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                        sb.append("/");
                        if (i2 < 10) {
                            sb3 = new StringBuilder();
                            sb3.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                            sb3.append(i2);
                            objValueOf3 = sb3.toString();
                            sb.append(objValueOf3);
                        }
                        objValueOf3 = Integer.valueOf(i2);
                        sb.append(objValueOf3);
                        break;
                    case 6:
                        i2 = i;
                        sb = new StringBuilder();
                        sb.append(string);
                        sb.append(strArr[4]);
                        sb.append(" ");
                        sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                        sb.append("/");
                        if (i2 < 10) {
                            sb3 = new StringBuilder();
                            sb3.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                            sb3.append(i2);
                            objValueOf3 = sb3.toString();
                            sb.append(objValueOf3);
                        }
                        objValueOf3 = Integer.valueOf(i2);
                        sb.append(objValueOf3);
                        break;
                    case 7:
                        sb = new StringBuilder();
                        sb.append(string);
                        sb.append(strArr[5]);
                        sb.append(" ");
                        sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                        sb.append("/");
                        i2 = i;
                        if (i2 < 10) {
                            sb3 = new StringBuilder();
                            sb3.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                            sb3.append(i2);
                            objValueOf3 = sb3.toString();
                            sb.append(objValueOf3);
                        }
                        objValueOf3 = Integer.valueOf(i2);
                        sb.append(objValueOf3);
                        break;
                    default:
                        return string;
                }
            }
            sb.append(str);
        } else {
            i2 = i;
            if (i6 - 1 == i13) {
                int i16 = (i3 + 7) - i9;
                if (i16 == 1) {
                    sb = new StringBuilder();
                    sb.append(string);
                    str = strArr[8];
                } else if (i16 == 2) {
                    sb = new StringBuilder();
                    sb.append(string);
                    str = strArr[9];
                } else {
                    switch (i9) {
                        case 1:
                            sb = new StringBuilder();
                            sb.append(string);
                            sb.append(strArr[6]);
                            sb.append(" ");
                            sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                            sb.append("/");
                            if (i2 < 10) {
                                sb3 = new StringBuilder();
                                sb3.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                                sb3.append(i2);
                                objValueOf3 = sb3.toString();
                            }
                            objValueOf3 = Integer.valueOf(i2);
                            break;
                        case 2:
                            sb = new StringBuilder();
                            sb.append(string);
                            sb.append(strArr[0]);
                            sb.append(" ");
                            sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                            sb.append("/");
                            if (i2 < 10) {
                                sb3 = new StringBuilder();
                                sb3.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                                sb3.append(i2);
                                objValueOf3 = sb3.toString();
                            }
                            objValueOf3 = Integer.valueOf(i2);
                            break;
                        case 3:
                            sb = new StringBuilder();
                            sb.append(string);
                            sb.append(strArr[1]);
                            sb.append(" ");
                            sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                            sb.append("/");
                            if (i2 < 10) {
                                sb3 = new StringBuilder();
                                sb3.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                                sb3.append(i2);
                                objValueOf3 = sb3.toString();
                            }
                            objValueOf3 = Integer.valueOf(i2);
                            break;
                        case 4:
                            sb = new StringBuilder();
                            sb.append(string);
                            sb.append(strArr[2]);
                            sb.append(" ");
                            sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                            sb.append("/");
                            if (i2 < 10) {
                                sb3 = new StringBuilder();
                                sb3.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                                sb3.append(i2);
                                objValueOf3 = sb3.toString();
                            }
                            objValueOf3 = Integer.valueOf(i2);
                            break;
                        case 5:
                            sb = new StringBuilder();
                            sb.append(string);
                            sb.append(strArr[3]);
                            sb.append(" ");
                            sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                            sb.append("/");
                            if (i2 < 10) {
                                sb3 = new StringBuilder();
                                sb3.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                                sb3.append(i2);
                                objValueOf3 = sb3.toString();
                            }
                            objValueOf3 = Integer.valueOf(i2);
                            break;
                        case 6:
                            sb = new StringBuilder();
                            sb.append(string);
                            sb.append(strArr[4]);
                            sb.append(" ");
                            sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                            sb.append("/");
                            if (i2 < 10) {
                                sb3 = new StringBuilder();
                                sb3.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                                sb3.append(i2);
                                objValueOf3 = sb3.toString();
                            }
                            objValueOf3 = Integer.valueOf(i2);
                            break;
                        case 7:
                            sb = new StringBuilder();
                            sb.append(string);
                            sb.append(strArr[5]);
                            sb.append(" ");
                            sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                            sb.append("/");
                            if (i2 < 10) {
                                sb3 = new StringBuilder();
                                sb3.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                                sb3.append(i2);
                                objValueOf3 = sb3.toString();
                            }
                            objValueOf3 = Integer.valueOf(i2);
                            break;
                        default:
                            return string;
                    }
                }
                sb.append(str);
            } else {
                switch (i9) {
                    case 1:
                        sb = new StringBuilder();
                        sb.append(string);
                        sb.append(strArr[6]);
                        sb.append(" ");
                        sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                        sb.append("/");
                        if (i2 < 10) {
                            sb3 = new StringBuilder();
                            sb3.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                            sb3.append(i2);
                            objValueOf3 = sb3.toString();
                        }
                        objValueOf3 = Integer.valueOf(i2);
                        break;
                    case 2:
                        sb = new StringBuilder();
                        sb.append(string);
                        sb.append(strArr[0]);
                        sb.append(" ");
                        sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                        sb.append("/");
                        if (i2 < 10) {
                            sb3 = new StringBuilder();
                            sb3.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                            sb3.append(i2);
                            objValueOf3 = sb3.toString();
                        }
                        objValueOf3 = Integer.valueOf(i2);
                        break;
                    case 3:
                        sb = new StringBuilder();
                        sb.append(string);
                        sb.append(strArr[1]);
                        sb.append(" ");
                        sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                        sb.append("/");
                        if (i2 < 10) {
                            sb3 = new StringBuilder();
                            sb3.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                            sb3.append(i2);
                            objValueOf3 = sb3.toString();
                        }
                        objValueOf3 = Integer.valueOf(i2);
                        break;
                    case 4:
                        sb = new StringBuilder();
                        sb.append(string);
                        sb.append(strArr[2]);
                        sb.append(" ");
                        sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                        sb.append("/");
                        if (i2 < 10) {
                            sb3 = new StringBuilder();
                            sb3.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                            sb3.append(i2);
                            objValueOf3 = sb3.toString();
                        }
                        objValueOf3 = Integer.valueOf(i2);
                        break;
                    case 5:
                        sb = new StringBuilder();
                        sb.append(string);
                        sb.append(strArr[3]);
                        sb.append(" ");
                        sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                        sb.append("/");
                        if (i2 < 10) {
                            sb3 = new StringBuilder();
                            sb3.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                            sb3.append(i2);
                            objValueOf3 = sb3.toString();
                        }
                        objValueOf3 = Integer.valueOf(i2);
                        break;
                    case 6:
                        sb = new StringBuilder();
                        sb.append(string);
                        sb.append(strArr[4]);
                        sb.append(" ");
                        sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                        sb.append("/");
                        if (i2 < 10) {
                            sb3 = new StringBuilder();
                            sb3.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                            sb3.append(i2);
                            objValueOf3 = sb3.toString();
                        }
                        objValueOf3 = Integer.valueOf(i2);
                        break;
                    case 7:
                        sb = new StringBuilder();
                        sb.append(string);
                        sb.append(strArr[5]);
                        sb.append(" ");
                        sb.append(i10 < 10 ? AppEventsConstants.EVENT_PARAM_VALUE_NO + i10 : Integer.valueOf(i10));
                        sb.append("/");
                        if (i2 < 10) {
                            sb3 = new StringBuilder();
                            sb3.append(AppEventsConstants.EVENT_PARAM_VALUE_NO);
                            sb3.append(i2);
                            objValueOf3 = sb3.toString();
                        }
                        objValueOf3 = Integer.valueOf(i2);
                        break;
                    default:
                        return string;
                }
            }
            sb.append(objValueOf3);
        }
        return sb.toString();
    }

    public static CharSequence b(long j, String[] strArr, String[] strArr2) {
        StringBuilder sb;
        CharSequence string;
        CharSequence charSequenceA;
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(System.currentTimeMillis());
        int i = calendar.get(5);
        int i2 = calendar.get(1);
        int i3 = calendar.get(7);
        int i4 = calendar.get(3);
        calendar.setTimeInMillis(j);
        int i5 = calendar.get(7);
        int i6 = calendar.get(5);
        int i7 = calendar.get(2) + 1;
        int i8 = calendar.get(1);
        int i9 = calendar.get(3);
        SpannableStringBuilder spannableStringBuilder = new SpannableStringBuilder();
        if (i8 == i2) {
            if (i9 != i4) {
                int i10 = (i3 + 7) - i5;
                if (i10 == 1) {
                    charSequenceA = strArr[8];
                } else {
                    if (i10 != 2) {
                        spannableStringBuilder.append(a(a(strArr, i5)));
                        spannableStringBuilder.append((CharSequence) a(i6));
                        spannableStringBuilder.append((CharSequence) "/");
                        string = a(i7);
                        spannableStringBuilder.append(string);
                        return spannableStringBuilder;
                    }
                    charSequenceA = strArr[9];
                }
            } else if (i6 == i) {
                charSequenceA = strArr[7];
            } else {
                int i11 = i - i6;
                if (i11 > 2) {
                    charSequenceA = a(strArr, i5);
                } else if (i11 > 1) {
                    charSequenceA = strArr[9];
                } else if (i11 > 0) {
                    charSequenceA = strArr[8];
                } else {
                    spannableStringBuilder.append((CharSequence) a(i6));
                    spannableStringBuilder.append((CharSequence) "/");
                    spannableStringBuilder.append((CharSequence) a(i7));
                    spannableStringBuilder.append((CharSequence) "/");
                    sb = new StringBuilder();
                }
            }
            string = a(charSequenceA);
            spannableStringBuilder.append(string);
            return spannableStringBuilder;
        }
        spannableStringBuilder.append(a(a(strArr, i5)));
        spannableStringBuilder.append((CharSequence) a(i6));
        spannableStringBuilder.append((CharSequence) "/");
        spannableStringBuilder.append((CharSequence) a(i7));
        spannableStringBuilder.append((CharSequence) "/");
        sb = new StringBuilder();
        sb.append(i8);
        sb.append("");
        string = sb.toString();
        spannableStringBuilder.append(string);
        return spannableStringBuilder;
    }
}
