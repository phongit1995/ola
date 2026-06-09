.class public Lchat/ola/vn/w/bn;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 1

    iget-boolean p3, p1, Lchat/ola/vn/w/bk;->aw:Z

    const/16 v0, 0x3e

    if-eqz p3, :cond_0

    const/4 p3, 0x1

    :goto_0
    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SB)V

    goto :goto_1

    :cond_0
    const/4 p3, 0x0

    goto :goto_0

    :goto_1
    const/4 p3, 0x7

    iget-object p1, p1, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 1

    const/4 p3, 0x0

    const/16 v0, 0x3e

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result p3

    int-to-short p3, p3

    const/4 v0, 0x7

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x1

    if-ne p3, v0, :cond_0

    invoke-interface {p2, p1}, Lchat/ola/vn/p/g;->f(Ljava/lang/String;)V

    return-void

    :cond_0
    invoke-interface {p2, p1}, Lchat/ola/vn/p/g;->g(Ljava/lang/String;)V

    return-void
.end method
