.class Lchat/ola/vn/w/dm;
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

    iget-object p3, p1, Lchat/ola/vn/w/bk;->m:Ljava/lang/String;

    if-eqz p3, :cond_0

    const/16 p3, 0x8

    iget-object v0, p1, Lchat/ola/vn/w/bk;->m:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    iget-short p3, p1, Lchat/ola/vn/w/bk;->ai:S

    if-eqz p3, :cond_1

    const/16 p3, 0xdc

    iget-short v0, p1, Lchat/ola/vn/w/bk;->ai:S

    int-to-byte v0, v0

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_1
    iget-object p3, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_2

    const/16 p3, 0x6e

    iget-object v0, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_2
    iget-object p3, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_3

    const/16 p3, 0x6d

    iget-object p1, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_3
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 10

    const/16 v0, 0x81

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x7

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0x8

    invoke-virtual {p1, v2}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    const/16 v4, 0xdc

    invoke-virtual {p1, v4, v3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v4

    invoke-virtual {p1, v4, v3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v4

    int-to-short v4, v4

    const/16 v5, 0x2d

    invoke-virtual {p1, v5, v3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v5

    invoke-virtual {p1, v5, v3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v5

    int-to-short v5, v5

    const/16 v6, 0x9

    invoke-virtual {p1, v6, v3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v3

    const-wide/16 v6, 0x0

    invoke-virtual {p1, v3, v6, v7}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v8

    cmp-long v3, v8, v6

    if-nez v3, :cond_0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    :cond_0
    new-instance v3, Lchat/ola/vn/message/d;

    invoke-direct {v3}, Lchat/ola/vn/message/d;-><init>()V

    invoke-virtual {v3, v1}, Lchat/ola/vn/message/d;->d(Ljava/lang/String;)V

    invoke-virtual {v3, v2}, Lchat/ola/vn/message/d;->f(Ljava/lang/String;)V

    invoke-virtual {v3, v4}, Lchat/ola/vn/message/d;->b(S)V

    invoke-virtual {v3, v5}, Lchat/ola/vn/message/d;->a(S)V

    invoke-virtual {v3, v8, v9}, Lchat/ola/vn/message/d;->a(J)V

    const/4 v1, 0x2

    invoke-virtual {v3, v1}, Lchat/ola/vn/message/d;->a(B)V

    const/16 v1, 0x6e

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_1

    invoke-virtual {p3, v0, p1}, Lchat/ola/vn/w/ci;->f(Ljava/lang/String;Ljava/lang/String;)V

    :cond_1
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_2

    invoke-virtual {v3, p1}, Lchat/ola/vn/message/d;->h(Ljava/lang/String;)V

    :cond_2
    invoke-interface {p2, v0, v3}, Lchat/ola/vn/p/g;->c(Ljava/lang/String;Lchat/ola/vn/message/d;)V

    return-void
.end method
