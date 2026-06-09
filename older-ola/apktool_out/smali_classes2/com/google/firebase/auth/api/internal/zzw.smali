.class final Lcom/google/firebase/auth/api/internal/zzw;
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

.field private final synthetic zzgf:Lcom/google/firebase/auth/api/internal/zzv;


# direct methods
.method constructor <init>(Lcom/google/firebase/auth/api/internal/zzv;Lcom/google/firebase/auth/api/internal/zzdk;Lcom/google/android/gms/internal/firebase_auth/zzao;)V
    .locals 0

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzw;->zzgf:Lcom/google/firebase/auth/api/internal/zzv;

    iput-object p2, p0, Lcom/google/firebase/auth/api/internal/zzw;->zzga:Lcom/google/firebase/auth/api/internal/zzdk;

    iput-object p3, p0, Lcom/google/firebase/auth/api/internal/zzw;->zzgd:Lcom/google/android/gms/internal/firebase_auth/zzao;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final synthetic onSuccess(Ljava/lang/Object;)V
    .locals 3
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
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzw;->zzgf:Lcom/google/firebase/auth/api/internal/zzv;

    iget-object v0, v0, Lcom/google/firebase/auth/api/internal/zzv;->zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzw;->zzgd:Lcom/google/android/gms/internal/firebase_auth/zzao;

    const/4 v2, 0x0

    invoke-interface {p1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzaj;

    invoke-virtual {v0, v1, p1}, Lcom/google/firebase/auth/api/internal/zzcb;->zza(Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzaj;)V

    return-void

    :cond_1
    :goto_0
    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zzw;->zzga:Lcom/google/firebase/auth/api/internal/zzdk;

    const-string v0, "No users"

    invoke-interface {p1, v0}, Lcom/google/firebase/auth/api/internal/zzdk;->zzc(Ljava/lang/String;)V

    return-void
.end method

.method public final zzc(Ljava/lang/String;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzw;->zzga:Lcom/google/firebase/auth/api/internal/zzdk;

    invoke-interface {v0, p1}, Lcom/google/firebase/auth/api/internal/zzdk;->zzc(Ljava/lang/String;)V

    return-void
.end method
