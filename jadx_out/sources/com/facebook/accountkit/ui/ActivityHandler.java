package com.facebook.accountkit.ui;

import android.os.Parcel;
import android.os.Parcelable;
import com.facebook.accountkit.Tracker;

/* JADX INFO: loaded from: classes.dex */
public abstract class ActivityHandler implements Parcelable {
    protected static final long COMPLETION_UI_DURATION_MS = 2000;
    protected final AccountKitConfiguration configuration;
    protected Tracker tracker;

    protected ActivityHandler(Parcel parcel) {
        this.configuration = (AccountKitConfiguration) parcel.readParcelable(AccountKitConfiguration.class.getClassLoader());
    }

    ActivityHandler(AccountKitConfiguration accountKitConfiguration) {
        this.configuration = accountKitConfiguration;
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    public abstract Tracker getLoginTracker(AccountKitActivity accountKitActivity);

    public abstract void onAccountVerifiedComplete(AccountKitActivity accountKitActivity);

    void onConfirmSeamlessLogin(AccountKitActivity accountKitActivity, LoginFlowManager loginFlowManager) {
        accountKitActivity.pushState(LoginFlowState.CONFIRM_INSTANT_VERIFICATION_LOGIN, null);
        loginFlowManager.confirmSeamlessLogin();
    }

    public abstract void onSentCodeComplete(AccountKitActivity accountKitActivity);

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeParcelable(this.configuration, i);
    }
}
