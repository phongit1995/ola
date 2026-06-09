.class Lchat/ola/vn/w/be;
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

    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_0

    const/16 p3, 0xff

    iget-short v0, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte v0, v0

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_0
    iget-object p3, p1, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    if-eqz p3, :cond_1

    const/4 p3, 0x7

    iget-object v0, p1, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_1
    iget-object p3, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    if-eqz p3, :cond_2

    const/16 p3, 0x6e

    iget-object v0, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_2
    const/16 p3, 0x16

    iget-object p1, p1, Lchat/ola/vn/w/bk;->i:Ljava/lang/String;

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 8

    const/4 p3, 0x0

    const/16 v0, 0xff

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result p3

    int-to-short v7, p3

    const/4 p3, 0x7

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    const/16 p3, 0x15

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v2

    const/16 p3, 0x81

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v3

    const/16 p3, 0x16

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v5

    const/16 p3, 0xd

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v6

    const/16 p3, 0x18

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v4

    const/16 p3, 0x6e

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p1

    if-eqz v1, :cond_0

    move-object v0, p2

    invoke-interface/range {v0 .. v6}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_0
    move-object v0, p2

    move-object v1, p1

    invoke-interface/range {v0 .. v7}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method
