.class Lchat/ola/vn/game/caro/d$1;
.super Landroid/os/CountDownTimer;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/game/caro/d;->d()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/game/caro/d;


# direct methods
.method constructor <init>(Lchat/ola/vn/game/caro/d;JJ)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/game/caro/d$1;->a:Lchat/ola/vn/game/caro/d;

    invoke-direct {p0, p2, p3, p4, p5}, Landroid/os/CountDownTimer;-><init>(JJ)V

    return-void
.end method


# virtual methods
.method public onFinish()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/game/caro/d$1;->a:Lchat/ola/vn/game/caro/d;

    invoke-static {v0}, Lchat/ola/vn/game/caro/d;->a(Lchat/ola/vn/game/caro/d;)Landroid/graphics/Paint;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/game/caro/d;->b()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v0, p0, Lchat/ola/vn/game/caro/d$1;->a:Lchat/ola/vn/game/caro/d;

    invoke-virtual {v0}, Lchat/ola/vn/game/caro/d;->invalidate()V

    return-void
.end method

.method public onTick(J)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/game/caro/d$1;->a:Lchat/ola/vn/game/caro/d;

    invoke-static {p1}, Lchat/ola/vn/game/caro/d;->a(Lchat/ola/vn/game/caro/d;)Landroid/graphics/Paint;

    move-result-object p1

    invoke-virtual {p1}, Landroid/graphics/Paint;->getColor()I

    move-result p1

    invoke-static {}, Lchat/ola/vn/game/caro/d;->b()I

    move-result p2

    if-ne p1, p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/game/caro/d$1;->a:Lchat/ola/vn/game/caro/d;

    invoke-static {p1}, Lchat/ola/vn/game/caro/d;->a(Lchat/ola/vn/game/caro/d;)Landroid/graphics/Paint;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/game/caro/d;->c()I

    move-result p2

    :goto_0
    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setColor(I)V

    goto :goto_1

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/game/caro/d$1;->a:Lchat/ola/vn/game/caro/d;

    invoke-static {p1}, Lchat/ola/vn/game/caro/d;->a(Lchat/ola/vn/game/caro/d;)Landroid/graphics/Paint;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/game/caro/d;->b()I

    move-result p2

    goto :goto_0

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/game/caro/d$1;->a:Lchat/ola/vn/game/caro/d;

    invoke-virtual {p1}, Lchat/ola/vn/game/caro/d;->invalidate()V

    return-void
.end method
