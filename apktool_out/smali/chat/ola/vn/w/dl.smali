.class Lchat/ola/vn/w/dl;
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

    iget-object p3, p1, Lchat/ola/vn/w/bk;->n:Ljava/lang/String;

    const/4 v0, 0x7

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
    .locals 11

    const/4 v0, 0x7

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x18

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    const/16 v3, 0x2d

    invoke-virtual {p1, v3, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v3

    invoke-virtual {p1, v3, v2}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v3

    int-to-short v3, v3

    const/16 v4, 0x6e

    invoke-virtual {p1, v4}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v5

    const/16 v6, 0x9

    invoke-virtual {p1, v6, v2}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v6

    const-wide/16 v7, 0x0

    invoke-virtual {p1, v6, v7, v8}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v9

    cmp-long v6, v9, v7

    if-nez v6, :cond_0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v9

    :cond_0
    new-instance v6, Lchat/ola/vn/message/d;

    invoke-direct {v6}, Lchat/ola/vn/message/d;-><init>()V

    invoke-virtual {v6, v0}, Lchat/ola/vn/message/d;->d(Ljava/lang/String;)V

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "##"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v8, "#"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Lchat/ola/vn/message/d;->f(Ljava/lang/String;)V

    invoke-virtual {v6, v3}, Lchat/ola/vn/message/d;->a(S)V

    invoke-virtual {v6, v9, v10}, Lchat/ola/vn/message/d;->a(J)V

    const/4 v3, 0x2

    invoke-virtual {v6, v3}, Lchat/ola/vn/message/d;->a(B)V

    invoke-virtual {p1, v4}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_1

    invoke-virtual {p3, v0, p1}, Lchat/ola/vn/w/ci;->e(Ljava/lang/String;Ljava/lang/String;)V

    :cond_1
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_2

    invoke-virtual {v6, p1}, Lchat/ola/vn/message/d;->h(Ljava/lang/String;)V

    :cond_2
    iget-object p1, p3, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    const/4 v4, 0x1

    if-eqz p1, :cond_3

    invoke-static {v6, v3}, Lchat/ola/vn/message/e;->a(Lchat/ola/vn/message/d;B)Lchat/ola/vn/message/d;

    move-result-object p1

    goto :goto_0

    :cond_3
    invoke-static {v6, v4}, Lchat/ola/vn/message/e;->a(Lchat/ola/vn/message/d;B)Lchat/ola/vn/message/d;

    move-result-object p1

    :goto_0
    invoke-interface {p2, p1}, Lchat/ola/vn/p/g;->a(Lchat/ola/vn/message/d;)V

    if-eqz v5, :cond_4

    invoke-virtual {p3, v0, v5}, Lchat/ola/vn/w/ci;->e(Ljava/lang/String;Ljava/lang/String;)V

    :cond_4
    :try_start_0
    invoke-static {v1}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result p1

    const/4 p2, 0x3

    if-ne p1, p2, :cond_5

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "inbox:"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p2, p3, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-array p2, v4, [Ljava/lang/String;

    aput-object v1, p2, v2

    invoke-virtual {p3, p1, p2, v2}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;[Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_5
    return-void
.end method
