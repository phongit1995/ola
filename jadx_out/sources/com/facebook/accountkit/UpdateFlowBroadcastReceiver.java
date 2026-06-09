package com.facebook.accountkit;

import android.content.BroadcastReceiver;
import android.content.IntentFilter;

/* JADX INFO: loaded from: classes.dex */
public abstract class UpdateFlowBroadcastReceiver extends BroadcastReceiver {
    private static final String TAG = "UpdateFlowBroadcastReceiver";
    public static final String ACTION_UPDATE = TAG + ".action_update";
    public static final String EXTRA_EVENT = TAG + ".extra_event";
    public static final String EXTRA_PHONE_NUMBER = TAG + ".extra_phoneNumber";
    public static final String EXTRA_ERROR_MESSAGE = TAG + ".extra_error_message";
    public static final String EXTRA_CONFIRMATION_CODE = TAG + ".extra_confirmationCode";
    public static final String EXTRA_UPDATE_STATE = TAG + ".extra_updateState";

    public enum Event {
        UPDATE_START,
        SENT_CODE,
        SENT_CODE_COMPLETE,
        ERROR_UPDATE,
        ERROR_CONFIRMATION_CODE,
        RETRY_CONFIRMATION_CODE,
        CONFIRMATION_CODE_COMPLETE,
        ACCOUNT_UPDATE_COMPLETE,
        RETRY
    }

    public static IntentFilter getIntentFilter() {
        return new IntentFilter(ACTION_UPDATE);
    }
}
