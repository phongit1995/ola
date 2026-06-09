.class public Lchat/ola/vn/w/bp;
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
    .locals 4

    iget-object p3, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_0

    const/16 p3, 0x6d

    iget-object v0, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    const-wide/16 v0, 0x0

    iget-wide v2, p1, Lchat/ola/vn/w/bk;->W:J

    cmp-long p3, v0, v2

    if-eqz p3, :cond_1

    const/16 p3, 0x82

    iget-wide v0, p1, Lchat/ola/vn/w/bk;->W:J

    invoke-virtual {p2, p3, v0, v1}, Lchat/ola/vn/w/cg;->a(SJ)V

    :cond_1
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 9

    const/4 p3, 0x0

    invoke-virtual {p1, p3, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    const/4 v1, -0x1

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/w/s;->a(IB)B

    move-result v0

    const/16 v1, 0x82

    invoke-virtual {p1, v1, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result p3

    const-wide/16 v1, 0x0

    invoke-virtual {p1, p3, v1, v2}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v4

    const/16 p3, 0x6d

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v6

    if-ltz v0, :cond_1

    const/16 p3, 0x9

    if-ne v0, p3, :cond_0

    return-void

    :cond_0
    const/16 p3, 0x8

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p1

    invoke-interface {p2, v4, v5, v6, p1}, Lchat/ola/vn/p/g;->a(JLjava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_1
    const/16 p3, 0x6e

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v8

    const/16 p3, 0x17

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->a(S)[B

    move-result-object v7

    move-object v3, p2

    invoke-interface/range {v3 .. v8}, Lchat/ola/vn/p/g;->a(JLjava/lang/String;[BLjava/lang/String;)V

    return-void
.end method
