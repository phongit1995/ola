.class Lchat/ola/vn/w/do;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/f/c;
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

    iget-object p3, p1, Lchat/ola/vn/w/bk;->n:Ljava/lang/String;

    const/4 v0, 0x7

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-short p3, p1, Lchat/ola/vn/w/bk;->ai:S

    int-to-byte p3, p3

    const/16 v0, 0xdc

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SB)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->m:Ljava/lang/String;

    const/16 v0, 0x8

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_0

    const/16 p3, 0x6e

    iget-object v0, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    iget-object p3, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_1

    const/16 p3, 0x6d

    iget-object p1, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_1
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 10

    const/4 v0, 0x7

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    const/16 v3, 0x2d

    invoke-virtual {p1, v3, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v3

    invoke-virtual {p1, v3, v2}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v3

    int-to-short v3, v3

    const/16 v4, 0xdc

    invoke-virtual {p1, v4, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v4

    invoke-virtual {p1, v4, v2}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v4

    int-to-short v4, v4

    const/16 v5, 0x9

    invoke-virtual {p1, v5, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v5

    const-wide/16 v6, 0x0

    invoke-virtual {p1, v5, v6, v7}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v8

    cmp-long v5, v8, v6

    if-nez v5, :cond_0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    :cond_0
    if-nez v1, :cond_1

    const-string v1, ""

    :cond_1
    new-instance v5, Lchat/ola/vn/message/d;

    invoke-direct {v5}, Lchat/ola/vn/message/d;-><init>()V

    invoke-virtual {v5, v0}, Lchat/ola/vn/message/d;->d(Ljava/lang/String;)V

    sget-object v6, Lchat/ola/vn/w/do;->b:Ljava/lang/String;

    invoke-static {v1, v6}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2

    sget-object v1, Lchat/ola/vn/w/do;->a:Ljava/lang/String;

    :cond_2
    invoke-virtual {v5, v1}, Lchat/ola/vn/message/d;->f(Ljava/lang/String;)V

    invoke-virtual {v5, v3}, Lchat/ola/vn/message/d;->a(S)V

    invoke-virtual {v5, v4}, Lchat/ola/vn/message/d;->b(S)V

    invoke-virtual {v5, v8, v9}, Lchat/ola/vn/message/d;->a(J)V

    const/4 v1, 0x2

    invoke-virtual {v5, v1}, Lchat/ola/vn/message/d;->a(B)V

    const/16 v3, 0x6e

    invoke-virtual {p1, v3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_3

    invoke-virtual {p3, v0, p1}, Lchat/ola/vn/w/ci;->e(Ljava/lang/String;Ljava/lang/String;)V

    :cond_3
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_4

    invoke-virtual {v5, p1}, Lchat/ola/vn/message/d;->h(Ljava/lang/String;)V

    :cond_4
    iget-object p1, p3, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    const/4 v0, 0x1

    if-eqz p1, :cond_5

    invoke-static {v5, v1}, Lchat/ola/vn/message/e;->a(Lchat/ola/vn/message/d;B)Lchat/ola/vn/message/d;

    move-result-object p1

    goto :goto_0

    :cond_5
    invoke-static {v5, v0}, Lchat/ola/vn/message/e;->a(Lchat/ola/vn/message/d;B)Lchat/ola/vn/message/d;

    move-result-object p1

    :goto_0
    invoke-interface {p2, p1}, Lchat/ola/vn/p/g;->a(Lchat/ola/vn/message/d;)V

    :try_start_0
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->e()B

    move-result p2

    const/4 v1, 0x3

    if-ne p2, v1, :cond_6

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "inbox:"

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p3, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    new-array v0, v0, [Ljava/lang/String;

    check-cast p1, Lchat/ola/vn/message/aa;

    invoke-virtual {p1}, Lchat/ola/vn/message/aa;->C()Ljava/lang/String;

    move-result-object p1

    aput-object p1, v0, v2

    invoke-virtual {p3, p2, v0, v2}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;[Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_6
    return-void
.end method
