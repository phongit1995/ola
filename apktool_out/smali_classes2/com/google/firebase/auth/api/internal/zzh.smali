.class final Lcom/google/firebase/auth/api/internal/zzh;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/firebase/auth/api/internal/zzdk;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/google/firebase/auth/api/internal/zzdk<",
        "Lcom/google/android/gms/internal/firebase_auth/zzba;",
        ">;"
    }
.end annotation


# instance fields
.field private final synthetic zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

.field private final synthetic zzfm:Lcom/google/firebase/auth/api/internal/zza;

.field private final synthetic zzfo:Lcom/google/firebase/auth/api/internal/zzdj;

.field private final synthetic zzfp:Lcom/google/android/gms/internal/firebase_auth/zzao;

.field private final synthetic zzfq:Lcom/google/android/gms/internal/firebase_auth/zzaz;

.field private final synthetic zzfr:Lcom/google/android/gms/internal/firebase_auth/zzaj;


# direct methods
.method constructor <init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/android/gms/internal/firebase_auth/zzaz;Lcom/google/android/gms/internal/firebase_auth/zzaj;Lcom/google/firebase/auth/api/internal/zzcb;Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/firebase/auth/api/internal/zzdj;)V
    .locals 0

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfm:Lcom/google/firebase/auth/api/internal/zza;

    iput-object p2, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfq:Lcom/google/android/gms/internal/firebase_auth/zzaz;

    iput-object p3, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfr:Lcom/google/android/gms/internal/firebase_auth/zzaj;

    iput-object p4, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

    iput-object p5, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfp:Lcom/google/android/gms/internal/firebase_auth/zzao;

    iput-object p6, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfo:Lcom/google/firebase/auth/api/internal/zzdj;

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

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzba;

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfq:Lcom/google/android/gms/internal/firebase_auth/zzaz;

    const-string v1, "EMAIL"

    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzu(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfr:Lcom/google/android/gms/internal/firebase_auth/zzaj;

    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzl(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaj;

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfq:Lcom/google/android/gms/internal/firebase_auth/zzaz;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzaz;->getEmail()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfr:Lcom/google/android/gms/internal/firebase_auth/zzaj;

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfq:Lcom/google/android/gms/internal/firebase_auth/zzaz;

    invoke-virtual {v2}, Lcom/google/android/gms/internal/firebase_auth/zzaz;->getEmail()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzl(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaj;

    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfq:Lcom/google/android/gms/internal/firebase_auth/zzaz;

    const-string v2, "DISPLAY_NAME"

    invoke-virtual {v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzu(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfr:Lcom/google/android/gms/internal/firebase_auth/zzaj;

    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzm(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaj;

    goto :goto_1

    :cond_2
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfq:Lcom/google/android/gms/internal/firebase_auth/zzaz;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzaz;->getDisplayName()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfr:Lcom/google/android/gms/internal/firebase_auth/zzaj;

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfq:Lcom/google/android/gms/internal/firebase_auth/zzaz;

    invoke-virtual {v2}, Lcom/google/android/gms/internal/firebase_auth/zzaz;->getDisplayName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzm(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaj;

    :cond_3
    :goto_1
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfq:Lcom/google/android/gms/internal/firebase_auth/zzaz;

    const-string v2, "PHOTO_URL"

    invoke-virtual {v0, v2}, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzu(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfr:Lcom/google/android/gms/internal/firebase_auth/zzaj;

    :goto_2
    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzn(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaj;

    goto :goto_3

    :cond_4
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfq:Lcom/google/android/gms/internal/firebase_auth/zzaz;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzt()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfr:Lcom/google/android/gms/internal/firebase_auth/zzaj;

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfq:Lcom/google/android/gms/internal/firebase_auth/zzaz;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzt()Ljava/lang/String;

    move-result-object v1

    goto :goto_2

    :cond_5
    :goto_3
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfq:Lcom/google/android/gms/internal/firebase_auth/zzaz;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/firebase_auth/zzaz;->getPassword()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_6

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfr:Lcom/google/android/gms/internal/firebase_auth/zzaj;

    const-string v1, "redacted"

    invoke-virtual {v1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    invoke-static {v1}, Lcom/google/android/gms/common/util/Base64Utils;->encode([B)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzo(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaj;

    :cond_6
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzba;->zzat()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_7

    goto :goto_4

    :cond_7
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    :goto_4
    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfr:Lcom/google/android/gms/internal/firebase_auth/zzaj;

    invoke-virtual {v1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzb(Ljava/util/List;)Lcom/google/android/gms/internal/firebase_auth/zzaj;

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfm:Lcom/google/firebase/auth/api/internal/zza;

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfp:Lcom/google/android/gms/internal/firebase_auth/zzao;

    invoke-static {v1, v2, p1}, Lcom/google/firebase/auth/api/internal/zza;->zza(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzba;)Lcom/google/android/gms/internal/firebase_auth/zzao;

    move-result-object p1

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfr:Lcom/google/android/gms/internal/firebase_auth/zzaj;

    invoke-virtual {v0, p1, v1}, Lcom/google/firebase/auth/api/internal/zzcb;->zza(Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzaj;)V

    return-void
.end method

.method public final zzc(Ljava/lang/String;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzh;->zzfo:Lcom/google/firebase/auth/api/internal/zzdj;

    invoke-interface {v0, p1}, Lcom/google/firebase/auth/api/internal/zzdj;->zzc(Ljava/lang/String;)V

    return-void
.end method
