.class public abstract Lchat/ola/vn/balloon/a/a;
.super Ljava/lang/Object;


# instance fields
.field protected a:S

.field protected b:Lchat/ola/vn/balloon/a;

.field protected c:Landroid/os/Handler;

.field protected d:Landroid/view/animation/Interpolator;

.field protected e:J

.field protected f:Landroid/view/WindowManager$LayoutParams;


# direct methods
.method public constructor <init>(Lchat/ola/vn/balloon/a;Landroid/os/Handler;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-short v0, p0, Lchat/ola/vn/balloon/a/a;->a:S

    new-instance v0, Landroid/view/animation/OvershootInterpolator;

    const v1, 0x3ee66666    # 0.45f

    invoke-direct {v0, v1}, Landroid/view/animation/OvershootInterpolator;-><init>(F)V

    iput-object v0, p0, Lchat/ola/vn/balloon/a/a;->d:Landroid/view/animation/Interpolator;

    const-wide/16 v0, 0x1f4

    iput-wide v0, p0, Lchat/ola/vn/balloon/a/a;->e:J

    iput-object p1, p0, Lchat/ola/vn/balloon/a/a;->b:Lchat/ola/vn/balloon/a;

    iput-object p2, p0, Lchat/ola/vn/balloon/a/a;->c:Landroid/os/Handler;

    iget-object p2, p0, Lchat/ola/vn/balloon/a/a;->c:Landroid/os/Handler;

    if-nez p2, :cond_0

    new-instance p2, Landroid/os/Handler;

    invoke-direct {p2}, Landroid/os/Handler;-><init>()V

    :cond_0
    invoke-interface {p1}, Lchat/ola/vn/balloon/a;->getBalloonLayoutParameter()Landroid/view/WindowManager$LayoutParams;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/balloon/a/a;->f:Landroid/view/WindowManager$LayoutParams;

    return-void
.end method


# virtual methods
.method public a(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/balloon/a/a;->e:J

    return-void
.end method

.method protected a(S)V
    .locals 1

    iput-short p1, p0, Lchat/ola/vn/balloon/a/a;->a:S

    iget-short p1, p0, Lchat/ola/vn/balloon/a/a;->a:S

    const/4 v0, 0x3

    if-ne p1, v0, :cond_0

    iget-object p1, p0, Lchat/ola/vn/balloon/a/a;->b:Lchat/ola/vn/balloon/a;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/balloon/a/a;->b:Lchat/ola/vn/balloon/a;

    invoke-interface {p1}, Lchat/ola/vn/balloon/a;->b()V

    :cond_0
    return-void
.end method
