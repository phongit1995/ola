package com.facebook.accountkit.ui;

import android.app.Fragment;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.annotation.StyleRes;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.AccountKitException;
import com.facebook.accountkit.R;
import com.facebook.accountkit.internal.InternalAccountKitError;
import com.facebook.accountkit.ui.UIManager;

/* JADX INFO: loaded from: classes.dex */
public class BaseUIManager implements Parcelable, UIManager {
    public static final Parcelable.Creator<BaseUIManager> CREATOR = new Parcelable.Creator<BaseUIManager>() { // from class: com.facebook.accountkit.ui.BaseUIManager.1
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public BaseUIManager createFromParcel(Parcel parcel) {
            return new BaseUIManager(parcel);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public BaseUIManager[] newArray(int i) {
            return new BaseUIManager[i];
        }
    };
    public static final int THEME_ID_NOT_SET = -1;
    private Fragment bodyFragment;
    private LoginFlowState flowState;
    private Fragment footerFragment;
    private Fragment headerFragment;
    protected UIManager.UIManagerListener listener;

    @StyleRes
    private int themeId;

    public BaseUIManager(@StyleRes int i) {
        this.themeId = i;
        this.flowState = LoginFlowState.NONE;
    }

    protected BaseUIManager(Parcel parcel) {
        this.themeId = parcel.readInt();
        this.flowState = LoginFlowState.values()[parcel.readInt()];
    }

    @NonNull
    static Fragment getDefaultBodyFragment(UIManager uIManager, LoginFlowState loginFlowState) {
        int i;
        switch (loginFlowState) {
            case ACCOUNT_VERIFIED:
            case SENT_CODE:
                i = R.layout.com_accountkit_fragment_sent_code_center;
                break;
            case CONFIRM_ACCOUNT_VERIFIED:
            default:
                return StaticContentFragmentFactory.create(uIManager, loginFlowState);
            case CODE_INPUT:
                i = R.layout.com_accountkit_fragment_confirmation_code_center;
                break;
            case EMAIL_INPUT:
                i = R.layout.com_accountkit_fragment_email_login_center;
                break;
            case EMAIL_VERIFY:
                i = R.layout.com_accountkit_fragment_email_verify_center;
                break;
            case ERROR:
                i = R.layout.com_accountkit_fragment_error_center;
                break;
            case PHONE_NUMBER_INPUT:
                i = R.layout.com_accountkit_fragment_phone_login_center;
                break;
            case SENDING_CODE:
            case CONFIRM_INSTANT_VERIFICATION_LOGIN:
                i = R.layout.com_accountkit_fragment_sending_code_center;
                break;
            case VERIFIED:
                i = R.layout.com_accountkit_fragment_verified_code_center;
                break;
            case VERIFYING_CODE:
                i = R.layout.com_accountkit_fragment_verifying_code_center;
                break;
        }
        return StaticContentFragmentFactory.create(uIManager, loginFlowState, i);
    }

    static Fragment getDefaultBodyFragment(UIManager uIManager, UpdateFlowState updateFlowState) {
        LoginFlowState loginFlowState;
        int i;
        switch (updateFlowState) {
            case CODE_INPUT:
                loginFlowState = LoginFlowState.NONE;
                i = R.layout.com_accountkit_fragment_confirmation_code_center;
                break;
            case CODE_INPUT_ERROR:
            case PHONE_NUMBER_INPUT_ERROR:
                loginFlowState = LoginFlowState.NONE;
                i = R.layout.com_accountkit_fragment_error_center;
                break;
            case PHONE_NUMBER_INPUT:
                loginFlowState = LoginFlowState.NONE;
                i = R.layout.com_accountkit_fragment_phone_login_center;
                break;
            case SENDING_CODE:
                loginFlowState = LoginFlowState.NONE;
                i = R.layout.com_accountkit_fragment_sending_code_center;
                break;
            case SENT_CODE:
                loginFlowState = LoginFlowState.NONE;
                i = R.layout.com_accountkit_fragment_sent_code_center;
                break;
            case VERIFIED:
                loginFlowState = LoginFlowState.NONE;
                i = R.layout.com_accountkit_fragment_verified_code_center;
                break;
            case VERIFYING_CODE:
                loginFlowState = LoginFlowState.NONE;
                i = R.layout.com_accountkit_fragment_verifying_code_center;
                break;
            default:
                return StaticContentFragmentFactory.create(uIManager, LoginFlowState.NONE);
        }
        return StaticContentFragmentFactory.create(uIManager, loginFlowState, i);
    }

    @NonNull
    static Fragment getDefaultFooterFragment(UIManager uIManager) {
        return TitleFragmentFactory.create(uIManager);
    }

    @NonNull
    static Fragment getDefaultHeaderFragment(UIManager uIManager, LoginFlowState loginFlowState, LoginType loginType, @Nullable NotificationChannel notificationChannel) {
        int i;
        switch (loginFlowState) {
            case ACCOUNT_VERIFIED:
            case CONFIRM_ACCOUNT_VERIFIED:
            case CONFIRM_INSTANT_VERIFICATION_LOGIN:
                i = R.string.com_accountkit_account_verified;
                break;
            case CODE_INPUT:
                i = R.string.com_accountkit_confirmation_code_title;
                break;
            case EMAIL_INPUT:
                i = R.string.com_accountkit_email_login_title;
                break;
            case EMAIL_VERIFY:
                i = R.string.com_accountkit_email_verify_title;
                break;
            case ERROR:
                i = AnonymousClass2.$SwitchMap$com$facebook$accountkit$ui$LoginType[loginType.ordinal()] == 1 ? R.string.com_accountkit_phone_error_title : R.string.com_accountkit_error_title;
                break;
            case PHONE_NUMBER_INPUT:
                i = R.string.com_accountkit_phone_login_title;
                break;
            case SENDING_CODE:
                switch (loginType) {
                    case PHONE:
                        i = notificationChannel != NotificationChannel.FACEBOOK ? R.string.com_accountkit_phone_loading_title : R.string.com_accountkit_phone_sending_code_on_fb_title;
                        break;
                    case EMAIL:
                        i = R.string.com_accountkit_email_loading_title;
                        break;
                    default:
                        throw new AccountKitException(AccountKitError.Type.INTERNAL_ERROR, InternalAccountKitError.UNEXPECTED_STATE);
                }
                break;
            case SENT_CODE:
                i = R.string.com_accountkit_sent_title;
                break;
            case VERIFIED:
                i = R.string.com_accountkit_success_title;
                break;
            case VERIFYING_CODE:
                i = R.string.com_accountkit_verify_title;
                break;
            case RESEND:
                i = R.string.com_accountkit_resend_title;
                break;
            default:
                i = -1;
                break;
        }
        return i > -1 ? TitleFragmentFactory.create(uIManager, i, new String[0]) : TitleFragmentFactory.create(uIManager);
    }

    static Fragment getDefaultHeaderFragment(UIManager uIManager, UpdateFlowState updateFlowState) {
        int i;
        switch (updateFlowState) {
            case CODE_INPUT:
                i = R.string.com_accountkit_confirmation_code_title;
                break;
            case CODE_INPUT_ERROR:
                i = R.string.com_accountkit_error_title;
                break;
            case PHONE_NUMBER_INPUT_ERROR:
                i = R.string.com_accountkit_phone_error_title;
                break;
            case PHONE_NUMBER_INPUT:
                i = R.string.com_accountkit_phone_update_title;
                break;
            case SENDING_CODE:
                i = R.string.com_accountkit_phone_loading_title;
                break;
            case SENT_CODE:
                i = R.string.com_accountkit_sent_title;
                break;
            case VERIFIED:
                i = R.string.com_accountkit_success_title;
                break;
            case VERIFYING_CODE:
                i = R.string.com_accountkit_verify_title;
                break;
            default:
                i = -1;
                break;
        }
        return i > -1 ? TitleFragmentFactory.create(uIManager, i, new String[0]) : TitleFragmentFactory.create(uIManager);
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    @Nullable
    public Fragment getBodyFragment(LoginFlowState loginFlowState) {
        updateFlowState(loginFlowState);
        if (this.bodyFragment != null) {
            return this.bodyFragment;
        }
        this.bodyFragment = getDefaultBodyFragment(this, this.flowState);
        return this.bodyFragment;
    }

    @Nullable
    public ButtonType getButtonType(LoginFlowState loginFlowState) {
        updateFlowState(loginFlowState);
        return null;
    }

    LoginFlowState getFlowState() {
        return this.flowState;
    }

    @Nullable
    public Fragment getFooterFragment(LoginFlowState loginFlowState) {
        updateFlowState(loginFlowState);
        if (this.footerFragment != null) {
            return this.footerFragment;
        }
        this.footerFragment = getDefaultFooterFragment(this);
        return this.footerFragment;
    }

    @Nullable
    public Fragment getHeaderFragment(LoginFlowState loginFlowState) {
        updateFlowState(loginFlowState);
        return this.headerFragment;
    }

    @Nullable
    public TextPosition getTextPosition(LoginFlowState loginFlowState) {
        updateFlowState(loginFlowState);
        return TextPosition.BELOW_BODY;
    }

    @Override // com.facebook.accountkit.ui.UIManager
    public int getThemeId() {
        return this.themeId;
    }

    public void onError(AccountKitError accountKitError) {
    }

    @Override // com.facebook.accountkit.ui.UIManager
    public void setThemeId(@StyleRes int i) {
        this.themeId = i;
    }

    public void setUIManagerListener(UIManager.UIManagerListener uIManagerListener) {
        this.listener = uIManagerListener;
    }

    protected void updateFlowState(LoginFlowState loginFlowState) {
        if (this.flowState != loginFlowState) {
            this.flowState = loginFlowState;
            this.headerFragment = null;
            this.bodyFragment = null;
            this.footerFragment = null;
        }
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeInt(this.themeId);
        parcel.writeInt(this.flowState.ordinal());
    }
}
