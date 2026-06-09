.class Landroid/support/transition/WindowIdPort;
.super Ljava/lang/Object;


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0xe
.end annotation

.annotation build Landroid/support/annotation/RequiresApi;
    value = 0xe
.end annotation


# instance fields
.field private final mToken:Landroid/os/IBinder;


# direct methods
.method private constructor <init>(Landroid/os/IBinder;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Landroid/support/transition/WindowIdPort;->mToken:Landroid/os/IBinder;

    return-void
.end method

.method static getWindowId(Landroid/view/View;)Landroid/support/transition/WindowIdPort;
    .locals 1
    .param p0    # Landroid/view/View;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    new-instance v0, Landroid/support/transition/WindowIdPort;

    invoke-virtual {p0}, Landroid/view/View;->getWindowToken()Landroid/os/IBinder;

    move-result-object p0

    invoke-direct {v0, p0}, Landroid/support/transition/WindowIdPort;-><init>(Landroid/os/IBinder;)V

    return-object v0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 1

    instance-of v0, p1, Landroid/support/transition/WindowIdPort;

    if-eqz v0, :cond_0

    check-cast p1, Landroid/support/transition/WindowIdPort;

    iget-object p1, p1, Landroid/support/transition/WindowIdPort;->mToken:Landroid/os/IBinder;

    iget-object v0, p0, Landroid/support/transition/WindowIdPort;->mToken:Landroid/os/IBinder;

    invoke-virtual {p1, v0}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method
