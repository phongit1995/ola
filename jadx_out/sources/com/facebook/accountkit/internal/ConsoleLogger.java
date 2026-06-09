package com.facebook.accountkit.internal;

import android.support.annotation.NonNull;
import android.util.Log;
import com.facebook.accountkit.AccountKit;
import com.facebook.accountkit.LoggingBehavior;

/* JADX INFO: loaded from: classes.dex */
final class ConsoleLogger {
    private static final String LOG_TAG_BASE = "AccountKitSDK.";
    private static final String NEWLINE = "\n";
    private final LoggingBehavior behavior;
    private StringBuilder contents = new StringBuilder();
    private final String tag;

    ConsoleLogger(LoggingBehavior loggingBehavior, @NonNull String str) {
        this.behavior = loggingBehavior;
        this.tag = LOG_TAG_BASE + str;
    }

    private void append(String str, Object... objArr) {
        if (shouldLog()) {
            this.contents.append(String.format(str, objArr));
        }
    }

    private static void log(LoggingBehavior loggingBehavior, int i, String str, String str2) {
        if (AccountKit.getLoggingBehaviors().isEnabled(loggingBehavior)) {
            if (!str.startsWith(LOG_TAG_BASE)) {
                str = LOG_TAG_BASE + str;
            }
            Log.println(i, str, str2);
            if (loggingBehavior == LoggingBehavior.DEVELOPER_ERRORS) {
                new Exception().printStackTrace();
            }
        }
    }

    public static void log(LoggingBehavior loggingBehavior, int i, String str, String str2, Object... objArr) {
        log(loggingBehavior, i, str, String.format(str2, objArr));
    }

    public static void log(LoggingBehavior loggingBehavior, String str, String str2) {
        log(loggingBehavior, 3, str, str2);
    }

    public static void log(LoggingBehavior loggingBehavior, String str, String str2, Object... objArr) {
        log(loggingBehavior, 3, str, String.format(str2, objArr));
    }

    private boolean shouldLog() {
        return AccountKit.getLoggingBehaviors().isEnabled(this.behavior);
    }

    void appendKeyValue(String str, Object obj) {
        append("  %s:\t%s\n", str, obj);
    }

    void appendLine(String str) {
        if (shouldLog()) {
            StringBuilder sb = this.contents;
            sb.append(str);
            sb.append(NEWLINE);
        }
    }

    public void log() {
        log(this.behavior, 3, this.tag, this.contents.toString());
        this.contents = new StringBuilder();
    }
}
