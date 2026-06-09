.class final Lcom/google/firebase/auth/api/internal/zzg;
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
.field private final synthetic zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

.field private final synthetic zzfm:Lcom/google/firebase/auth/api/internal/zza;

.field private final synthetic zzfo:Lcom/google/firebase/auth/api/internal/zzdj;

.field private final synthetic zzfp:Lcom/google/android/gms/internal/firebase_auth/zzao;

.field private final synthetic zzfq:Lcom/google/android/gms/internal/firebase_auth/zzaz;


# direct methods
.method constructor <init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzdj;Lcom/google/firebase/auth/api/internal/zzcb;Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzaz;)V
    .locals 0

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzg;->zzfm:Lcom/google/firebase/auth/api/internal/zza;

    iput-object p2, p0, Lcom/google/firebase/auth/api/internal/zzg;->zzfo:Lcom/google/firebase/auth/api/internal/zzdj;

    iput-object p3, p0, Lcom/google/firebase/auth/api/internal/zzg;->zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

    iput-object p4, p0, Lcom/google/firebase/auth/api/internal/zzg;->zzfp:Lcom/google/android/gms/internal/firebase_auth/zzao;

    iput-object p5, p0, Lcom/google/firebase/auth/api/internal/zzg;->zzfq:Lcom/google/android/gms/internal/firebase_auth/zzaz;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final synthetic onSuccess(Ljava/lang/Object;)V
    .locals 7
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
    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzg;->zzfm:Lcom/google/firebase/auth/api/internal/zza;

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzg;->zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

    iget-object v3, p0, Lcom/google/firebase/auth/api/internal/zzg;->zzfp:Lcom/google/android/gms/internal/firebase_auth/zzao;

    const/4 v0, 0x0

    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    move-object v4, p1

    check-cast v4, Lcom/google/android/gms/internal/firebase_auth/zzaj;

    iget-object v5, p0, Lcom/google/firebase/auth/api/internal/zzg;->zzfq:Lcom/google/android/gms/internal/firebase_auth/zzaz;

    iget-object v6, p0, Lcom/google/firebase/auth/api/internal/zzg;->zzfo:Lcom/google/firebase/auth/api/internal/zzdj;

    invoke-static/range {v1 .. v6}, Lcom/google/firebase/auth/api/internal/zza;->zza(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzaj;Lcom/google/android/gms/internal/firebase_auth/zzaz;Lcom/google/firebase/auth/api/internal/zzdj;)V

    return-void

    :cond_1
    :goto_0
    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zzg;->zzfo:Lcom/google/firebase/auth/api/internal/zzdj;

    const-string v0, "No users"

    invoke-interface {p1, v0}, Lcom/google/firebase/auth/api/internal/zzdj;->zzc(Ljava/lang/String;)V

    return-void
.end method

.method public final zzc(Ljava/lang/String;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzg;->zzfo:Lcom/google/firebase/auth/api/internal/zzdj;

    invoke-interface {v0, p1}, Lcom/google/firebase/auth/api/internal/zzdj;->zzc(Ljava/lang/String;)V

    return-void
.end method
