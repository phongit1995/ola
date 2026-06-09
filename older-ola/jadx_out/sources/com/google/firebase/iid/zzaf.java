package com.google.firebase.iid;

/* JADX INFO: loaded from: classes2.dex */
public final class zzaf extends Exception {
    private final int errorCode;

    public zzaf(int i, String str) {
        super(str);
        this.errorCode = i;
    }

    public final int getErrorCode() {
        return this.errorCode;
    }
}
