.class public Lchat/ola/vn/w/bv;
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

    iget-byte p3, p1, Lchat/ola/vn/w/bk;->as:B

    if-eqz p3, :cond_0

    const/16 p3, 0x72

    iget-byte p1, p1, Lchat/ola/vn/w/bk;->as:B

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 2

    const/16 p3, 0x8a

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p3

    const/4 v0, 0x0

    const/16 v1, 0x8b

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->a(IS)B

    move-result p1

    int-to-short p1, p1

    invoke-static {p1}, Lchat/ola/vn/w/cc;->a(S)S

    move-result p1

    invoke-interface {p2, p3, p1}, Lchat/ola/vn/p/g;->k(Ljava/lang/String;S)V

    return-void
.end method
