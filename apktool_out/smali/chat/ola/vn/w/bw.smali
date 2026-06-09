.class public Lchat/ola/vn/w/bw;
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

    iget-byte p3, p1, Lchat/ola/vn/w/bk;->as:B

    if-eqz p3, :cond_0

    const/16 p3, 0x72

    iget-byte v0, p1, Lchat/ola/vn/w/bk;->as:B

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_0
    iget-object p1, p1, Lchat/ola/vn/w/bk;->b:Ljava/util/List;

    if-eqz p1, :cond_1

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p3

    if-lez p3, :cond_1

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p3

    if-eqz p3, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lchat/ola/vn/message/f;

    const/16 v0, 0x8a

    invoke-virtual {p3}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/16 v0, 0x8b

    invoke-virtual {p3}, Lchat/ola/vn/message/f;->k()S

    move-result p3

    invoke-static {p3}, Lchat/ola/vn/w/cc;->b(S)S

    move-result p3

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SS)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 0

    return-void
.end method
