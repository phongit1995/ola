.class public final Lcom/google/firebase/auth/api/internal/zza;
.super Ljava/lang/Object;


# instance fields
.field private final zzfk:Lcom/google/firebase/auth/api/internal/zzdi;


# direct methods
.method public constructor <init>(Lcom/google/firebase/auth/api/internal/zzdi;)V
    .locals 0
    .param p1    # Lcom/google/firebase/auth/api/internal/zzdi;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/firebase/auth/api/internal/zzdi;

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zza;->zzfk:Lcom/google/firebase/auth/api/internal/zzdi;

    return-void
.end method

.method private static zza(Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzba;)Lcom/google/android/gms/internal/firebase_auth/zzao;
    .locals 4
    .param p0    # Lcom/google/android/gms/internal/firebase_auth/zzao;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/internal/firebase_auth/zzba;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzba;->getIdToken()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzba;->zzap()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzba;->zzaq()J

    move-result-wide v2

    new-instance p1, Lcom/google/android/gms/internal/firebase_auth/zzao;

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {p0}, Lcom/google/android/gms/internal/firebase_auth/zzao;->zzax()Ljava/lang/String;

    move-result-object p0

    invoke-direct {p1, v1, v0, v2, p0}, Lcom/google/android/gms/internal/firebase_auth/zzao;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;Ljava/lang/String;)V

    return-object p1

    :cond_0
    return-object p0
.end method

.method static synthetic zza(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzba;)Lcom/google/android/gms/internal/firebase_auth/zzao;
    .locals 0

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zza;->zza(Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzba;)Lcom/google/android/gms/internal/firebase_auth/zzao;

    move-result-object p0

    return-object p0
.end method

.method static synthetic zza(Lcom/google/firebase/auth/api/internal/zza;)Lcom/google/firebase/auth/api/internal/zzdi;
    .locals 0

    iget-object p0, p0, Lcom/google/firebase/auth/api/internal/zza;->zzfk:Lcom/google/firebase/auth/api/internal/zzdi;

    return-object p0
.end method

.method private final zza(Lcom/google/android/gms/internal/firebase_auth/zzaa;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 2
    .param p1    # Lcom/google/android/gms/internal/firebase_auth/zzaa;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zza;->zzfk:Lcom/google/firebase/auth/api/internal/zzdi;

    new-instance v1, Lcom/google/firebase/auth/api/internal/zzf;

    invoke-direct {v1, p0, p2}, Lcom/google/firebase/auth/api/internal/zzf;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-virtual {v0, p1, v1}, Lcom/google/firebase/auth/api/internal/zzdi;->zza(Lcom/google/android/gms/internal/firebase_auth/zzaa;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method private final zza(Lcom/google/android/gms/internal/firebase_auth/zzao;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Boolean;Lcom/google/firebase/auth/zzd;Lcom/google/firebase/auth/api/internal/zzcb;Lcom/google/firebase/auth/api/internal/zzdj;)V
    .locals 13
    .param p1    # Lcom/google/android/gms/internal/firebase_auth/zzao;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .param p4    # Ljava/lang/Boolean;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .param p5    # Lcom/google/firebase/auth/zzd;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .param p6    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p7    # Lcom/google/firebase/auth/api/internal/zzdj;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static/range {p7 .. p7}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static/range {p6 .. p6}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzao;->zzaw()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/google/android/gms/internal/firebase_auth/zzag;

    invoke-direct {v1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzag;-><init>(Ljava/lang/String;)V

    move-object v0, p0

    iget-object v11, v0, Lcom/google/firebase/auth/api/internal/zza;->zzfk:Lcom/google/firebase/auth/api/internal/zzdi;

    new-instance v12, Lcom/google/firebase/auth/api/internal/zzi;

    move-object v2, v12

    move-object v3, v0

    move-object/from16 v4, p7

    move-object/from16 v5, p3

    move-object v6, p2

    move-object/from16 v7, p4

    move-object/from16 v8, p5

    move-object/from16 v9, p6

    move-object v10, p1

    invoke-direct/range {v2 .. v10}, Lcom/google/firebase/auth/api/internal/zzi;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzdj;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Boolean;Lcom/google/firebase/auth/zzd;Lcom/google/firebase/auth/api/internal/zzcb;Lcom/google/android/gms/internal/firebase_auth/zzao;)V

    invoke-virtual {v11, v1, v12}, Lcom/google/firebase/auth/api/internal/zzdi;->zza(Lcom/google/android/gms/internal/firebase_auth/zzag;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method static synthetic zza(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/android/gms/internal/firebase_auth/zzaa;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/google/firebase/auth/api/internal/zza;->zza(Lcom/google/android/gms/internal/firebase_auth/zzaa;Lcom/google/firebase/auth/api/internal/zzcb;)V

    return-void
.end method

.method static synthetic zza(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/android/gms/internal/firebase_auth/zzao;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Boolean;Lcom/google/firebase/auth/zzd;Lcom/google/firebase/auth/api/internal/zzcb;Lcom/google/firebase/auth/api/internal/zzdj;)V
    .locals 0

    invoke-direct/range {p0 .. p7}, Lcom/google/firebase/auth/api/internal/zza;->zza(Lcom/google/android/gms/internal/firebase_auth/zzao;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Boolean;Lcom/google/firebase/auth/zzd;Lcom/google/firebase/auth/api/internal/zzcb;Lcom/google/firebase/auth/api/internal/zzdj;)V

    return-void
.end method

.method static synthetic zza(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzaj;Lcom/google/android/gms/internal/firebase_auth/zzaz;Lcom/google/firebase/auth/api/internal/zzdj;)V
    .locals 0

    invoke-direct/range {p0 .. p5}, Lcom/google/firebase/auth/api/internal/zza;->zza(Lcom/google/firebase/auth/api/internal/zzcb;Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzaj;Lcom/google/android/gms/internal/firebase_auth/zzaz;Lcom/google/firebase/auth/api/internal/zzdj;)V

    return-void
.end method

.method static synthetic zza(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzaz;Lcom/google/firebase/auth/api/internal/zzdj;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lcom/google/firebase/auth/api/internal/zza;->zza(Lcom/google/firebase/auth/api/internal/zzcb;Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzaz;Lcom/google/firebase/auth/api/internal/zzdj;)V

    return-void
.end method

.method private final zza(Lcom/google/firebase/auth/api/internal/zzcb;Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzaj;Lcom/google/android/gms/internal/firebase_auth/zzaz;Lcom/google/firebase/auth/api/internal/zzdj;)V
    .locals 9
    .param p1    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/android/gms/internal/firebase_auth/zzao;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/android/gms/internal/firebase_auth/zzaj;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p4    # Lcom/google/android/gms/internal/firebase_auth/zzaz;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p5    # Lcom/google/firebase/auth/api/internal/zzdj;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p4}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p5}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zza;->zzfk:Lcom/google/firebase/auth/api/internal/zzdi;

    new-instance v8, Lcom/google/firebase/auth/api/internal/zzh;

    move-object v1, v8

    move-object v2, p0

    move-object v3, p4

    move-object v4, p3

    move-object v5, p1

    move-object v6, p2

    move-object v7, p5

    invoke-direct/range {v1 .. v7}, Lcom/google/firebase/auth/api/internal/zzh;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/android/gms/internal/firebase_auth/zzaz;Lcom/google/android/gms/internal/firebase_auth/zzaj;Lcom/google/firebase/auth/api/internal/zzcb;Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/firebase/auth/api/internal/zzdj;)V

    invoke-virtual {v0, p4, v8}, Lcom/google/firebase/auth/api/internal/zzdi;->zza(Lcom/google/android/gms/internal/firebase_auth/zzaz;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method private final zza(Lcom/google/firebase/auth/api/internal/zzcb;Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzaz;Lcom/google/firebase/auth/api/internal/zzdj;)V
    .locals 9
    .param p1    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/android/gms/internal/firebase_auth/zzao;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/android/gms/internal/firebase_auth/zzaz;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p4    # Lcom/google/firebase/auth/api/internal/zzdj;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p4}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {p2}, Lcom/google/android/gms/internal/firebase_auth/zzao;->zzaw()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/google/android/gms/internal/firebase_auth/zzag;

    invoke-direct {v1, v0}, Lcom/google/android/gms/internal/firebase_auth/zzag;-><init>(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zza;->zzfk:Lcom/google/firebase/auth/api/internal/zzdi;

    new-instance v8, Lcom/google/firebase/auth/api/internal/zzg;

    move-object v2, v8

    move-object v3, p0

    move-object v4, p4

    move-object v5, p1

    move-object v6, p2

    move-object v7, p3

    invoke-direct/range {v2 .. v7}, Lcom/google/firebase/auth/api/internal/zzg;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzdj;Lcom/google/firebase/auth/api/internal/zzcb;Lcom/google/android/gms/internal/firebase_auth/zzao;Lcom/google/android/gms/internal/firebase_auth/zzaz;)V

    invoke-virtual {v0, v1, v8}, Lcom/google/firebase/auth/api/internal/zzdi;->zza(Lcom/google/android/gms/internal/firebase_auth/zzag;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method private final zza(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzdk;)V
    .locals 2
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/api/internal/zzdk;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lcom/google/firebase/auth/api/internal/zzdk<",
            "Lcom/google/android/gms/internal/firebase_auth/zzao;",
            ">;)V"
        }
    .end annotation

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p1}, Lcom/google/android/gms/internal/firebase_auth/zzao;->zzs(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzao;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzao;->isValid()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p2, p1}, Lcom/google/firebase/auth/api/internal/zzdk;->onSuccess(Ljava/lang/Object;)V

    return-void

    :cond_0
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzao;->zzap()Ljava/lang/String;

    move-result-object p1

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzaf;

    invoke-direct {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzaf;-><init>(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zza;->zzfk:Lcom/google/firebase/auth/api/internal/zzdi;

    new-instance v1, Lcom/google/firebase/auth/api/internal/zzag;

    invoke-direct {v1, p0, p2}, Lcom/google/firebase/auth/api/internal/zzag;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzdk;)V

    invoke-virtual {p1, v0, v1}, Lcom/google/firebase/auth/api/internal/zzdi;->zza(Lcom/google/android/gms/internal/firebase_auth/zzaf;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method


# virtual methods
.method public final zza(Lcom/google/android/gms/internal/firebase_auth/zzbf;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 2
    .param p1    # Lcom/google/android/gms/internal/firebase_auth/zzbf;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zza;->zzfk:Lcom/google/firebase/auth/api/internal/zzdi;

    new-instance v1, Lcom/google/firebase/auth/api/internal/zzx;

    invoke-direct {v1, p0, p2}, Lcom/google/firebase/auth/api/internal/zzx;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-virtual {v0, p1, v1}, Lcom/google/firebase/auth/api/internal/zzdi;->zza(Lcom/google/android/gms/internal/firebase_auth/zzbf;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method public final zza(Lcom/google/firebase/auth/EmailAuthCredential;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 2
    .param p1    # Lcom/google/firebase/auth/EmailAuthCredential;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {p1}, Lcom/google/firebase/auth/EmailAuthCredential;->zzi()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Lcom/google/firebase/auth/EmailAuthCredential;->zzh()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lcom/google/firebase/auth/api/internal/zze;

    invoke-direct {v1, p0, p1, p2}, Lcom/google/firebase/auth/api/internal/zze;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/EmailAuthCredential;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-direct {p0, v0, v1}, Lcom/google/firebase/auth/api/internal/zza;->zza(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void

    :cond_0
    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzaa;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/google/android/gms/internal/firebase_auth/zzaa;-><init>(Lcom/google/firebase/auth/EmailAuthCredential;Ljava/lang/String;)V

    invoke-direct {p0, v0, p2}, Lcom/google/firebase/auth/api/internal/zza;->zza(Lcom/google/android/gms/internal/firebase_auth/zzaa;Lcom/google/firebase/auth/api/internal/zzcb;)V

    return-void
.end method

.method public final zza(Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 3
    .param p1    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzbb;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzbb;-><init>()V

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zza;->zzfk:Lcom/google/firebase/auth/api/internal/zzdi;

    new-instance v2, Lcom/google/firebase/auth/api/internal/zzab;

    invoke-direct {v2, p0, p1}, Lcom/google/firebase/auth/api/internal/zzab;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-virtual {v1, v0, v2}, Lcom/google/firebase/auth/api/internal/zzdi;->zza(Lcom/google/android/gms/internal/firebase_auth/zzbb;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method public final zza(Ljava/lang/String;Lcom/google/android/gms/internal/firebase_auth/zzbf;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/android/gms/internal/firebase_auth/zzbf;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzq;

    invoke-direct {v0, p0, p2, p3}, Lcom/google/firebase/auth/api/internal/zzq;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/android/gms/internal/firebase_auth/zzbf;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-direct {p0, p1, v0}, Lcom/google/firebase/auth/api/internal/zza;->zza(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method public final zza(Ljava/lang/String;Lcom/google/firebase/auth/ActionCodeSettings;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 2
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/ActionCodeSettings;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzan;

    invoke-virtual {p2}, Lcom/google/firebase/auth/ActionCodeSettings;->getRequestType()I

    move-result v1

    invoke-direct {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzan;-><init>(I)V

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzan;->zzp(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzan;

    invoke-virtual {v0, p2}, Lcom/google/android/gms/internal/firebase_auth/zzan;->zza(Lcom/google/firebase/auth/ActionCodeSettings;)Lcom/google/android/gms/internal/firebase_auth/zzan;

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zza;->zzfk:Lcom/google/firebase/auth/api/internal/zzdi;

    new-instance p2, Lcom/google/firebase/auth/api/internal/zzk;

    invoke-direct {p2, p0, p3}, Lcom/google/firebase/auth/api/internal/zzk;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-virtual {p1, v0, p2}, Lcom/google/firebase/auth/api/internal/zzdi;->zza(Lcom/google/android/gms/internal/firebase_auth/zzan;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method public final zza(Ljava/lang/String;Lcom/google/firebase/auth/UserProfileChangeRequest;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/UserProfileChangeRequest;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzac;

    invoke-direct {v0, p0, p2, p3}, Lcom/google/firebase/auth/api/internal/zzac;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/UserProfileChangeRequest;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-direct {p0, p1, v0}, Lcom/google/firebase/auth/api/internal/zza;->zza(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method public final zza(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 2
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzaf;

    invoke-direct {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzaf;-><init>(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zza;->zzfk:Lcom/google/firebase/auth/api/internal/zzdi;

    new-instance v1, Lcom/google/firebase/auth/api/internal/zzb;

    invoke-direct {v1, p0, p2}, Lcom/google/firebase/auth/api/internal/zzb;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-virtual {p1, v0, v1}, Lcom/google/firebase/auth/api/internal/zzdi;->zza(Lcom/google/android/gms/internal/firebase_auth/zzaf;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method public final zza(Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzad;

    invoke-direct {v0, p0, p2, p3}, Lcom/google/firebase/auth/api/internal/zzad;-><init>(Lcom/google/firebase/auth/api/internal/zza;Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-direct {p0, p1, v0}, Lcom/google/firebase/auth/api/internal/zza;->zza(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method public final zza(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p4    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p4}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzp;

    invoke-direct {v0, p0, p1, p2, p4}, Lcom/google/firebase/auth/api/internal/zzp;-><init>(Lcom/google/firebase/auth/api/internal/zza;Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-direct {p0, p3, v0}, Lcom/google/firebase/auth/api/internal/zza;->zza(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method public final zzb(Ljava/lang/String;Lcom/google/firebase/auth/ActionCodeSettings;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 2
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/ActionCodeSettings;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzan;

    const/4 v1, 0x4

    invoke-direct {v0, v1}, Lcom/google/android/gms/internal/firebase_auth/zzan;-><init>(I)V

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzan;->zzq(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzan;

    if-eqz p2, :cond_0

    invoke-virtual {v0, p2}, Lcom/google/android/gms/internal/firebase_auth/zzan;->zza(Lcom/google/firebase/auth/ActionCodeSettings;)Lcom/google/android/gms/internal/firebase_auth/zzan;

    :cond_0
    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zza;->zzfk:Lcom/google/firebase/auth/api/internal/zzdi;

    new-instance p2, Lcom/google/firebase/auth/api/internal/zzl;

    invoke-direct {p2, p0, p3}, Lcom/google/firebase/auth/api/internal/zzl;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-virtual {p1, v0, p2}, Lcom/google/firebase/auth/api/internal/zzdi;->zza(Lcom/google/android/gms/internal/firebase_auth/zzan;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method public final zzb(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 2
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzbi;

    invoke-direct {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzbi;-><init>(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zza;->zzfk:Lcom/google/firebase/auth/api/internal/zzdi;

    new-instance v1, Lcom/google/firebase/auth/api/internal/zzm;

    invoke-direct {v1, p0, p2}, Lcom/google/firebase/auth/api/internal/zzm;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-virtual {p1, v0, v1}, Lcom/google/firebase/auth/api/internal/zzdi;->zza(Lcom/google/android/gms/internal/firebase_auth/zzbi;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method public final zzb(Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzae;

    invoke-direct {v0, p0, p2, p3}, Lcom/google/firebase/auth/api/internal/zzae;-><init>(Lcom/google/firebase/auth/api/internal/zza;Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-direct {p0, p1, v0}, Lcom/google/firebase/auth/api/internal/zza;->zza(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method public final zzc(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 2
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzaz;

    invoke-direct {v0}, Lcom/google/android/gms/internal/firebase_auth/zzaz;-><init>()V

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzaz;->zzab(Ljava/lang/String;)Lcom/google/android/gms/internal/firebase_auth/zzaz;

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zza;->zzfk:Lcom/google/firebase/auth/api/internal/zzdi;

    new-instance v1, Lcom/google/firebase/auth/api/internal/zzaf;

    invoke-direct {v1, p0, p2}, Lcom/google/firebase/auth/api/internal/zzaf;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-virtual {p1, v0, v1}, Lcom/google/firebase/auth/api/internal/zzdi;->zza(Lcom/google/android/gms/internal/firebase_auth/zzaz;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method public final zzc(Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 2
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzbb;

    const/4 v1, 0x0

    invoke-direct {v0, p1, p2, v1}, Lcom/google/android/gms/internal/firebase_auth/zzbb;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zza;->zzfk:Lcom/google/firebase/auth/api/internal/zzdi;

    new-instance p2, Lcom/google/firebase/auth/api/internal/zzc;

    invoke-direct {p2, p0, p3}, Lcom/google/firebase/auth/api/internal/zzc;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-virtual {p1, v0, p2}, Lcom/google/firebase/auth/api/internal/zzdi;->zza(Lcom/google/android/gms/internal/firebase_auth/zzbb;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method public final zzd(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 2
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzw;

    invoke-direct {v0, p1}, Lcom/google/android/gms/internal/firebase_auth/zzw;-><init>(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zza;->zzfk:Lcom/google/firebase/auth/api/internal/zzdi;

    new-instance v1, Lcom/google/firebase/auth/api/internal/zzj;

    invoke-direct {v1, p0, p2}, Lcom/google/firebase/auth/api/internal/zzj;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-virtual {p1, v0, v1}, Lcom/google/firebase/auth/api/internal/zzdi;->zza(Lcom/google/android/gms/internal/firebase_auth/zzw;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method public final zzd(Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzbl;

    invoke-direct {v0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzbl;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zza;->zzfk:Lcom/google/firebase/auth/api/internal/zzdi;

    new-instance p2, Lcom/google/firebase/auth/api/internal/zzd;

    invoke-direct {p2, p0, p3}, Lcom/google/firebase/auth/api/internal/zzd;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-virtual {p1, v0, p2}, Lcom/google/firebase/auth/api/internal/zzdi;->zza(Lcom/google/android/gms/internal/firebase_auth/zzbl;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method public final zze(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 2
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzau;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/google/android/gms/internal/firebase_auth/zzau;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zza;->zzfk:Lcom/google/firebase/auth/api/internal/zzdi;

    new-instance v1, Lcom/google/firebase/auth/api/internal/zzn;

    invoke-direct {v1, p0, p2}, Lcom/google/firebase/auth/api/internal/zzn;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-virtual {p1, v0, v1}, Lcom/google/firebase/auth/api/internal/zzdi;->zza(Lcom/google/android/gms/internal/firebase_auth/zzau;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method public final zze(Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/android/gms/internal/firebase_auth/zzau;

    invoke-direct {v0, p1, p2}, Lcom/google/android/gms/internal/firebase_auth/zzau;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zza;->zzfk:Lcom/google/firebase/auth/api/internal/zzdi;

    new-instance p2, Lcom/google/firebase/auth/api/internal/zzo;

    invoke-direct {p2, p0, p3}, Lcom/google/firebase/auth/api/internal/zzo;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-virtual {p1, v0, p2}, Lcom/google/firebase/auth/api/internal/zzdi;->zza(Lcom/google/android/gms/internal/firebase_auth/zzau;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method public final zzf(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzs;

    invoke-direct {v0, p0, p2}, Lcom/google/firebase/auth/api/internal/zzs;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-direct {p0, p1, v0}, Lcom/google/firebase/auth/api/internal/zza;->zza(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method public final zzf(Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzt;

    invoke-direct {v0, p0, p1, p3}, Lcom/google/firebase/auth/api/internal/zzt;-><init>(Lcom/google/firebase/auth/api/internal/zza;Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-direct {p0, p2, v0}, Lcom/google/firebase/auth/api/internal/zza;->zza(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method public final zzg(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzv;

    invoke-direct {v0, p0, p2}, Lcom/google/firebase/auth/api/internal/zzv;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-direct {p0, p1, v0}, Lcom/google/firebase/auth/api/internal/zza;->zza(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method public final zzh(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzy;

    invoke-direct {v0, p0, p2}, Lcom/google/firebase/auth/api/internal/zzy;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-direct {p0, p1, v0}, Lcom/google/firebase/auth/api/internal/zza;->zza(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method

.method public final zzi(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzcb;)V
    .locals 2
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/api/internal/zzcb;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zza;->zzfk:Lcom/google/firebase/auth/api/internal/zzdi;

    new-instance v1, Lcom/google/firebase/auth/api/internal/zzaa;

    invoke-direct {v1, p0, p2}, Lcom/google/firebase/auth/api/internal/zzaa;-><init>(Lcom/google/firebase/auth/api/internal/zza;Lcom/google/firebase/auth/api/internal/zzcb;)V

    invoke-virtual {v0, p1, v1}, Lcom/google/firebase/auth/api/internal/zzdi;->zzb(Ljava/lang/String;Lcom/google/firebase/auth/api/internal/zzdk;)V

    return-void
.end method
