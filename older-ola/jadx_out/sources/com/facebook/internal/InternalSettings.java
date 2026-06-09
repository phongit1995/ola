package com.facebook.internal;

/* JADX INFO: loaded from: classes.dex */
public class InternalSettings {
    private static volatile String mCustomUserAgent;

    public static String getCustomUserAgent() {
        return mCustomUserAgent;
    }

    public static void setCustomUserAgent(String str) {
        mCustomUserAgent = str;
    }
}
