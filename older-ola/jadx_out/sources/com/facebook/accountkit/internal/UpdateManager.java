package com.facebook.accountkit.internal;

import android.app.Activity;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.content.LocalBroadcastManager;
import com.facebook.accountkit.AccountKit;
import com.facebook.accountkit.AccountKitException;
import com.facebook.accountkit.PhoneNumber;

/* JADX INFO: loaded from: classes.dex */
final class UpdateManager {
    private static final String SAVED_UPDATE_MODEL = "accountkitUpdateModel";

    @Nullable
    private volatile Activity currentActivity;

    @Nullable
    private volatile PhoneUpdateController currentPhoneUpdateController;
    private volatile boolean isActivityAvailable = false;
    private final LocalBroadcastManager localBroadcastManager;
    private final InternalLogger logger;

    UpdateManager(InternalLogger internalLogger, LocalBroadcastManager localBroadcastManager) {
        this.logger = internalLogger;
        this.localBroadcastManager = localBroadcastManager;
    }

    private void continueWith(PhoneUpdateModelImpl phoneUpdateModelImpl) {
        Utility.assertUIThread();
        this.currentPhoneUpdateController = new PhoneUpdateController(this, phoneUpdateModelImpl);
        handle(phoneUpdateModelImpl);
    }

    @Nullable
    private PhoneUpdateModelImpl getCurrentUpdateModel() {
        if (this.currentPhoneUpdateController == null) {
            return null;
        }
        return this.currentPhoneUpdateController.getUpdateModel();
    }

    private void handle(PhoneUpdateModelImpl phoneUpdateModelImpl) {
        Utility.assertUIThread();
        if (this.currentPhoneUpdateController == null) {
        }
        switch (phoneUpdateModelImpl.getStatus()) {
            case PENDING:
                this.currentPhoneUpdateController.onPending();
                break;
            case CANCELLED:
                this.currentPhoneUpdateController.onCancel();
                break;
            case ERROR:
                this.currentPhoneUpdateController.onError(phoneUpdateModelImpl.getError());
                break;
        }
    }

    void cancelExisting() {
        if (this.currentPhoneUpdateController != null) {
            this.currentPhoneUpdateController.onCancel();
        }
    }

    void clearUpdate() {
        this.currentPhoneUpdateController = null;
    }

    void continueWithCode(String str) {
        PhoneUpdateModelImpl currentUpdateModel;
        Utility.assertUIThread();
        if (AccountKit.getCurrentAccessToken() == null || (currentUpdateModel = getCurrentUpdateModel()) == null) {
            return;
        }
        try {
            currentUpdateModel.setConfirmationCode(str);
            handle(currentUpdateModel);
            this.logger.logUpdateModel(InternalLogger.EVENT_NAME_UPDATE_VERIFY, currentUpdateModel);
        } catch (AccountKitException e) {
            if (Utility.isDebuggable(AccountKitController.getApplicationContext())) {
                throw e;
            }
            this.logger.logUpdateModel(InternalLogger.EVENT_NAME_SET_CONFIRMATION_CODE, currentUpdateModel);
        }
    }

    LocalBroadcastManager getLocalBroadcastManager() {
        return this.localBroadcastManager;
    }

    InternalLogger getLogger() {
        return this.logger;
    }

    boolean isActivityAvailable() {
        return this.isActivityAvailable;
    }

    void onActivityCreate(Activity activity, Bundle bundle) {
        PhoneUpdateModelImpl phoneUpdateModelImpl;
        this.isActivityAvailable = true;
        this.currentActivity = activity;
        this.logger.onActivityCreate(bundle);
        if (bundle == null || (phoneUpdateModelImpl = (PhoneUpdateModelImpl) bundle.getParcelable(SAVED_UPDATE_MODEL)) == null) {
            return;
        }
        continueWith(phoneUpdateModelImpl);
    }

    void onActivityDestroy(Activity activity) {
        if (this.currentActivity != activity) {
            return;
        }
        this.isActivityAvailable = false;
        this.currentActivity = null;
        this.currentPhoneUpdateController = null;
        AccountKitGraphRequestAsyncTask.cancelCurrentAsyncTask();
        AccountKitGraphRequestAsyncTask.setCurrentAsyncTask(null);
    }

    void onActivitySaveInstanceState(Activity activity, Bundle bundle) {
        if (this.currentActivity != activity) {
            return;
        }
        this.logger.saveInstanceState(bundle);
        if (this.currentPhoneUpdateController != null) {
            bundle.putParcelable(SAVED_UPDATE_MODEL, this.currentPhoneUpdateController.getUpdateModel());
        }
    }

    @Nullable
    PhoneUpdateModelImpl updatePhoneNumber(PhoneNumber phoneNumber, @Nullable String str) {
        Utility.assertUIThread();
        if (AccountKit.getCurrentAccessToken() == null) {
            return null;
        }
        cancelExisting();
        PhoneUpdateModelImpl phoneUpdateModelImpl = new PhoneUpdateModelImpl(phoneNumber);
        PhoneUpdateController phoneUpdateController = new PhoneUpdateController(this, phoneUpdateModelImpl);
        phoneUpdateController.update(str);
        this.logger.logUpdateModel(InternalLogger.EVENT_NAME_UPDATE_START, phoneUpdateModelImpl);
        this.currentPhoneUpdateController = phoneUpdateController;
        return phoneUpdateModelImpl;
    }
}
