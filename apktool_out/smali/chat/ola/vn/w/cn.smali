.class public Lchat/ola/vn/w/cn;
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

    iget-byte p3, p1, Lchat/ola/vn/w/bk;->as:B

    const/16 v0, 0x72

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SB)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->m:Ljava/lang/String;

    const/16 v0, 0x8

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->s:Ljava/lang/String;

    if-eqz p3, :cond_0

    const/16 p3, 0x18

    iget-object v0, p1, Lchat/ola/vn/w/bk;->s:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    iget-short p3, p1, Lchat/ola/vn/w/bk;->ai:S

    if-eqz p3, :cond_1

    const/16 p3, 0xdc

    iget-short p1, p1, Lchat/ola/vn/w/bk;->ai:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_1
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 6

    const/4 p3, 0x0

    const/16 v0, 0x48

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    const-wide/16 v1, 0x0

    invoke-virtual {p1, v0, v1, v2}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v3

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v0

    const/16 v5, 0xff

    invoke-virtual {p1, v5, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v5

    invoke-virtual {p1, v5, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result p1

    int-to-short p1, p1

    cmp-long p3, v3, v1

    if-eqz p3, :cond_0

    invoke-interface {p2, v3, v4, p1}, Lchat/ola/vn/p/g;->b(JS)V

    return-void

    :cond_0
    invoke-interface {p2, v0, p1}, Lchat/ola/vn/p/g;->j(Ljava/lang/String;S)V

    return-void
.end method
