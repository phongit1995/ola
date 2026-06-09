.class final Lcom/google/firebase/auth/api/internal/zzca;
.super Lcom/google/firebase/auth/api/internal/zzcy;


# annotations
.annotation build Lcom/google/android/gms/common/util/VisibleForTesting;
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/firebase/auth/api/internal/zzcy<",
        "Ljava/lang/Void;",
        "Lcom/google/firebase/auth/PhoneAuthProvider$OnVerificationStateChangedCallbacks;",
        ">;"
    }
.end annotation


# instance fields
.field private final zzhg:Lcom/google/android/gms/internal/firebase_auth/zzax;


# direct methods
.method public constructor <init>(Lcom/google/android/gms/internal/firebase_auth/zzax;)V
    .locals 1

    const/16 v0, 0x8

    invoke-direct {p0, v0}, Lcom/google/firebase/auth/api/internal/zzcy;-><init>(I)V

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzax;

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzca;->zzhg:Lcom/google/android/gms/internal/firebase_auth/zzax;

    return-void
.end method


# virtual methods
.method public final zzaa()V
    .locals 3

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzca;->zzid:Lcom/google/firebase/auth/api/internal/zzck;

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzca;->zzhg:Lcom/google/android/gms/internal/firebase_auth/zzax;

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzca;->zzib:Lcom/google/firebase/auth/api/internal/zzdb;

    invoke-interface {v0, v1, v2}, Lcom/google/firebase/auth/api/internal/zzck;->zza(Lcom/google/android/gms/internal/firebase_auth/zzax;Lcom/google/firebase/auth/api/internal/zzch;)V

    return-void
.end method

.method public final zzab()V
    .locals 0

    return-void
.end method
