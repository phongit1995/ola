package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import android.text.TextUtils;
import android.util.Pair;
import android.util.SparseArray;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.firebase.FirebaseError;
import com.google.firebase.auth.FirebaseAuthUserCollisionException;
import com.google.firebase.auth.PhoneAuthCredential;

/* JADX INFO: loaded from: classes2.dex */
public final class zzce {

    @VisibleForTesting
    private static final SparseArray<Pair<String, String>> zzhj;

    static {
        SparseArray<Pair<String, String>> sparseArray = new SparseArray<>();
        zzhj = sparseArray;
        sparseArray.put(FirebaseError.ERROR_INVALID_CUSTOM_TOKEN, new Pair<>("ERROR_INVALID_CUSTOM_TOKEN", "The custom token format is incorrect. Please check the documentation."));
        zzhj.put(FirebaseError.ERROR_CUSTOM_TOKEN_MISMATCH, new Pair<>("ERROR_CUSTOM_TOKEN_MISMATCH", "The custom token corresponds to a different audience."));
        zzhj.put(FirebaseError.ERROR_INVALID_CREDENTIAL, new Pair<>("ERROR_INVALID_CREDENTIAL", "The supplied auth credential is malformed or has expired."));
        zzhj.put(FirebaseError.ERROR_INVALID_EMAIL, new Pair<>("ERROR_INVALID_EMAIL", "The email address is badly formatted."));
        zzhj.put(FirebaseError.ERROR_WRONG_PASSWORD, new Pair<>("ERROR_WRONG_PASSWORD", "The password is invalid or the user does not have a password."));
        zzhj.put(FirebaseError.ERROR_USER_MISMATCH, new Pair<>("ERROR_USER_MISMATCH", "The supplied credentials do not correspond to the previously signed in user."));
        zzhj.put(FirebaseError.ERROR_REQUIRES_RECENT_LOGIN, new Pair<>("ERROR_REQUIRES_RECENT_LOGIN", "This operation is sensitive and requires recent authentication. Log in again before retrying this request."));
        zzhj.put(FirebaseError.ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL, new Pair<>("ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL", "An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address."));
        zzhj.put(FirebaseError.ERROR_EMAIL_ALREADY_IN_USE, new Pair<>("ERROR_EMAIL_ALREADY_IN_USE", "The email address is already in use by another account."));
        zzhj.put(FirebaseError.ERROR_CREDENTIAL_ALREADY_IN_USE, new Pair<>("ERROR_CREDENTIAL_ALREADY_IN_USE", "This credential is already associated with a different user account."));
        zzhj.put(FirebaseError.ERROR_USER_DISABLED, new Pair<>("ERROR_USER_DISABLED", "The user account has been disabled by an administrator."));
        zzhj.put(FirebaseError.ERROR_USER_TOKEN_EXPIRED, new Pair<>("ERROR_USER_TOKEN_EXPIRED", "The user's credential is no longer valid. The user must sign in again."));
        zzhj.put(FirebaseError.ERROR_USER_NOT_FOUND, new Pair<>("ERROR_USER_NOT_FOUND", "There is no user record corresponding to this identifier. The user may have been deleted."));
        zzhj.put(FirebaseError.ERROR_INVALID_USER_TOKEN, new Pair<>("ERROR_INVALID_USER_TOKEN", "This user's credential isn't valid for this project. This can happen if the user's token has been tampered with, or if the user isn't for the project associated with this API key."));
        zzhj.put(FirebaseError.ERROR_OPERATION_NOT_ALLOWED, new Pair<>("ERROR_OPERATION_NOT_ALLOWED", "The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section."));
        zzhj.put(FirebaseError.ERROR_WEAK_PASSWORD, new Pair<>("ERROR_WEAK_PASSWORD", "The given password is invalid."));
        zzhj.put(17029, new Pair<>("ERROR_EXPIRED_ACTION_CODE", "The out of band code has expired."));
        zzhj.put(17030, new Pair<>("ERROR_INVALID_ACTION_CODE", "The out of band code is invalid. This can happen if the code is malformed, expired, or has already been used."));
        zzhj.put(17031, new Pair<>("ERROR_INVALID_MESSAGE_PAYLOAD", "The email template corresponding to this action contains invalid characters in its message. Please fix by going to the Auth email templates section in the Firebase Console."));
        zzhj.put(17033, new Pair<>("ERROR_INVALID_RECIPIENT_EMAIL", "The email corresponding to this action failed to send as the provided recipient email address is invalid."));
        zzhj.put(17032, new Pair<>("ERROR_INVALID_SENDER", "The email template corresponding to this action contains an invalid sender email or name. Please fix by going to the Auth email templates section in the Firebase Console."));
        zzhj.put(17034, new Pair<>("ERROR_MISSING_EMAIL", "An email address must be provided."));
        zzhj.put(17035, new Pair<>("ERROR_MISSING_PASSWORD", "A password must be provided."));
        zzhj.put(17041, new Pair<>("ERROR_MISSING_PHONE_NUMBER", "To send verification codes, provide a phone number for the recipient."));
        zzhj.put(17042, new Pair<>("ERROR_INVALID_PHONE_NUMBER", "The format of the phone number provided is incorrect. Please enter the phone number in a format that can be parsed into E.164 format. E.164 phone numbers are written in the format [+][country code][subscriber number including area code]."));
        zzhj.put(17043, new Pair<>("ERROR_MISSING_VERIFICATION_CODE", "The Phone Auth Credential was created with an empty sms verification Code"));
        zzhj.put(17044, new Pair<>("ERROR_INVALID_VERIFICATION_CODE", "The sms verification code used to create the phone auth credential is invalid. Please resend the verification code sms and be sure use the verification code provided by the user."));
        zzhj.put(17045, new Pair<>("ERROR_MISSING_VERIFICATION_ID", "The Phone Auth Credential was created with an empty verification ID"));
        zzhj.put(17046, new Pair<>("ERROR_INVALID_VERIFICATION_ID", "The verification ID used to create the phone auth credential is invalid."));
        zzhj.put(17049, new Pair<>("ERROR_RETRY_PHONE_AUTH", "An error occurred during authentication using the PhoneAuthCredential. Please retry authentication."));
        zzhj.put(17051, new Pair<>("ERROR_SESSION_EXPIRED", "The sms code has expired. Please re-send the verification code to try again."));
        zzhj.put(17052, new Pair<>("ERROR_QUOTA_EXCEEDED", "The sms quota for this project has been exceeded."));
        zzhj.put(FirebaseError.ERROR_APP_NOT_AUTHORIZED, new Pair<>("ERROR_APP_NOT_AUTHORIZED", "This app is not authorized to use Firebase Authentication. Please verifythat the correct package name and SHA-1 are configured in the Firebase Console."));
        zzhj.put(17063, new Pair<>("ERROR_API_NOT_AVAILABLE", "The API that you are calling is not available on devices without Google Play Services."));
        zzhj.put(17062, new Pair<>("ERROR_WEB_INTERNAL_ERROR", "There was an internal error in the web widget."));
        zzhj.put(17064, new Pair<>("ERROR_INVALID_CERT_HASH", "There was an error while trying to get your package certificate hash."));
        zzhj.put(17065, new Pair<>("ERROR_WEB_STORAGE_UNSUPPORTED", "This browser is not supported or 3rd party cookies and data may be disabled."));
        zzhj.put(17040, new Pair<>("ERROR_MISSING_CONTINUE_URI", "A continue URL must be provided in the request."));
        zzhj.put(17068, new Pair<>("ERROR_DYNAMIC_LINK_NOT_ACTIVATED", "Please activate Dynamic Links in the Firebase Console and agree to the terms and conditions."));
    }

    private static String zza(String str, Status status) {
        return TextUtils.isEmpty(status.getStatusMessage()) ? str : String.format(String.valueOf(str).concat(" [ %s ]"), status.getStatusMessage());
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    /* JADX WARN: Removed duplicated region for block: B:40:0x00bb  */
    /* JADX WARN: Removed duplicated region for block: B:42:0x00c5  */
    /* JADX WARN: Removed duplicated region for block: B:44:0x00cf A[FALL_THROUGH] */
    /* JADX WARN: Removed duplicated region for block: B:46:0x00d9  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static com.google.firebase.FirebaseException zzb(com.google.android.gms.common.api.Status r3) {
        /*
            Method dump skipped, instruction units count: 366
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.firebase.auth.api.internal.zzce.zzb(com.google.android.gms.common.api.Status):com.google.firebase.FirebaseException");
    }

    public static FirebaseAuthUserCollisionException zzb(Status status, @NonNull PhoneAuthCredential phoneAuthCredential) {
        int statusCode = status.getStatusCode();
        return new FirebaseAuthUserCollisionException(zzc(statusCode), zza(zzd(statusCode), status), phoneAuthCredential);
    }

    private static String zzc(int i) {
        Pair<String, String> pair = zzhj.get(i);
        return pair != null ? (String) pair.first : "INTERNAL_ERROR";
    }

    private static String zzd(int i) {
        Pair<String, String> pair = zzhj.get(i);
        return pair != null ? (String) pair.second : "An internal error happened";
    }
}
