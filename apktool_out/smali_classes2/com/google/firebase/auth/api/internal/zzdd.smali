.class final Lcom/google/firebase/auth/api/internal/zzdd;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzdh;


# instance fields
.field private final synthetic zziy:Lcom/google/firebase/auth/PhoneAuthCredential;


# direct methods
.method constructor <init>(Lcom/google/firebase/auth/api/internal/zzdb;Lcom/google/firebase/auth/PhoneAuthCredential;)V
    .locals 0

    iput-object p2, p0, Lcom/google/firebase/auth/api/internal/zzdd;->zziy:Lcom/google/firebase/auth/PhoneAuthCredential;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final varargs zza(Lcom/google/firebase/auth/PhoneAuthProvider$OnVerificationStateChangedCallbacks;[Ljava/lang/Object;)V
    .locals 0

    iget-object p2, p0, Lcom/google/firebase/auth/api/internal/zzdd;->zziy:Lcom/google/firebase/auth/PhoneAuthCredential;

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/PhoneAuthProvider$OnVerificationStateChangedCallbacks;->onVerificationCompleted(Lcom/google/firebase/auth/PhoneAuthCredential;)V

    return-void
.end method
