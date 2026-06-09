.class Lchat/ola/vn/w/da;
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
    .locals 3

    const/4 v0, 0x0

    const/16 v1, 0xff

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    int-to-short v0, v0

    const/4 v1, 0x1

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->a(S)[B

    move-result-object v1

    const/16 v2, 0xb

    invoke-virtual {p1, v2}, Lchat/ola/vn/w/s;->a(S)[B

    move-result-object p1

    invoke-virtual {p3, p1}, Lchat/ola/vn/w/ci;->a([B)V

    invoke-interface {p2, v1, v0}, Lchat/ola/vn/p/g;->a([BS)V

    return-void
.end method
