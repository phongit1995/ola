package com.google.android.gms.internal.ads;

import android.webkit.ConsoleMessage;

/* JADX INFO: loaded from: classes.dex */
final /* synthetic */ class zzaqv {
    static final /* synthetic */ int[] zzdbn = new int[ConsoleMessage.MessageLevel.values().length];

    static {
        try {
            zzdbn[ConsoleMessage.MessageLevel.ERROR.ordinal()] = 1;
        } catch (NoSuchFieldError unused) {
        }
        try {
            zzdbn[ConsoleMessage.MessageLevel.WARNING.ordinal()] = 2;
        } catch (NoSuchFieldError unused2) {
        }
        try {
            zzdbn[ConsoleMessage.MessageLevel.LOG.ordinal()] = 3;
        } catch (NoSuchFieldError unused3) {
        }
        try {
            zzdbn[ConsoleMessage.MessageLevel.TIP.ordinal()] = 4;
        } catch (NoSuchFieldError unused4) {
        }
        try {
            zzdbn[ConsoleMessage.MessageLevel.DEBUG.ordinal()] = 5;
        } catch (NoSuchFieldError unused5) {
        }
    }
}
