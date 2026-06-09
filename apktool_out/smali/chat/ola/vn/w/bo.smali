.class public Lchat/ola/vn/w/bo;
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

    iget-object p3, p1, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    const/4 v0, 0x7

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-object p1, p1, Lchat/ola/vn/w/bk;->am:[B

    const/16 p3, 0x2b

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(S[B)V

    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 8

    const/4 p3, 0x7

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p3

    const/16 v0, 0x2d

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->a(S)[B

    move-result-object v1

    if-eqz v1, :cond_0

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    int-to-short v0, v0

    const/16 v2, 0x9

    invoke-virtual {p1, v2, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    const-wide/16 v2, 0x0

    invoke-virtual {p1, v1, v2, v3}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v4

    cmp-long p1, v4, v2

    if-lez p1, :cond_1

    if-lez v0, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    sub-long v6, v4, v1

    const-wide/32 v1, 0x5265c00

    div-long/2addr v6, v1

    long-to-int p1, v6

    add-int/lit8 p1, p1, 0x1

    invoke-interface {p2, p3, v0, p1}, Lchat/ola/vn/p/g;->b(Ljava/lang/String;SI)V

    return-void

    :cond_0
    invoke-interface {p2, p3}, Lchat/ola/vn/p/g;->h(Ljava/lang/String;)V

    :cond_1
    return-void
.end method
