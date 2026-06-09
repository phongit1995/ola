package com.google.android.gms.flags.impl.util;

import android.os.StrictMode;
import java.util.concurrent.Callable;

/* JADX INFO: loaded from: classes.dex */
public class StrictModeUtil {
    public static <T> T runWithLaxStrictMode(Callable<T> callable) {
        StrictMode.ThreadPolicy threadPolicy = StrictMode.getThreadPolicy();
        try {
            StrictMode.setThreadPolicy(StrictMode.ThreadPolicy.LAX);
            return callable.call();
        } finally {
            StrictMode.setThreadPolicy(threadPolicy);
        }
    }
}
