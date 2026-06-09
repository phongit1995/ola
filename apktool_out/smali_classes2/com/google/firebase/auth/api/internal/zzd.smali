.class final Lcom/google/firebase/auth/api/internal/zzd;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzdk;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/google/firebase/auth/api/internal/zzdk<",
        "Lcom/google/android/gms/internal/firebase_auth/zzbm;",
        ">;"
    }
.end annotation


# instance fields
.field private final synthetic zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

.field private final synthetic zzfm:Lcom/google/firebase/auth/api/internal/zza;


# direct methods
.method constructor <init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 0

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzd;->zzfm:Lcom/google/firebase/auth/api/internal/zza;

    iput-object p2, p0, Lcom/google/firebase/auth/api/internal/zzd;->zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final synthetic onSuccess(Ljava/lang/Object;)V
    .locals 8
    .param p1    # Ljava/lang/Object;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzbm;

    new-instance v1, Lcom/google/android/gms/internal/firebase_auth/zzao;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzbm;->zzap()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzbm;->getIdToken()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzbm;->zzaq()J

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    const-string v3, "Bearer"

    invoke-direct {v1, v0, v2, p1, v3}, Lcom/google/android/gms/internal/firebase_auth/zzao;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzd;->zzfm:Lcom/google/firebase/auth/api/internal/zza;

    const/4 p1, 0x0

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    iget-object v6, p0, Lcom/google/firebase/auth/api/internal/zzd;->zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v5, 0x0

    move-object v7, p0

    invoke-static/range {v0 .. v7}, Lcom/google/firebase/auth/api/internal/zza;->zza(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/android/gms/internal/firebase_auth/zzao;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Boolean;Lcom/google/firebase/auth/zzd;Lcom/google/firebase/auth/api/internal/zzcb;Lcom/google/firebase/auth/api/internal/zzdj;)V

    return-void
.end method

.method public final zzc(Ljava/lang/String;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/firebase/auth/internal/zzq;->zzaf(Ljava/lang/String;)Lcom/google/android/gms/common/api/Status;

    move-result-object p1

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzd;->zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcb;->onFailure(Lcom/google/android/gms/common/api/Status;)V

    return-void
.end method
