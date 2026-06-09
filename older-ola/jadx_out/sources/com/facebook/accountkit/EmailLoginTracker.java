package com.facebook.accountkit;

import android.content.Intent;
import com.facebook.accountkit.internal.LoginStatus;
import java.util.Collections;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public abstract class EmailLoginTracker extends Tracker {
    public static final String ACTION_EMAIL_LOGIN_STATE_CHANGED = "com.facebook.accountkit.sdk.ACTION_EMAIL_LOGIN_STATE_CHANGED";

    @Override // com.facebook.accountkit.Tracker
    protected List<String> getActionsStateChanged() {
        return Collections.singletonList(ACTION_EMAIL_LOGIN_STATE_CHANGED);
    }

    protected abstract void onAccountVerified(EmailLoginModel emailLoginModel);

    protected abstract void onCancel(EmailLoginModel emailLoginModel);

    protected abstract void onError(AccountKitException accountKitException);

    @Override // com.facebook.accountkit.Tracker
    protected void onReceive(Intent intent) {
        EmailLoginModel emailLoginModel = (EmailLoginModel) intent.getParcelableExtra(Tracker.EXTRA_LOGIN_MODEL);
        LoginStatus loginStatus = (LoginStatus) intent.getSerializableExtra(Tracker.EXTRA_LOGIN_STATUS);
        if (emailLoginModel == null || loginStatus == null) {
        }
        switch (loginStatus) {
            case PENDING:
                onStarted(emailLoginModel);
                break;
            case ACCOUNT_VERIFIED:
                onAccountVerified(emailLoginModel);
                break;
            case SUCCESS:
                onSuccess(emailLoginModel);
                break;
            case CANCELLED:
                onCancel(emailLoginModel);
                break;
            case ERROR:
                AccountKitError accountKitError = (AccountKitError) intent.getParcelableExtra(Tracker.EXTRA_LOGIN_ERROR);
                if (accountKitError != null) {
                    onError(new AccountKitException(accountKitError));
                }
                break;
        }
    }

    protected abstract void onStarted(EmailLoginModel emailLoginModel);

    protected abstract void onSuccess(EmailLoginModel emailLoginModel);
}
