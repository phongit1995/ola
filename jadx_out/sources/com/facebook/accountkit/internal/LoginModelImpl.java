package com.facebook.accountkit.internal;

import android.os.Parcel;
import android.support.annotation.Nullable;
import com.facebook.accountkit.AccessToken;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.LoginModel;
import java.util.HashMap;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
abstract class LoginModelImpl implements LoginModel {
    private static final int PARCEL_VERSION = 2;
    private AccessToken accessToken;
    private String code;
    private AccountKitError error;
    private long expiresInSeconds;
    protected Map<String, String> fields;
    private String finalAuthState;
    private String initialAuthState;
    private String loginModelCode;
    private String responseType;
    private LoginStatus status;

    LoginModelImpl(Parcel parcel) {
        this.status = LoginStatus.EMPTY;
        this.fields = new HashMap();
        if (parcel.readInt() != 2) {
            this.error = new AccountKitError(AccountKitError.Type.LOGIN_INVALIDATED);
            this.status = LoginStatus.ERROR;
            return;
        }
        this.error = (AccountKitError) parcel.readParcelable(AccountKitError.class.getClassLoader());
        this.expiresInSeconds = parcel.readLong();
        this.loginModelCode = parcel.readString();
        this.status = LoginStatus.valueOf(parcel.readString());
        this.responseType = parcel.readString();
        this.finalAuthState = parcel.readString();
        this.code = parcel.readString();
    }

    LoginModelImpl(String str) {
        this.status = LoginStatus.EMPTY;
        this.fields = new HashMap();
        this.responseType = str;
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof LoginModelImpl)) {
            return false;
        }
        LoginModelImpl loginModelImpl = (LoginModelImpl) obj;
        return this.expiresInSeconds == loginModelImpl.expiresInSeconds && Utility.areObjectsEqual(this.error, loginModelImpl.error) && Utility.areObjectsEqual(this.loginModelCode, loginModelImpl.loginModelCode) && Utility.areObjectsEqual(this.status, loginModelImpl.status) && Utility.areObjectsEqual(this.responseType, loginModelImpl.responseType) && Utility.areObjectsEqual(this.finalAuthState, loginModelImpl.finalAuthState) && Utility.areObjectsEqual(this.code, loginModelImpl.code);
    }

    @Override // com.facebook.accountkit.LoginModel
    @Nullable
    public AccessToken getAccessToken() {
        return this.accessToken;
    }

    @Override // com.facebook.accountkit.LoginModel
    public String getCode() {
        return this.code;
    }

    public AccountKitError getError() {
        return this.error;
    }

    long getExpiresInSeconds() {
        return this.expiresInSeconds;
    }

    @Override // com.facebook.accountkit.LoginModel
    public String getFinalAuthState() {
        return this.finalAuthState;
    }

    public String getInitialAuthState() {
        return this.initialAuthState;
    }

    String getLoginRequestCode() {
        return this.loginModelCode;
    }

    @Override // com.facebook.accountkit.LoginModel
    @Nullable
    public String getPrivacyPolicy() {
        return this.fields.get(AccountKitGraphConstants.PRIVACY_POLICY);
    }

    public String getResponseType() {
        return this.responseType;
    }

    public LoginStatus getStatus() {
        return this.status;
    }

    @Override // com.facebook.accountkit.LoginModel
    @Nullable
    public String getTermsOfService() {
        return this.fields.get(AccountKitGraphConstants.TERMS_OF_SERVICE);
    }

    void putField(String str, String str2) {
        this.fields.put(str, str2);
    }

    void setAccessToken(AccessToken accessToken) {
        this.accessToken = accessToken;
    }

    void setCode(String str) {
        this.code = str;
    }

    void setError(AccountKitError accountKitError) {
        this.error = accountKitError;
    }

    void setExpiresInSeconds(long j) {
        this.expiresInSeconds = j;
    }

    void setFinalAuthState(String str) {
        this.finalAuthState = str;
    }

    void setInitialAuthState(String str) {
        this.initialAuthState = str;
    }

    void setLoginCode(String str) {
        this.loginModelCode = str;
    }

    void setStatus(LoginStatus loginStatus) {
        this.status = loginStatus;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeInt(2);
        parcel.writeParcelable(this.error, i);
        parcel.writeLong(this.expiresInSeconds);
        parcel.writeString(this.loginModelCode);
        parcel.writeString(this.status.name());
        parcel.writeString(this.responseType);
        parcel.writeString(this.finalAuthState);
        parcel.writeString(this.code);
    }
}
