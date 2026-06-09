.class final Lcom/google/firebase/auth/api/internal/zzi;
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

.field private final synthetic zzfo:Lcom/google/firebase/auth/api/internal/zzdj;

.field private final synthetic zzfs:Ljava/lang/String;

.field private final synthetic zzft:Ljava/lang/String;

.field private final synthetic zzfu:Ljava/lang/Boolean;

.field private final synthetic zzfv:Lcom/google/firebase/auth/zzd;

.field private final synthetic zzfw:Lcom/google/android/gms/internal/firebase_auth/zzao;


# direct methods
.method constructor <init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzdj;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Boolean;Lcom/google/firebase/auth/zzd;Lcom/google/firebase/auth/api/internal/zzcb;Lcom/google/android/gms/internal/firebase_auth/zzao;)V
    .locals 0

    iput-object p2, p0, Lcom/google/firebase/auth/api/internal/zzi;->zzfo:Lcom/google/firebase/auth/api/internal/zzdj;

    iput-object p3, p0, Lcom/google/firebase/auth/api/internal/zzi;->zzfs:Ljava/lang/String;

    iput-object p4, p0, Lcom/google/firebase/auth/api/internal/zzi;->zzft:Ljava/lang/String;

    iput-object p5, p0, Lcom/google/firebase/auth/api/internal/zzi;->zzfu:Ljava/lang/Boolean;

    iput-object p6, p0, Lcom/google/firebase/auth/api/internal/zzi;->zzfv:Lcom/google/firebase/auth/zzd;

    iput-object p7, p0, Lcom/google/firebase/auth/api/internal/zzi;->zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

    iput-object p8, p0, Lcom/google/firebase/auth/api/internal/zzi;->zzfw:Lcom/google/android/gms/internal/firebase_auth/zzao;

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

    if-eqz p1, :cond_7

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto/16 :goto_5

    :cond_0
    const/4 v0, 0x0

    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/internal/firebase_auth/zzaj;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzau()Lcom/google/android/gms/internal/firebase_auth/zzas;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Lcom/google/android/gms/internal/firebase_auth/zzas;->zzat()Ljava/util/List;

    move-result-object v1

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    :goto_0
    if-eqz v1, :cond_4

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_4

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzi;->zzfs:Ljava/lang/String;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_3

    const/4 v2, 0x0

    :goto_1
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v3

    if-ge v2, v3, :cond_4

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/google/android/gms/internal/firebase_auth/zzaq;

    invoke-virtual {v3}, Lcom/google/android/gms/internal/firebase_auth/zzaq;->getProviderId()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/google/firebase/auth/api/internal/zzi;->zzfs:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    goto :goto_2

    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_3
    invoke-interface {v1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    :goto_2
    check-cast v1, Lcom/google/android/gms/internal/firebase_auth/zzaq;

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzi;->zzft:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/google/android/gms/internal/firebase_auth/zzaq;->zzt(Ljava/lang/String;)V

    :cond_4
    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzi;->zzfu:Ljava/lang/Boolean;

    if-eqz v1, :cond_6

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzi;->zzfu:Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    :cond_5
    :goto_3
    invoke-virtual {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzc(Z)Lcom/google/android/gms/internal/firebase_auth/zzaj;

    goto :goto_4

    :cond_6
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzaj;->getLastSignInTimestamp()J

    move-result-wide v1

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzaj;->getCreationTimestamp()J

    move-result-wide v3

    sub-long v5, v1, v3

    const-wide/16 v1, 0x3e8

    cmp-long v3, v5, v1

    if-gez v3, :cond_5

    const/4 v0, 0x1

    goto :goto_3

    :goto_4
    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzi;->zzfv:Lcom/google/firebase/auth/zzd;

    invoke-virtual {p1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzb(Lcom/google/firebase/auth/zzd;)Lcom/google/android/gms/internal/firebase_auth/zzaj;

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzi;->zzfl:Lcom/google/firebase/auth/api/internal/zzcb;

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzi;->zzfw:Lcom/google/android/gms/internal/firebase_auth/zzao;

    invoke-virtual {v0, v1, p1}, Lcom/google/firebase/auth/api/internal/zzcb;->zza(Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzaj;)V

    return-void

    :cond_7
    :goto_5
    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zzi;->zzfo:Lcom/google/firebase/auth/api/internal/zzdj;

    const-string v0, "No users."

    invoke-interface {p1, v0}, Lcom/google/firebase/auth/api/internal/zzdj;->zzc(Ljava/lang/String;)V

    return-void
.end method

.method public final zzc(Ljava/lang/String;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzi;->zzfo:Lcom/google/firebase/auth/api/internal/zzdj;

    invoke-interface {v0, p1}, Lcom/google/firebase/auth/api/internal/zzdj;->zzc(Ljava/lang/String;)V

    return-void
.end method
