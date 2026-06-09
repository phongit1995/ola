.class public final Lcom/google/firebase/auth/api/internal/zzao;
.super Lcom/google/firebase/auth/api/internal/zzah;


# instance fields
.field private final zzgs:Landroid/content/Context;
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation
.end field

.field private final zzgt:Lcom/google/firebase/auth/api/internal/zzcp;
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation
.end field


# direct methods
.method constructor <init>(Landroid/content/Context;Lcom/google/firebase/auth/api/internal/zzcp;)V
    .locals 0
    .param p1    # Landroid/content/Context;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/api/internal/zzcp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-direct {p0}, Lcom/google/firebase/auth/api/internal/zzah;-><init>()V

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzao;->zzgs:Landroid/content/Context;

    iput-object p2, p0, Lcom/google/firebase/auth/api/internal/zzao;->zzgt:Lcom/google/firebase/auth/api/internal/zzcp;

    return-void
.end method

.method private static zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<ResultT:",
            "Ljava/lang/Object;",
            "CallbackT:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/google/firebase/auth/api/internal/zzcy<",
            "TResultT;TCallbackT;>;",
            "Ljava/lang/String;",
            ")",
            "Lcom/google/firebase/auth/api/internal/zzbb<",
            "TResultT;TCallbackT;>;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbb;

    invoke-direct {v0, p0, p1}, Lcom/google/firebase/auth/api/internal/zzbb;-><init>(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)V

    return-object v0
.end method

.method static zza(Lcom/google/firebase/FirebaseApp;Lcom/google/android/gms/internal/firebase_auth/zzaj;)Lcom/google/firebase/auth/internal/zzl;
    .locals 6
    .param p0    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Lcom/google/android/gms/internal/firebase_auth/zzaj;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    .annotation build Lcom/google/android/gms/common/util/VisibleForTesting;
    .end annotation

    invoke-static {p0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    new-instance v1, Lcom/google/firebase/auth/internal/zzh;

    const-string v2, "firebase"

    invoke-direct {v1, p1, v2}, Lcom/google/firebase/auth/internal/zzh;-><init>(Lcom/google/android/gms/internal/firebase_auth/zzaj;Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzat()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_0

    const/4 v2, 0x0

    :goto_0
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v3

    if-ge v2, v3, :cond_0

    new-instance v3, Lcom/google/firebase/auth/internal/zzh;

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/google/android/gms/internal/firebase_auth/zzaq;

    invoke-direct {v3, v4}, Lcom/google/firebase/auth/internal/zzh;-><init>(Lcom/google/android/gms/internal/firebase_auth/zzaq;)V

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    new-instance v1, Lcom/google/firebase/auth/internal/zzl;

    invoke-direct {v1, p0, v0}, Lcom/google/firebase/auth/internal/zzl;-><init>(Lcom/google/firebase/FirebaseApp;Ljava/util/List;)V

    new-instance p0, Lcom/google/firebase/auth/internal/zzn;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzaj;->getLastSignInTimestamp()J

    move-result-wide v2

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzaj;->getCreationTimestamp()J

    move-result-wide v4

    invoke-direct {p0, v2, v3, v4, v5}, Lcom/google/firebase/auth/internal/zzn;-><init>(JJ)V

    invoke-virtual {v1, p0}, Lcom/google/firebase/auth/internal/zzl;->zza(Lcom/google/firebase/auth/internal/zzn;)V

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzaj;->isNewUser()Z

    move-result p0

    invoke-virtual {v1, p0}, Lcom/google/firebase/auth/internal/zzl;->zze(Z)V

    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzaj;->zzav()Lcom/google/firebase/auth/zzd;

    move-result-object p0

    invoke-virtual {v1, p0}, Lcom/google/firebase/auth/internal/zzl;->zzc(Lcom/google/firebase/auth/zzd;)V

    return-object v1
.end method

.method private final zzb(Z)Lcom/google/android/gms/common/api/GoogleApi;
    .locals 4
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(Z)",
            "Lcom/google/android/gms/common/api/GoogleApi<",
            "Lcom/google/firebase/auth/api/internal/zzcp;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzao;->zzgt:Lcom/google/firebase/auth/api/internal/zzcp;

    invoke-virtual {v0}, Lcom/google/firebase/auth/api/internal/zzaj;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/firebase/auth/api/internal/zzcp;

    iput-boolean p1, v0, Lcom/google/firebase/auth/api/internal/zzaj;->zzgn:Z

    new-instance p1, Lcom/google/firebase/auth/api/internal/zzal;

    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzao;->zzgs:Landroid/content/Context;

    sget-object v2, Lcom/google/firebase/auth/api/internal/zzcn;->zzhn:Lcom/google/android/gms/common/api/Api;

    new-instance v3, Lcom/google/firebase/FirebaseExceptionMapper;

    invoke-direct {v3}, Lcom/google/firebase/FirebaseExceptionMapper;-><init>()V

    invoke-direct {p1, v1, v2, v0, v3}, Lcom/google/firebase/auth/api/internal/zzal;-><init>(Landroid/content/Context;Lcom/google/android/gms/common/api/Api;Lcom/google/android/gms/common/api/Api$ApiOptions;Lcom/google/android/gms/common/api/internal/StatusExceptionMapper;)V

    return-object p1
.end method


# virtual methods
.method public final setFirebaseUIVersion(Ljava/lang/String;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbm;

    invoke-direct {v0, p1}, Lcom/google/firebase/auth/api/internal/zzbm;-><init>(Ljava/lang/String;)V

    const-string p1, "setFirebaseUIVersion"

    invoke-static {v0, p1}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Lcom/google/firebase/FirebaseApp;Lcom/google/firebase/auth/ActionCodeSettings;Ljava/lang/String;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/ActionCodeSettings;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Lcom/google/firebase/auth/ActionCodeSettings;",
            "Ljava/lang/String;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbk;

    invoke-direct {v0, p3, p2}, Lcom/google/firebase/auth/api/internal/zzbk;-><init>(Ljava/lang/String;Lcom/google/firebase/auth/ActionCodeSettings;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "sendEmailVerification"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Lcom/google/firebase/FirebaseApp;Lcom/google/firebase/auth/AuthCredential;Lcom/google/firebase/auth/internal/zza;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/AuthCredential;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/internal/zza;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Lcom/google/firebase/auth/AuthCredential;",
            "Lcom/google/firebase/auth/internal/zza;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/firebase/auth/AuthResult;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbo;

    invoke-direct {v0, p2}, Lcom/google/firebase/auth/api/internal/zzbo;-><init>(Lcom/google/firebase/auth/AuthCredential;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p3}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "signInWithCredential"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Lcom/google/firebase/FirebaseApp;Lcom/google/firebase/auth/EmailAuthCredential;Lcom/google/firebase/auth/internal/zza;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/EmailAuthCredential;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/internal/zza;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Lcom/google/firebase/auth/EmailAuthCredential;",
            "Lcom/google/firebase/auth/internal/zza;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/firebase/auth/AuthResult;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbr;

    invoke-direct {v0, p2}, Lcom/google/firebase/auth/api/internal/zzbr;-><init>(Lcom/google/firebase/auth/EmailAuthCredential;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p3}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "sendSignInLinkToEmail"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Lcom/google/firebase/FirebaseApp;Lcom/google/firebase/auth/FirebaseUser;Lcom/google/firebase/auth/AuthCredential;Lcom/google/firebase/auth/internal/zzae;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/FirebaseUser;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/AuthCredential;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p4    # Lcom/google/firebase/auth/internal/zzae;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Lcom/google/firebase/auth/FirebaseUser;",
            "Lcom/google/firebase/auth/AuthCredential;",
            "Lcom/google/firebase/auth/internal/zzae;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbc;

    invoke-direct {v0, p3}, Lcom/google/firebase/auth/api/internal/zzbc;-><init>(Lcom/google/firebase/auth/AuthCredential;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "reauthenticateWithCredential"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Lcom/google/firebase/FirebaseApp;Lcom/google/firebase/auth/FirebaseUser;Lcom/google/firebase/auth/EmailAuthCredential;Lcom/google/firebase/auth/internal/zzae;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/FirebaseUser;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/EmailAuthCredential;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p4    # Lcom/google/firebase/auth/internal/zzae;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Lcom/google/firebase/auth/FirebaseUser;",
            "Lcom/google/firebase/auth/EmailAuthCredential;",
            "Lcom/google/firebase/auth/internal/zzae;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbe;

    invoke-direct {v0, p3}, Lcom/google/firebase/auth/api/internal/zzbe;-><init>(Lcom/google/firebase/auth/EmailAuthCredential;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "reauthenticateWithEmailLink"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Lcom/google/firebase/FirebaseApp;Lcom/google/firebase/auth/FirebaseUser;Lcom/google/firebase/auth/PhoneAuthCredential;Lcom/google/firebase/auth/internal/zzae;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/FirebaseUser;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/PhoneAuthCredential;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p4    # Lcom/google/firebase/auth/internal/zzae;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Lcom/google/firebase/auth/FirebaseUser;",
            "Lcom/google/firebase/auth/PhoneAuthCredential;",
            "Lcom/google/firebase/auth/internal/zzae;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbx;

    invoke-direct {v0, p3}, Lcom/google/firebase/auth/api/internal/zzbx;-><init>(Lcom/google/firebase/auth/PhoneAuthCredential;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "updatePhoneNumber"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Lcom/google/firebase/FirebaseApp;Lcom/google/firebase/auth/FirebaseUser;Lcom/google/firebase/auth/UserProfileChangeRequest;Lcom/google/firebase/auth/internal/zzae;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/FirebaseUser;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/UserProfileChangeRequest;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p4    # Lcom/google/firebase/auth/internal/zzae;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Lcom/google/firebase/auth/FirebaseUser;",
            "Lcom/google/firebase/auth/UserProfileChangeRequest;",
            "Lcom/google/firebase/auth/internal/zzae;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzby;

    invoke-direct {v0, p3}, Lcom/google/firebase/auth/api/internal/zzby;-><init>(Lcom/google/firebase/auth/UserProfileChangeRequest;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "updateProfile"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Lcom/google/firebase/FirebaseApp;Lcom/google/firebase/auth/FirebaseUser;Lcom/google/firebase/auth/internal/zzae;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/FirebaseUser;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/internal/zzae;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Lcom/google/firebase/auth/FirebaseUser;",
            "Lcom/google/firebase/auth/internal/zzae;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbj;

    invoke-direct {v0}, Lcom/google/firebase/auth/api/internal/zzbj;-><init>()V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p3}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p3}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "reload"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zza(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Lcom/google/firebase/FirebaseApp;Lcom/google/firebase/auth/FirebaseUser;Ljava/lang/String;Lcom/google/firebase/auth/internal/zzae;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/FirebaseUser;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p4    # Lcom/google/firebase/auth/internal/zzae;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Lcom/google/firebase/auth/FirebaseUser;",
            "Ljava/lang/String;",
            "Lcom/google/firebase/auth/internal/zzae;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/firebase/auth/GetTokenResult;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzaw;

    invoke-direct {v0, p3}, Lcom/google/firebase/auth/api/internal/zzaw;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "getAccessToken"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zza(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Lcom/google/firebase/FirebaseApp;Lcom/google/firebase/auth/FirebaseUser;Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/auth/internal/zzae;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/FirebaseUser;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p4    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p5    # Lcom/google/firebase/auth/internal/zzae;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Lcom/google/firebase/auth/FirebaseUser;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/google/firebase/auth/internal/zzae;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbg;

    invoke-direct {v0, p3, p4}, Lcom/google/firebase/auth/api/internal/zzbg;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p5}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p5}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "reauthenticateWithEmailPassword"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Lcom/google/firebase/FirebaseApp;Lcom/google/firebase/auth/PhoneAuthCredential;Lcom/google/firebase/auth/internal/zza;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/PhoneAuthCredential;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/internal/zza;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Lcom/google/firebase/auth/PhoneAuthCredential;",
            "Lcom/google/firebase/auth/internal/zza;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/firebase/auth/AuthResult;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbs;

    invoke-direct {v0, p2}, Lcom/google/firebase/auth/api/internal/zzbs;-><init>(Lcom/google/firebase/auth/PhoneAuthCredential;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p3}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "signInWithPhoneNumber"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Lcom/google/firebase/FirebaseApp;Lcom/google/firebase/auth/internal/zza;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/internal/zza;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Lcom/google/firebase/auth/internal/zza;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/firebase/auth/AuthResult;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbn;

    invoke-direct {v0}, Lcom/google/firebase/auth/api/internal/zzbn;-><init>()V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "signInAnonymously"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Lcom/google/firebase/FirebaseApp;Ljava/lang/String;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Ljava/lang/String;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/firebase/auth/ProviderQueryResult;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzau;

    invoke-direct {v0, p2}, Lcom/google/firebase/auth/api/internal/zzau;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "fetchProvidersForEmail"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zza(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Lcom/google/firebase/FirebaseApp;Ljava/lang/String;Lcom/google/firebase/auth/ActionCodeSettings;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/ActionCodeSettings;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Ljava/lang/String;",
            "Lcom/google/firebase/auth/ActionCodeSettings;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x1

    invoke-virtual {p3, v0}, Lcom/google/firebase/auth/ActionCodeSettings;->zzb(I)V

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbl;

    invoke-direct {v0, p2, p3}, Lcom/google/firebase/auth/api/internal/zzbl;-><init>(Ljava/lang/String;Lcom/google/firebase/auth/ActionCodeSettings;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "sendPasswordResetEmail"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Lcom/google/firebase/FirebaseApp;Ljava/lang/String;Lcom/google/firebase/auth/internal/zza;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/internal/zza;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Ljava/lang/String;",
            "Lcom/google/firebase/auth/internal/zza;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/firebase/auth/AuthResult;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbp;

    invoke-direct {v0, p2}, Lcom/google/firebase/auth/api/internal/zzbp;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p3}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "signInWithCustomToken"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Lcom/google/firebase/FirebaseApp;Ljava/lang/String;Ljava/lang/String;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
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
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzar;

    invoke-direct {v0, p2, p3}, Lcom/google/firebase/auth/api/internal/zzar;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "confirmPasswordReset"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Lcom/google/firebase/FirebaseApp;Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/auth/internal/zza;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
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
    .param p4    # Lcom/google/firebase/auth/internal/zza;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/google/firebase/auth/internal/zza;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/firebase/auth/AuthResult;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzas;

    invoke-direct {v0, p2, p3}, Lcom/google/firebase/auth/api/internal/zzas;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "createUserWithEmailAndPassword"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Lcom/google/firebase/auth/FirebaseUser;Lcom/google/firebase/auth/internal/zzv;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/auth/FirebaseUser;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/internal/zzv;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Landroid/support/annotation/NonNull;
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/auth/FirebaseUser;",
            "Lcom/google/firebase/auth/internal/zzv;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzat;

    invoke-direct {v0}, Lcom/google/firebase/auth/api/internal/zzat;-><init>()V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "delete"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zza(Lcom/google/firebase/FirebaseApp;Lcom/google/android/gms/internal/firebase_auth/zzax;Lcom/google/firebase/auth/PhoneAuthProvider$OnVerificationStateChangedCallbacks;Landroid/app/Activity;Ljava/util/concurrent/Executor;)V
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/android/gms/internal/firebase_auth/zzax;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/PhoneAuthProvider$OnVerificationStateChangedCallbacks;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p4    # Landroid/app/Activity;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .param p5    # Ljava/util/concurrent/Executor;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzca;

    invoke-direct {v0, p2}, Lcom/google/firebase/auth/api/internal/zzca;-><init>(Lcom/google/android/gms/internal/firebase_auth/zzax;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p3, p4, p5}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/PhoneAuthProvider$OnVerificationStateChangedCallbacks;Landroid/app/Activity;Ljava/util/concurrent/Executor;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "verifyPhoneNumber"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    return-void
.end method

.method public final zzb(Lcom/google/firebase/FirebaseApp;Lcom/google/firebase/auth/FirebaseUser;Lcom/google/firebase/auth/AuthCredential;Lcom/google/firebase/auth/internal/zzae;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/FirebaseUser;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/AuthCredential;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p4    # Lcom/google/firebase/auth/internal/zzae;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Lcom/google/firebase/auth/FirebaseUser;",
            "Lcom/google/firebase/auth/AuthCredential;",
            "Lcom/google/firebase/auth/internal/zzae;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/firebase/auth/AuthResult;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbd;

    invoke-direct {v0, p3}, Lcom/google/firebase/auth/api/internal/zzbd;-><init>(Lcom/google/firebase/auth/AuthCredential;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "reauthenticateWithCredentialWithData"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zzb(Lcom/google/firebase/FirebaseApp;Lcom/google/firebase/auth/FirebaseUser;Lcom/google/firebase/auth/EmailAuthCredential;Lcom/google/firebase/auth/internal/zzae;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/FirebaseUser;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/EmailAuthCredential;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p4    # Lcom/google/firebase/auth/internal/zzae;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Lcom/google/firebase/auth/FirebaseUser;",
            "Lcom/google/firebase/auth/EmailAuthCredential;",
            "Lcom/google/firebase/auth/internal/zzae;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/firebase/auth/AuthResult;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbf;

    invoke-direct {v0, p3}, Lcom/google/firebase/auth/api/internal/zzbf;-><init>(Lcom/google/firebase/auth/EmailAuthCredential;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "reauthenticateWithEmailLinkWithData"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zzb(Lcom/google/firebase/FirebaseApp;Lcom/google/firebase/auth/FirebaseUser;Lcom/google/firebase/auth/PhoneAuthCredential;Lcom/google/firebase/auth/internal/zzae;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/FirebaseUser;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/PhoneAuthCredential;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p4    # Lcom/google/firebase/auth/internal/zzae;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Lcom/google/firebase/auth/FirebaseUser;",
            "Lcom/google/firebase/auth/PhoneAuthCredential;",
            "Lcom/google/firebase/auth/internal/zzae;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbi;

    invoke-direct {v0, p3}, Lcom/google/firebase/auth/api/internal/zzbi;-><init>(Lcom/google/firebase/auth/PhoneAuthCredential;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "reauthenticateWithPhoneCredential"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zzb(Lcom/google/firebase/FirebaseApp;Lcom/google/firebase/auth/FirebaseUser;Ljava/lang/String;Lcom/google/firebase/auth/internal/zzae;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/FirebaseUser;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p4    # Lcom/google/firebase/auth/internal/zzae;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Lcom/google/firebase/auth/FirebaseUser;",
            "Ljava/lang/String;",
            "Lcom/google/firebase/auth/internal/zzae;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbv;

    invoke-direct {v0, p3}, Lcom/google/firebase/auth/api/internal/zzbv;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "updateEmail"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zzb(Lcom/google/firebase/FirebaseApp;Lcom/google/firebase/auth/FirebaseUser;Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/auth/internal/zzae;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/FirebaseUser;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p4    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p5    # Lcom/google/firebase/auth/internal/zzae;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Lcom/google/firebase/auth/FirebaseUser;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/google/firebase/auth/internal/zzae;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/firebase/auth/AuthResult;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbh;

    invoke-direct {v0, p3, p4}, Lcom/google/firebase/auth/api/internal/zzbh;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p5}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p5}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "reauthenticateWithEmailPasswordWithData"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zzb(Lcom/google/firebase/FirebaseApp;Ljava/lang/String;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Ljava/lang/String;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/firebase/auth/SignInMethodQueryResult;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzav;

    invoke-direct {v0, p2}, Lcom/google/firebase/auth/api/internal/zzav;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "fetchSignInMethodsForEmail"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zza(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zzb(Lcom/google/firebase/FirebaseApp;Ljava/lang/String;Lcom/google/firebase/auth/ActionCodeSettings;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/ActionCodeSettings;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Ljava/lang/String;",
            "Lcom/google/firebase/auth/ActionCodeSettings;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x6

    invoke-virtual {p3, v0}, Lcom/google/firebase/auth/ActionCodeSettings;->zzb(I)V

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbl;

    invoke-direct {v0, p2, p3}, Lcom/google/firebase/auth/api/internal/zzbl;-><init>(Ljava/lang/String;Lcom/google/firebase/auth/ActionCodeSettings;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "sendSignInLinkToEmail"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zzb(Lcom/google/firebase/FirebaseApp;Ljava/lang/String;Ljava/lang/String;Lcom/google/firebase/auth/internal/zza;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
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
    .param p4    # Lcom/google/firebase/auth/internal/zza;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/google/firebase/auth/internal/zza;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/firebase/auth/AuthResult;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbq;

    invoke-direct {v0, p2, p3}, Lcom/google/firebase/auth/api/internal/zzbq;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "signInWithEmailAndPassword"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zzc(Lcom/google/firebase/FirebaseApp;Lcom/google/firebase/auth/FirebaseUser;Lcom/google/firebase/auth/AuthCredential;Lcom/google/firebase/auth/internal/zzae;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/FirebaseUser;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/AuthCredential;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p4    # Lcom/google/firebase/auth/internal/zzae;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Lcom/google/firebase/auth/FirebaseUser;",
            "Lcom/google/firebase/auth/AuthCredential;",
            "Lcom/google/firebase/auth/internal/zzae;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/firebase/auth/AuthResult;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbd;

    invoke-direct {v0, p3}, Lcom/google/firebase/auth/api/internal/zzbd;-><init>(Lcom/google/firebase/auth/AuthCredential;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "reauthenticateWithPhoneCredentialWithData"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zzc(Lcom/google/firebase/FirebaseApp;Lcom/google/firebase/auth/FirebaseUser;Ljava/lang/String;Lcom/google/firebase/auth/internal/zzae;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/FirebaseUser;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p4    # Lcom/google/firebase/auth/internal/zzae;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Lcom/google/firebase/auth/FirebaseUser;",
            "Ljava/lang/String;",
            "Lcom/google/firebase/auth/internal/zzae;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbw;

    invoke-direct {v0, p3}, Lcom/google/firebase/auth/api/internal/zzbw;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "updatePassword"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zzc(Lcom/google/firebase/FirebaseApp;Ljava/lang/String;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Ljava/lang/String;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/firebase/auth/ActionCodeResult;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzaq;

    invoke-direct {v0, p2}, Lcom/google/firebase/auth/api/internal/zzaq;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "checkActionCode"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zzd(Lcom/google/firebase/FirebaseApp;Lcom/google/firebase/auth/FirebaseUser;Lcom/google/firebase/auth/AuthCredential;Lcom/google/firebase/auth/internal/zzae;)Lcom/google/android/gms/tasks/Task;
    .locals 2
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/FirebaseUser;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Lcom/google/firebase/auth/AuthCredential;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p4    # Lcom/google/firebase/auth/internal/zzae;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Lcom/google/firebase/auth/FirebaseUser;",
            "Lcom/google/firebase/auth/AuthCredential;",
            "Lcom/google/firebase/auth/internal/zzae;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/firebase/auth/AuthResult;",
            ">;"
        }
    .end annotation

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p4}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {p2}, Lcom/google/firebase/auth/FirebaseUser;->getProviders()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p3}, Lcom/google/firebase/auth/AuthCredential;->getProvider()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance p1, Lcom/google/android/gms/common/api/Status;

    const/16 p2, 0x4277

    invoke-direct {p1, p2}, Lcom/google/android/gms/common/api/Status;-><init>(I)V

    invoke-static {p1}, Lcom/google/firebase/auth/api/internal/zzce;->zzb(Lcom/google/android/gms/common/api/Status;)Lcom/google/firebase/FirebaseException;

    move-result-object p1

    invoke-static {p1}, Lcom/google/android/gms/tasks/Tasks;->forException(Ljava/lang/Exception;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1

    :cond_0
    instance-of v0, p3, Lcom/google/firebase/auth/EmailAuthCredential;

    if-eqz v0, :cond_2

    check-cast p3, Lcom/google/firebase/auth/EmailAuthCredential;

    invoke-virtual {p3}, Lcom/google/firebase/auth/EmailAuthCredential;->zzj()Z

    move-result v0

    if-nez v0, :cond_1

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzax;

    invoke-direct {v0, p3}, Lcom/google/firebase/auth/api/internal/zzax;-><init>(Lcom/google/firebase/auth/EmailAuthCredential;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "linkEmailAuthCredential"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1

    :cond_1
    new-instance v0, Lcom/google/firebase/auth/api/internal/zzba;

    invoke-direct {v0, p3}, Lcom/google/firebase/auth/api/internal/zzba;-><init>(Lcom/google/firebase/auth/EmailAuthCredential;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "linkEmailAuthCredential"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1

    :cond_2
    instance-of v0, p3, Lcom/google/firebase/auth/PhoneAuthCredential;

    if-eqz v0, :cond_3

    check-cast p3, Lcom/google/firebase/auth/PhoneAuthCredential;

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzaz;

    invoke-direct {v0, p3}, Lcom/google/firebase/auth/api/internal/zzaz;-><init>(Lcom/google/firebase/auth/PhoneAuthCredential;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "linkPhoneAuthCredential"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1

    :cond_3
    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p4}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzay;

    invoke-direct {v0, p3}, Lcom/google/firebase/auth/api/internal/zzay;-><init>(Lcom/google/firebase/auth/AuthCredential;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "linkFederatedCredential"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zzd(Lcom/google/firebase/FirebaseApp;Lcom/google/firebase/auth/FirebaseUser;Ljava/lang/String;Lcom/google/firebase/auth/internal/zzae;)Lcom/google/android/gms/tasks/Task;
    .locals 3
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/FirebaseUser;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p4    # Lcom/google/firebase/auth/internal/zzae;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Lcom/google/firebase/auth/FirebaseUser;",
            "Ljava/lang/String;",
            "Lcom/google/firebase/auth/internal/zzae;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Lcom/google/firebase/auth/AuthResult;",
            ">;"
        }
    .end annotation

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p4}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {p2}, Lcom/google/firebase/auth/FirebaseUser;->getProviders()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0, p3}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    invoke-virtual {p2}, Lcom/google/firebase/auth/FirebaseUser;->isAnonymous()Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_1
    new-instance p1, Lcom/google/android/gms/common/api/Status;

    const/16 p2, 0x4278

    invoke-direct {p1, p2, p3}, Lcom/google/android/gms/common/api/Status;-><init>(ILjava/lang/String;)V

    invoke-static {p1}, Lcom/google/firebase/auth/api/internal/zzce;->zzb(Lcom/google/android/gms/common/api/Status;)Lcom/google/firebase/FirebaseException;

    move-result-object p1

    invoke-static {p1}, Lcom/google/android/gms/tasks/Tasks;->forException(Ljava/lang/Exception;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1

    :cond_2
    const/4 v0, -0x1

    invoke-virtual {p3}, Ljava/lang/String;->hashCode()I

    move-result v1

    const v2, 0x4889ba9b

    if-eq v1, v2, :cond_3

    goto :goto_0

    :cond_3
    const-string v1, "password"

    invoke-virtual {p3, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    const/4 v0, 0x0

    :cond_4
    :goto_0
    if-eqz v0, :cond_5

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbu;

    invoke-direct {v0, p3}, Lcom/google/firebase/auth/api/internal/zzbu;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "unlinkFederatedCredential"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1

    :cond_5
    new-instance p3, Lcom/google/firebase/auth/api/internal/zzbt;

    invoke-direct {p3}, Lcom/google/firebase/auth/api/internal/zzbt;-><init>()V

    invoke-virtual {p3, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/firebase/auth/api/internal/zzcy;->zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    invoke-virtual {p1, p4}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "unlinkEmailCredential"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zzd(Lcom/google/firebase/FirebaseApp;Ljava/lang/String;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Ljava/lang/String;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzap;

    invoke-direct {v0, p2}, Lcom/google/firebase/auth/api/internal/zzap;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "applyActionCode"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final zze(Lcom/google/firebase/FirebaseApp;Ljava/lang/String;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            "Ljava/lang/String;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzbz;

    invoke-direct {v0, p2}, Lcom/google/firebase/auth/api/internal/zzbz;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;

    move-result-object p1

    const-string p2, "verifyPasswordResetCode"

    invoke-static {p1, p2}, Lcom/google/firebase/auth/api/internal/zzao;->zza(Lcom/google/firebase/auth/api/internal/zzcy;Ljava/lang/String;)Lcom/google/firebase/auth/api/internal/zzbb;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/google/firebase/auth/api/internal/zzah;->zzb(Lcom/google/firebase/auth/api/internal/zzam;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method final zzw()Lcom/google/firebase/auth/api/internal/zzai;
    .locals 7

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzao;->zzgs:Landroid/content/Context;

    const-string v1, "com.google.android.gms.firebase_auth"

    invoke-static {v0, v1}, Lcom/google/android/gms/dynamite/DynamiteModule;->getRemoteVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    const/4 v1, 0x0

    invoke-direct {p0, v1}, Lcom/google/firebase/auth/api/internal/zzao;->zzb(Z)Lcom/google/android/gms/common/api/GoogleApi;

    move-result-object v1

    iget-object v2, p0, Lcom/google/firebase/auth/api/internal/zzao;->zzgs:Landroid/content/Context;

    const-string v3, "com.google.firebase.auth"

    invoke-static {v2, v3}, Lcom/google/android/gms/dynamite/DynamiteModule;->getLocalVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v2

    const/4 v3, 0x1

    if-eqz v2, :cond_0

    invoke-direct {p0, v3}, Lcom/google/firebase/auth/api/internal/zzao;->zzb(Z)Lcom/google/android/gms/common/api/GoogleApi;

    move-result-object v4

    goto :goto_0

    :cond_0
    const/4 v4, 0x0

    :goto_0
    new-instance v5, Lcom/google/firebase/auth/api/internal/zzak;

    invoke-static {}, Ljava/util/Collections;->emptyMap()Ljava/util/Map;

    move-result-object v6

    invoke-direct {v5, v0, v2, v6, v3}, Lcom/google/firebase/auth/api/internal/zzak;-><init>(IILjava/util/Map;Z)V

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzai;

    invoke-direct {v0, v1, v4, v5}, Lcom/google/firebase/auth/api/internal/zzai;-><init>(Lcom/google/android/gms/common/api/GoogleApi;Lcom/google/android/gms/common/api/GoogleApi;Lcom/google/firebase/auth/api/internal/zzan;)V

    return-object v0
.end method
