package com.facebook.accountkit.ui;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.facebook.accountkit.PhoneNumber;
import com.facebook.accountkit.ui.AccountKitActivity;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public final class AccountKitConfiguration implements Parcelable {
    public static final Parcelable.Creator CREATOR = new Parcelable.Creator() { // from class: com.facebook.accountkit.ui.AccountKitConfiguration.1
        @Override // android.os.Parcelable.Creator
        public AccountKitConfiguration createFromParcel(Parcel parcel) {
            return new AccountKitConfiguration(parcel);
        }

        @Override // android.os.Parcelable.Creator
        public AccountKitConfiguration[] newArray(int i) {
            return new AccountKitConfiguration[i];
        }
    };
    static final String TAG = "AccountKitConfiguration";
    private final String defaultCountryCode;
    private final String initialAuthState;
    private final String initialEmail;
    private final PhoneNumber initialPhoneNumber;
    private final LoginType loginType;
    private final LinkedHashSet<NotificationChannel> notificationChannels;
    private final boolean readPhoneStateEnabled;
    private final boolean receiveSMSEnabled;
    private final AccountKitActivity.ResponseType responseType;
    private final String[] smsBlacklist;
    private final String[] smsWhitelist;

    @NonNull
    private final UIManager uiManager;

    public static class AccountKitConfigurationBuilder {
        private String defaultCountryCode;
        private String initialAuthState;
        private String initialEmail;
        private PhoneNumber initialPhoneNumber;
        private LoginType loginType;
        private AccountKitActivity.ResponseType responseType;
        private String[] smsBlacklist;
        private String[] smsWhitelist;
        private UIManagerStub uiManager;
        private final LinkedHashSet<NotificationChannel> notificationChannels = new LinkedHashSet<>(NotificationChannel.values().length);
        private boolean readPhoneStateEnabled = true;
        private boolean receiveSMSEnabled = true;

        @Deprecated
        private int theme = -1;

        public AccountKitConfigurationBuilder(LoginType loginType, AccountKitActivity.ResponseType responseType) {
            this.notificationChannels.add(NotificationChannel.FACEBOOK);
            this.notificationChannels.add(NotificationChannel.VOICE_CALLBACK);
            this.loginType = loginType;
            this.responseType = responseType;
        }

        public AccountKitConfiguration build() {
            if (this.uiManager == null) {
                this.uiManager = new ThemeUIManager(this.theme);
            } else if (this.theme != -1 && (this.uiManager instanceof SkinManager)) {
                ((UIManager) this.uiManager).setThemeId(this.theme);
            }
            if (this.uiManager instanceof AdvancedUIManager) {
                this.uiManager = new AdvancedUIManagerWrapper((AdvancedUIManager) this.uiManager, this.theme);
            }
            return new AccountKitConfiguration((UIManager) this.uiManager, this.defaultCountryCode, this.notificationChannels, this.initialAuthState, this.initialEmail, this.initialPhoneNumber, this.loginType, this.readPhoneStateEnabled, this.receiveSMSEnabled, this.responseType, this.smsBlacklist, this.smsWhitelist);
        }

        public AccountKitConfigurationBuilder setAdvancedUIManager(@Nullable AdvancedUIManager advancedUIManager) {
            this.uiManager = advancedUIManager;
            this.theme = -1;
            return this;
        }

        public AccountKitConfigurationBuilder setDefaultCountryCode(@Nullable String str) {
            this.defaultCountryCode = str;
            return this;
        }

        public AccountKitConfigurationBuilder setFacebookNotificationsEnabled(boolean z) {
            if (!z) {
                this.notificationChannels.remove(NotificationChannel.FACEBOOK);
                return this;
            }
            if (!this.notificationChannels.contains(NotificationChannel.FACEBOOK)) {
                this.notificationChannels.add(NotificationChannel.FACEBOOK);
            }
            return this;
        }

        public AccountKitConfigurationBuilder setInitialAuthState(@Nullable String str) {
            this.initialAuthState = str;
            return this;
        }

        public AccountKitConfigurationBuilder setInitialEmail(@Nullable String str) {
            this.initialEmail = str;
            return this;
        }

        public AccountKitConfigurationBuilder setInitialPhoneNumber(@Nullable PhoneNumber phoneNumber) {
            this.initialPhoneNumber = phoneNumber;
            return this;
        }

        public AccountKitConfigurationBuilder setReadPhoneStateEnabled(boolean z) {
            this.readPhoneStateEnabled = z;
            return this;
        }

        public AccountKitConfigurationBuilder setReceiveSMS(boolean z) {
            this.receiveSMSEnabled = z;
            return this;
        }

        public AccountKitConfigurationBuilder setSMSBlacklist(@Nullable String[] strArr) {
            this.smsBlacklist = strArr;
            return this;
        }

        public AccountKitConfigurationBuilder setSMSWhitelist(@Nullable String[] strArr) {
            this.smsWhitelist = strArr;
            return this;
        }

        public AccountKitConfigurationBuilder setTheme(int i) {
            this.theme = i;
            return this;
        }

        public AccountKitConfigurationBuilder setTitleType(@Nullable AccountKitActivity.TitleType titleType) {
            return this;
        }

        public AccountKitConfigurationBuilder setUIManager(@Nullable UIManager uIManager) {
            this.uiManager = uIManager;
            this.theme = -1;
            return this;
        }

        public AccountKitConfigurationBuilder setVoiceCallbackNotificationsEnabled(boolean z) {
            if (!z) {
                this.notificationChannels.remove(NotificationChannel.VOICE_CALLBACK);
                return this;
            }
            if (!this.notificationChannels.contains(NotificationChannel.VOICE_CALLBACK)) {
                this.notificationChannels.add(NotificationChannel.VOICE_CALLBACK);
            }
            return this;
        }
    }

    private AccountKitConfiguration(Parcel parcel) {
        this.notificationChannels = new LinkedHashSet<>(NotificationChannel.values().length);
        this.uiManager = (UIManager) parcel.readParcelable(UIManager.class.getClassLoader());
        this.defaultCountryCode = parcel.readString();
        this.notificationChannels.clear();
        for (int i : parcel.createIntArray()) {
            this.notificationChannels.add(NotificationChannel.values()[i]);
        }
        this.initialAuthState = parcel.readString();
        this.initialEmail = parcel.readString();
        this.initialPhoneNumber = (PhoneNumber) parcel.readParcelable(PhoneNumber.class.getClassLoader());
        this.loginType = LoginType.valueOf(parcel.readString());
        this.readPhoneStateEnabled = parcel.readByte() != 0;
        this.receiveSMSEnabled = parcel.readByte() != 0;
        this.responseType = AccountKitActivity.ResponseType.valueOf(parcel.readString());
        this.smsBlacklist = parcel.createStringArray();
        this.smsWhitelist = parcel.createStringArray();
    }

    private AccountKitConfiguration(@NonNull UIManager uIManager, String str, LinkedHashSet<NotificationChannel> linkedHashSet, String str2, String str3, PhoneNumber phoneNumber, LoginType loginType, boolean z, boolean z2, AccountKitActivity.ResponseType responseType, String[] strArr, String[] strArr2) {
        this.notificationChannels = new LinkedHashSet<>(NotificationChannel.values().length);
        this.initialAuthState = str2;
        this.defaultCountryCode = str;
        this.initialEmail = str3;
        this.notificationChannels.addAll(linkedHashSet);
        this.uiManager = uIManager;
        this.loginType = loginType;
        this.initialPhoneNumber = phoneNumber;
        this.readPhoneStateEnabled = z;
        this.receiveSMSEnabled = z2;
        this.responseType = responseType;
        this.smsBlacklist = strArr;
        this.smsWhitelist = strArr2;
    }

    public boolean areFacebookNotificationsEnabled() {
        return getNotificationChannels().contains(NotificationChannel.FACEBOOK);
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    @Nullable
    @Deprecated
    public AdvancedUIManager getAdvancedUIManager() {
        if (this.uiManager instanceof AdvancedUIManagerWrapper) {
            return ((AdvancedUIManagerWrapper) this.uiManager).getAdvancedUIManager();
        }
        return null;
    }

    public String getDefaultCountryCode() {
        return this.defaultCountryCode;
    }

    public String getInitialAuthState() {
        return this.initialAuthState;
    }

    public String getInitialEmail() {
        return this.initialEmail;
    }

    public PhoneNumber getInitialPhoneNumber() {
        return this.initialPhoneNumber;
    }

    public LoginType getLoginType() {
        return this.loginType;
    }

    public List<NotificationChannel> getNotificationChannels() {
        return Collections.unmodifiableList(new ArrayList(this.notificationChannels));
    }

    public AccountKitActivity.ResponseType getResponseType() {
        return this.responseType;
    }

    public String[] getSmsBlacklist() {
        return this.smsBlacklist;
    }

    public String[] getSmsWhitelist() {
        return this.smsWhitelist;
    }

    @Deprecated
    public int getTheme() {
        return this.uiManager.getThemeId();
    }

    @Deprecated
    public AccountKitActivity.TitleType getTitleType() {
        return null;
    }

    @NonNull
    public UIManager getUIManager() {
        return this.uiManager;
    }

    public boolean isReadPhoneStateEnabled() {
        return this.readPhoneStateEnabled;
    }

    public boolean isReceiveSMSEnabled() {
        return this.receiveSMSEnabled;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeParcelable(this.uiManager, i);
        parcel.writeString(this.defaultCountryCode);
        NotificationChannel[] notificationChannelArr = new NotificationChannel[this.notificationChannels.size()];
        this.notificationChannels.toArray(notificationChannelArr);
        int[] iArr = new int[notificationChannelArr.length];
        for (int i2 = 0; i2 < notificationChannelArr.length; i2++) {
            iArr[i2] = notificationChannelArr[i2].ordinal();
        }
        parcel.writeIntArray(iArr);
        parcel.writeString(this.initialAuthState);
        parcel.writeString(this.initialEmail);
        parcel.writeParcelable(this.initialPhoneNumber, i);
        parcel.writeString(this.loginType.name());
        parcel.writeByte(this.readPhoneStateEnabled ? (byte) 1 : (byte) 0);
        parcel.writeByte(this.receiveSMSEnabled ? (byte) 1 : (byte) 0);
        parcel.writeString(this.responseType.name());
        parcel.writeStringArray(this.smsBlacklist);
        parcel.writeStringArray(this.smsWhitelist);
    }
}
