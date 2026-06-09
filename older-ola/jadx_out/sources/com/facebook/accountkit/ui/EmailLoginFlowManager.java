package com.facebook.accountkit.ui;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.Nullable;
import com.facebook.accountkit.internal.AccountKitController;
import com.facebook.accountkit.ui.AccountKitActivity;

/* JADX INFO: loaded from: classes.dex */
class EmailLoginFlowManager extends LoginFlowManager {
    public static final Parcelable.Creator<EmailLoginFlowManager> CREATOR = new Parcelable.Creator<EmailLoginFlowManager>() { // from class: com.facebook.accountkit.ui.EmailLoginFlowManager.1
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public EmailLoginFlowManager createFromParcel(Parcel parcel) {
            return new EmailLoginFlowManager(parcel);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public EmailLoginFlowManager[] newArray(int i) {
            return new EmailLoginFlowManager[i];
        }
    };
    private String email;

    protected EmailLoginFlowManager(Parcel parcel) {
        super(parcel);
        this.activityHandler = (ActivityHandler) parcel.readParcelable(ActivityEmailHandler.class.getClassLoader());
        this.email = parcel.readString();
    }

    public EmailLoginFlowManager(AccountKitConfiguration accountKitConfiguration) {
        super(LoginType.EMAIL);
        this.activityHandler = new ActivityEmailHandler(accountKitConfiguration);
    }

    public String getEmail() {
        return this.email;
    }

    public void logInWithEmail(AccountKitActivity.ResponseType responseType, @Nullable String str) {
        if (!isValid() || this.email == null) {
            return;
        }
        AccountKitController.logInWithEmail(this.email, responseType.getValue(), str);
    }

    public void setEmail(String str) {
        this.email = str;
    }

    @Override // com.facebook.accountkit.ui.LoginFlowManager, android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        super.writeToParcel(parcel, i);
        parcel.writeParcelable(this.activityHandler, i);
        parcel.writeString(this.email);
    }
}
