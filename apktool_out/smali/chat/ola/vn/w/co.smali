.class Lchat/ola/vn/w/co;
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
    .locals 4

    iget-object p3, p1, Lchat/ola/vn/w/bk;->m:Ljava/lang/String;

    iget-byte v0, p1, Lchat/ola/vn/w/bk;->as:B

    if-eqz v0, :cond_0

    const/16 v0, 0x72

    iget-byte v1, p1, Lchat/ola/vn/w/bk;->as:B

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_0
    if-eqz p3, :cond_1

    const/16 v0, 0x8

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_1
    iget-object p3, p1, Lchat/ola/vn/w/bk;->s:Ljava/lang/String;

    if-eqz p3, :cond_2

    const/16 v0, 0x18

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_2
    iget-short p3, p1, Lchat/ola/vn/w/bk;->ak:S

    if-eqz p3, :cond_3

    const/16 p3, 0xc

    iget-short v0, p1, Lchat/ola/vn/w/bk;->ak:S

    int-to-byte v0, v0

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_3
    iget-short p3, p1, Lchat/ola/vn/w/bk;->ai:S

    if-eqz p3, :cond_4

    const/16 p3, 0xdc

    iget-short v0, p1, Lchat/ola/vn/w/bk;->ai:S

    int-to-byte v0, v0

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_4
    iget-wide v0, p1, Lchat/ola/vn/w/bk;->S:J

    const-wide/16 v2, 0x0

    cmp-long p3, v0, v2

    if-eqz p3, :cond_5

    const/16 p3, 0x48

    invoke-virtual {p2, p3, v0, v1}, Lchat/ola/vn/w/cg;->a(SJ)V

    :cond_5
    iget-object p3, p1, Lchat/ola/vn/w/bk;->c:Ljava/lang/String;

    if-eqz p3, :cond_6

    const/16 p3, 0x4f

    iget-object v0, p1, Lchat/ola/vn/w/bk;->c:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_6
    iget-object p3, p1, Lchat/ola/vn/w/bk;->D:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_7

    const/16 p3, 0x71

    iget-object v0, p1, Lchat/ola/vn/w/bk;->D:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_7
    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_8

    const/16 p3, 0xff

    iget-short p1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_8
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
