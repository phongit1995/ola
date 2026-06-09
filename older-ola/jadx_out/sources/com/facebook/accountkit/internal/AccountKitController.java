package com.facebook.accountkit.internal;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import com.facebook.accountkit.AccessToken;
import com.facebook.accountkit.Account;
import com.facebook.accountkit.AccountKit;
import com.facebook.accountkit.AccountKitCallback;
import com.facebook.accountkit.EmailLoginModel;
import com.facebook.accountkit.PhoneLoginModel;
import com.facebook.accountkit.PhoneNumber;
import com.facebook.accountkit.PhoneUpdateModel;
import com.facebook.accountkit.ui.AdvancedUIManagerWrapper;
import com.facebook.accountkit.ui.BaseUIManager;
import com.facebook.accountkit.ui.LoginType;
import com.facebook.accountkit.ui.NotificationChannel;
import com.facebook.accountkit.ui.SkinManager;
import com.facebook.accountkit.ui.ThemeUIManager;
import com.facebook.accountkit.ui.UIManager;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public final class AccountKitController {
    private static final String ACCOUNT_KIT_PREFERENCES = "com.facebook.accountkit.internal.AccountKitController.preferences";
    private static final String GRAPH_BASE_HOST = "graph.accountkit.com";
    private static final String GRAPH_HOST_PREFERENCE_KEY = "AccountHost";
    private static final Initializer initializer = new Initializer();
    private static final ExperimentationConfigurator experimentationConfigurator = new ExperimentationConfigurator();

    public static class Logger {
        public static void logEvent(String str, Bundle bundle) {
            AccountKitController.initializer.getLogger().logEvent(str, bundle);
        }

        public static void logInvalidUIManager() {
            logUIInteraction(InternalLogger.EVENT_INVALID_UI_MANAGER, null);
        }

        public static void logUIAccountVerified(boolean z) {
            AccountKitController.initializer.getLogger().logImpression(InternalLogger.EVENT_NAME_ACCOUNT_VERIFIED_VIEW, "phone", z, null);
        }

        public static void logUIConfirmAccountVerified(boolean z) {
            AccountKitController.initializer.getLogger().logImpression(InternalLogger.EVENT_NAME_CONFIRM_ACCOUNT_VERIFIED_VIEW, "phone", z, null);
        }

        public static void logUIConfirmSeamlessLoginInteraction(String str) {
            logUIInteraction(InternalLogger.EVENT_NAME_CONFIRM_ACCOUNT_VERIFIED_VIEW, str);
        }

        public static void logUIConfirmationCode() {
            AccountKitController.initializer.getLogger().logImpression(InternalLogger.EVENT_NAME_CONFIRMATION_CODE_VIEW, "phone", false, null);
        }

        public static void logUIConfirmationCodeInteraction(String str) {
            logUIInteraction(InternalLogger.EVENT_NAME_CONFIRMATION_CODE_VIEW, str, null);
        }

        public static void logUIConfirmationCodeInteraction(String str, @Nullable String str2) {
            JSONObject jSONObject = new JSONObject();
            if (str2 != null) {
                try {
                    jSONObject.put("link", str2);
                } catch (JSONException unused) {
                }
            }
            logUIInteraction(InternalLogger.EVENT_NAME_CONFIRMATION_CODE_VIEW, str, jSONObject);
        }

        public static void logUIConfirmationCodeInteraction(String str, String str2, String str3) {
            String str4;
            String str5;
            JSONObject jSONObject = new JSONObject();
            if (!Utility.isNullOrEmpty(str2)) {
                if (!Utility.isNullOrEmpty(str3)) {
                    if (str2.equals(str3)) {
                        str4 = "confirmation_code";
                        str5 = InternalLogger.EVENT_PARAM_EXTRAS_EQUALS;
                    } else {
                        str4 = "confirmation_code";
                        str5 = InternalLogger.EVENT_PARAM_EXTRAS_NOT_EQUALS;
                    }
                }
                logUIInteraction(InternalLogger.EVENT_NAME_CONFIRMATION_CODE_VIEW, str, jSONObject);
            }
            str4 = "confirmation_code";
            str5 = InternalLogger.EVENT_PARAM_EXTRAS_NOT_SUPPLIED;
            jSONObject.put(str4, str5);
            logUIInteraction(InternalLogger.EVENT_NAME_CONFIRMATION_CODE_VIEW, str, jSONObject);
        }

        public static void logUIConfirmationCodeShown(boolean z) {
            JSONObject jSONObject = new JSONObject();
            try {
                jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_RETRY, z ? "true" : InternalLogger.EVENT_PARAM_EXTRAS_FALSE);
            } catch (JSONException unused) {
            }
            AccountKitController.initializer.getLogger().logImpression(InternalLogger.EVENT_NAME_CONFIRMATION_CODE_VIEW, "phone", true, jSONObject);
        }

        public static void logUICountryCode(boolean z, String str) {
            JSONObject jSONObject = new JSONObject();
            try {
                jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_COUNTRY_CODE, str);
            } catch (JSONException unused) {
            }
            AccountKitController.initializer.getLogger().logImpression(InternalLogger.EVENT_NAME_COUNTRY_CODE_VIEW, "phone", z, jSONObject);
        }

        public static void logUICustomFragment(LoginType loginType, String str, boolean z) {
            JSONObject jSONObject = new JSONObject();
            try {
                jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_CUSTOM_VIEW_TYPE, str);
                jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_CUSTOM_VIEW_PROVIDED, z);
            } catch (JSONException unused) {
            }
            AccountKitController.initializer.getLogger().logCustomUI(InternalLogger.EVENT_NAME_CUSTOM_VIEW, loginType.equals(LoginType.PHONE) ? "phone" : "email", jSONObject);
        }

        public static void logUIEmailLogin() {
            AccountKitController.initializer.getLogger().logImpression(InternalLogger.EVENT_NAME_EMAIL_VIEW, "email", false, null);
        }

        public static void logUIEmailLoginInteraction(String str, String str2, String str3, String str4) {
            JSONObject jSONObject = new JSONObject();
            try {
                jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_EMAIL, str4);
                jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_EMAIL_APP_SUPPLIED_USE, str2);
                jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_EMAIL_SELECTED_USE, str3);
            } catch (JSONException unused) {
            }
            logUIInteraction(InternalLogger.EVENT_NAME_EMAIL_VIEW, str, jSONObject);
        }

        public static void logUIEmailLoginShown(boolean z) {
            JSONObject jSONObject = new JSONObject();
            try {
                jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_GET_ACCOUNTS_PERM, Utility.hasGetAccountsPermissions(AccountKitController.initializer.getApplicationContext()) ? "true" : InternalLogger.EVENT_PARAM_EXTRAS_FALSE);
                jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_RETRY, z ? "true" : InternalLogger.EVENT_PARAM_EXTRAS_FALSE);
            } catch (JSONException unused) {
            }
            AccountKitController.initializer.getLogger().logImpression(InternalLogger.EVENT_NAME_EMAIL_VIEW, "email", true, jSONObject);
        }

        public static void logUIEmailVerify(boolean z) {
            AccountKitController.initializer.getLogger().logImpression(InternalLogger.EVENT_NAME_EMAIL_VERIFY_VIEW, "email", z, null);
        }

        public static void logUIEmailVerifyInteraction(String str) {
            logUIInteraction(InternalLogger.EVENT_NAME_EMAIL_VERIFY_VIEW, str, null);
        }

        public static void logUIError(boolean z, LoginType loginType) {
            AccountKitController.initializer.getLogger().logImpression(InternalLogger.EVENT_NAME_ERROR_VIEW, loginType.equals(LoginType.PHONE) ? "phone" : "email", z, null);
        }

        public static void logUIErrorInteraction(String str) {
            logUIInteraction(InternalLogger.EVENT_NAME_ERROR_VIEW, str);
        }

        private static void logUIInteraction(String str, String str2) {
            logUIInteraction(str, str2, null);
        }

        private static void logUIInteraction(String str, String str2, JSONObject jSONObject) {
            if (jSONObject == null) {
                jSONObject = new JSONObject();
            }
            try {
                jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_BUTTON_CLICKED_TYPE, str2);
            } catch (JSONException unused) {
            }
            AccountKitController.initializer.getLogger().logButtonImpression(str, "phone", jSONObject);
        }

        public static void logUIManager(UIManager uIManager) {
            JSONObject jSONObject = new JSONObject();
            try {
                jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_UIMANAGER, uIManager instanceof SkinManager ? InternalLogger.EVENT_PARAM_UIMANAGER_SKIN : uIManager instanceof AdvancedUIManagerWrapper ? InternalLogger.EVENT_PARAM_UIMANAGER_ADVANCED : uIManager instanceof ThemeUIManager ? InternalLogger.EVENT_PARAM_UIMANAGER_THEME : uIManager instanceof BaseUIManager ? InternalLogger.EVENT_PARAM_UIMANAGER_BASE : InternalLogger.EVENT_PARAM_UIMANAGER_DEFAULT);
                if (uIManager instanceof SkinManager) {
                    SkinManager skinManager = (SkinManager) uIManager;
                    jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_SKIN_TYPE, skinManager.getSkin());
                    jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_SKIN_MANAGER_HAS_BG_IMAGE, skinManager.hasBackgroundImage());
                    jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_SKIN_MANAGER_PRIMARY_COLOR, skinManager.getPrimaryColor());
                    jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_SKIN_MANAGER_TINT, skinManager.getTint());
                    jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_SKIN_MANAGER_TINT_INTENSITY, skinManager.getTintIntensity());
                }
            } catch (JSONException unused) {
            }
            AccountKitController.initializer.getLogger().logUIManager(InternalLogger.EVENT_NAME_UI_MANAGER_VIEW, jSONObject);
        }

        public static void logUIPhoneLogin() {
            AccountKitController.initializer.getLogger().logImpression(InternalLogger.EVENT_NAME_PHONE_NUMBER_VIEW, "phone", false, null);
        }

        public static void logUIPhoneLoginInteraction(String str, String str2) {
            JSONObject jSONObject = new JSONObject();
            if (str2 != null) {
                try {
                    jSONObject.put("link", str2);
                } catch (JSONException unused) {
                }
            }
            logUIInteraction(InternalLogger.EVENT_NAME_PHONE_NUMBER_VIEW, str, jSONObject);
        }

        public static void logUIPhoneLoginInteraction(String str, String str2, PhoneNumber phoneNumber) {
            JSONObject jSONObject = new JSONObject();
            try {
                jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_PHONE_NUMBER_SOURCE, str2);
                jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_SUBMITTED_PHONE_NUMBER, phoneNumber.toString());
            } catch (JSONException unused) {
            }
            logUIInteraction(InternalLogger.EVENT_NAME_PHONE_NUMBER_VIEW, str, jSONObject);
        }

        public static void logUIPhoneLoginShown(String str, String str2, boolean z) {
            JSONObject jSONObject = new JSONObject();
            try {
                jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_COUNTRY_CODE, str);
                jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_COUNTRY_CODE_SOURCE, str2);
                jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_READ_NUMBER_PERM, Utility.hasReadPhoneStatePermissions(AccountKitController.initializer.getApplicationContext()) ? "true" : InternalLogger.EVENT_PARAM_EXTRAS_FALSE);
                jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_RECEIVE_SMS_PERM, Utility.hasReceiveSmsPermissions(AccountKitController.initializer.getApplicationContext()) ? "true" : InternalLogger.EVENT_PARAM_EXTRAS_FALSE);
                jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_SIM_LOCALE, Utility.getCurrentCountry(AccountKitController.initializer.getApplicationContext()));
                jSONObject.put(InternalLogger.EVENT_PARAM_EXTRAS_RETRY, z ? "true" : InternalLogger.EVENT_PARAM_EXTRAS_FALSE);
            } catch (JSONException unused) {
            }
            AccountKitController.initializer.getLogger().logImpression(InternalLogger.EVENT_NAME_PHONE_NUMBER_VIEW, "phone", true, jSONObject);
        }

        public static void logUIResend(boolean z) {
            AccountKitController.initializer.getLogger().logImpression(InternalLogger.EVENT_NAME_RESEND_VIEW, "phone", z, null);
        }

        public static void logUIResendInteraction(String str) {
            logUIInteraction(InternalLogger.EVENT_NAME_RESEND_VIEW, str);
        }

        public static void logUISendingCode(boolean z, LoginType loginType) {
            AccountKitController.initializer.getLogger().logImpression(InternalLogger.EVENT_NAME_SENDING_CODE_VIEW, loginType.equals(LoginType.PHONE) ? "phone" : "email", z, null);
        }

        public static void logUISentCode(boolean z, LoginType loginType) {
            AccountKitController.initializer.getLogger().logImpression(InternalLogger.EVENT_NAME_SENT_CODE_VIEW, loginType.equals(LoginType.PHONE) ? "phone" : "email", z, null);
        }

        public static void logUIVerifiedCode(boolean z, LoginType loginType) {
            AccountKitController.initializer.getLogger().logImpression(InternalLogger.EVENT_NAME_VERIFIED_CODE_VIEW, loginType.equals(LoginType.PHONE) ? "phone" : "email", z, null);
        }

        public static void logUIVerifyingCode(boolean z, LoginType loginType) {
            AccountKitController.initializer.getLogger().logImpression(InternalLogger.EVENT_NAME_VERIFYING_CODE_VIEW, loginType.equals(LoginType.PHONE) ? "phone" : "email", z, null);
        }
    }

    public static void cancelLogin() {
        initializer.getLoginManager().cancelLogin();
    }

    public static void cancelUpdate() {
        initializer.getUpdateManager().cancelExisting();
    }

    public static void continueLoginWithCode(String str) {
        initializer.getLoginManager().continueWithCode(str);
    }

    public static void continueSeamlessLogin() {
        initializer.getLoginManager().continueSeamlessLogin();
    }

    public static void continueUpdateWithCode(String str) {
        initializer.getUpdateManager().continueWithCode(str);
    }

    public static boolean getAccountKitFacebookAppEventsEnabled() {
        return initializer.getAccountKitFacebookAppEventsEnabled();
    }

    public static Context getApplicationContext() {
        return initializer.getApplicationContext();
    }

    public static String getApplicationId() {
        return initializer.getApplicationId();
    }

    public static String getApplicationName() {
        return initializer.getApplicationName();
    }

    public static String getBaseGraphHost() {
        return getApplicationContext().getSharedPreferences(ACCOUNT_KIT_PREFERENCES, 0).getString(GRAPH_HOST_PREFERENCE_KEY, GRAPH_BASE_HOST);
    }

    public static String getClientToken() {
        return initializer.getClientToken();
    }

    @Nullable
    public static AccessToken getCurrentAccessToken() {
        return initializer.getAccessTokenManager().getCurrentAccessToken();
    }

    public static void getCurrentAccount(AccountKitCallback<Account> accountKitCallback) {
        initializer.getLoginManager().getCurrentAccount(accountKitCallback);
    }

    public static EmailLoginModel getCurrentEmailLogInModel() {
        return initializer.getLoginManager().getCurrentEmailLogInModel();
    }

    public static PhoneLoginModel getCurrentPhoneNumberLogInModel() {
        return initializer.getLoginManager().getCurrentPhoneNumberLogInModel();
    }

    public static ExperimentationConfiguration getExperimentationConfiguration() {
        return experimentationConfigurator.getExperimentationConfiguration();
    }

    public static void initialize(Context context, AccountKit.InitializeCallback initializeCallback) {
        initializer.initialize(context, initializeCallback);
        experimentationConfigurator.initialize(context);
    }

    public static void initializeLogin() {
        initializer.getLoginManager().initializeLogin();
    }

    public static boolean isInitialized() {
        return initializer.isInitialized();
    }

    public static EmailLoginModel logInWithEmail(String str, String str2, @Nullable String str3) {
        if (getCurrentAccessToken() != null) {
            logOut();
        }
        return initializer.getLoginManager().logInWithEmail(str, str2, str3);
    }

    public static PhoneLoginModel logInWithPhoneNumber(PhoneNumber phoneNumber, NotificationChannel notificationChannel, String str, @Nullable String str2) {
        if (getCurrentAccessToken() != null) {
            logOut();
        }
        return initializer.getLoginManager().logInWithPhoneNumber(phoneNumber, notificationChannel, str, str2);
    }

    public static void logOut() {
        initializer.getLoginManager().logOut();
    }

    public static void logOut(AccountKitCallback<Void> accountKitCallback) {
        initializer.getLoginManager().logOut(accountKitCallback);
    }

    public static void onActivityCreate(Activity activity, Bundle bundle) {
        initializer.getLoginManager().onActivityCreate(activity, bundle);
    }

    public static void onActivityDestroy(Activity activity) {
        initializer.getLoginManager().onActivityDestroy(activity);
    }

    public static void onActivitySaveInstanceState(Activity activity, Bundle bundle) {
        initializer.getLoginManager().onActivitySaveInstanceState(activity, bundle);
    }

    public static void onUpdateActivityCreate(Activity activity, Bundle bundle) {
        initializer.getUpdateManager().onActivityCreate(activity, bundle);
    }

    public static void onUpdateActivityDestroy(Activity activity) {
        initializer.getUpdateManager().onActivityDestroy(activity);
    }

    public static void onUpdateActivitySaveInstanceState(Activity activity, Bundle bundle) {
        initializer.getUpdateManager().onActivitySaveInstanceState(activity, bundle);
    }

    public static void setBaseGraphHost(String str) {
        getApplicationContext().getSharedPreferences(ACCOUNT_KIT_PREFERENCES, 0).edit().putString(GRAPH_HOST_PREFERENCE_KEY, str).apply();
    }

    @Nullable
    public static PhoneUpdateModel updatePhoneNumber(PhoneNumber phoneNumber, @Nullable String str) {
        return initializer.getUpdateManager().updatePhoneNumber(phoneNumber, str);
    }
}
