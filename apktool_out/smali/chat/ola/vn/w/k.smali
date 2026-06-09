.class public Lchat/ola/vn/w/k;
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

    iget-object p3, p1, Lchat/ola/vn/w/bk;->w:Ljava/lang/String;

    const/16 v0, 0x81

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->r:Ljava/lang/String;

    if-eqz p3, :cond_0

    const/16 p3, 0xd

    iget-object v0, p1, Lchat/ola/vn/w/bk;->r:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    iget-object p3, p1, Lchat/ola/vn/w/bk;->s:Ljava/lang/String;

    if-eqz p3, :cond_1

    const/16 p3, 0x18

    iget-object v0, p1, Lchat/ola/vn/w/bk;->s:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_1
    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_2

    const/16 p3, 0xff

    iget-short p1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_2
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 6

    const/4 p3, 0x0

    const/16 v0, 0xff

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result p3

    int-to-short v5, p3

    const/4 p3, 0x7

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    const/16 p3, 0x81

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v2

    const/16 p3, 0xd

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v3

    const/16 p3, 0x18

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v4

    move-object v0, p2

    invoke-interface/range {v0 .. v5}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method
