.class Lchat/ola/vn/w/av;
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

    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 2

    invoke-virtual {p3}, Lchat/ola/vn/w/ci;->i()Ljava/lang/String;

    move-result-object p3

    invoke-static {p1, p3}, Lchat/ola/vn/w/s;->a(Lchat/ola/vn/w/s;Ljava/lang/String;)Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_1

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p3

    :goto_0
    invoke-interface {p3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/f;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/f;->f(S)V

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/f;->a(S)V

    goto :goto_0

    :cond_0
    invoke-interface {p2, p1}, Lchat/ola/vn/p/g;->a(Ljava/util/List;)V

    :cond_1
    return-void
.end method
