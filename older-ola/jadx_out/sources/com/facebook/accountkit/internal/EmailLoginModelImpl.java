package com.facebook.accountkit.internal;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.Nullable;
import com.facebook.accountkit.AccessToken;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.EmailLoginModel;
import java.util.HashMap;

/* JADX INFO: loaded from: classes.dex */
public final class EmailLoginModelImpl extends LoginModelImpl implements EmailLoginModel {
    public static final Parcelable.Creator<EmailLoginModelImpl> CREATOR = new Parcelable.Creator<EmailLoginModelImpl>() { // from class: com.facebook.accountkit.internal.EmailLoginModelImpl.1
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public EmailLoginModelImpl createFromParcel(Parcel parcel) {
            return new EmailLoginModelImpl(parcel);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public EmailLoginModelImpl[] newArray(int i) {
            return new EmailLoginModelImpl[i];
        }
    };
    private String email;
    private int interval;

    private EmailLoginModelImpl(Parcel parcel) {
        super(parcel);
        this.email = parcel.readString();
        this.interval = parcel.readInt();
        this.fields = new HashMap();
        int i = parcel.readInt();
        for (int i2 = 0; i2 < i; i2++) {
            this.fields.put(parcel.readString(), parcel.readString());
        }
    }

    EmailLoginModelImpl(String str, String str2) {
        super(str2);
        this.email = str;
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof EmailLoginModelImpl)) {
            return false;
        }
        EmailLoginModelImpl emailLoginModelImpl = (EmailLoginModelImpl) obj;
        return super.equals(obj) && this.interval == emailLoginModelImpl.interval && Utility.areObjectsEqual(this.email, emailLoginModelImpl.email);
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl, com.facebook.accountkit.LoginModel
    @Nullable
    public /* bridge */ /* synthetic */ AccessToken getAccessToken() {
        return super.getAccessToken();
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl, com.facebook.accountkit.LoginModel
    public /* bridge */ /* synthetic */ String getCode() {
        return super.getCode();
    }

    @Override // com.facebook.accountkit.EmailLoginModel
    public String getEmail() {
        return this.email;
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl
    public /* bridge */ /* synthetic */ AccountKitError getError() {
        return super.getError();
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl, com.facebook.accountkit.LoginModel
    public /* bridge */ /* synthetic */ String getFinalAuthState() {
        return super.getFinalAuthState();
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl
    public /* bridge */ /* synthetic */ String getInitialAuthState() {
        return super.getInitialAuthState();
    }

    public int getInterval() {
        return this.interval;
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl, com.facebook.accountkit.LoginModel
    @Nullable
    public /* bridge */ /* synthetic */ String getPrivacyPolicy() {
        return super.getPrivacyPolicy();
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl
    public /* bridge */ /* synthetic */ String getResponseType() {
        return super.getResponseType();
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl
    public /* bridge */ /* synthetic */ LoginStatus getStatus() {
        return super.getStatus();
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl, com.facebook.accountkit.LoginModel
    @Nullable
    public /* bridge */ /* synthetic */ String getTermsOfService() {
        return super.getTermsOfService();
    }

    void setEmail(String str) {
        this.email = str;
    }

    void setInterval(int i) {
        this.interval = i;
    }

    @Override // com.facebook.accountkit.internal.LoginModelImpl, android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        super.writeToParcel(parcel, i);
        parcel.writeString(this.email);
        parcel.writeInt(this.interval);
        parcel.writeInt(this.fields.size());
        for (String str : this.fields.keySet()) {
            parcel.writeString(str);
            parcel.writeString(this.fields.get(str));
        }
    }
}
