package com.facebook.accountkit;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

/* JADX INFO: loaded from: classes.dex */
public final class LoggingBehaviorCollection {
    private final HashSet<LoggingBehavior> loggingBehaviors = new HashSet<>(Collections.singleton(LoggingBehavior.DEVELOPER_ERRORS));

    public void add(LoggingBehavior loggingBehavior) {
        synchronized (this.loggingBehaviors) {
            this.loggingBehaviors.add(loggingBehavior);
        }
    }

    public void clear() {
        synchronized (this.loggingBehaviors) {
            this.loggingBehaviors.clear();
        }
    }

    public Set<LoggingBehavior> get() {
        Set<LoggingBehavior> setUnmodifiableSet;
        synchronized (this.loggingBehaviors) {
            setUnmodifiableSet = Collections.unmodifiableSet(new HashSet(this.loggingBehaviors));
        }
        return setUnmodifiableSet;
    }

    public boolean isEnabled(LoggingBehavior loggingBehavior) {
        boolean zContains;
        synchronized (this.loggingBehaviors) {
            zContains = this.loggingBehaviors.contains(loggingBehavior);
        }
        return zContains;
    }

    public void remove(LoggingBehavior loggingBehavior) {
        synchronized (this.loggingBehaviors) {
            this.loggingBehaviors.remove(loggingBehavior);
        }
    }
}
