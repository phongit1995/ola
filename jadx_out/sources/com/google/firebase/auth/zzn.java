package com.google.firebase.auth;

import com.google.firebase.FirebaseException;
import com.google.firebase.auth.PhoneAuthProvider;

/* JADX INFO: loaded from: classes2.dex */
final class zzn extends PhoneAuthProvider.OnVerificationStateChangedCallbacks {
    private final /* synthetic */ FirebaseAuth zzeo;
    private final /* synthetic */ PhoneAuthProvider.OnVerificationStateChangedCallbacks zzer;

    zzn(FirebaseAuth firebaseAuth, PhoneAuthProvider.OnVerificationStateChangedCallbacks onVerificationStateChangedCallbacks) {
        this.zzeo = firebaseAuth;
        this.zzer = onVerificationStateChangedCallbacks;
    }

    @Override // com.google.firebase.auth.PhoneAuthProvider.OnVerificationStateChangedCallbacks
    public final void onCodeAutoRetrievalTimeOut(String str) {
        this.zzer.onCodeAutoRetrievalTimeOut(str);
    }

    @Override // com.google.firebase.auth.PhoneAuthProvider.OnVerificationStateChangedCallbacks
    public final void onCodeSent(String str, PhoneAuthProvider.ForceResendingToken forceResendingToken) {
        this.zzer.onVerificationCompleted(PhoneAuthProvider.getCredential(str, this.zzeo.zzeh.getSmsCode()));
    }

    @Override // com.google.firebase.auth.PhoneAuthProvider.OnVerificationStateChangedCallbacks
    public final void onVerificationCompleted(PhoneAuthCredential phoneAuthCredential) {
        this.zzer.onVerificationCompleted(phoneAuthCredential);
    }

    @Override // com.google.firebase.auth.PhoneAuthProvider.OnVerificationStateChangedCallbacks
    public final void onVerificationFailed(FirebaseException firebaseException) {
        this.zzer.onVerificationFailed(firebaseException);
    }
}
