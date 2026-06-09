.class Lchat/ola/vn/u/l;
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
    .locals 2
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

    new-instance p2, Lchat/ola/vn/w/cg;

    iget-short v0, p1, Lchat/ola/vn/u/e;->j:S

    invoke-direct {p2, v0}, Lchat/ola/vn/w/cg;-><init>(S)V

    iget-object v0, p1, Lchat/ola/vn/u/e;->e:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const/16 v0, 0xa

    iget-object v1, p1, Lchat/ola/vn/u/e;->e:Ljava/lang/String;

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    const/4 v0, 0x5

    iget-object v1, p1, Lchat/ola/vn/u/e;->c:Ljava/lang/String;

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/4 v0, 0x7

    iget v1, p1, Lchat/ola/vn/u/e;->i:I

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/w/cg;->a(SI)V

    iget-object v0, p1, Lchat/ola/vn/u/e;->l:[B

    if-eqz v0, :cond_1

    const/4 v0, 0x6

    iget-object p1, p1, Lchat/ola/vn/u/e;->l:[B

    invoke-virtual {p2, v0, p1}, Lchat/ola/vn/w/cg;->a(S[B)V

    :cond_1
    return-object p2
.end method

.method public a(Lchat/ola/vn/w/s;Ljava/util/List;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/w/s;",
            "Ljava/util/List<",
            "Lchat/ola/vn/u/g;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x5

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0xd

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p1

    if-nez p1, :cond_1

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p2

    if-eqz p2, :cond_3

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/u/g;

    invoke-interface {p2}, Lchat/ola/vn/u/g;->c()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {p2, v0}, Lchat/ola/vn/u/g;->a(Ljava/lang/String;)V

    return-void

    :cond_1
    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :cond_2
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/u/g;

    invoke-interface {v1}, Lchat/ola/vn/u/g;->c()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1, v0, p1}, Lchat/ola/vn/u/g;->a(Ljava/lang/String;Ljava/lang/String;)V

    :cond_3
    return-void
.end method
