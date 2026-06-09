.class public Lchat/ola/vn/w/ea;
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
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 8

    const/16 p3, 0x64

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->a(S)[B

    move-result-object p3

    invoke-static {p3}, Lchat/ola/vn/util/e;->d([B)J

    move-result-wide v0

    const/4 p3, 0x7

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p3

    const/16 v2, 0xd

    invoke-virtual {p1, v2}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    const/16 v4, 0x2d

    invoke-virtual {p1, v4, v3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v4

    invoke-virtual {p1, v4, v3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v4

    int-to-short v4, v4

    const/16 v5, 0x26

    invoke-virtual {p1, v5, v3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v5

    const/4 v6, -0x1

    invoke-virtual {p1, v5, v6}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v5

    int-to-short v5, v5

    const/16 v7, 0x58

    invoke-virtual {p1, v7, v3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v7

    invoke-virtual {p1, v7, v6}, Lchat/ola/vn/w/s;->a(IB)B

    move-result p1

    new-instance v6, Lchat/ola/vn/message/f;

    invoke-direct {v6, p3, v3}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    const/4 p3, 0x2

    invoke-virtual {v6, p3}, Lchat/ola/vn/message/f;->b(S)V

    invoke-virtual {v6, v2}, Lchat/ola/vn/message/f;->e(Ljava/lang/String;)V

    invoke-virtual {v6, v5}, Lchat/ola/vn/message/f;->c(S)V

    invoke-virtual {v6, v4}, Lchat/ola/vn/message/f;->e(S)V

    invoke-virtual {v6, p1}, Lchat/ola/vn/message/f;->a(B)V

    invoke-interface {p2, v0, v1, v6}, Lchat/ola/vn/p/g;->a(JLchat/ola/vn/message/f;)V

    return-void
.end method
