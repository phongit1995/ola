.class final Lcom/google/firebase/auth/api/internal/zzdf;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzdh;


# instance fields
.field private final synthetic zziz:Lcom/google/android/gms/common/api/Status;


# direct methods
.method constructor <init>(Lcom/google/firebase/auth/api/internal/zzdb;Lcom/google/android/gms/common/api/Status;)V
    .locals 0

    iput-object p2, p0, Lcom/google/firebase/auth/api/internal/zzdf;->zziz:Lcom/google/android/gms/common/api/Status;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final varargs zza(Lcom/google/firebase/auth/PhoneAuthProvider$OnVerificationStateChangedCallbacks;[Ljava/lang/Object;)V
    .locals 0

    iget-object p2, p0, Lcom/google/firebase/auth/api/internal/zzdf;->zziz:Lcom/google/android/gms/common/api/Status;

    invoke-static {p2}, Lcom/google/firebase/auth/api/internal/zzce;->zzb(Lcom/google/android/gms/common/api/Status;)Lcom/google/firebase/FirebaseException;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/PhoneAuthProvider$OnVerificationStateChangedCallbacks;->onVerificationFailed(Lcom/google/firebase/FirebaseException;)V

    return-void
.end method
