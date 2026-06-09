package com.facebook.accountkit;

import android.content.Intent;
import com.facebook.accountkit.internal.LoginStatus;
import java.util.Collections;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public abstract class PhoneLoginTracker extends Tracker {
    public static final String ACTION_PHONE_LOGIN_STATE_CHANGED = "com.facebook.accountkit.sdk.ACTION_PHONE_LOGIN_STATE_CHANGED";
    private String code;

    @Override // com.facebook.accountkit.Tracker
    protected List<String> getActionsStateChanged() {
        return Collections.singletonList(ACTION_PHONE_LOGIN_STATE_CHANGED);
    }

    public String getCode() {
        return this.code;
    }

    protected abstract void onAccountVerified(PhoneLoginModel phoneLoginModel);

    protected abstract void onCancel(PhoneLoginModel phoneLoginModel);

    protected abstract void onError(AccountKitException accountKitException);

    @Override // com.facebook.accountkit.Tracker
    protected void onReceive(Intent intent) {
        PhoneLoginModel phoneLoginModel = (PhoneLoginModel) intent.getParcelableExtra(Tracker.EXTRA_LOGIN_MODEL);
        LoginStatus loginStatus = (LoginStatus) intent.getSerializableExtra(Tracker.EXTRA_LOGIN_STATUS);
        if (phoneLoginModel == null || loginStatus == null) {
        }
        switch (loginStatus) {
            case PENDING:
                onStarted(phoneLoginModel);
                break;
            case ACCOUNT_VERIFIED:
                onAccountVerified(phoneLoginModel);
                break;
            case SUCCESS:
                onSuccess(phoneLoginModel);
                break;
            case CANCELLED:
                onCancel(phoneLoginModel);
                break;
            case ERROR:
                AccountKitError accountKitError = (AccountKitError) intent.getParcelableExtra(Tracker.EXTRA_LOGIN_ERROR);
                if (accountKitError != null) {
                    setCode("");
                    onError(new AccountKitException(accountKitError));
                }
                break;
        }
    }

    protected abstract void onStarted(PhoneLoginModel phoneLoginModel);

    protected abstract void onSuccess(PhoneLoginModel phoneLoginModel);

    public void setCode(String str) {
        this.code = str;
    }
}
