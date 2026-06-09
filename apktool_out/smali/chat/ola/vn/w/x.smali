.class public Lchat/ola/vn/w/x;
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
    .locals 0

    return-void
.end method
