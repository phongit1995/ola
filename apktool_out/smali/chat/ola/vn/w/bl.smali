.class Lchat/ola/vn/w/bl;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 1

    iget-object p3, p1, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    if-eqz p3, :cond_0

    const/4 p3, 0x7

    iget-object v0, p1, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    iget-object p3, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    if-eqz p3, :cond_1

    const/16 p3, 0x6d

    iget-object v0, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_1
    const/16 p3, 0x72

    iget-byte p1, p1, Lchat/ola/vn/w/bk;->as:B

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 3

    const/4 p3, 0x7

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p3

    const/16 v0, 0x6d

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    const/16 v2, 0x72

    invoke-virtual {p1, v2, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v2

    invoke-virtual {p1, v2, v1}, Lchat/ola/vn/w/s;->a(IB)B

    move-result p1

    const/4 v2, 0x1

    if-ne p1, v2, :cond_0

    const/4 v1, 0x1

    :cond_0
    if-eqz p3, :cond_4

    if-eqz v0, :cond_2

    if-eqz v1, :cond_1

    invoke-interface {p2, v0, p3}, Lchat/ola/vn/p/g;->h(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_1
    invoke-interface {p2, v0, p3}, Lchat/ola/vn/p/g;->i(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_2
    if-eqz v1, :cond_3

    invoke-interface {p2, p3}, Lchat/ola/vn/p/g;->b(Ljava/lang/String;)V

    return-void

    :cond_3
    invoke-interface {p2, p3}, Lchat/ola/vn/p/g;->c(Ljava/lang/String;)V

    :cond_4
    return-void
.end method
