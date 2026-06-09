.class final Lcom/google/firebase/auth/api/internal/zzu;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzdk;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/google/firebase/auth/api/internal/zzdk<",
        "Lcom/google/android/gms/internal/firebase_auth/zzah;",
        ">;"
    }
.end annotation


# instance fields
.field private final synthetic zzga:Lcom/google/firebase/auth/api/internal/zzdk;

.field private final synthetic zzgd:Lcom/google/android/gms/internal/firebase_auth/zzao;

.field private final synthetic zzge:Lcom/google/firebase/auth/api/internal/zzt;


# direct methods
.method constructor <init>(Lcom/google/firebase/auth/api/internal/zzt;Lcom/google/firebase/auth/api/internal/zzdk;Lcom/google/android/gms/internal/firebase_auth/zzao;)V
    .locals 0

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzu;->zzge:Lcom/google/firebase/auth/api/internal/zzt;

    iput-object p2, p0, Lcom/google/firebase/auth/api/internal/zzu;->zzga:Lcom/google/firebase/auth/api/internal/zzdk;

    iput-object p3, p0, Lcom/google/firebase/auth/api/internal/zzu;->zzgd:Lcom/google/android/gms/internal/firebase_auth/zzao;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final synthetic onSuccess(Ljava/lang/Object;)V
    .locals 6
    .param p1    # Ljava/lang/Object;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzah;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzah;->zzas()Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_1

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    move-object v3, p1

    check-cast v3, Lcom/google/android/gms/internal/firebase_auth/zzaj;

    new-instance v4, Lcom/google/android/gms/internal/firebase_auth/zzaz;

    invoke-direct {v4}, Lcom/google/android/gms/internal/firebase_auth/zzaz;-><init>()V

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zzu;->zzgd:Lcom/google/android/gms/internal/firebase_auth/zzao;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzao;->zzaw()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v4, p1}, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzv(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaz;

    move-result-object p1

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzu;->zzge:Lcom/google/firebase/auth/api/internal/zzt;

    iget-object v0, v0, Lcom/google/firebase/auth/api/internal/zzt;->zzgc:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzaa(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaz;

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zzu;->zzge:Lcom/google/firebase/auth/api/internal/zzt;

    iget-object v0, p1, Lcom/google/firebase/auth/api/internal/zzt;->zzfm:Lcom/google/firebase/auth/api/internal/zza;

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zzu;->zzge:Lcom/google/firebase/auth/api/internal/zzt;

    iget-object v1, p1, Lcom/google/firebase/auth/api/internal/zzt;->zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzu;->zzgd:Lcom/google/android/gms/internal/firebase_auth/zzao;

    iget-object v5, p0, Lcom/google/firebase/auth/api/internal/zzu;->zzga:Lcom/google/firebase/auth/api/internal/zzdk;

    invoke-static/range {v0 .. v5}, Lcom/google/firebase/auth/api/internal/zza;->zza(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzaj;Lcom/google/android/gms/internal/firebase_auth/zzaz;Lcom/google/firebase/auth/api/internal/zzdj;)V

    return-void

    :cond_1
    :goto_0
    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zzu;->zzga:Lcom/google/firebase/auth/api/internal/zzdk;

    const-string v0, "No users."

    invoke-interface {p1, v0}, Lcom/google/firebase/auth/api/internal/zzdk;->zzc(Ljava/lang/String;)V

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

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzu;->zzge:Lcom/google/firebase/auth/api/internal/zzt;

    iget-object v0, v0, Lcom/google/firebase/auth/api/internal/zzt;->zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcb;->onFailure(Lcom/google/android/gms/common/api/Status;)V

    return-void
.end method
