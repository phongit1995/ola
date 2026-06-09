package com.facebook.accountkit.ui;

import android.content.Context;
import android.content.Intent;
import android.support.v4.content.LocalBroadcastManager;
import com.facebook.accountkit.PhoneNumber;
import com.facebook.accountkit.R;
import com.facebook.accountkit.UpdateFlowBroadcastReceiver;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.ui.PhoneContentController;
import com.facebook.accountkit.ui.TitleFragmentFactory;

/* JADX INFO: loaded from: classes.dex */
final class PhoneUpdateContentController extends PhoneContentController {
    PhoneUpdateContentController(AccountKitConfiguration accountKitConfiguration) {
        super(accountKitConfiguration);
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public TitleFragmentFactory.TitleFragment getHeaderFragment() {
        if (this.headerFragment == null) {
            setHeaderFragment(TitleFragmentFactory.create(this.configuration.getUIManager(), R.string.com_accountkit_phone_update_title, new String[0]));
        }
        return this.headerFragment;
    }

    @Override // com.facebook.accountkit.ui.PhoneContentController
    PhoneContentController.OnCompleteListener getOnCompleteListener() {
        if (this.onCompleteListener == null) {
            this.onCompleteListener = new PhoneContentController.OnCompleteListener() { // from class: com.facebook.accountkit.ui.PhoneUpdateContentController.1
                @Override // com.facebook.accountkit.ui.PhoneContentController.OnCompleteListener
                public void onNext(Context context, String str) {
                    PhoneNumber phoneNumber;
                    if (PhoneUpdateContentController.this.topFragment == null || PhoneUpdateContentController.this.bottomFragment == null || (phoneNumber = PhoneUpdateContentController.this.topFragment.getPhoneNumber()) == null) {
                        return;
                    }
                    AccountKitController.Logger.logUIPhoneLoginInteraction(str, PhoneContentController.getPhoneNumberSource(phoneNumber, PhoneUpdateContentController.this.topFragment.getAppSuppliedPhoneNumber(), PhoneUpdateContentController.this.topFragment.getDevicePhoneNumber()).name(), phoneNumber);
                    LocalBroadcastManager.getInstance(context).sendBroadcast(new Intent(UpdateFlowBroadcastReceiver.ACTION_UPDATE).putExtra(UpdateFlowBroadcastReceiver.EXTRA_EVENT, UpdateFlowBroadcastReceiver.Event.UPDATE_START).putExtra(UpdateFlowBroadcastReceiver.EXTRA_PHONE_NUMBER, phoneNumber));
                }
            };
        }
        return this.onCompleteListener;
    }
}
