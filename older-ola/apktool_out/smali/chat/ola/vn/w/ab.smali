.class Lchat/ola/vn/w/ab;
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
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 9

    const/4 p3, 0x0

    invoke-virtual {p1, p3, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    const/4 v1, -0x1

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/w/s;->a(IB)B

    move-result v3

    if-ltz v3, :cond_1

    const/16 v0, 0x9

    if-ne v3, v0, :cond_0

    return-void

    :cond_0
    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v5

    const/16 v0, 0xff

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    int-to-short v8, v0

    const/16 v0, 0xc

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result p3

    int-to-short v4, p3

    const/4 p3, 0x1

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->a(S)[B

    move-result-object v6

    const/4 v7, 0x0

    move-object v2, p2

    invoke-interface/range {v2 .. v8}, Lchat/ola/vn/p/g;->a(ISLjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V

    :cond_1
    return-void
.end method
