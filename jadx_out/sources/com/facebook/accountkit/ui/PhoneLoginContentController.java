package com.facebook.accountkit.ui;

import android.content.Context;
import android.content.Intent;
import android.support.v4.content.LocalBroadcastManager;
import com.facebook.accountkit.PhoneNumber;
import com.facebook.accountkit.R;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.ui.LoginFlowBroadcastReceiver;
import com.facebook.accountkit.ui.PhoneContentController;
import com.facebook.accountkit.ui.TitleFragmentFactory;

/* JADX INFO: loaded from: classes.dex */
final class PhoneLoginContentController extends PhoneContentController {
    PhoneLoginContentController(AccountKitConfiguration accountKitConfiguration) {
        super(accountKitConfiguration);
        AccountKitController.initializeLogin();
    }

    @Override // com.facebook.accountkit.ui.ContentController
    public TitleFragmentFactory.TitleFragment getHeaderFragment() {
        if (this.headerFragment == null) {
            setHeaderFragment(TitleFragmentFactory.create(this.configuration.getUIManager(), R.string.com_accountkit_phone_login_title, new String[0]));
        }
        return this.headerFragment;
    }

    @Override // com.facebook.accountkit.ui.PhoneContentController
    PhoneContentController.OnCompleteListener getOnCompleteListener() {
        if (this.onCompleteListener == null) {
            this.onCompleteListener = new PhoneContentController.OnCompleteListener() { // from class: com.facebook.accountkit.ui.PhoneLoginContentController.1
                @Override // com.facebook.accountkit.ui.PhoneContentController.OnCompleteListener
                public void onNext(Context context, String str) {
                    PhoneNumber phoneNumber;
                    if (PhoneLoginContentController.this.topFragment == null || PhoneLoginContentController.this.bottomFragment == null || (phoneNumber = PhoneLoginContentController.this.topFragment.getPhoneNumber()) == null) {
                        return;
                    }
                    AccountKitController.Logger.logUIPhoneLoginInteraction(str, PhoneContentController.getPhoneNumberSource(phoneNumber, PhoneLoginContentController.this.topFragment.getAppSuppliedPhoneNumber(), PhoneLoginContentController.this.topFragment.getDevicePhoneNumber()).name(), phoneNumber);
                    LocalBroadcastManager.getInstance(context).sendBroadcast(new Intent(LoginFlowBroadcastReceiver.ACTION_UPDATE).putExtra(LoginFlowBroadcastReceiver.EXTRA_EVENT, LoginFlowBroadcastReceiver.Event.PHONE_LOGIN_COMPLETE).putExtra(LoginFlowBroadcastReceiver.EXTRA_PHONE_NUMBER, phoneNumber));
                }
            };
        }
        return this.onCompleteListener;
    }

    void setRetry() {
        if (this.headerFragment != null) {
            this.headerFragment.setTitleResourceId(R.string.com_accountkit_phone_login_retry_title, new String[0]);
        }
        if (this.bottomFragment != null) {
            this.bottomFragment.setRetry(true);
        }
        if (this.textFragment != null) {
            this.textFragment.updateText();
        }
    }
}
