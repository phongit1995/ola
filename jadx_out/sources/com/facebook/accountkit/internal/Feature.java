package com.facebook.accountkit.internal;

/* JADX INFO: loaded from: classes.dex */
public enum Feature {
    EMAIL_ENABLED(0, 1),
    PHONE_NUMBER_ENABLED(1, 1),
    CALLBACK_BUTTON_ALTERNATE_TEXT(2, 1);

    private int defaultValue;
    private int prefKey;

    Feature(int i, int i2) {
        this.prefKey = i;
        this.defaultValue = i2;
    }

    int getDefaultValue() {
        return this.defaultValue;
    }

    int getPrefKey() {
        return this.prefKey;
    }
}
