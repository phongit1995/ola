.class public final Lcom/google/firebase/auth/internal/zzad;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/util/concurrent/Executor;


# static fields
.field private static zzly:Lcom/google/firebase/auth/internal/zzad;


# instance fields
.field private handler:Landroid/os/Handler;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/google/firebase/auth/internal/zzad;

    invoke-direct {v0}, Lcom/google/firebase/auth/internal/zzad;-><init>()V

    sput-object v0, Lcom/google/firebase/auth/internal/zzad;->zzly:Lcom/google/firebase/auth/internal/zzad;

    return-void
.end method

.method private constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/google/firebase/auth/internal/zzad;->handler:Landroid/os/Handler;

    return-void
.end method

.method public static zzbn()Lcom/google/firebase/auth/internal/zzad;
    .locals 1

    sget-object v0, Lcom/google/firebase/auth/internal/zzad;->zzly:Lcom/google/firebase/auth/internal/zzad;

    return-object v0
.end method


# virtual methods
.method public final execute(Ljava/lang/Runnable;)V
    .locals 1
    .param p1    # Ljava/lang/Runnable;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    iget-object v0, p0, Lcom/google/firebase/auth/internal/zzad;->handler:Landroid/os/Handler;

    invoke-virtual {v0, p1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method
