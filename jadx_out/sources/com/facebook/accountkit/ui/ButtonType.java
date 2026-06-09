package com.facebook.accountkit.ui;

import com.facebook.accountkit.R;

/* JADX INFO: loaded from: classes.dex */
public enum ButtonType {
    BEGIN(R.string.com_accountkit_button_begin),
    CONFIRM(R.string.com_accountkit_button_confirm),
    CONTINUE(R.string.com_accountkit_button_continue),
    LOG_IN(R.string.com_accountkit_button_log_in),
    NEXT(R.string.com_accountkit_button_next),
    OK(R.string.com_accountkit_button_ok),
    SEND(R.string.com_accountkit_button_send),
    START(R.string.com_accountkit_button_start),
    SUBMIT(R.string.com_accountkit_button_submit);

    private final int value;

    ButtonType(int i) {
        this.value = i;
    }

    public int getValue() {
        return this.value;
    }
}
