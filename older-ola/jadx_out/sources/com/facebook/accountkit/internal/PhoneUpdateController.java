package com.facebook.accountkit.internal;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Pair;
import com.facebook.accountkit.AccountKit;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.UpdateFlowBroadcastReceiver;
import com.facebook.accountkit.internal.AccountKitGraphRequest;
import java.lang.ref.WeakReference;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
final class PhoneUpdateController {
    private static final String GRAPH_PATH_CONFIRM_UPDATE = "confirm_update";
    private static final String GRAPH_PATH_START_UPDATE = "start_update";
    private static final String PARAMETER_CONFIRMATION_CODE = "confirmation_code";
    private static final String PARAMETER_CREDENTIALS_TYPE = "credentials_type";
    private static final String PARAMETER_EXTRAS_TYPE = "extras";
    private static final String PARAMETER_PHONE = "phone_number";
    private static final String PARAMETER_STATE = "state";
    private static final String PARAMETER_UPDATE_REQUEST_CODE = "update_request_code";
    private final WeakReference<UpdateManager> updateManagerRef;
    private final PhoneUpdateModelImpl updateModel;

    PhoneUpdateController(UpdateManager updateManager, PhoneUpdateModelImpl phoneUpdateModelImpl) {
        this.updateManagerRef = new WeakReference<>(updateManager);
        this.updateModel = phoneUpdateModelImpl;
    }

    private AccountKitGraphRequest buildGraphRequest(String str, Bundle bundle) {
        Bundle bundle2 = new Bundle();
        Utility.putNonNullString(bundle2, PARAMETER_CREDENTIALS_TYPE, getCredentialsType());
        Utility.putNonNullString(bundle2, "update_request_code", this.updateModel.getUpdateRequestCode());
        bundle2.putAll(bundle);
        return new AccountKitGraphRequest(AccountKit.getCurrentAccessToken(), str, bundle2, false, HttpMethod.POST);
    }

    private String getCredentialsType() {
        return PARAMETER_PHONE;
    }

    /* JADX INFO: Access modifiers changed from: private */
    @Nullable
    public UpdateManager getUpdateManager() {
        UpdateManager updateManager = this.updateManagerRef.get();
        if (updateManager != null && updateManager.isActivityAvailable()) {
            return updateManager;
        }
        return null;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void setError(AccountKitError.Type type, InternalAccountKitError internalAccountKitError) {
        setError(new AccountKitError(type, internalAccountKitError));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void setError(AccountKitError accountKitError) {
        this.updateModel.setError(accountKitError);
        this.updateModel.setStatus(UpdateStatus.ERROR);
    }

    PhoneUpdateModelImpl getUpdateModel() {
        return this.updateModel;
    }

    public void onCancel() {
        this.updateModel.setStatus(UpdateStatus.CANCELLED);
        AccountKitGraphRequestAsyncTask.cancelCurrentAsyncTask();
        AccountKitGraphRequestAsyncTask.setCurrentAsyncTask(null);
        UpdateManager updateManager = getUpdateManager();
        if (updateManager != null) {
            updateManager.clearUpdate();
        }
    }

    public void onError(AccountKitError accountKitError) {
        this.updateModel.setError(accountKitError);
        this.updateModel.setStatus(UpdateStatus.ERROR);
        UpdateManager updateManager = getUpdateManager();
        if (updateManager != null) {
            updateManager.clearUpdate();
        }
    }

    void onPending() {
        if (Utility.isNullOrEmpty(this.updateModel.getConfirmationCode())) {
            return;
        }
        AccountKitGraphRequest.Callback callback = new AccountKitGraphRequest.Callback() { // from class: com.facebook.accountkit.internal.PhoneUpdateController.2
            @Override // com.facebook.accountkit.internal.AccountKitGraphRequest.Callback
            public void onCompleted(AccountKitGraphResponse accountKitGraphResponse) {
                UpdateManager updateManager = PhoneUpdateController.this.getUpdateManager();
                if (updateManager == null || accountKitGraphResponse == null) {
                    return;
                }
                Intent intent = new Intent(UpdateFlowBroadcastReceiver.ACTION_UPDATE);
                if (accountKitGraphResponse.getError() != null) {
                    Pair<AccountKitError, InternalAccountKitError> pairCreateErrorFromServerError = Utility.createErrorFromServerError(accountKitGraphResponse.getError());
                    if (Utility.isConfirmationCodeRetryable((InternalAccountKitError) pairCreateErrorFromServerError.second)) {
                        PhoneUpdateController.this.updateModel.setStatus(UpdateStatus.PENDING);
                        PhoneUpdateController.this.updateModel.setError(null);
                        intent.putExtra(UpdateFlowBroadcastReceiver.EXTRA_EVENT, UpdateFlowBroadcastReceiver.Event.RETRY_CONFIRMATION_CODE);
                    } else {
                        PhoneUpdateController.this.setError((AccountKitError) pairCreateErrorFromServerError.first);
                        updateManager.clearUpdate();
                        intent.putExtra(UpdateFlowBroadcastReceiver.EXTRA_EVENT, UpdateFlowBroadcastReceiver.Event.ERROR_CONFIRMATION_CODE);
                        intent.putExtra(UpdateFlowBroadcastReceiver.EXTRA_ERROR_MESSAGE, ((AccountKitError) pairCreateErrorFromServerError.first).getUserFacingMessage());
                    }
                } else {
                    JSONObject responseObject = accountKitGraphResponse.getResponseObject();
                    if (responseObject == null) {
                        PhoneUpdateController.this.setError(AccountKitError.Type.UPDATE_INVALIDATED, InternalAccountKitError.NO_RESULT_FOUND);
                        intent.putExtra(UpdateFlowBroadcastReceiver.EXTRA_EVENT, UpdateFlowBroadcastReceiver.Event.ERROR_CONFIRMATION_CODE);
                    } else {
                        PhoneUpdateController.this.updateModel.setFinalUpdateState(responseObject.optString("state"));
                        PhoneUpdateController.this.updateModel.setStatus(UpdateStatus.SUCCESS);
                        intent.putExtra(UpdateFlowBroadcastReceiver.EXTRA_EVENT, UpdateFlowBroadcastReceiver.Event.ACCOUNT_UPDATE_COMPLETE);
                        intent.putExtra(UpdateFlowBroadcastReceiver.EXTRA_UPDATE_STATE, PhoneUpdateController.this.updateModel.getFinalUpdateState());
                    }
                    updateManager.clearUpdate();
                }
                updateManager.getLogger().logUpdateModel(InternalLogger.EVENT_NAME_UPDATE_COMPLETE, PhoneUpdateController.this.updateModel);
                updateManager.getLocalBroadcastManager().sendBroadcast(intent);
            }
        };
        Bundle bundle = new Bundle();
        Utility.putNonNullString(bundle, "confirmation_code", this.updateModel.getConfirmationCode());
        Utility.putNonNullString(bundle, PARAMETER_PHONE, this.updateModel.getPhoneNumber().toString());
        AccountKitGraphRequest accountKitGraphRequestBuildGraphRequest = buildGraphRequest(GRAPH_PATH_CONFIRM_UPDATE, bundle);
        AccountKitGraphRequestAsyncTask.cancelCurrentAsyncTask();
        AccountKitGraphRequestAsyncTask.setCurrentAsyncTask(AccountKitGraphRequest.executeAsync(accountKitGraphRequestBuildGraphRequest, callback));
    }

    void update(String str) {
        AccountKitGraphRequest.Callback callback = new AccountKitGraphRequest.Callback() { // from class: com.facebook.accountkit.internal.PhoneUpdateController.1
            /* JADX WARN: Removed duplicated region for block: B:56:0x018c  */
            /* JADX WARN: Removed duplicated region for block: B:57:0x0194  */
            @Override // com.facebook.accountkit.internal.AccountKitGraphRequest.Callback
            /*
                Code decompiled incorrectly, please refer to instructions dump.
                To view partially-correct add '--show-bad-code' argument
            */
            public void onCompleted(com.facebook.accountkit.internal.AccountKitGraphResponse r11) throws java.lang.Throwable {
                /*
                    Method dump skipped, instruction units count: 449
                    To view this dump add '--comments-level debug' option
                */
                throw new UnsupportedOperationException("Method not decompiled: com.facebook.accountkit.internal.PhoneUpdateController.AnonymousClass1.onCompleted(com.facebook.accountkit.internal.AccountKitGraphResponse):void");
            }
        };
        String string = this.updateModel.getPhoneNumber().toString();
        Bundle bundle = new Bundle();
        Utility.putNonNullString(bundle, PARAMETER_PHONE, string);
        Utility.putNonNullString(bundle, "state", str);
        Utility.putNonNullString(bundle, "extras", AccountKitGraphConstants.TERMS_OF_SERVICE_AND_PRIVACY_POLICY);
        this.updateModel.setInitialUpdateState(str);
        AccountKitGraphRequest accountKitGraphRequestBuildGraphRequest = buildGraphRequest(GRAPH_PATH_START_UPDATE, bundle);
        AccountKitGraphRequestAsyncTask.cancelCurrentAsyncTask();
        AccountKitGraphRequestAsyncTask.setCurrentAsyncTask(AccountKitGraphRequest.executeAsync(accountKitGraphRequestBuildGraphRequest, callback));
    }
}
