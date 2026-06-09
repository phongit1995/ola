.class abstract Lcom/google/firebase/auth/api/internal/zzcy;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/firebase/auth/api/internal/zzcy$zza;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<SuccessT:",
        "Ljava/lang/Object;",
        "CallbackT:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# instance fields
.field protected zzeb:Lcom/google/firebase/FirebaseApp;

.field protected zzey:Ljava/lang/String;

.field protected final zzia:I

.field protected final zzib:Lcom/google/firebase/auth/api/internal/zzdb;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/firebase/auth/api/internal/zzdb;"
        }
    .end annotation
.end field

.field protected zzic:Lcom/google/firebase/auth/FirebaseUser;

.field protected zzid:Lcom/google/firebase/auth/api/internal/zzck;

.field protected zzie:Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TCallbackT;"
        }
    .end annotation
.end field

.field protected zzif:Lcom/google/firebase/auth/internal/zzw;

.field protected zzig:Lcom/google/firebase/auth/api/internal/zzcx;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/firebase/auth/api/internal/zzcx<",
            "TSuccessT;>;"
        }
    .end annotation
.end field

.field protected final zzih:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/google/firebase/auth/PhoneAuthProvider$OnVerificationStateChangedCallbacks;",
            ">;"
        }
    .end annotation
.end field

.field private zzii:Landroid/app/Activity;

.field protected zzij:Ljava/util/concurrent/Executor;

.field protected zzik:Lcom/google/firebase/auth/api/internal/zzda;

.field protected zzil:Lcom/google/android/gms/internal/firebase_auth/zzao;

.field protected zzim:Lcom/google/android/gms/internal/firebase_auth/zzaj;

.field protected zzin:Lcom/google/android/gms/internal/firebase_auth/zzx;

.field protected zzio:Lcom/google/android/gms/internal/firebase_auth/zzav;

.field protected zzip:Ljava/lang/String;

.field protected zziq:Lcom/google/firebase/auth/PhoneAuthCredential;

.field private zzir:Z

.field zzis:Z
    .annotation build Lcom/google/android/gms/common/util/VisibleForTesting;
    .end annotation
.end field

.field private zzit:Ljava/lang/Object;
    .annotation build Lcom/google/android/gms/common/util/VisibleForTesting;
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TSuccessT;"
        }
    .end annotation
.end field

.field private zziu:Lcom/google/android/gms/common/api/Status;
    .annotation build Lcom/google/android/gms/common/util/VisibleForTesting;
    .end annotation
.end field


# direct methods
.method public constructor <init>(I)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Lcom/google/firebase/auth/api/internal/zzdb;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/google/firebase/auth/api/internal/zzdb;-><init>(Lcom/google/firebase/auth/api/internal/zzcy;Lcom/google/firebase/auth/api/internal/zzcz;)V

    iput-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzib:Lcom/google/firebase/auth/api/internal/zzdb;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzih:Ljava/util/List;

    iput p1, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzia:I

    return-void
.end method

.method static synthetic zza(Lcom/google/firebase/auth/api/internal/zzcy;)V
    .locals 0

    invoke-direct {p0}, Lcom/google/firebase/auth/api/internal/zzcy;->zzam()V

    return-void
.end method

.method static synthetic zza(Lcom/google/firebase/auth/api/internal/zzcy;Lcom/google/android/gms/common/api/Status;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/google/firebase/auth/api/internal/zzcy;->zzd(Lcom/google/android/gms/common/api/Status;)V

    return-void
.end method

.method static synthetic zza(Lcom/google/firebase/auth/api/internal/zzcy;Z)Z
    .locals 0

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzir:Z

    return p1
.end method

.method private final zzam()V
    .locals 2

    invoke-virtual {p0}, Lcom/google/firebase/auth/api/internal/zzcy;->zzab()V

    iget-boolean v0, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzir:Z

    const-string v1, "no success or failure set on method implementation"

    invoke-static {v0, v1}, Lcom/google/android/gms/common/internal/Preconditions;->checkState(ZLjava/lang/Object;)V

    return-void
.end method

.method private final zzd(Lcom/google/android/gms/common/api/Status;)V
    .locals 1

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzif:Lcom/google/firebase/auth/internal/zzw;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzif:Lcom/google/firebase/auth/internal/zzw;

    invoke-interface {v0, p1}, Lcom/google/firebase/auth/internal/zzw;->zza(Lcom/google/android/gms/common/api/Status;)V

    :cond_0
    return-void
.end method


# virtual methods
.method public final zza(Lcom/google/firebase/FirebaseApp;)Lcom/google/firebase/auth/api/internal/zzcy;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/FirebaseApp;",
            ")",
            "Lcom/google/firebase/auth/api/internal/zzcy<",
            "TSuccessT;TCallbackT;>;"
        }
    .end annotation

    const-string v0, "firebaseApp cannot be null"

    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/firebase/FirebaseApp;

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzeb:Lcom/google/firebase/FirebaseApp;

    return-object p0
.end method

.method public final zza(Lcom/google/firebase/auth/PhoneAuthProvider$OnVerificationStateChangedCallbacks;Landroid/app/Activity;Ljava/util/concurrent/Executor;)Lcom/google/firebase/auth/api/internal/zzcy;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/auth/PhoneAuthProvider$OnVerificationStateChangedCallbacks;",
            "Landroid/app/Activity;",
            "Ljava/util/concurrent/Executor;",
            ")",
            "Lcom/google/firebase/auth/api/internal/zzcy<",
            "TSuccessT;TCallbackT;>;"
        }
    .end annotation

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzih:Ljava/util/List;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzih:Ljava/util/List;

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/firebase/auth/PhoneAuthProvider$OnVerificationStateChangedCallbacks;

    invoke-interface {v1, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iput-object p2, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzii:Landroid/app/Activity;

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzii:Landroid/app/Activity;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzih:Ljava/util/List;

    invoke-static {p2, p1}, Lcom/google/firebase/auth/api/internal/zzcy$zza;->zza(Landroid/app/Activity;Ljava/util/List;)V

    :cond_0
    invoke-static {p3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/concurrent/Executor;

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzij:Ljava/util/concurrent/Executor;

    return-object p0

    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method public final zza(Lcom/google/firebase/auth/internal/zzw;)Lcom/google/firebase/auth/api/internal/zzcy;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/auth/internal/zzw;",
            ")",
            "Lcom/google/firebase/auth/api/internal/zzcy<",
            "TSuccessT;TCallbackT;>;"
        }
    .end annotation

    const-string v0, "external failure callback cannot be null"

    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/firebase/auth/internal/zzw;

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzif:Lcom/google/firebase/auth/internal/zzw;

    return-object p0
.end method

.method public final zza(Ljava/lang/Object;)Lcom/google/firebase/auth/api/internal/zzcy;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TCallbackT;)",
            "Lcom/google/firebase/auth/api/internal/zzcy<",
            "TSuccessT;TCallbackT;>;"
        }
    .end annotation

    const-string v0, "external callback cannot be null"

    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzie:Ljava/lang/Object;

    return-object p0
.end method

.method protected abstract zzaa()V
.end method

.method public abstract zzab()V
.end method

.method public final zzb(Ljava/lang/Object;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TSuccessT;)V"
        }
    .end annotation

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzir:Z

    iput-boolean v0, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzis:Z

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzit:Ljava/lang/Object;

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzig:Lcom/google/firebase/auth/api/internal/zzcx;

    const/4 v1, 0x0

    invoke-interface {v0, p1, v1}, Lcom/google/firebase/auth/api/internal/zzcx;->zza(Ljava/lang/Object;Lcom/google/android/gms/common/api/Status;)V

    return-void
.end method

.method public final zzc(Lcom/google/android/gms/common/api/Status;)V
    .locals 2

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzir:Z

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzis:Z

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zziu:Lcom/google/android/gms/common/api/Status;

    iget-object v0, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzig:Lcom/google/firebase/auth/api/internal/zzcx;

    const/4 v1, 0x0

    invoke-interface {v0, v1, p1}, Lcom/google/firebase/auth/api/internal/zzcx;->zza(Ljava/lang/Object;Lcom/google/android/gms/common/api/Status;)V

    return-void
.end method

.method public final zzf(Lcom/google/firebase/auth/FirebaseUser;)Lcom/google/firebase/auth/api/internal/zzcy;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/auth/FirebaseUser;",
            ")",
            "Lcom/google/firebase/auth/api/internal/zzcy<",
            "TSuccessT;TCallbackT;>;"
        }
    .end annotation

    const-string v0, "firebaseUser cannot be null"

    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/firebase/auth/FirebaseUser;

    iput-object p1, p0, Lcom/google/firebase/auth/api/internal/zzcy;->zzic:Lcom/google/firebase/auth/FirebaseUser;

    return-object p0
.end method
