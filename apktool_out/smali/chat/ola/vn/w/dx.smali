.class public Lchat/ola/vn/w/dx;
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
    .locals 2

    iget-object p3, p1, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    const/4 v0, 0x7

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-wide v0, p1, Lchat/ola/vn/w/bk;->U:J

    const/16 p3, 0x11

    invoke-virtual {p2, p3, v0, v1}, Lchat/ola/vn/w/cg;->a(SJ)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->am:[B

    const/16 v0, 0x2b

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(S[B)V

    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_0

    const/16 p3, 0xff

    iget-short p1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 4

    const/4 p3, 0x0

    const/16 v0, 0xff

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    int-to-short v0, v0

    const/4 v1, 0x7

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    const/16 v0, 0x11

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result p3

    const-wide/16 v2, 0x0

    invoke-virtual {p1, p3, v2, v3}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v2

    invoke-interface {p2, v1, v2, v3}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;J)V

    return-void

    :cond_0
    invoke-interface {p2, v0}, Lchat/ola/vn/p/g;->a(S)V

    return-void
.end method
