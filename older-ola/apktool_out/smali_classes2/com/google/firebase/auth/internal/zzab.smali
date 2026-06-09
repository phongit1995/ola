.class public final Lcom/google/firebase/auth/internal/zzab;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/firebase/FirebaseApp$IdTokenListenersCountChangedListener;


# instance fields
.field private volatile zzlt:I

.field private volatile zzlu:I

.field private final zzlv:Lcom/google/firebase/auth/internal/zzs;

.field private volatile zzlw:Z


# direct methods
.method private constructor <init>(Landroid/content/Context;Lcom/google/firebase/auth/internal/zzs;)V
    .locals 1
    .param p1    # Landroid/content/Context;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/google/firebase/auth/internal/zzs;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .annotation build Lcom/google/android/gms/common/util/VisibleForTesting;
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/google/firebase/auth/internal/zzab;->zzlw:Z

    iput v0, p0, Lcom/google/firebase/auth/internal/zzab;->zzlt:I

    iput v0, p0, Lcom/google/firebase/auth/internal/zzab;->zzlu:I

    iput-object p2, p0, Lcom/google/firebase/auth/internal/zzab;->zzlv:Lcom/google/firebase/auth/internal/zzs;

    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    check-cast p1, Landroid/app/Application;

    invoke-static {p1}, Lcom/google/android/gms/common/api/internal/BackgroundDetector;->initialize(Landroid/app/Application;)V

    invoke-static {}, Lcom/google/android/gms/common/api/internal/BackgroundDetector;->getInstance()Lcom/google/android/gms/common/api/internal/BackgroundDetector;

    move-result-object p1

    new-instance p2, Lcom/google/firebase/auth/internal/zzac;

    invoke-direct {p2, p0}, Lcom/google/firebase/auth/internal/zzac;-><init>(Lcom/google/firebase/auth/internal/zzab;)V

    invoke-virtual {p1, p2}, Lcom/google/android/gms/common/api/internal/BackgroundDetector;->addListener(Lcom/google/android/gms/common/api/internal/BackgroundDetector$BackgroundStateChangeListener;)V

    return-void
.end method

.method public constructor <init>(Lcom/google/firebase/FirebaseApp;)V
    .locals 2
    .param p1    # Lcom/google/firebase/FirebaseApp;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    invoke-virtual {p1}, Lcom/google/firebase/FirebaseApp;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    new-instance v1, Lcom/google/firebase/auth/internal/zzs;

    invoke-direct {v1, p1}, Lcom/google/firebase/auth/internal/zzs;-><init>(Lcom/google/firebase/FirebaseApp;)V

    invoke-direct {p0, v0, v1}, Lcom/google/firebase/auth/internal/zzab;-><init>(Landroid/content/Context;Lcom/google/firebase/auth/internal/zzs;)V

    return-void
.end method

.method static synthetic zza(Lcom/google/firebase/auth/internal/zzab;Z)Z
    .locals 0

    iput-boolean p1, p0, Lcom/google/firebase/auth/internal/zzab;->zzlw:Z

    return p1
.end method

.method static synthetic zzb(Lcom/google/firebase/auth/internal/zzab;)Z
    .locals 0

    invoke-direct {p0}, Lcom/google/firebase/auth/internal/zzab;->zzbm()Z

    move-result p0

    return p0
.end method

.method private final zzbm()Z
    .locals 2

    iget v0, p0, Lcom/google/firebase/auth/internal/zzab;->zzlt:I

    iget v1, p0, Lcom/google/firebase/auth/internal/zzab;->zzlu:I

    add-int/2addr v0, v1

    if-lez v0, :cond_0

    iget-boolean v0, p0, Lcom/google/firebase/auth/internal/zzab;->zzlw:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method static synthetic zzc(Lcom/google/firebase/auth/internal/zzab;)Lcom/google/firebase/auth/internal/zzs;
    .locals 0

    iget-object p0, p0, Lcom/google/firebase/auth/internal/zzab;->zzlv:Lcom/google/firebase/auth/internal/zzs;

    return-object p0
.end method


# virtual methods
.method public final cancel()V
    .locals 1

    iget-object v0, p0, Lcom/google/firebase/auth/internal/zzab;->zzlv:Lcom/google/firebase/auth/internal/zzs;

    invoke-virtual {v0}, Lcom/google/firebase/auth/internal/zzs;->cancel()V

    return-void
.end method

.method public final onListenerCountChanged(I)V
    .locals 1

    if-lez p1, :cond_0

    iget v0, p0, Lcom/google/firebase/auth/internal/zzab;->zzlt:I

    if-nez v0, :cond_0

    iget v0, p0, Lcom/google/firebase/auth/internal/zzab;->zzlu:I

    if-nez v0, :cond_0

    iput p1, p0, Lcom/google/firebase/auth/internal/zzab;->zzlt:I

    invoke-direct {p0}, Lcom/google/firebase/auth/internal/zzab;->zzbm()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/google/firebase/auth/internal/zzab;->zzlv:Lcom/google/firebase/auth/internal/zzs;

    invoke-virtual {v0}, Lcom/google/firebase/auth/internal/zzs;->zzbi()V

    goto :goto_0

    :cond_0
    if-nez p1, :cond_1

    iget v0, p0, Lcom/google/firebase/auth/internal/zzab;->zzlt:I

    if-eqz v0, :cond_1

    iget v0, p0, Lcom/google/firebase/auth/internal/zzab;->zzlu:I

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/google/firebase/auth/internal/zzab;->zzlv:Lcom/google/firebase/auth/internal/zzs;

    invoke-virtual {v0}, Lcom/google/firebase/auth/internal/zzs;->cancel()V

    :cond_1
    :goto_0
    iput p1, p0, Lcom/google/firebase/auth/internal/zzab;->zzlt:I

    return-void
.end method

.method public final zzc(Lcom/google/android/gms/internal/firebase_auth/zzao;)V
    .locals 6
    .param p1    # Lcom/google/android/gms/internal/firebase_auth/zzao;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    if-nez p1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzao;->zzaq()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-gtz v4, :cond_1

    const-wide/16 v0, 0xe10

    :cond_1
    invoke-virtual {p1}, Lcom/google/android/gms/internal/firebase_auth/zzao;->zzay()J

    move-result-wide v2

    const-wide/16 v4, 0x3e8

    mul-long v0, v0, v4

    add-long v4, v2, v0

    iget-object p1, p0, Lcom/google/firebase/auth/internal/zzab;->zzlv:Lcom/google/firebase/auth/internal/zzs;

    iput-wide v4, p1, Lcom/google/firebase/auth/internal/zzs;->zzlh:J

    const-wide/16 v0, -0x1

    iput-wide v0, p1, Lcom/google/firebase/auth/internal/zzs;->zzli:J

    invoke-direct {p0}, Lcom/google/firebase/auth/internal/zzab;->zzbm()Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/google/firebase/auth/internal/zzab;->zzlv:Lcom/google/firebase/auth/internal/zzs;

    invoke-virtual {p1}, Lcom/google/firebase/auth/internal/zzs;->zzbi()V

    :cond_2
    return-void
.end method

.method public final zzf(I)V
    .locals 1

    if-lez p1, :cond_0

    iget v0, p0, Lcom/google/firebase/auth/internal/zzab;->zzlu:I

    if-nez v0, :cond_0

    iget v0, p0, Lcom/google/firebase/auth/internal/zzab;->zzlt:I

    if-nez v0, :cond_0

    iput p1, p0, Lcom/google/firebase/auth/internal/zzab;->zzlu:I

    invoke-direct {p0}, Lcom/google/firebase/auth/internal/zzab;->zzbm()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/google/firebase/auth/internal/zzab;->zzlv:Lcom/google/firebase/auth/internal/zzs;

    invoke-virtual {v0}, Lcom/google/firebase/auth/internal/zzs;->zzbi()V

    goto :goto_0

    :cond_0
    if-nez p1, :cond_1

    iget v0, p0, Lcom/google/firebase/auth/internal/zzab;->zzlu:I

    if-eqz v0, :cond_1

    iget v0, p0, Lcom/google/firebase/auth/internal/zzab;->zzlt:I

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/google/firebase/auth/internal/zzab;->zzlv:Lcom/google/firebase/auth/internal/zzs;

    invoke-virtual {v0}, Lcom/google/firebase/auth/internal/zzs;->cancel()V

    :cond_1
    :goto_0
    iput p1, p0, Lcom/google/firebase/auth/internal/zzab;->zzlu:I

    return-void
.end method
