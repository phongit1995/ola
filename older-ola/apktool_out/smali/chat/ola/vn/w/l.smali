.class public Lchat/ola/vn/w/l;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# instance fields
.field e:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 1

    iget-object p3, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/w/l;->e:Ljava/lang/String;

    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_0

    const/16 p3, 0xff

    iget-short v0, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte v0, v0

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_0
    const/16 p3, 0x2b

    iget-object v0, p1, Lchat/ola/vn/w/bk;->am:[B

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(S[B)V

    const/16 p3, 0x2e

    iget-object p1, p1, Lchat/ola/vn/w/bk;->an:[B

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(S[B)V

    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 1

    const/4 p3, 0x0

    const/16 v0, 0xff

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result p1

    int-to-short p1, p1

    iget-object p3, p0, Lchat/ola/vn/w/l;->e:Ljava/lang/String;

    invoke-interface {p2, p3, p1}, Lchat/ola/vn/p/g;->h(Ljava/lang/String;S)V

    return-void
.end method
