package com.facebook.accountkit.ui;

import android.app.FragmentManager;
import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.support.annotation.Nullable;
import com.facebook.accountkit.AccountKitUpdateResult;
import com.facebook.accountkit.PhoneNumber;
import com.facebook.accountkit.UpdateFlowBroadcastReceiver;
import com.facebook.accountkit.internal.AccountKitController;
import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
final class UpdateStateStackManager extends UpdateFlowBroadcastReceiver {
    private static final int COMPLETION_UI_DURATION_MS = 2000;
    private final WeakReference<AccountKitUpdateActivity> activityRef;
    private final AccountKitConfiguration configuration;

    @Nullable
    private ContentController contentController;
    private final Map<UpdateFlowState, ContentController> contentControllerMap = new HashMap();
    private UpdateFlowState updateFlowState;

    UpdateStateStackManager(AccountKitUpdateActivity accountKitUpdateActivity, AccountKitConfiguration accountKitConfiguration) {
        this.activityRef = new WeakReference<>(accountKitUpdateActivity);
        this.configuration = accountKitConfiguration;
        pushState(UpdateFlowState.PHONE_NUMBER_INPUT);
    }

    @Nullable
    private ContentController ensureContentController(UpdateFlowState updateFlowState) {
        ContentController phoneUpdateContentController;
        ContentController contentController = this.contentControllerMap.get(updateFlowState);
        if (contentController != null) {
            return contentController;
        }
        switch (updateFlowState) {
            case NONE:
                return null;
            case PHONE_NUMBER_INPUT:
                phoneUpdateContentController = new PhoneUpdateContentController(this.configuration);
                break;
            case SENDING_CODE:
                phoneUpdateContentController = new SendingCodeContentController(this.configuration);
                break;
            case SENT_CODE:
                phoneUpdateContentController = new PhoneUpdateSentCodeContentController(this.configuration);
                break;
            case CODE_INPUT:
                phoneUpdateContentController = new UpdateConfirmationCodeContentController(this.configuration);
                break;
            case VERIFYING_CODE:
                phoneUpdateContentController = new VerifyingCodeContentController(this.configuration);
                break;
            case VERIFIED:
                phoneUpdateContentController = new VerifiedCodeContentController(this.configuration);
                break;
            case CODE_INPUT_ERROR:
            case PHONE_NUMBER_INPUT_ERROR:
                phoneUpdateContentController = new UpdateErrorContentController(this.configuration);
                break;
            default:
                return null;
        }
        this.contentControllerMap.put(updateFlowState, phoneUpdateContentController);
        return phoneUpdateContentController;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void finishActivity(String str) {
        AccountKitUpdateActivity accountKitUpdateActivity = this.activityRef.get();
        if (accountKitUpdateActivity == null) {
            return;
        }
        accountKitUpdateActivity.setFinalUpdateState(str);
        accountKitUpdateActivity.setUpdateResult(AccountKitUpdateResult.UpdateResult.SUCCESS);
        accountKitUpdateActivity.sendResult();
    }

    private void pushState(UpdateFlowState updateFlowState) {
        pushState(updateFlowState, null);
    }

    private void pushState(UpdateFlowState updateFlowState, String str) {
        AccountKitUpdateActivity accountKitUpdateActivity = this.activityRef.get();
        if (accountKitUpdateActivity == null) {
            return;
        }
        this.updateFlowState = updateFlowState;
        ContentController contentController = getContentController();
        this.contentController = ensureContentController(this.updateFlowState);
        if (this.contentController == null || contentController == this.contentController) {
            return;
        }
        FragmentManager fragmentManager = accountKitUpdateActivity.getFragmentManager();
        if (contentController != null) {
            contentController.onPause(accountKitUpdateActivity);
            if (contentController.isTransient()) {
                fragmentManager.popBackStack();
            }
        }
        accountKitUpdateActivity.updateUI(this.updateFlowState, this.contentController);
        if ((updateFlowState == UpdateFlowState.PHONE_NUMBER_INPUT_ERROR || updateFlowState == UpdateFlowState.CODE_INPUT_ERROR) && str != null) {
            ((UpdateErrorContentController) this.contentController).setErrorMessage(str);
        }
    }

    @Nullable
    ContentController getContentController() {
        return this.contentController;
    }

    public UpdateFlowState getUpdateFlowState() {
        return this.updateFlowState;
    }

    @Override // android.content.BroadcastReceiver
    public void onReceive(Context context, Intent intent) {
        UpdateFlowState updateFlowState;
        UpdateFlowState updateFlowState2;
        if (UpdateFlowBroadcastReceiver.ACTION_UPDATE.contentEquals(intent.getAction())) {
            UpdateFlowBroadcastReceiver.Event event = (UpdateFlowBroadcastReceiver.Event) intent.getSerializableExtra(EXTRA_EVENT);
            String stringExtra = intent.getStringExtra(EXTRA_ERROR_MESSAGE);
            switch (event) {
                case UPDATE_START:
                    PhoneNumber phoneNumber = (PhoneNumber) intent.getParcelableExtra(EXTRA_PHONE_NUMBER);
                    pushState(UpdateFlowState.SENDING_CODE);
                    AccountKitController.updatePhoneNumber(phoneNumber, this.configuration.getInitialAuthState());
                    break;
                case SENT_CODE:
                    updateFlowState = UpdateFlowState.SENT_CODE;
                    pushState(updateFlowState);
                    break;
                case SENT_CODE_COMPLETE:
                    updateFlowState = UpdateFlowState.CODE_INPUT;
                    pushState(updateFlowState);
                    break;
                case CONFIRMATION_CODE_COMPLETE:
                    pushState(UpdateFlowState.VERIFYING_CODE);
                    AccountKitController.continueUpdateWithCode(intent.getStringExtra(EXTRA_CONFIRMATION_CODE));
                    break;
                case ACCOUNT_UPDATE_COMPLETE:
                    pushState(UpdateFlowState.VERIFIED);
                    final String stringExtra2 = intent.getStringExtra(EXTRA_UPDATE_STATE);
                    new Handler().postDelayed(new Runnable() { // from class: com.facebook.accountkit.ui.UpdateStateStackManager.1
                        @Override // java.lang.Runnable
                        public void run() {
                            UpdateStateStackManager.this.finishActivity(stringExtra2);
                        }
                    }, 2000L);
                    break;
                case ERROR_UPDATE:
                    updateFlowState2 = UpdateFlowState.PHONE_NUMBER_INPUT_ERROR;
                    pushState(updateFlowState2, stringExtra);
                    break;
                case ERROR_CONFIRMATION_CODE:
                    updateFlowState2 = UpdateFlowState.CODE_INPUT_ERROR;
                    pushState(updateFlowState2, stringExtra);
                    break;
                case RETRY_CONFIRMATION_CODE:
                    popState();
                    ((UpdateConfirmationCodeContentController) this.contentController).setRetry(true);
                    break;
                case RETRY:
                    popState();
                    break;
            }
        }
    }

    void popState() {
        AccountKitUpdateActivity accountKitUpdateActivity = this.activityRef.get();
        if (accountKitUpdateActivity == null) {
            return;
        }
        UpdateFlowState updateFlowState = this.updateFlowState;
        UpdateFlowState backState = UpdateFlowState.getBackState(updateFlowState);
        this.updateFlowState = backState;
        this.contentController = ensureContentController(this.updateFlowState);
        switch (backState) {
            case NONE:
                if (updateFlowState != UpdateFlowState.VERIFIED) {
                    accountKitUpdateActivity.sendCancelResult();
                } else {
                    accountKitUpdateActivity.sendResult();
                }
                break;
            case PHONE_NUMBER_INPUT:
                AccountKitController.cancelUpdate();
                break;
        }
        accountKitUpdateActivity.getFragmentManager().popBackStack();
        accountKitUpdateActivity.ensureNextButton(this.contentController);
    }
}
