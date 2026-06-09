.class Lchat/ola/vn/w/dk;
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

    iget-object p3, p1, Lchat/ola/vn/w/bk;->w:Ljava/lang/String;

    const/16 v0, 0x81

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->s:Ljava/lang/String;

    const/16 v0, 0x18

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_0

    const/16 p3, 0x6d

    iget-object v0, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    iget-object p3, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_1

    const/16 p3, 0x6e

    iget-object p1, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_1
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 9

    const/16 v0, 0x81

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x7

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0x18

    invoke-virtual {p1, v2}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    const/16 v4, 0x9

    invoke-virtual {p1, v4, v3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v4

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    invoke-virtual {p1, v4, v5, v6}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v4

    const/16 v6, 0x2d

    invoke-virtual {p1, v6, v3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v6

    invoke-virtual {p1, v6, v3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v3

    int-to-short v3, v3

    const/16 v6, 0x6e

    invoke-virtual {p1, v6}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p1

    new-instance v6, Lchat/ola/vn/message/d;

    invoke-direct {v6}, Lchat/ola/vn/message/d;-><init>()V

    invoke-virtual {v6, v1}, Lchat/ola/vn/message/d;->d(Ljava/lang/String;)V

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "##"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "#"

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v6, v2}, Lchat/ola/vn/message/d;->f(Ljava/lang/String;)V

    invoke-virtual {v6, v3}, Lchat/ola/vn/message/d;->a(S)V

    invoke-virtual {v6, v4, v5}, Lchat/ola/vn/message/d;->a(J)V

    invoke-virtual {v6, p1}, Lchat/ola/vn/message/d;->h(Ljava/lang/String;)V

    const/4 v2, 0x2

    invoke-virtual {v6, v2}, Lchat/ola/vn/message/d;->a(B)V

    invoke-interface {p2, v0, v6}, Lchat/ola/vn/p/g;->c(Ljava/lang/String;Lchat/ola/vn/message/d;)V

    if-eqz p1, :cond_0

    invoke-virtual {p3, v1, p1}, Lchat/ola/vn/w/ci;->e(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method
