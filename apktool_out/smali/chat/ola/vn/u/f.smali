.class Lchat/ola/vn/u/f;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/u/a;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/u/e;Ljava/util/List;)Lchat/ola/vn/w/cg;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/u/e;",
            "Ljava/util/List<",
            "Lchat/ola/vn/u/g;",
            ">;)",
            "Lchat/ola/vn/w/cg;"
        }
    .end annotation

    const/4 p1, 0x0

    return-object p1
.end method

.method public a(Lchat/ola/vn/w/s;Ljava/util/List;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/w/s;",
            "Ljava/util/List<",
            "Lchat/ola/vn/u/g;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x0

    invoke-virtual {p1, v0, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->a(IB)B

    move-result v1

    const/16 v2, 0xe

    invoke-virtual {p1, v2}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x4

    invoke-virtual {p1, v3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x5

    invoke-virtual {p1, v4}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v4

    packed-switch v1, :pswitch_data_0

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    goto/16 :goto_0

    :pswitch_0
    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p2

    if-eqz p2, :cond_8

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/u/g;

    invoke-interface {p2}, Lchat/ola/vn/u/g;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v3, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-interface {p2}, Lchat/ola/vn/u/g;->c()Ljava/lang/String;

    move-result-object v0

    invoke-static {v4, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    :cond_1
    invoke-interface {p2, v3, v2}, Lchat/ola/vn/u/g;->e(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :pswitch_1
    const/4 v1, 0x1

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->a(II)I

    move-result p1

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :cond_2
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_8

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/u/g;

    invoke-interface {v0}, Lchat/ola/vn/u/g;->b()Ljava/lang/String;

    move-result-object v1

    invoke-static {v3, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_3

    invoke-interface {v0}, Lchat/ola/vn/u/g;->c()Ljava/lang/String;

    move-result-object v1

    invoke-static {v4, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    :cond_3
    invoke-interface {v0, v3, p1, v2}, Lchat/ola/vn/u/g;->a(Ljava/lang/String;ILjava/lang/String;)V

    return-void

    :pswitch_2
    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_4
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p2

    if-eqz p2, :cond_8

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/u/g;

    invoke-interface {p2}, Lchat/ola/vn/u/g;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v3, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_5

    invoke-interface {p2}, Lchat/ola/vn/u/g;->c()Ljava/lang/String;

    move-result-object v0

    invoke-static {v4, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    :cond_5
    invoke-interface {p2, v3, v2}, Lchat/ola/vn/u/g;->d(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_6
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p2

    if-eqz p2, :cond_8

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/u/g;

    invoke-interface {p2}, Lchat/ola/vn/u/g;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v3, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_7

    invoke-interface {p2}, Lchat/ola/vn/u/g;->c()Ljava/lang/String;

    move-result-object v0

    invoke-static {v4, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_6

    :cond_7
    invoke-interface {p2, v4, v2}, Lchat/ola/vn/u/g;->c(Ljava/lang/String;Ljava/lang/String;)V

    :cond_8
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
