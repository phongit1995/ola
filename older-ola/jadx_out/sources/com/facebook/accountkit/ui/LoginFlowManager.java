package com.facebook.accountkit.ui;

import android.os.Parcel;
import android.os.Parcelable;
import com.facebook.accountkit.AccessToken;
import com.facebook.accountkit.AccountKit;
import com.facebook.accountkit.internal.AccountKitController;

/* JADX INFO: loaded from: classes.dex */
abstract class LoginFlowManager implements Parcelable {
    protected ActivityHandler activityHandler;
    private LoginFlowState flowState;
    private boolean isValid;
    private final LoginType loginType;

    protected LoginFlowManager(Parcel parcel) {
        this.isValid = true;
        this.isValid = parcel.readByte() == 1;
        this.loginType = LoginType.valueOf(parcel.readString());
        this.flowState = LoginFlowState.values()[parcel.readInt()];
    }

    public LoginFlowManager(LoginType loginType) {
        this.isValid = true;
        this.loginType = loginType;
        this.flowState = LoginFlowState.NONE;
    }

    public void cancel() {
        this.isValid = false;
        AccountKit.cancelLogin();
    }

    void confirmSeamlessLogin() {
        if (isValid()) {
            AccountKitController.continueSeamlessLogin();
        }
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    public AccessToken getAccessToken() {
        if (this.isValid) {
            return AccountKit.getCurrentAccessToken();
        }
        return null;
    }

    public ActivityHandler getActivityHandler() {
        return this.activityHandler;
    }

    public LoginFlowState getFlowState() {
        return this.flowState;
    }

    public LoginType getLoginType() {
        return this.loginType;
    }

    public boolean isValid() {
        return this.isValid;
    }

    public final void setFlowState(LoginFlowState loginFlowState) {
        this.flowState = loginFlowState;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeByte(this.isValid ? (byte) 1 : (byte) 0);
        parcel.writeString(this.loginType.name());
        parcel.writeInt(this.flowState.ordinal());
    }
}
