package com.facebook.accountkit.ui;

import android.app.Activity;
import android.content.Intent;
import android.os.Handler;
import android.support.v4.content.LocalBroadcastManager;
import com.facebook.accountkit.UpdateFlowBroadcastReceiver;
import com.facebook.accountkit.internal.AccountKitController;

/* JADX INFO: loaded from: classes.dex */
final class PhoneUpdateSentCodeContentController extends SentCodeContentController {
    PhoneUpdateSentCodeContentController(AccountKitConfiguration accountKitConfiguration) {
        super(accountKitConfiguration);
    }

    @Override // com.facebook.accountkit.ui.ContentControllerBase
    protected void logImpression() {
        AccountKitController.Logger.logUISentCode(true, LoginType.PHONE);
    }

    @Override // com.facebook.accountkit.ui.SentCodeContentController, com.facebook.accountkit.ui.ContentControllerBase, com.facebook.accountkit.ui.ContentController
    public void onResume(final Activity activity) {
        super.onResume(activity);
        cancelTransition();
        this.delayedTransitionHandler = new Handler();
        this.delayedTransitionRunnable = new Runnable() { // from class: com.facebook.accountkit.ui.PhoneUpdateSentCodeContentController.1
            @Override // java.lang.Runnable
            public void run() {
                Intent intent = new Intent(UpdateFlowBroadcastReceiver.ACTION_UPDATE);
                intent.putExtra(UpdateFlowBroadcastReceiver.EXTRA_EVENT, UpdateFlowBroadcastReceiver.Event.SENT_CODE_COMPLETE);
                LocalBroadcastManager.getInstance(activity).sendBroadcast(intent);
                PhoneUpdateSentCodeContentController.this.delayedTransitionHandler = null;
                PhoneUpdateSentCodeContentController.this.delayedTransitionRunnable = null;
            }
        };
        this.delayedTransitionHandler.postDelayed(this.delayedTransitionRunnable, 2000L);
    }
}
