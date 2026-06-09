.class Lchat/ola/vn/w/u;
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

    iget-object p3, p1, Lchat/ola/vn/w/bk;->T:[J

    const/16 v0, 0x48

    if-eqz p3, :cond_0

    iget-object p1, p1, Lchat/ola/vn/w/bk;->T:[J

    array-length p3, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, p3, :cond_1

    aget-wide v2, p1, v1

    invoke-virtual {p2, v0, v2, v3}, Lchat/ola/vn/w/cg;->a(SJ)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    iget-wide v1, p1, Lchat/ola/vn/w/bk;->S:J

    invoke-virtual {p2, v0, v1, v2}, Lchat/ola/vn/w/cg;->a(SJ)V

    :cond_1
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 0

    return-void
.end method
