.class public Lchat/ola/vn/balloon/a/b;
.super Lchat/ola/vn/balloon/a/a;


# instance fields
.field private g:I

.field private h:I

.field private i:I

.field private j:I

.field private k:J

.field private l:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>(Lchat/ola/vn/balloon/a;Landroid/os/Handler;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/balloon/a/a;-><init>(Lchat/ola/vn/balloon/a;Landroid/os/Handler;)V

    const-wide/16 p1, 0x0

    iput-wide p1, p0, Lchat/ola/vn/balloon/a/b;->k:J

    new-instance p1, Lchat/ola/vn/balloon/a/b$1;

    invoke-direct {p1, p0}, Lchat/ola/vn/balloon/a/b$1;-><init>(Lchat/ola/vn/balloon/a/b;)V

    iput-object p1, p0, Lchat/ola/vn/balloon/a/b;->l:Ljava/lang/Runnable;

    invoke-direct {p0}, Lchat/ola/vn/balloon/a/b;->b()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/balloon/a/b;)J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/balloon/a/b;->k:J

    return-wide v0
.end method

.method static synthetic a(Lchat/ola/vn/balloon/a/b;J)J
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/balloon/a/b;->k:J

    return-wide p1
.end method

.method private a(II)Z
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/balloon/a/b;->b:Lchat/ola/vn/balloon/a;

    invoke-interface {v0}, Lchat/ola/vn/balloon/a;->c()Z

    move-result v0

    const/4 v1, 0x1

    if-nez v0, :cond_0

    return v1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/balloon/a/b;->f:Landroid/view/WindowManager$LayoutParams;

    if-nez v0, :cond_1

    return v1

    :cond_1
    const/4 v0, 0x0

    if-gez p1, :cond_2

    const/4 p1, 0x0

    goto :goto_0

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/balloon/a/b;->b:Lchat/ola/vn/balloon/a;

    invoke-interface {v1}, Lchat/ola/vn/balloon/a;->getWindowWidth()I

    move-result v1

    iget-object v2, p0, Lchat/ola/vn/balloon/a/b;->b:Lchat/ola/vn/balloon/a;

    invoke-interface {v2}, Lchat/ola/vn/balloon/a;->getBalloonWidth()I

    move-result v2

    sub-int/2addr v1, v2

    if-le p1, v1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/balloon/a/b;->b:Lchat/ola/vn/balloon/a;

    invoke-interface {p1}, Lchat/ola/vn/balloon/a;->getWindowWidth()I

    move-result p1

    iget-object v1, p0, Lchat/ola/vn/balloon/a/b;->b:Lchat/ola/vn/balloon/a;

    invoke-interface {v1}, Lchat/ola/vn/balloon/a;->getBalloonWidth()I

    move-result v1

    sub-int/2addr p1, v1

    :cond_3
    :goto_0
    if-gez p2, :cond_4

    const/4 p2, 0x0

    goto :goto_1

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/balloon/a/b;->b:Lchat/ola/vn/balloon/a;

    invoke-interface {v0}, Lchat/ola/vn/balloon/a;->getWindowHeight()I

    move-result v0

    iget-object v1, p0, Lchat/ola/vn/balloon/a/b;->b:Lchat/ola/vn/balloon/a;

    invoke-interface {v1}, Lchat/ola/vn/balloon/a;->getBalloonHeight()I

    move-result v1

    sub-int/2addr v0, v1

    if-le p2, v0, :cond_5

    iget-object p2, p0, Lchat/ola/vn/balloon/a/b;->b:Lchat/ola/vn/balloon/a;

    invoke-interface {p2}, Lchat/ola/vn/balloon/a;->getWindowHeight()I

    move-result p2

    iget-object v0, p0, Lchat/ola/vn/balloon/a/b;->b:Lchat/ola/vn/balloon/a;

    invoke-interface {v0}, Lchat/ola/vn/balloon/a;->getBalloonHeight()I

    move-result v0

    sub-int/2addr p2, v0

    :cond_5
    :goto_1
    iget-object v0, p0, Lchat/ola/vn/balloon/a/b;->f:Landroid/view/WindowManager$LayoutParams;

    iput p1, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object p1, p0, Lchat/ola/vn/balloon/a/b;->f:Landroid/view/WindowManager$LayoutParams;

    iput p2, p1, Landroid/view/WindowManager$LayoutParams;->y:I

    iget-object p1, p0, Lchat/ola/vn/balloon/a/b;->b:Lchat/ola/vn/balloon/a;

    invoke-interface {p1}, Lchat/ola/vn/balloon/a;->a()V

    iget-object p1, p0, Lchat/ola/vn/balloon/a/b;->b:Lchat/ola/vn/balloon/a;

    invoke-interface {p1}, Lchat/ola/vn/balloon/a;->d()Z

    move-result p1

    return p1
.end method

.method static synthetic a(Lchat/ola/vn/balloon/a/b;II)Z
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/balloon/a/b;->a(II)Z

    move-result p0

    return p0
.end method

.method static synthetic b(Lchat/ola/vn/balloon/a/b;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/balloon/a/b;->i:I

    return p0
.end method

.method private b()V
    .locals 0

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/balloon/a/b;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/balloon/a/b;->j:I

    return p0
.end method

.method static synthetic d(Lchat/ola/vn/balloon/a/b;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/balloon/a/b;->g:I

    return p0
.end method

.method static synthetic e(Lchat/ola/vn/balloon/a/b;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/balloon/a/b;->h:I

    return p0
.end method


# virtual methods
.method public a()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/balloon/a/b;->c:Landroid/os/Handler;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/balloon/a/b;->f:Landroid/view/WindowManager$LayoutParams;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    iput-short v0, p0, Lchat/ola/vn/balloon/a/b;->a:S

    iget-object v0, p0, Lchat/ola/vn/balloon/a/b;->c:Landroid/os/Handler;

    iget-object v1, p0, Lchat/ola/vn/balloon/a/b;->l:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_0
    return-void
.end method

.method public a(IIII)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/balloon/a/b;->g:I

    iput p2, p0, Lchat/ola/vn/balloon/a/b;->i:I

    iput p3, p0, Lchat/ola/vn/balloon/a/b;->h:I

    iput p4, p0, Lchat/ola/vn/balloon/a/b;->j:I

    return-void
.end method

.method protected a(S)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/balloon/a/a;->a(S)V

    iget-object p1, p0, Lchat/ola/vn/balloon/a/b;->c:Landroid/os/Handler;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/balloon/a/b;->c:Landroid/os/Handler;

    iget-object v0, p0, Lchat/ola/vn/balloon/a/b;->l:Ljava/lang/Runnable;

    invoke-virtual {p1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void

    :cond_0
    const/4 p1, 0x3

    iput-short p1, p0, Lchat/ola/vn/balloon/a/b;->a:S

    return-void
.end method
