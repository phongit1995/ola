package com.google.firebase.auth;

import android.app.Activity;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.logging.Logger;
import com.google.android.gms.tasks.TaskExecutors;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseException;
import java.util.concurrent.Executor;
import java.util.concurrent.TimeUnit;

/* JADX INFO: loaded from: classes2.dex */
public class PhoneAuthProvider {
    public static final String PHONE_SIGN_IN_METHOD = "phone";
    public static final String PROVIDER_ID = "phone";
    private FirebaseAuth zzfc;

    @SafeParcelable.Class(creator = "DefaultForceResendingTokenCreator")
    public static class ForceResendingToken extends AbstractSafeParcelable {
        public static final Parcelable.Creator<ForceResendingToken> CREATOR = new zzc();

        @SafeParcelable.Constructor
        ForceResendingToken() {
        }

        public static ForceResendingToken zzs() {
            return new ForceResendingToken();
        }

        @Override // android.os.Parcelable
        public void writeToParcel(Parcel parcel, int i) {
            SafeParcelWriter.finishObjectHeader(parcel, SafeParcelWriter.beginObjectHeader(parcel));
        }
    }

    public static abstract class OnVerificationStateChangedCallbacks {
        private static final Logger zzdx = new Logger("PhoneAuthProvider", new String[0]);

        public void onCodeAutoRetrievalTimeOut(String str) {
            zzdx.i("Sms auto retrieval timed-out.", new Object[0]);
        }

        public void onCodeSent(String str, ForceResendingToken forceResendingToken) {
        }

        public abstract void onVerificationCompleted(PhoneAuthCredential phoneAuthCredential);

        public abstract void onVerificationFailed(FirebaseException firebaseException);
    }

    private PhoneAuthProvider(FirebaseAuth firebaseAuth) {
        this.zzfc = firebaseAuth;
    }

    public static PhoneAuthCredential getCredential(@NonNull String str, @NonNull String str2) {
        return new PhoneAuthCredential(str, str2, false, null, true, null);
    }

    public static PhoneAuthProvider getInstance() {
        return new PhoneAuthProvider(FirebaseAuth.getInstance(FirebaseApp.getInstance()));
    }

    public static PhoneAuthProvider getInstance(FirebaseAuth firebaseAuth) {
        return new PhoneAuthProvider(firebaseAuth);
    }

    private final void zza(String str, long j, TimeUnit timeUnit, Activity activity, Executor executor, OnVerificationStateChangedCallbacks onVerificationStateChangedCallbacks, ForceResendingToken forceResendingToken) {
        this.zzfc.zza(str, j, timeUnit, onVerificationStateChangedCallbacks, activity, executor, forceResendingToken != null);
    }

    public void verifyPhoneNumber(@NonNull String str, long j, TimeUnit timeUnit, @NonNull Activity activity, @NonNull OnVerificationStateChangedCallbacks onVerificationStateChangedCallbacks) {
        zza(Preconditions.checkNotEmpty(str), j, timeUnit, (Activity) Preconditions.checkNotNull(activity), TaskExecutors.MAIN_THREAD, (OnVerificationStateChangedCallbacks) Preconditions.checkNotNull(onVerificationStateChangedCallbacks), null);
    }

    public void verifyPhoneNumber(@NonNull String str, long j, TimeUnit timeUnit, @NonNull Activity activity, @NonNull OnVerificationStateChangedCallbacks onVerificationStateChangedCallbacks, @Nullable ForceResendingToken forceResendingToken) {
        zza(Preconditions.checkNotEmpty(str), j, timeUnit, (Activity) Preconditions.checkNotNull(activity), TaskExecutors.MAIN_THREAD, (OnVerificationStateChangedCallbacks) Preconditions.checkNotNull(onVerificationStateChangedCallbacks), forceResendingToken);
    }

    public void verifyPhoneNumber(@NonNull String str, long j, TimeUnit timeUnit, @NonNull Executor executor, @NonNull OnVerificationStateChangedCallbacks onVerificationStateChangedCallbacks) {
        zza(Preconditions.checkNotEmpty(str), j, timeUnit, null, (Executor) Preconditions.checkNotNull(executor), (OnVerificationStateChangedCallbacks) Preconditions.checkNotNull(onVerificationStateChangedCallbacks), null);
    }

    public void verifyPhoneNumber(@NonNull String str, long j, TimeUnit timeUnit, @NonNull Executor executor, @NonNull OnVerificationStateChangedCallbacks onVerificationStateChangedCallbacks, @Nullable ForceResendingToken forceResendingToken) {
        zza(Preconditions.checkNotEmpty(str), j, timeUnit, null, (Executor) Preconditions.checkNotNull(executor), (OnVerificationStateChangedCallbacks) Preconditions.checkNotNull(onVerificationStateChangedCallbacks), forceResendingToken);
    }
}
