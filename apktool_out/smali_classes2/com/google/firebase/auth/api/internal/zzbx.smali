.class final Lcom/google/firebase/auth/api/internal/zzbx;
.super Lcom/google/firebase/auth/api/internal/zzcy;


# annotations
.annotation build Lcom/google/android/gms/common/util/VisibleForTesting;
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/firebase/auth/api/internal/zzcy<",
        "Ljava/lang/Void;",
        "Lcom/google/firebase/auth/internal/zza;",
        ">;"
    }
.end annotation


# instance fields
.field private final zzgx:Lcom/google/firebase/auth/PhoneAuthCredential;
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lcom/google/firebase/auth/PhoneAuthCredential;)V
    .locals 1

    const/4 v0, 0x2

    invoke-direct {p0, v0}, Lcom/google/firebase/auth/api/internal/zzcy;-><init>(I)V

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/firebase/auth/PhoneAuthCredential;

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzbx;->zzgx:Lcom/google/firebase/auth/PhoneAuthCredential;

    return-void
.end method


# virtual methods
.method public final zzaa()V
    .locals 4

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzbx;->zzid:Lcom/google/firebase/auth/api/internal/zzck;

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzbx;->zzic:Lcom/google/firebase/auth/FirebaseUser;

    invoke-virtual {v1}, Lcom/google/firebase/auth/FirebaseUser;->zzq()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzbx;->zzgx:Lcom/google/firebase/auth/PhoneAuthCredential;

    iget-object v3, p0, Lcom/google/firebase/auth/api/internal/zzbx;->zzib:Lcom/google/firebase/auth/api/internal/zzdb;

    invoke-interface {v0, v1, v2, v3}, Lcom/google/firebase/auth/api/internal/zzck;->zza(Ljava/lang/String;Lcom/google/firebase/auth/PhoneAuthCredential;Lcom/google/firebase/auth/api/internal/zzch;)V

    return-void
.end method

.method public final zzab()V
    .locals 4

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzbx;->zzie:Ljava/lang/Object;

    check-cast v0, Lcom/google/firebase/auth/internal/zza;

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzbx;->zzil:Lcom/google/android/gms/internal/firebase_auth/zzao;

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzbx;->zzeb:Lcom/google/firebase/FirebaseApp;

    iget-object v3, p0, Lcom/google/firebase/auth/api/internal/zzbx;->zzim:Lcom/google/android/gms/internal/firebase_auth/zzaj;

    invoke-static {v2, v3}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/FirebaseApp;Lcom/google/android/gms/internal/firebase_auth/zzaj;)Lcom/google/firebase/auth/internal/zzl;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Lcom/google/firebase/auth/internal/zza;->zza(Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/firebase/auth/FirebaseUser;)V

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/google/firebase/auth/api/internal/zzcy;->zzb(Ljava/lang/Object;)V

    return-void
.end method
