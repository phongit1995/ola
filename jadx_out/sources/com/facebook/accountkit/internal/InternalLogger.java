package com.facebook.accountkit.internal;

import android.content.Context;
import android.os.Bundle;
import com.facebook.accountkit.AccountKitError;
import java.security.InvalidParameterException;
import java.util.UUID;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public final class InternalLogger {
    public static final String EVENT_AUTOFILL_EMAIL_BY_GOOGLE = "autofill_email_by_google";
    public static final String EVENT_AUTOFILL_NUMBER_BY_DEVICE = "autofill_number_by_device";
    public static final String EVENT_AUTOFILL_NUMBER_BY_GOOGLE = "autofill_number_by_google";
    public static final String EVENT_INVALID_UI_MANAGER = "ak_ui_manager_invalid";
    public static final String EVENT_NAME_ACCOUNT_VERIFIED_VIEW = "ak_account_verified_view";
    public static final String EVENT_NAME_CONFIRMATION_CODE_VIEW = "ak_confirmation_code_view";
    public static final String EVENT_NAME_CONFIRM_ACCOUNT_VERIFIED_VIEW = "ak_confirm_account_verified_view";
    public static final String EVENT_NAME_CONFIRM_SEAMLESS_PENDING = "ak_seamless_pending";
    public static final String EVENT_NAME_COUNTRY_CODE_VIEW = "ak_country_code_view";
    public static final String EVENT_NAME_CUSTOM_VIEW = "ak_custom_view";
    public static final String EVENT_NAME_EMAIL_AUTOFILLED = "ak_email_autofilled";
    public static final String EVENT_NAME_EMAIL_VERIFY_VIEW = "ak_email_sent_view";
    public static final String EVENT_NAME_EMAIL_VIEW = "ak_email_login_view";
    public static final String EVENT_NAME_ERROR_VIEW = "ak_error_view";
    public static final String EVENT_NAME_FETCH_SEAMLESS_LOGIN_TOKEN = "ak_fetch_seamless_login_token";
    public static final String EVENT_NAME_LOGIN_COMPLETE = "ak_login_complete";
    public static final String EVENT_NAME_LOGIN_START = "ak_login_start";
    public static final String EVENT_NAME_LOGIN_VERIFY = "ak_login_verify";
    public static final String EVENT_NAME_LOG_OUT = "ak_log_out";
    public static final String EVENT_NAME_LOG_OUT_ERROR = "ak_log_out_error";
    public static final String EVENT_NAME_PHONE_AUTOFILLED = "ak_phone_number_autofilled";
    public static final String EVENT_NAME_PHONE_NUMBER_VIEW = "ak_phone_login_view";
    public static final String EVENT_NAME_RESEND_VIEW = "ak_resend_view";
    public static final String EVENT_NAME_SDK_START = "ak_sdk_init";
    public static final String EVENT_NAME_SENDING_CODE_VIEW = "ak_sending_code_view";
    public static final String EVENT_NAME_SENT_CODE_VIEW = "ak_sent_code_view";
    public static final String EVENT_NAME_SET_CONFIRMATION_CODE = "ak_confirmation_code_set";
    public static final String EVENT_NAME_UI_MANAGER_VIEW = "ak_ui_manager_view";
    public static final String EVENT_NAME_UPDATE_COMPLETE = "ak_update_complete";
    public static final String EVENT_NAME_UPDATE_START = "ak_update_start";
    public static final String EVENT_NAME_UPDATE_VERIFY = "ak_update_verify";
    public static final String EVENT_NAME_VERIFIED_CODE_VIEW = "ak_verified_code_view";
    public static final String EVENT_NAME_VERIFYING_CODE_VIEW = "ak_verifying_code_view";
    private static final String EVENT_PARAM_AUTH_LOGGER_ID = "0_logger_ref";
    private static final String EVENT_PARAM_COUNTRY_CODE = "9_country_code";
    private static final String EVENT_PARAM_ERROR_CODE = "5_error_code";
    private static final String EVENT_PARAM_ERROR_MESSAGE = "6_error_message";
    private static final String EVENT_PARAM_EXTRAS = "7_extras";
    public static final String EVENT_PARAM_EXTRAS_AUTOFILL_EMAIL_METHOD = "autofill_email_method";
    public static final String EVENT_PARAM_EXTRAS_AUTOFILL_NUMBER_METHOD = "autofill_number_method";
    public static final String EVENT_PARAM_EXTRAS_BUTTON_CLICKED_TYPE = "button_type";
    public static final String EVENT_PARAM_EXTRAS_COMPLETED = "completed";
    public static final String EVENT_PARAM_EXTRAS_CONFIRMATION_CODE = "confirmation_code";
    public static final String EVENT_PARAM_EXTRAS_COUNTRY_CODE = "country_code";
    public static final String EVENT_PARAM_EXTRAS_COUNTRY_CODE_SOURCE = "country_code_source";
    public static final String EVENT_PARAM_EXTRAS_CUSTOM_VIEW_PROVIDED = "view_provided";
    public static final String EVENT_PARAM_EXTRAS_CUSTOM_VIEW_TYPE = "view_type";
    public static final String EVENT_PARAM_EXTRAS_EMAIL = "submitted_email";
    public static final String EVENT_PARAM_EXTRAS_EMAIL_APP_SUPPLIED_USE = "email_app_supplied_use";
    public static final String EVENT_PARAM_EXTRAS_EMAIL_SELECTED_USE = "email_selected_use";
    public static final String EVENT_PARAM_EXTRAS_EQUALS = "equals";
    public static final String EVENT_PARAM_EXTRAS_ERROR = "error";
    public static final String EVENT_PARAM_EXTRAS_FALSE = "false";
    public static final String EVENT_PARAM_EXTRAS_FETCH_STATUS = "fetch_status";
    public static final String EVENT_PARAM_EXTRAS_GET_ACCOUNTS_PERM = "get_accounts_perm";
    public static final String EVENT_PARAM_EXTRAS_LINK = "link";
    public static final String EVENT_PARAM_EXTRAS_NOT_COMPLETED = "not_completed";
    public static final String EVENT_PARAM_EXTRAS_NOT_EQUALS = "notEquals";
    public static final String EVENT_PARAM_EXTRAS_NOT_SUPPLIED = "notSupplied";
    public static final String EVENT_PARAM_EXTRAS_PHONE_NUMBER_SOURCE = "phone_number_source";
    public static final String EVENT_PARAM_EXTRAS_READ_NUMBER_PERM = "read_phone_number_permission";
    public static final String EVENT_PARAM_EXTRAS_RECEIVE_SMS_PERM = "read_sms_permission";
    public static final String EVENT_PARAM_EXTRAS_RETRY = "retry";
    public static final String EVENT_PARAM_EXTRAS_SIM_LOCALE = "sim_locale";
    public static final String EVENT_PARAM_EXTRAS_SKIN_MANAGER_HAS_BG_IMAGE = "skin_manager_has_background_image";
    public static final String EVENT_PARAM_EXTRAS_SKIN_MANAGER_PRIMARY_COLOR = "skin_manager_primary_color";
    public static final String EVENT_PARAM_EXTRAS_SKIN_MANAGER_TINT = "skin_manager_tint";
    public static final String EVENT_PARAM_EXTRAS_SKIN_MANAGER_TINT_INTENSITY = "skin_manager_tint_intensity";
    public static final String EVENT_PARAM_EXTRAS_SKIN_TYPE = "skin_type";
    public static final String EVENT_PARAM_EXTRAS_STARTED = "started";
    public static final String EVENT_PARAM_EXTRAS_SUBMITTED_PHONE_NUMBER = "submitted_phone_number";
    public static final String EVENT_PARAM_EXTRAS_TRUE = "true";
    public static final String EVENT_PARAM_EXTRAS_UIMANAGER = "ui_manager";
    private static final String EVENT_PARAM_LOGIN_RESULT = "4_result";
    private static final String EVENT_PARAM_LOGIN_TYPE = "3_type";
    public static final String EVENT_PARAM_LOGIN_TYPE_VALUE_EMAIL = "email";
    public static final String EVENT_PARAM_LOGIN_TYPE_VALUE_PHONE = "phone";
    private static final String EVENT_PARAM_SDK = "11_sdk";
    public static final String EVENT_PARAM_SDK_ANDROID = "Android";
    private static final String EVENT_PARAM_STATE = "2_state";
    private static final String EVENT_PARAM_TIMESTAMP = "1_timestamp_ms";
    public static final String EVENT_PARAM_TYPE_VALUE_PHONE_UPDATE = "phone_update";
    public static final String EVENT_PARAM_UIMANAGER_ADVANCED = "AdvancedUIManager";
    public static final String EVENT_PARAM_UIMANAGER_BASE = "BaseUIManager";
    public static final String EVENT_PARAM_UIMANAGER_DEFAULT = "UIManager";
    public static final String EVENT_PARAM_UIMANAGER_SKIN = "SkinManager";
    public static final String EVENT_PARAM_UIMANAGER_THEME = "ThemeUIManager";
    private static final String EVENT_PARAM_VERIFICATION_METHOD = "10_verification_method";
    public static final String EVENT_PARAM_VERIFICATION_METHOD_CONFIRMATION_CODE = "confirmation_code";
    public static final String EVENT_PARAM_VERIFICATION_METHOD_INSTANT_VERIFICATION = "instant_verification";
    private static final String EVENT_PARAM_VIEW_STATE = "8_view_state";
    public static final String EVENT_PARAM_VIEW_STATE_DISMISSED = "dismissed";
    public static final String EVENT_PARAM_VIEW_STATE_PRESENTED = "presented";
    public static final String EVENT_PARAM_VIEW_STATE_VISIBLE = "visible";
    private static final String SAVED_LOGGING_REF = "accountkitLoggingRef";
    private final Context applicationContext;
    private final String applicationId;
    private final boolean facebookAppEventsEnabled;
    private String loggingRef = UUID.randomUUID().toString();

    InternalLogger(Context context, String str, boolean z) {
        this.applicationContext = context;
        this.applicationId = str;
        this.facebookAppEventsEnabled = z;
    }

    private Bundle getAuthorizationLoggingBundle() {
        Bundle bundle = new Bundle();
        bundle.putLong(EVENT_PARAM_TIMESTAMP, System.currentTimeMillis());
        bundle.putString(EVENT_PARAM_AUTH_LOGGER_ID, this.loggingRef == null ? "" : this.loggingRef);
        bundle.putString(EVENT_PARAM_STATE, "");
        bundle.putString(EVENT_PARAM_LOGIN_TYPE, "");
        bundle.putString(EVENT_PARAM_LOGIN_RESULT, "");
        bundle.putString(EVENT_PARAM_ERROR_MESSAGE, "");
        bundle.putString(EVENT_PARAM_VIEW_STATE, "");
        bundle.putString(EVENT_PARAM_ERROR_CODE, "");
        bundle.putString(EVENT_PARAM_SDK, EVENT_PARAM_SDK_ANDROID);
        bundle.putString(EVENT_PARAM_EXTRAS, "");
        return bundle;
    }

    private void logFetchEvent(String str, String str2, InternalAccountKitError internalAccountKitError) {
        JSONObject jSONObject = new JSONObject();
        try {
            jSONObject.put(EVENT_PARAM_EXTRAS_FETCH_STATUS, str2);
        } catch (JSONException unused) {
        }
        Bundle authorizationLoggingBundle = getAuthorizationLoggingBundle();
        authorizationLoggingBundle.putString(EVENT_PARAM_EXTRAS, jSONObject.toString());
        if (internalAccountKitError != null) {
            authorizationLoggingBundle.putString(EVENT_PARAM_ERROR_CODE, Integer.toString(internalAccountKitError.getCode()));
            authorizationLoggingBundle.putString(EVENT_PARAM_ERROR_MESSAGE, internalAccountKitError.getMessage());
        }
        new AppEventsLogger(this.applicationContext, this.applicationId).logSdkEvent(str, null, authorizationLoggingBundle);
    }

    public boolean getFacebookAppEventsEnabled() {
        return this.facebookAppEventsEnabled && FacebookAppEventLogger.isFacebookSDKInitialized();
    }

    String getLoggingRef() {
        return this.loggingRef;
    }

    public void logButtonImpression(String str, String str2, JSONObject jSONObject) {
        Bundle authorizationLoggingBundle = getAuthorizationLoggingBundle();
        authorizationLoggingBundle.putString(EVENT_PARAM_LOGIN_TYPE, str2);
        authorizationLoggingBundle.putString(EVENT_PARAM_VIEW_STATE, EVENT_PARAM_VIEW_STATE_VISIBLE);
        if (jSONObject != null) {
            authorizationLoggingBundle.putString(EVENT_PARAM_EXTRAS, jSONObject.toString());
        }
        new AppEventsLogger(this.applicationContext, this.applicationId).logSdkEvent(str, null, authorizationLoggingBundle);
    }

    public void logCustomUI(String str, String str2, JSONObject jSONObject) {
        Bundle authorizationLoggingBundle = getAuthorizationLoggingBundle();
        authorizationLoggingBundle.putString(EVENT_PARAM_LOGIN_TYPE, str2);
        if (jSONObject != null) {
            authorizationLoggingBundle.putString(EVENT_PARAM_EXTRAS, jSONObject.toString());
        }
        new AppEventsLogger(this.applicationContext, this.applicationId).logSdkEvent(str, null, authorizationLoggingBundle);
    }

    public void logEvent(String str) {
        new AppEventsLogger(this.applicationContext, this.applicationId).logSdkEvent(str, null, null);
    }

    public void logEvent(String str, Bundle bundle) {
        new AppEventsLogger(this.applicationContext, this.applicationId).logSdkEvent(str, null, bundle);
    }

    public void logFetchEvent(String str, String str2) {
        logFetchEvent(str, str2, null);
    }

    public void logFetchEventError(String str, InternalAccountKitError internalAccountKitError) {
        logFetchEvent(str, "error", internalAccountKitError);
    }

    public void logImpression(String str, String str2, boolean z, JSONObject jSONObject) {
        Bundle authorizationLoggingBundle = getAuthorizationLoggingBundle();
        authorizationLoggingBundle.putString(EVENT_PARAM_LOGIN_TYPE, str2);
        authorizationLoggingBundle.putString(EVENT_PARAM_VIEW_STATE, z ? EVENT_PARAM_VIEW_STATE_PRESENTED : EVENT_PARAM_VIEW_STATE_DISMISSED);
        if (jSONObject != null) {
            authorizationLoggingBundle.putString(EVENT_PARAM_EXTRAS, jSONObject.toString());
        }
        new AppEventsLogger(this.applicationContext, this.applicationId).logSdkEvent(str, null, authorizationLoggingBundle);
        if (this.facebookAppEventsEnabled) {
            new FacebookAppEventLogger(this.applicationContext).logImpression(str, authorizationLoggingBundle, z);
        }
    }

    public void logLoginModel(String str, LoginModelImpl loginModelImpl) {
        String str2;
        String countryCodeIso;
        String str3;
        String str4;
        FacebookAppEventLogger facebookAppEventLogger;
        if (loginModelImpl == null) {
            return;
        }
        Bundle authorizationLoggingBundle = getAuthorizationLoggingBundle();
        if (loginModelImpl instanceof PhoneLoginModelImpl) {
            authorizationLoggingBundle.putString(EVENT_PARAM_LOGIN_TYPE, "phone");
            str2 = EVENT_PARAM_COUNTRY_CODE;
            countryCodeIso = ((PhoneLoginModelImpl) loginModelImpl).getPhoneNumber().getCountryCodeIso();
        } else {
            if (!(loginModelImpl instanceof EmailLoginModelImpl)) {
                throw new InvalidParameterException("Unexpected loginModel type");
            }
            str2 = EVENT_PARAM_LOGIN_TYPE;
            countryCodeIso = "email";
        }
        authorizationLoggingBundle.putString(str2, countryCodeIso);
        authorizationLoggingBundle.putString(EVENT_PARAM_STATE, loginModelImpl.getStatus().toString());
        AccountKitError error = loginModelImpl.getError();
        if (error != null) {
            authorizationLoggingBundle.putString(EVENT_PARAM_ERROR_CODE, Integer.toString(error.getErrorType().getCode()));
            authorizationLoggingBundle.putString(EVENT_PARAM_ERROR_MESSAGE, error.getErrorType().getMessage());
        }
        new AppEventsLogger(this.applicationContext, this.applicationId).logSdkEvent(str, null, authorizationLoggingBundle);
        if (this.facebookAppEventsEnabled) {
            if (!str.equals(EVENT_NAME_CONFIRM_SEAMLESS_PENDING) && !str.equals(EVENT_NAME_FETCH_SEAMLESS_LOGIN_TOKEN)) {
                if (str.equals(EVENT_NAME_LOGIN_VERIFY) || str.equals(EVENT_NAME_LOGIN_COMPLETE)) {
                    str3 = EVENT_PARAM_VERIFICATION_METHOD;
                    str4 = "confirmation_code";
                }
                facebookAppEventLogger = new FacebookAppEventLogger(this.applicationContext);
                if (str.equals(EVENT_NAME_LOGIN_COMPLETE) && (loginModelImpl instanceof EmailLoginModelImpl)) {
                    facebookAppEventLogger.logFacebookAppEvents(EVENT_NAME_LOGIN_VERIFY, null, authorizationLoggingBundle);
                }
                facebookAppEventLogger.logFacebookAppEvents(str, null, authorizationLoggingBundle);
            }
            str3 = EVENT_PARAM_VERIFICATION_METHOD;
            str4 = EVENT_PARAM_VERIFICATION_METHOD_INSTANT_VERIFICATION;
            authorizationLoggingBundle.putString(str3, str4);
            facebookAppEventLogger = new FacebookAppEventLogger(this.applicationContext);
            if (str.equals(EVENT_NAME_LOGIN_COMPLETE)) {
                facebookAppEventLogger.logFacebookAppEvents(EVENT_NAME_LOGIN_VERIFY, null, authorizationLoggingBundle);
            }
            facebookAppEventLogger.logFacebookAppEvents(str, null, authorizationLoggingBundle);
        }
    }

    public void logUIManager(String str, JSONObject jSONObject) {
        Bundle authorizationLoggingBundle = getAuthorizationLoggingBundle();
        if (jSONObject != null) {
            authorizationLoggingBundle.putString(EVENT_PARAM_EXTRAS, jSONObject.toString());
        }
        new AppEventsLogger(this.applicationContext, this.applicationId).logSdkEvent(str, null, authorizationLoggingBundle);
    }

    void logUpdateModel(String str, PhoneUpdateModelImpl phoneUpdateModelImpl) {
        if (phoneUpdateModelImpl == null) {
            return;
        }
        Bundle authorizationLoggingBundle = getAuthorizationLoggingBundle();
        authorizationLoggingBundle.putString(EVENT_PARAM_LOGIN_TYPE, EVENT_PARAM_TYPE_VALUE_PHONE_UPDATE);
        authorizationLoggingBundle.putString(EVENT_PARAM_COUNTRY_CODE, phoneUpdateModelImpl.getPhoneNumber().getCountryCodeIso());
        authorizationLoggingBundle.putString(EVENT_PARAM_STATE, phoneUpdateModelImpl.getStatus().toString());
        AccountKitError error = phoneUpdateModelImpl.getError();
        if (error != null) {
            authorizationLoggingBundle.putString(EVENT_PARAM_ERROR_CODE, Integer.toString(error.getErrorType().getCode()));
            authorizationLoggingBundle.putString(EVENT_PARAM_ERROR_MESSAGE, error.getErrorType().getMessage());
        }
        new AppEventsLogger(this.applicationContext, this.applicationId).logSdkEvent(str, null, authorizationLoggingBundle);
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    void onActivityCreate(Bundle bundle) {
        this.loggingRef = bundle != null ? bundle.getString(SAVED_LOGGING_REF) : UUID.randomUUID().toString();
    }

    void saveInstanceState(Bundle bundle) {
        bundle.putString(SAVED_LOGGING_REF, this.loggingRef);
    }
}
