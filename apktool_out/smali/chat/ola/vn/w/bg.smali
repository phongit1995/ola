.class Lchat/ola/vn/w/bg;
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

    iget-byte p3, p1, Lchat/ola/vn/w/bk;->as:B

    const/16 v0, 0x72

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SB)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_0

    const/16 p3, 0x6d

    iget-object v0, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    iget-wide v0, p1, Lchat/ola/vn/w/bk;->S:J

    const-wide/16 v2, 0x0

    cmp-long p3, v0, v2

    if-eqz p3, :cond_1

    const/16 p3, 0x48

    iget-wide v0, p1, Lchat/ola/vn/w/bk;->S:J

    invoke-virtual {p2, p3, v0, v1}, Lchat/ola/vn/w/cg;->a(SJ)V

    :cond_1
    const/16 p3, 0x5a

    iget-short p1, p1, Lchat/ola/vn/w/bk;->ac:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 0

    return-void
.end method
