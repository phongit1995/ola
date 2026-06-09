.class Lchat/ola/vn/w/af;
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

    iget p3, p1, Lchat/ola/vn/w/bk;->aa:I

    if-eqz p3, :cond_0

    const/16 p3, 0x27

    iget p1, p1, Lchat/ola/vn/w/bk;->aa:I

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SI)V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 1

    const/16 v0, 0x27

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->a(S)[B

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/e;->c([B)I

    move-result v0

    invoke-virtual {p3}, Lchat/ola/vn/w/ci;->i()Ljava/lang/String;

    move-result-object p3

    invoke-static {p1, p3}, Lchat/ola/vn/w/s;->a(Lchat/ola/vn/w/s;Ljava/lang/String;)Ljava/util/List;

    move-result-object p1

    invoke-interface {p2, p1, v0}, Lchat/ola/vn/p/g;->a(Ljava/util/List;I)V

    return-void
.end method
